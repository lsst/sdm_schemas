
-- One-time setup actions for LSST database stored functions 
-- and procedures - assumes the LSST Database Schema already exists.
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu/trac/wiki/Copyrights>
-- for copyright information.


DELIMITER //

-- ===========================   SDQA   =========================== --

-- Created: 24 October 2008, R. Laher (laher@ipac.caltech.edu)
--
-- Insert a new record into the SDQA_Threshold table. 
--
-- Modifications: 
--
-- 8 December 2008, R. Laher (laher@ipac.caltech.edu)
-- Removed code associated with versioning of SDQA_Threshold records,
-- since is to be handled by provenance.
--

-- Returns number of elements inserted.
-- Negative value indicates an error:
-- -1: metric not found
-- -2: insert failed
CREATE FUNCTION addSdqaThresholdRecord (
    metricName_      VARCHAR(30),
    upperThreshold_  DOUBLE,
    lowerThreshold_  DOUBLE
) RETURNS INT

BEGIN

    DECLARE sdqa_thresholdId_ SMALLINT;
    DECLARE sdqa_metricId_    SMALLINT;


    -- Get sdqa_metricId.
    SELECT sdqa_metricId INTO sdqa_metricId_
    FROM   sdqa_Metric
    WHERE  metricName = metricName_;

    IF sdqa_metricId_ IS NULL THEN
        RETURN -1;
    END IF;

    -- Insert SDQA_Threshold record.
    INSERT INTO sdqa_Threshold ( sdqa_metricId, 
                                 upperThreshold, 
                                 lowerThreshold, 
                                 createdDate )
    VALUES ( sdqa_metricId_, 
             upperThreshold_, 
             lowerThreshold_, 
             now() );

    SELECT LAST_INSERT_ID() INTO sdqa_thresholdId_;

    IF sdqa_thresholdId_ IS NULL THEN
        RETURN -2;
    END IF;

    RETURN sdqa_thresholdId_;
END
//

-- ===========================   Time   =========================== --


--
-- Function to convert UTC nanoseconds to TAI nanoseconds.
--

CREATE FUNCTION utcToTai (
    nsecs_ BIGINT
) RETURNS BIGINT
BEGIN
    DECLARE nsecsPerDay_ DOUBLE;
    DECLARE epochInMjd_ DOUBLE;
    DECLARE offset_ FLOAT;
    DECLARE mjdRef_ FLOAT;
    DECLARE drift_ FLOAT;
    DECLARE mjd_ DOUBLE;
    DECLARE leapSecs_ DOUBLE;

    SET nsecsPerDay_ = 86.4e12;
    SET epochInMjd_ = 40587.0;
    SELECT offset, mjdRef, drift INTO offset_, mjdRef_, drift_
        FROM LeapSeconds
        WHERE whenUtc = (
            SELECT MAX(whenUtc) FROM LeapSeconds WHERE whenUtc <= nsecs_
        );
    SET mjd_ = nsecs_ / nsecsPerDay_ + epochInMjd_;
    SET leapSecs_ = offset_ + (mjd_ - mjdRef_) * drift_;
    
    RETURN nsecs_ + CAST(leapSecs_ * 1.0e9 + 0.5 AS SIGNED INTEGER);

END
//


--
-- Function to convert TAI nanoseconds to UTC nanoseconds.
--

CREATE FUNCTION taiToUtc (
    nsecs_ BIGINT
) RETURNS BIGINT
BEGIN

    DECLARE nsecsPerDay_ DOUBLE;
    DECLARE epochInMjd_ DOUBLE;
    DECLARE offset_ FLOAT;
    DECLARE mjdRef_ FLOAT;
    DECLARE drift_ FLOAT;
    DECLARE taiSecs_ DOUBLE;
    DECLARE leapSecs_ DOUBLE;

    SET nsecsPerDay_ = 86.4e12;
    SET epochInMjd_ = 40587.0;
    SELECT offset, mjdRef, drift INTO offset_, mjdRef_, drift_
        FROM LeapSeconds
        WHERE whenTai = (
            SELECT MAX(whenTai) FROM LeapSeconds WHERE whenTai <= nsecs_
        );
    SET taiSecs_ = nsecs_ / 1.0e9;
    SET leapSecs_ = taiSecs_ -
        (taiSecs_ - offset_ - drift_ * (epochInMjd_ - mjdRef_)) /
        (1.0 + drift_ * 1.0e9 / nsecsPerDay_);
    RETURN nsecs_ - CAST(leapSecs_ * 1.0e9 + 0.5 AS SIGNED);

END
//


--
-- Function to convert TAI nanoseconds to Modified Julian Days (UTC).
--

CREATE FUNCTION taiToMjdUtc (
    nsecs_ BIGINT
) RETURNS DOUBLE
BEGIN
    RETURN taiToUTC(nsecs_) / 86.4e12 + 40587.0;
