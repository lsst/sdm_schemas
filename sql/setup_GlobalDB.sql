
-- create global database
CREATE DATABASE IF NOT EXISTS GlobalDB;

USE GlobalDB;


-- create global table(s)
CREATE TABLE IF NOT EXISTS RunInfo_DC3a (
    runId VARCHAR(64) NOT NULL,     -- unique name of the run
    expDate DATETIME NOT NULL,      -- time at which run can be deleted
    initiator VARCHAR(64) NOT NULL, -- user name of the run initiator
    status ENUM ('STARTED', 'KILLED', 'FAILED', 'FINISHED'),
    delDate DATETIME,               -- deletion time or NULL
    PRIMARY KEY (runId),
    INDEX (expDate)
) ENGINE=MyISAM; 


-- create stored functions / procedures
DELIMITER //

CREATE PROCEDURE extendRun ( in_dbName VARCHAR(64) )
BEGIN
   UPDATE RunInfo_DC3a
   SET    expDate = DATE_ADD(NOW(), INTERVAL 1 WEEK)
   WHERE  runId = in_dbName
   AND    delDate IS NULL;
END;
//

DELIMITER ;


-- authorize everybody to insert runs and 
-- extend runs' expiration time.
-- Notice that users won't be able to hack in
-- and extend runs by calling 'UPDATE' by hand
GRANT SELECT, INSERT ON RunInfo_DC3a TO ''@'localhost';
GRANT EXECUTE ON PROCEDURE extendRun TO ''@'localhost';
