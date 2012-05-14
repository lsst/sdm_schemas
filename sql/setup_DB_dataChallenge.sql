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


SET FOREIGN_KEY_CHECKS=0;


CREATE TABLE IF NOT EXISTS ZZZ_Db_Description 
    -- <descr>Internal table used for storing database description</descr>
(
    f VARCHAR(255),
        -- <descr>The schema file name.</descr>
    r VARCHAR(255)
        -- <descr>Captures information from 'git describe'.</descr>
) ENGINE=MyISAM;

INSERT INTO ZZZ_Db_Description(f) VALUES('setup_DB_dataChallenge.sql');


CREATE TABLE prv_Activity
(
    activityId BIGINT NOT NULL,
        -- <descr>Unique id derived from prv_Run.offset.&#xA;</descr>
    offset MEDIUMINT NOT NULL,
        -- <descr>Corresponding prv_Run offset.&#xA;</descr>
    name VARCHAR(64) NOT NULL,
        -- <descr>A name for the activity.&#xA;</descr>
    type VARCHAR(64) NOT NULL,
        -- <descr>A name indicating type of activity, e.g. &quot;launch&quot;,
        -- &quot;workflow&quot;.&#xA;</descr>
    platform VARCHAR(64) NOT NULL,
        -- <descr>Name of the platform where the activity occurred (does not
        -- need to a be a DNS name).&#xA;</descr>
    PRIMARY KEY (activityId, offset)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_PolicyKey
(
    policyKeyId BIGINT NOT NULL,
    value TEXT NULL,
    validityBegin DATETIME NULL,
    validityEnd DATETIME NULL,
    PRIMARY KEY (policyKeyId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_SoftwarePackage
(
    packageId BIGINT NOT NULL,
    version VARCHAR(255) NOT NULL,
    directory VARCHAR(255) NOT NULL,
    validityBegin DATETIME NULL,
    validityEnd DATETIME NULL,
    PRIMARY KEY (packageId)
) ENGINE=InnoDB;


CREATE TABLE prv_Filter
    -- <descr>One row per color - the table will have 6 rows</descr>
(
    filterId TINYINT NOT NULL,
        -- <descr>Unique id.</descr>
    focalPlaneId TINYINT NOT NULL,
        -- <descr>Pointer to FocalPlane - focal plane this filter belongs to.
        -- </descr>
    name VARCHAR(80) NOT NULL,
        -- <descr>String description of the filter,e.g. 'VR SuperMacho c6027'.
        -- </descr>
    url VARCHAR(255) NULL,
        -- <descr>URL for filter transmission curve. (Added from archive specs
        -- for LSST precursor data).</descr>
    clam FLOAT(0) NOT NULL,
        -- <descr>Filter centroid wavelength (Angstroms). (Added from archive
        -- specs for LSST precursor data).</descr>
    bw FLOAT(0) NOT NULL,
        -- <descr>Filter effective bandwidth (Angstroms). (Added from archive
        -- specs for LSST precursor data).</descr>
    PRIMARY KEY (filterId),
    UNIQUE name(name),
    INDEX focalPlaneId (focalPlaneId ASC)
) ENGINE=InnoDB;


CREATE TABLE prv_PolicyFile
(
    policyFileId BIGINT NOT NULL,
        -- <descr>Identifier for the file containing the Policy.</descr>
    pathName VARCHAR(255) NOT NULL,
        -- <descr>Path to the Policy file.</descr>
    hashValue CHAR(32) NOT NULL,
        -- <descr>MD5 hash of the Policy file contents for verification and
        -- modification detection.</descr>
    modifiedDate BIGINT NOT NULL,
        -- <descr>Time of last modification of the Policy file as provided by
        -- the filesystem.</descr>
    PRIMARY KEY (policyFileId)
) ENGINE=InnoDB;


CREATE TABLE prv_PolicyKey
(
    policyKeyId BIGINT NOT NULL,
        -- <descr>Identifier for a key within a Policy file.</descr>
    policyFileId BIGINT NOT NULL,
        -- <descr>Identifier for the Policy file.</descr>
    keyName VARCHAR(255) NOT NULL,
        -- <descr>Name of the key in the Policy file.</descr>
    keyType VARCHAR(16) NOT NULL,
        -- <descr>Type of the key in the Policy file.</descr>
    PRIMARY KEY (policyKeyId),
    KEY (policyFileId)
) ENGINE=InnoDB;


CREATE TABLE prv_Run
(
    offset MEDIUMINT NOT NULL AUTO_INCREMENT,
    runId VARCHAR(255) NOT NULL,
    PRIMARY KEY (offset),
    UNIQUE UQ_prv_Run_runId(runId)
) ENGINE=InnoDB;


CREATE TABLE prv_SoftwarePackage
(
    packageId BIGINT NOT NULL,
    packageName VARCHAR(64) NOT NULL,
    PRIMARY KEY (packageId)
) ENGINE=InnoDB;


SET FOREIGN_KEY_CHECKS=1;


ALTER TABLE prv_cnf_PolicyKey ADD CONSTRAINT FK_prv_cnf_PolicyKey_prv_PolicyKey
    FOREIGN KEY (policyKeyId) REFERENCES prv_PolicyKey (policyKeyId);

ALTER TABLE prv_cnf_SoftwarePackage ADD CONSTRAINT FK_prv_cnf_SoftwarePackage_prv_SoftwarePackage
    FOREIGN KEY (packageId) REFERENCES prv_SoftwarePackage (packageId);

ALTER TABLE prv_PolicyKey ADD CONSTRAINT FK_prv_PolicyKey_prv_PolicyFile
    FOREIGN KEY (policyFileId) REFERENCES prv_PolicyFile (policyFileId);
