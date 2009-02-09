
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
-- Convert TAI to UTC
--

CREATE FUNCTION taiToUtc (
    taiTime_ BIGINT
) RETURNS BIGINT

BEGIN

    DECLARE leapSeconds_ INT;

    SELECT COUNT(*) INTO leapSeconds_
    FROM leapSecondTable
    WHERE insertedSecond <= taiTime;

    RETURN taiTime_ - leapSeconds * 1000000000;

END
//

DELIMITER ;
