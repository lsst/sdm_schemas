
-- create global database
CREATE DATABASE IF NOT EXISTS GlobalDB;

USE GlobalDB;


-- global table for keeping run-related info
CREATE TABLE IF NOT EXISTS RunInfo_DC3a (
    runName VARCHAR(64) NOT NULL,            -- unique name of the run
    dbName VARCHAR(64) NOT NULL,             -- database name
    startDate DATETIME NOT NULL,             -- time when run was started
    initiator VARCHAR(64) NOT NULL,          -- user name of the run initiator
    nExtensions SMALLINT NOT NULL DEFAULT 0, -- number of times extension was requested
    expDate DATE NOT NULL,                   -- date at which run expires (can be deleted)
    firstNotifDate DATETIME DEFAULT NULL,    -- date when 1st notification was sent
    finalNotifDate DATETIME DEFAULT NULL,    -- date when final notification was sent
    delDate DATETIME DEFAULT NULL,           -- deletion time or NULL
    PRIMARY KEY (runName),
    INDEX (expDate)
) ENGINE=MyISAM; 


-- global table for keeping user-related into
-- used for notifications
CREATE TABLE IF NOT EXISTS UserInfo_DC3a (
    name VARCHAR(64) NOT NULL PRIMARY KEY,
    email VARCHAR(64) NOT NULL
) ENGINE=MyISAM;


-- create stored functions / procedures
DELIMITER //

-- known "feature": it will extend some else's run
-- return value:
--  1: successfully extended
-- -1: run not found
-- -2: run already deleted
CREATE FUNCTION extendRun ( in_runName VARCHAR(64) ) RETURNS INT
BEGIN
   DECLARE n INT;

   -- report error if run not found
   SELECT COUNT(*) INTO n
   FROM   RunInfo_DC3a
   WHERE  runName = in_runName;
   IF n <> 1 THEN RETURN -1; END IF;

   -- report error if run already deleted
   SELECT COUNT(*) INTO n
   FROM   RunInfo_DC3a
   WHERE  runName = in_runName
   AND    delDate IS NOT NULL;
   IF n = 1 THEN RETURN -2; END IF;

   -- do the update
   UPDATE RunInfo_DC3a
   SET    expDate = DATE_ADD(NOW(), INTERVAL 2 WEEK),
          nExtensions = nExtensions + 1,
          firstNotifDate = NULL,
          finalNotifDate = NULL
   WHERE  runName = in_runName
   AND    delDate IS NULL;

   RETURN 1;
END;
//

DELIMITER ;

