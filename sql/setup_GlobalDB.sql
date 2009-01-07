


-- global table for keeping run-related info
CREATE TABLE IF NOT EXISTS RunInfo (
    runInfoId INT NOT NULL AUTO_INCREMENT,   -- primary key
    dcVersion VARCHAR(16) NOT NULL,          -- DC version, eg DC3a, DC3b, DC4, ...
    runName VARCHAR(64) NOT NULL,            -- unique name of the run
    dbName VARCHAR(64) NOT NULL,             -- database name
    startDate DATETIME NOT NULL,             -- time when run was started
    initiator VARCHAR(64) NOT NULL,          -- user name of the run initiator
    nExtensions SMALLINT NOT NULL DEFAULT 0, -- number of times extension was requested
    expDate DATETIME NOT NULL,               -- date at which run expires (can be deleted)
    firstNotifDate DATETIME DEFAULT NULL,    -- date when 1st notification was sent
    finalNotifDate DATETIME DEFAULT NULL,    -- date when final notification was sent
    delDate DATETIME DEFAULT NULL,           -- deletion time or NULL
    PRIMARY KEY (runInfoId),
    UNIQUE(runName, initiator),
    INDEX (expDate)
) ENGINE=MyISAM; 


-- global table for keeping user-related into
-- used for notifications
CREATE TABLE IF NOT EXISTS UserInfo (
    name VARCHAR(64) NOT NULL PRIMARY KEY,
    email VARCHAR(64) NOT NULL
) ENGINE=MyISAM;




-- create stored functions / procedures
DELIMITER //

-- return value:
--  1: successfully extended
-- -1: run not found
-- -2: run already deleted
CREATE FUNCTION extendRun (
    in_runName VARCHAR(64),
    in_dcVersion VARCHAR(16),
    in_userName VARCHAR(64) ) RETURNS INT
BEGIN
   DECLARE n INT;

   -- report error if run not found
   SELECT COUNT(*) INTO n
   FROM   RunInfo
   WHERE  runName = in_runName
   AND    dcVersion = in_dcVersion
   AND    initiator = in_userName;
   IF n <> 1 THEN RETURN -1; END IF;

   -- report error if run already deleted
   SELECT COUNT(*) INTO n
   FROM   RunInfo
   WHERE  runName = in_runName
   AND    dcVersion = in_dcVersion
   AND    initiator = in_userName
   AND    delDate IS NOT NULL;
   IF n = 1 THEN RETURN -2; END IF;

   -- do the update
   UPDATE RunInfo
   SET    expDate = DATE_ADD(NOW(), INTERVAL 2 WEEK),
          nExtensions = nExtensions + 1,
          firstNotifDate = NULL,
          finalNotifDate = NULL
   WHERE  runName = in_runName
   AND    dcVersion = in_dcVersion
   AND    initiator = in_userName
   AND    delDate IS NULL;

   RETURN 1;
END;
//

DELIMITER ;

