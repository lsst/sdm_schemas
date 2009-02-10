
-- One-time setup actions for LSST database stored functions 
-- and procedures - assumes the LSST Database Schema already exists.
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu:8100/trac/wiki/Copyrights>
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

-- Created: 09 February 2008, K.-T. Lim (ktl@slac.stanford.edu)

--
-- Table of leap seconds.
--

CREATE TABLE LeapSeconds (
    daysSinceEpoch FLOAT NOT NULL,
    seconds INT NOT NULL
);

INSERT INTO LeapSeconds VALUES
    (730.0, 10),
    (912.0, 11),
    (1096.0, 12),
    (1461.0, 13),
    (1826.0, 14),
    (2191.0, 15),
    (2557.0, 16),
    (2922.0, 17),
    (3287.0, 18),
    (3652.0, 19),
    (4199.0, 20),
    (4564.0, 21),
    (4929.0, 22),
    (5660.0, 23),
    (6574.0, 24),
    (7305.0, 25),
    (7670.0, 26),
    (8217.0, 27),
    (8582.0, 28),
    (8947.0, 29),
    (9496.0, 30),
    (10043.0, 31),
    (10592.0, 32),
    (13149.0, 33),
    (14245.0, 34);


--
-- Function to convert UTC nanoseconds to Modified Julian Days (UTC).
--

CREATE FUNCTION utcToMJD (
    utcTime_ BIGINT
) RETURNS DOUBLE
BEGIN
    RETURN utcTime_ / 86.4e12 + 40587.0;
END
//


--
-- Function to convert UTC nanoseconds to TAI nanoseconds.
--

CREATE FUNCTION utcToTAI (
    utcTime_ BIGINT
) RETURNS BIGINT
BEGIN

    DECLARE daysSinceEpoch_ FLOAT;
    DECLARE leapSeconds_ INT;

    SELECT MAX(daysSinceEpoch) INTO daysSinceEpoch_
        FROM LeapSeconds
        WHERE daysSinceEpoch * 86.4e12 < utcTime_;

    IF daysSinceEpoch_ IS NULL THEN
        SET leapSeconds_ = (utcToMJD(utcTime_) - 39126.0) * 0.002592 + 4.21317;
    ELSE
        SELECT seconds INTO leapSeconds_
            FROM LeapSeconds
            WHERE daysSinceEpoch = daysSinceEpoch_;
    END IF;

    RETURN utcTime_ - leapSeconds_ * 1000000000;

END
//


--
-- Function to convert TAI nanoseconds to UTC nanoseconds.
--

CREATE FUNCTION taiToUTC (
    taiTime_ BIGINT
) RETURNS BIGINT
BEGIN

    DECLARE daysSinceEpoch_ FLOAT;
    DECLARE leapSeconds_ INT;

    SELECT MAX(daysSinceEpoch) INTO daysSinceEpoch_
        FROM LeapSeconds
        WHERE daysSinceEpoch * 86.4e12 + seconds * 1.0e9 < taiTime_;

    IF daysSinceEpoch_ IS NULL THEN
        RETURN (taiTime_ - 4.21317e9 - (40587.0 - 39126.0) * 0.002592e9) /
            (1 - 0.002592e9 / 86.4e12);
    END IF;

    SELECT seconds INTO leapSeconds_
        FROM LeapSeconds
        WHERE daysSinceEpoch = daysSinceEpoch_;
    RETURN taiTime_ + leapSeconds_ * 1000000000;

END
//


--
-- Function to convert TAI nanoseconds to Modified Julian Days (UTC).
--

CREATE FUNCTION taiToMJD (
    taiTime_ BIGINT
) RETURNS DOUBLE
BEGIN
    RETURN taiToUTC(taiTime_) / 86.4e12 + 40587.0;
END
//


DELIMITER ;
