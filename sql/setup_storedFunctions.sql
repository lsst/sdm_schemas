-- LSST Data Management System
-- Copyright 2008, 2009, 2010 LSST Corporation.
--
-- This product includes software developed by the
-- LSST Project (http://www.lsst.org/).
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the LSST License Statement and
-- the GNU General Public License along with this program.  If not,
-- see <http://www.lsstcorp.org/LegalNotices/>.


-- One-time setup actions for LSST database stored functions
-- and procedures - assumes the LSST Database Schema already exists.


DELIMITER //

-- ==========================  ADMIN  ============================= --


-- returns 1 if given user has privileges to create new run
-- otherwise it returns a negative number
CREATE FUNCTION checkIfUserCanStartRun (
    userName_      VARCHAR(30)
) RETURNS INT
  SQL SECURITY DEFINER
BEGIN

    DECLARE tmpI_ SMALLINT;
    DECLARE tmpC_ CHAR;

    SELECT Table_priv INTO tmpI_
    FROM   mysql.tables_priv
    WHERE  user = userName_
       AND Table_name = 'RunInfo';

    IF tmpI_ IS NOT NULL THEN
        RETURN 1; -- ok
    END IF;

    SELECT Insert_priv INTO tmpC_
    FROM   mysql.user
    WHERE user = userName_;

    IF tmpC_ IS NULL THEN
        RETURN -1;
    END IF;

    IF tmpC_ = "Y" THEN
        RETURN 1; -- ok
    END IF;

    RETURN -2;
END
//


-- ===========================   Time   =========================== --


--
-- Function to convert UTC nanoseconds to TAI nanoseconds.
--

CREATE FUNCTION utcToTai (
    nsecs_ BIGINT
) RETURNS BIGINT
    SQL SECURITY INVOKER
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
    SQL SECURITY INVOKER
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
    SQL SECURITY INVOKER
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
  SQL SECURITY INVOKER
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
  SQL SECURITY INVOKER
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
  SQL SECURITY INVOKER
BEGIN
    RETURN utcToTai((mjdUtc_ - 40587.0) * 86.4e12);
END
//

DELIMITER ;