END
//


--
-- Function to convert TAI nanoseconds to Modified Julian Days (TAI).
--

CREATE FUNCTION taiToMjdTai (
    nsecs_ BIGINT
) RETURNS DOUBLE
BEGIN
    RETURN nsecs_ / 86.4e12 + 40587.0;
END
//


--
-- Function to convert Modified Julian Days (TAI) to TAI nanoseconds.
--

CREATE FUNCTION mjdTaiToTai (
    mjdTai_ FLOAT
) RETURNS BIGINT
BEGIN
    RETURN (mjdTai_ - 40587.0) * 86.4e12;
END
//


--
-- Function to convert Modified Julian Days (UTC) to TAI nanoseconds.
--

CREATE FUNCTION mjdUtcToTai (
    mjdUtc_ FLOAT
) RETURNS BIGINT
BEGIN
    RETURN utcToTai((mjdUtc_ - 40587.0) * 86.4e12);
END
//

--
-- Function to compute the angular separation (in arcseconds) between
-- two positions. Input coordinates must be specified in degrees.
-- The implementation uses the haversine distance formula.
--
CREATE FUNCTION angSepArcsec(
    ra1 FLOAT,
    dec1 FLOAT,
    ra2 FLOAT,
    dec2 FLOAT
) RETURNS FLOAT DETERMINISTIC
BEGIN
   DECLARE dra FLOAT;
   DECLARE ddec FLOAT;
   DECLARE a FLOAT;
   DECLARE b FLOAT;
   DECLARE c FLOAT;
   SET dra = RADIANS(0.5*(ra2 - ra1));
   SET ddec = RADIANS(0.5*(dec2 - dec1));
   SET a = POW(SIN(ddec), 2) + COS(RADIANS(dec1)) * COS(RADIANS(dec2)) * POW(SIN(dra), 2);
   SET b = SQRT(a);
   SET c = IF(b > 1, 1, b);
   RETURN DEGREES(2.0 * ASIN(c)) * 3600.0;
END
//

--
-- Converts a calibrated flux (erg/cm**2/sec/Hz) to an AB magnitude.
--
CREATE FUNCTION fluxToAbMag(
    flux FLOAT
) RETURNS FLOAT DETERMINISTIC
BEGIN
    RETURN -2.5 * LOG10(flux) - 48.6;
END
//

--
-- Converts calibrated flux error (erg/cm**2/sec/Hz) to an AB magnitude error.
--
CREATE FUNCTION fluxToAbMagSigma(
    flux FLOAT,
    fluxSigma FLOAT
) RETURNS FLOAT DETERMINISTIC
BEGIN
   -- the constant below is 2.5 / LOG(10)
   RETURN 5.756462732485114210 * fluxSigma / flux; 
END
//

--
-- Converts a raw DN value to a calibrated flux (erg/cm**2/sec/Hz).
--
CREATE FUNCTION dnToFlux(
    dn       FLOAT,
    fluxMag0 FLOAT
) RETURNS FLOAT DETERMINISTIC
BEGIN
    RETURN 3.630780547701013425e-20 * dn / fluxMag0;
END
//

--
-- Converts a raw DN error to a calibrated flux error (erg/cm**2/sec/Hz).
--
CREATE FUNCTION dnToFluxSigma(
    dn            FLOAT,
    dnSigma       FLOAT,
    fluxMag0      FLOAT,
    fluxMag0Sigma FLOAT
) RETURNS FLOAT DETERMINISTIC
BEGIN
    RETURN 3.630780547701013425e-20 *
           SQRT((POW(dnSigma, 2) + POW(dn * fluxMag0Sigma / fluxMag0, 2)) /
                POW(fluxMag0, 2));
END
//

--
-- Converts a raw DN value to an AB magnitude.
--
CREATE FUNCTION dnToAbMag(
    dn       FLOAT,
    fluxMag0 FLOAT
) RETURNS FLOAT DETERMINISTIC
BEGIN
    DECLARE f FLOAT;
    SET f = dnToFlux(dn, fluxMag0);
    RETURN fluxToAbMag(f);
END
//

--
-- Converts a raw DN error to an AB magnitude error.
--
CREATE FUNCTION dnToAbMagSigma(
    dn            FLOAT,
    dnSigma       FLOAT,
    fluxMag0      FLOAT,
    fluxMag0Sigma FLOAT
) RETURNS FLOAT DETERMINISTIC
BEGIN
    DECLARE f FLOAT;
    DECLARE fSigma FLOAT;
    SET f = dnToFlux(dn, fluxMag0);
    SET fSigma = dnToFluxSigma(dn, dnSigma, fluxMag0, fluxMag0Sigma);
    RETURN fluxToAbMagSigma(f, fSigma);
END
//

DELIMITER ;
