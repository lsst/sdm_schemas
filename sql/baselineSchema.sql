-- LSST Data Management System
-- Copyright 2008-2013 LSST Corporation.
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


-- LSST Database Baseline Schema
--
-- UCD definitions based on:
-- http://www.ivoa.net/Documents/cover/UCDlist-20070402.html

CREATE TABLE AAA_Version_3_2_4 (version CHAR);

SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE ZZZ_Db_Description 
    -- <descr>Internal table used for storing database description</descr>
(
    f VARCHAR(255),
        -- <descr>The schema file name.</descr>
    r VARCHAR(255)
        -- <descr>Captures information from 'git describe'.</descr>
) ENGINE=MyISAM;

INSERT INTO ZZZ_Db_Description(f) VALUES('baselineSchema.sql');


CREATE TABLE prv_ProcHistory 
    -- <descr>This table is responsible for producing a new procHistoryId
    -- whenever something changes in the configuration.</descr>
(
    procHistoryId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Unique id</descr>
        -- <ucd>meta.id;src</ucd>
    PRIMARY KEY (procHistoryId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Amp
(
    cAmpId SMALLINT NOT NULL,
    ampName CHAR(3) NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    biasSec VARCHAR(20) NOT NULL DEFAULT '[0:0,0:0]',
        -- <descr>Bias section (ex: '[2045:2108,1:4096]')</descr>
    trimSec VARCHAR(20) NOT NULL DEFAULT '[0:0,0:0]',
        -- <descr>Trim section (ex: '[1:2044,1:4096]')</descr>
    gain FLOAT NULL,
        -- <descr>Detector/amplifier gain</descr>
    rdNoise FLOAT NULL,
        -- <descr>Read noise for detector/amplifier</descr>
    saturate FLOAT NULL,
        -- <descr>Maximum data value for A/D converter</descr>
    PRIMARY KEY (cAmpId),
    KEY (ampName)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Ccd
(
    cCcdId SMALLINT NOT NULL,
    ccdName CHAR(3) NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    serialN INTEGER NOT NULL,
    PRIMARY KEY (cCcdId),
    KEY (ccdName)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Filter
(
    cFilterId SMALLINT NOT NULL,
    filterName CHAR,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY (cFilterId),
    KEY (filterName)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Fpa
(
    cFpaId SMALLINT NOT NULL,
    fpaId TINYINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    versionN SMALLINT NOT NULL,
    PRIMARY KEY (cFpaId),
    KEY (fpaId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_InputDataSet
(
    cInputDataSetId INTEGER NOT NULL,
    inputDataSetId INTEGER NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY (cInputDataSetId),
    KEY (inputDataSetId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Node
(
    cNodeId INTEGER NOT NULL,
    nodeId INTEGER NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY (cNodeId),
    KEY (nodeId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_TaskGraph2Run
(
    cTaskGraph2RunId MEDIUMINT NOT NULL,
    taskGraph2runId MEDIUMINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY (cTaskGraph2RunId),
    KEY (taskGraph2runId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_TaskConfig
(
    cTaskConfigId MEDIUMINT NOT NULL,
    taskConfigId MEDIUMINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY (cTaskConfigId),
    KEY (taskConfigId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Raft
(
    cRaftId SMALLINT NOT NULL,
    raftName CHAR(3) NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    serialN INTEGER NOT NULL,
    PRIMARY KEY (cRaftId),
    KEY (raftName)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Task
(
    nodeId INTEGER NOT NULL,
    taskId MEDIUMINT NOT NULL,
    inputDataSetId INTEGER NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    KEY (nodeId),
    KEY (taskId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Stage
(
    cStageId MEDIUMINT NOT NULL,
    stageId SMALLINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY (cStageId),
    KEY (stageId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Stage2TaskGraph
(
    cStage2TaskGraphId MEDIUMINT NOT NULL,
    stage2taskGraphId MEDIUMINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY (cStage2TaskGraphId),
    KEY (stage2taskGraphId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Stage2Task
(
    cStage2TaskId MEDIUMINT NOT NULL,
    stage2taskId MEDIUMINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY (cStage2TaskId),
    KEY (stage2taskId)
) ENGINE=InnoDB;


CREATE TABLE prv_cnf_Stage2UpdatableColumn
(
    c_stage2UpdatableColumn SMALLINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY (c_stage2UpdatableColumn)
) ENGINE=InnoDB;


CREATE TABLE prv_Amp
(
    ampName CHAR(3) NOT NULL,
    ccdName CHAR(3) NOT NULL,
    raftName CHAR(3) NOT NULL,
    PRIMARY KEY (raftName, ccdName, ampName),
    KEY (ampName)
) ENGINE=InnoDB;


CREATE TABLE prv_Ccd
(
    ccdName CHAR(3) NOT NULL,
    raftName CHAR(3) NOT NULL,
    PRIMARY KEY (raftName, ccdName),
    KEY (ccdName)
) ENGINE=InnoDB;


CREATE TABLE prv_Filter
    -- <descr>One row per color - the table will have 6 rows</descr>
(
    filterName CHAR NOT NULL,
        -- <descr>Filter name. Unique id.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    url VARCHAR(255) NULL,
        -- <descr>URL for filter transmission curve. (Added from archive specs
        -- for LSST precursor data).</descr>
    clam FLOAT NOT NULL,
        -- <descr>Filter centroid wavelength (Angstroms). (Added from archive
        -- specs for LSST precursor data).</descr>
    bw FLOAT NOT NULL,
        -- <descr>Filter effective bandwidth (Angstroms). (Added from archive
        -- specs for LSST precursor data).</descr>
    PRIMARY KEY (filterName)
) ENGINE=InnoDB;


CREATE TABLE prv_Fpa
(
    fpaId TINYINT NOT NULL,
    PRIMARY KEY (fpaId)
) ENGINE=InnoDB;


CREATE TABLE prv_InputDataSet
(
    inputDataSetId INTEGER NOT NULL,
    name VARCHAR(80) NOT NULL,    
    PRIMARY KEY (inputDataSetId)
) ENGINE=InnoDB;


CREATE TABLE prv_Node
(
    nodeId INTEGER NOT NULL,
    taskConfigId MEDIUMINT NOT NULL,
    PRIMARY KEY (nodeId),
    KEY (taskConfigId)
) ENGINE=InnoDB;


CREATE TABLE prv_TaskGraph
(
    taskGraphId SMALLINT NOT NULL,
    taskConfigId MEDIUMINT NOT NULL,
    taskGraphName VARCHAR(64) NULL,
    PRIMARY KEY (taskGraphId),
    KEY (taskConfigId)
) ENGINE=InnoDB;


CREATE TABLE prv_TaskGraph2Run
(
    taskGraph2runId MEDIUMINT NOT NULL,
    runId MEDIUMINT NOT NULL,
    taskGraphId SMALLINT NOT NULL,
    PRIMARY KEY (taskGraph2runId),
    KEY (taskGraphId),
    KEY (runId)
) ENGINE=InnoDB;


CREATE TABLE prv_TaskConfig
(
    taskConfigId MEDIUMINT NOT NULL,
    taskConfigName VARCHAR(80) NOT NULL,
    PRIMARY KEY (taskConfigId)
) ENGINE=InnoDB;


CREATE TABLE prv_Raft
(
    raftName CHAR(3) NOT NULL,
    PRIMARY KEY (raftName)
) ENGINE=InnoDB;


CREATE TABLE prv_Run
(
    runId MEDIUMINT NOT NULL,
    taskConfigId MEDIUMINT NOT NULL,
    PRIMARY KEY (runId),
    KEY (taskConfigId)
) ENGINE=InnoDB;


CREATE TABLE prv_Task
(
    taskId MEDIUMINT NOT NULL,
    PRIMARY KEY (taskId)
) ENGINE=InnoDB;


CREATE TABLE prv_Snapshot
(
    snapshotId MEDIUMINT NOT NULL,
    procHistoryId BIGINT NOT NULL,
    snapshotDescr VARCHAR(255) NULL,
    PRIMARY KEY (snapshotId),
    KEY (procHistoryId)
) ENGINE=InnoDB;


CREATE TABLE prv_Stage
(
    stageId SMALLINT NOT NULL,
    taskConfigId MEDIUMINT NOT NULL,
    stageName VARCHAR(255) NULL,
    PRIMARY KEY (stageId),
    KEY (taskConfigId)
) ENGINE=InnoDB;


CREATE TABLE prv_Stage2TaskGraph
(
    stage2taskGraphId MEDIUMINT NOT NULL,
    taskGraphId SMALLINT NOT NULL,
    stageId SMALLINT NOT NULL,
    PRIMARY KEY (stage2taskGraphId),
    KEY (taskGraphId),
    KEY (stageId)
) ENGINE=InnoDB;


CREATE TABLE prv_Stage2ProcHistory
(
    stageId SMALLINT NOT NULL,
    procHistoryId BIGINT NOT NULL,
    stageStart DATETIME NOT NULL,
    stageEnd DATETIME NOT NULL,
    KEY (stageId),
    KEY (procHistoryId)
) ENGINE=InnoDB;


CREATE TABLE prv_Stage2Task
(
    stage2TaskId MEDIUMINT NOT NULL,
    stageId SMALLINT NOT NULL,
    taskId MEDIUMINT NOT NULL,
    PRIMARY KEY (stage2TaskId),
    KEY (taskId),
    KEY (stageId)
) ENGINE=InnoDB;


CREATE TABLE prv_Stage2UpdatableColumn
(
    stageId SMALLINT NOT NULL,
    columnId SMALLINT NOT NULL,
    cStage2UpdateColumnId SMALLINT NOT NULL,
    KEY (cStage2UpdateColumnId),
    KEY (stageId),
    KEY (columnId)
) ENGINE=InnoDB;


CREATE TABLE prv_UpdatableColumn
(
    columnId SMALLINT NOT NULL,
    tableId SMALLINT NOT NULL,
    columnName VARCHAR(64) NOT NULL,
    PRIMARY KEY (columnId),
    KEY (tableId)
) ENGINE=InnoDB;


CREATE TABLE prv_UpdatableTable
(
    tableId SMALLINT NOT NULL,
    tableName VARCHAR(64) NOT NULL,
    PRIMARY KEY (tableId)
) ENGINE=InnoDB;


CREATE TABLE LeapSeconds
    -- <descr>Based on <a href='http://maia.usno.navy.mil/ser7/tai-utc.dat'>
    -- http://maia.usno.navy.mil/ser7/tai-utc.dat</a>.
    -- </descr>
(
    whenJd FLOAT NOT NULL,
        -- <descr>JD of change in TAI-UTC difference (leap second).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    offset FLOAT NOT NULL,
        -- <descr>New number of leap seconds.</descr>
        -- <ucd>time.interval</ucd>
        -- <unit>s</unit>
    mjdRef FLOAT NOT NULL,
        -- <descr>Reference MJD for drift (prior to 1972-Jan-1).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    drift FLOAT NOT NULL,
        -- <descr>Drift in seconds per day (prior to 1972-Jan-1).</descr>
        -- <ucd>arith.rate</ucd>
        -- <unit>s/d</unit>
    whenMjdUtc FLOAT NULL,
        -- <descr>MJD in UTC system of change (computed).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    whenUtc BIGINT NULL,
        -- <descr>Nanoseconds from epoch in UTC system of change (computed).
        -- </descr>
        -- <ucd>time</ucd>
        -- <unit>ns</unit>
    whenTai BIGINT NULL
        -- <descr>Nanoseconds from epoch in TAI system of change (computed).
        -- </descr>
        -- <ucd>time</ucd>
        -- <unit>ns</unit>
) ENGINE=MyISAM;


CREATE TABLE ApertureBins
    -- <descr>Definition of aperture bins (for both the 
    -- Object and Source tables.)</descr>
(
    binN TINYINT NOT NULL,
        -- <descr>A bin in radius at which the aperture
        -- measurement is being performed.</descr>
    radiusMin FLOAT NOT NULL,
        -- <descr>Minimum aperture radii of bin.</descr>
    radiusMax FLOAt NOT NULL,
        -- <descr>Maximum aperture radii of bin.</descr>
    PRIMARY KEY PK_ObjecteBin (binN)
) ENGINE=MyISAM;


CREATE TABLE RefObjMatch
    -- <descr>Table containing the results of a spatial match between
    -- SimRefObject and Object.</descr>
(
    refObjectId BIGINT NULL,
        -- <descr>Reference object id (pointer to SimRefObject). NULL if 
        -- reference object has no matches.</descr>
        -- <ucd>meta.id</ucd>
    objectId BIGINT NULL,
        -- <descr>Object id. NULL if object has no matches.</descr>
        -- <ucd>meta.id;src</ucd>
    refRa DOUBLE NULL,
        -- <descr>RA of the reference object at mean epoch of object.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    refDec DOUBLE NULL,
        -- <descr>Decl of the reference object at mean epoch of object.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    angSep DOUBLE NULL,
        -- <descr>Angular separation between reference object and object.
        -- </descr>
        -- <unit>arcsec</unit>
        -- <ucd>pos.angDistance</ucd>
    nRefMatches INTEGER NULL,
        -- <descr>Total number of matches for reference object.</descr>
        -- <ucd>meta.number</ucd>
    nObjMatches INTEGER NULL,
        -- <descr>Total number of matches for object.</descr>
        -- <ucd>meta.number</ucd>
    closestToRef BIT(1) NULL,
        -- <descr>Is object the closest match for reference object?</descr>
        -- <ucd>meta.code</ucd>
    closestToObj BIT(1) NULL,
        -- <descr>Is reference object the closest match for object?</descr>
        -- <ucd>meta.code</ucd>
    flags INTEGER NULL DEFAULT 0,
        -- <descr>Bitwise OR of match flags:
        -- <ul>
        --   <li>0x1: the reference object has proper motion</li>
        --   <li>0x2: the reference object has parallax</li>
        --   <li>0x4: a reduction for parallax from barycentric to geocentric 
        --       place was applied prior to matching the reference object. 
        --       Should never be set when matching against objects, but may be 
        --       set when matching against sources.</li>
        --  </ul></descr>
        -- <ucd>meta.code</ucd>
    INDEX (objectId),
    INDEX (refObjectId)
) ENGINE=MyISAM;


CREATE TABLE SimRefObject
    -- <descr>Stores properties of ImSim reference objects that fall within
    -- at least one ccd. Includes both stars and galaxies.
    -- </descr>
(
    refObjectId BIGINT NOT NULL,
        -- <descr>Reference object id.</descr>
        -- <ucd>meta.id;src</ucd>
    isStar BIT(1) NOT NULL,
        -- <descr>1 for star, 0 for galaxy.</descr>
        -- <ucd>src.class.starGalaxy</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>RA.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    gLat DOUBLE NULL,
        -- <descr>Galactic latitude, NULL for galaxies.</descr>
        -- <ucd>pos.galactic.lat</ucd>
        -- <unit>deg</unit>
    gLon DOUBLE NULL,
        -- <descr>Galactic longitude. Null for galaxies.</descr>
        -- <ucd>pos.galactic.lon</ucd>
        -- <unit>deg</unit>
    sedName CHAR(32) NULL,
        -- <descr>Best-fit SED name. Null for galaxies.</descr>
        -- <ucd>src.sec</ucd>
    uMag DOUBLE NOT NULL,
        -- <descr>AB magnitude for u filter.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    gMag DOUBLE NOT NULL,
        -- <descr>AB magnitude for g filter.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    rMag DOUBLE NOT NULL,
        -- <descr>AB magnitude for r filter.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    iMag DOUBLE NOT NULL,
        -- <descr>AB magnitude for i filter.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    zMag DOUBLE NOT NULL,
        -- <descr>AB magnitude for z filter.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    yMag DOUBLE NOT NULL,
        -- <descr>AB magnitude for y filter.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    muRa DOUBLE NULL,
        -- <descr>Proper motion: dRA/dt*cos(decl). NULL for galaxies.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>mas/yr</unit>
    muDecl DOUBLE NULL,
        -- <descr>Proper motion: dDec/dt. NULL for galaxies.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>mas/yr</unit>
    parallax DOUBLE NULL,
        -- <descr>Stellar parallal. NULL for galaxies.</descr>
        -- <ucd>pos.parallax</ucd>
        -- <unit>mas</unit>
    vRad DOUBLE NULL,
        -- <descr>Radial velocity. NULL for galaxies.</descr>
        -- <ucd>spect.dopplerVeloc.opt</ucd>
        -- <unit>km/s</unit>
    isVar BIT(1) NOT NULL,
        -- <descr>1 for variable stars, 0 for galaxies and non-variable stars.
        -- </descr>
        -- <ucd>src.class</ucd>
    redshift DOUBLE NULL,
        -- <descr>Redshift. NULL for stars.</descr>
        -- <ucd>src.redshift</ucd>
    uCov INTEGER NOT NULL,
        -- <descr>Number of u-band science CCDs containing reference object.
        -- </descr>
        -- <ucd>meta.number</ucd>
    gCov INTEGER NOT NULL,
        -- <descr>Number of g-band science CCDs containing reference object.
        -- </descr>
        -- <ucd>meta.number</ucd>
    rCov INTEGER NOT NULL,
        -- <descr>Number of r-band science CCDs containing reference object.
        -- </descr>
        -- <ucd>meta.number</ucd>
    iCov INTEGER NOT NULL,
        -- <descr>Number of i-band science CCDs containing reference object.
        -- </descr>
        -- <ucd>meta.number</ucd>
    zCov INTEGER NOT NULL,
        -- <descr>Number of z-band science CCDs containing reference object.
        -- </descr>
        -- <ucd>meta.number</ucd>
    yCov INTEGER NOT NULL,
        -- <descr>Number of y-band science CCDs containing reference object.
        -- </descr>
        -- <ucd>meta.number</ucd>
    PRIMARY KEY (refObjectId),
    INDEX IDX_decl (decl ASC)
) ENGINE=MyISAM;


CREATE TABLE sdqa_ImageStatus
    -- <descr>Unique set of status names and their definitions, e.g.
    -- &quot;passed&quot;, &quot;failed&quot;, etc.</descr>
(
    sdqa_imageStatusId SMALLINT NOT NULL AUTO_INCREMENT,
        -- <descr>Primary key</descr>
    statusName VARCHAR(30) NOT NULL,
        -- <descr>One-word, camel-case, descriptive name of a possible image
        -- status (e.g., passedAuto, marginallyPassedManual, etc.)</descr>
    definition VARCHAR(255) NOT NULL,
        -- <descr>Detailed Definition of the image status</descr>
    PRIMARY KEY (sdqa_imageStatusId)
) ENGINE=MyISAM;


CREATE TABLE sdqa_Metric
    -- <descr>Unique set of metric names and associated metadata (e.g.,
    -- &quot;nDeadPix&quot;, &quot;median&quot;, etc.). There will be
    -- approximately 30 records total in this table.</descr>
(
    sdqa_metricId SMALLINT NOT NULL AUTO_INCREMENT,
        -- <descr>Primary key.</descr>
    metricName VARCHAR(30) NOT NULL,
        -- <descr>One-word, camel-case, descriptive name of a possible metric
        -- (e.g., mSatPix, median, etc).</descr>
    physicalUnits VARCHAR(30) NOT NULL,
        -- <descr>Physical units of metric.</descr>
    dataType CHAR(1) NOT NULL,
        -- <descr>Flag indicating whether data type of the metric value is
        -- integer (0) or float (1)</descr>
    definition VARCHAR(255) NOT NULL,
    PRIMARY KEY (sdqa_metricId),
    UNIQUE UQ_sdqaMetric_metricName(metricName)
) ENGINE=MyISAM;


CREATE TABLE sdqa_Rating_ForAmpVisit
    -- <descr>Various SDQA ratings for a given amplifier image. There will
    -- approximately 30 of these records per image record.</descr>
(
    sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Primary key. Auto-increment is used, we define a composite
        -- unique key, so potential duplicates will be captured.</descr>
    sdqa_metricId SMALLINT NOT NULL,
        -- <descr>Pointer to sdqa_Metric.</descr>
    sdqa_thresholdId SMALLINT NOT NULL,
        -- <descr>Pointer to sdqa_Threshold.</descr>
    ampVisitId BIGINT NOT NULL,
        -- <descr>Pointer to AmpVisit.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    metricValue DOUBLE NOT NULL,
        -- <descr>Value of this SDQA metric.</descr>
    metricSigma DOUBLE NOT NULL,
        -- <descr>Uncertainty of the value of this metric.</descr>
    PRIMARY KEY (sdqa_ratingId),
    UNIQUE UQ_sdqaRating_ForAmpVisit_metricId_ampVisitId(sdqa_metricId, ampVisitId),
    INDEX (sdqa_metricId),
    INDEX (sdqa_thresholdId),
    INDEX (ampVisitId)
) ENGINE=MyISAM;


CREATE TABLE sdqa_Rating_CcdVisit
    -- <descr>Various SDQA ratings for a given CcdVisit.</descr>
(
    sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Primary key. Auto-increment is used, we define a composite
        -- unique key, so potential duplicates will be captured.</descr>
    sdqa_metricId SMALLINT NOT NULL,
        -- <descr>Pointer to sdqa_Metric.</descr>
    sdqa_thresholdId SMALLINT NOT NULL,
        -- <descr>Pointer to sdqa_Threshold.</descr>
    ccdVisitId BIGINT NOT NULL,
        -- <descr>Pointer to CcdVisit.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    metricValue DOUBLE NOT NULL,
        -- <descr>Value of this SDQA metric.</descr>
    metricSigma DOUBLE NOT NULL,
        -- <descr>Uncertainty of the value of this metric.</descr>
    PRIMARY KEY (sdqa_ratingId),
    UNIQUE UQ_sdqa_Rating_ForCcdVisit_metricId_ccdVisitId(sdqa_metricId, ccdVisitId),
    INDEX (sdqa_metricId),
    INDEX (sdqa_thresholdId),
    INDEX (ccdVisitId)
) ENGINE=MyISAM;


CREATE TABLE sdqa_Threshold
    -- <descr>Version-controlled metric thresholds. Total number of these
    -- records is approximately equal to 30 x the number of times the thresholds
    -- will be changed over the entire period of LSST operations (of ordre of
    -- 100), with most of the changes occuring in the first year of operations.
    -- </descr>
(
    sdqa_thresholdId SMALLINT NOT NULL AUTO_INCREMENT,
        -- <descr>Primary key.</descr>
    sdqa_metricId SMALLINT NOT NULL,
        -- <descr>Pointer to sdqa_Metric table.</descr>
    upperThreshold DOUBLE NULL,
        -- <descr>Threshold for which a metric value is tested to be greater
        -- than.</descr>
    lowerThreshold DOUBLE NULL,
        -- <descr>Threshold for which a metric value is tested to be less than.
        -- </descr>
    createdDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Database timestamp when the record is inserted.</descr>
    PRIMARY KEY (sdqa_thresholdId),
    UNIQUE UQ_sdqa_Threshold_sdqa_metricId(sdqa_metricId),
    INDEX (sdqa_metricId)
) ENGINE=MyISAM;


CREATE TABLE Visit_To_RawExposure
    -- <descr>Mapping table: Visit to raw Exposure.</descr>
(
    visitId INTEGER NOT NULL,
        -- <descr>Pointer to entry in Visit table.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    rawExposureId BIGINT NOT NULL,
        -- <descr>Pointer to entry in RawExposure table.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    INDEX IDX_VisitToRawExposure_visitId (visitId),
    INDEX IDX_VisitToRawExposure_rawExposureId (rawExposureId)
) ENGINE=MyISAM;


CREATE TABLE RaftMetadata
(
    raftName BIGINT NOT NULL,
        -- <descr>tbd</descr>
        -- <ucd>meta.id;instr.det</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    metadataValue VARCHAR(255) NULL,
    PRIMARY KEY (raftName)
) ENGINE=MyISAM;


CREATE TABLE RawAmpExposure
    -- <descr>Exposure for one amplifier (raw image).</descr>
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    rawCcdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to RawCcdExposure containing this amp
        -- exposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    ampName CHAR(3) NOT NULL,
        -- <descr>Amplifier name.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Ccd name.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    raftName CHAR(3) NOT NULL,
        -- <descr>Raft name.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    filterName CHAR NOT NULL,
        -- <descr>Filter name.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>Ra of amp center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl of amp center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    gain FLOAT NULL,
        -- <descr>Detector/amplifier gain</descr>
    rdNoise FLOAT NULL,
        -- <descr>Read noise for detector/amplifier</descr>
    saturate FLOAT NULL,
        -- <descr>Maximum data value for A/D converter</descr>
    equinox FLOAT NOT NULL,
        -- <descr>Equinox of World Coordinate System.</descr>
        -- <ucd>pos.equinox</ucd>
    raDeSys VARCHAR(20) NOT NULL,
        -- <ucd>pos.frame</ucd>
    ctype1 VARCHAR(20) NOT NULL,
        -- <descr>Coordinate projection type, axis 1.</descr>
        -- <ucd>pos.wcs.ctype</ucd>
    ctype2 VARCHAR(20) NOT NULL,
        -- <descr>Coordinate projection type, axis 2.</descr>
        -- <ucd>pos.wcs.ctype</ucd>
    crpix1 FLOAT NOT NULL,
        -- <descr>Coordinate reference pixel, axis 1.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crpix2 FLOAT NOT NULL,
        -- <descr>Coordinate reference pixel, axis 2.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crval1 DOUBLE NOT NULL,
        -- <descr>Coordinate value 1 @reference pixel.</descr>
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    crval2 DOUBLE NOT NULL,
        -- <descr>Coordinate value 2 @reference pixel.</descr>
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    cd1_1 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 1.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd1_2 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 2.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_1 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 1.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_2 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 2.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    llcRa DOUBLE NOT NULL,
        -- <descr>Ra of FITS pixel coordinates (0.5, 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    llcDecl DOUBLE NOT NULL,
        -- <descr>Decl of FITS pixel coordinates (0.5, 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    ulcRa DOUBLE NOT NULL,
        -- <descr>Ra of FITS pixel coordinates
        -- (0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    ulcDecl DOUBLE NOT NULL,
        -- <descr>Decl of FITS pixel coordinates
        -- (0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    urcRa DOUBLE NOT NULL,
        -- <descr>Ra of FITS pixel coordinates
        -- (NAXIS1 + 0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    urcDecl DOUBLE NOT NULL,
        -- <descr>Decl of FITS pixel coordinates
        -- (NAXIS1 + 0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    lrcRa DOUBLE NOT NULL,
        -- <descr>Ra of FITS pixel coordinates
        -- (NAXIS1 + 0.5, 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    lrcDecl DOUBLE NOT NULL,
        -- <descr>Decl of FITS pixel coordinates
        -- (NAXIS1 + 0.5, 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    taiMjd DOUBLE NOT NULL,
        -- <descr>Time (MJD, TAI) at the start of the exposure</descr>
        -- <ucd>time.start</ucd>
        -- <unit>d</unit>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Time (UTC, 1s precision) at the start of the
        -- exposure.</descr>
        -- <ucd>time.start</ucd>
    expMidpt VARCHAR(30) NOT NULL,
        -- <descr>Time (ISO8601 format, UTC) at the mid-point of the
        -- exposure.</descr>
        -- <ucd>time.epoch</ucd>
    expTime FLOAT NOT NULL,
        -- <descr>Duration of exposure.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    airmass FLOAT NOT NULL,
        -- <ucd>obs.airmass</ucd>
    darkTime FLOAT NOT NULL,
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    zd FLOAT NULL,
        -- <ucd>pos.az.zd</ucd>
        -- <unit>deg</unit>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_RawAmpExposure (rawAmpExposureId),
    INDEX IDX_RawAmpExposure_procHistoryId (procHistoryId)
) ENGINE=MyISAM;


CREATE TABLE RawAmpExposureMetadata
    -- <descr>Generic key-value pair metadata for RawAmpExposure.</descr>
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding RawAmpExposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (rawAmpExposureId, metadataKey),
    INDEX IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;


CREATE TABLE RawCcdExposure
(
    rawCcdExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    rawExposureId BIGINT NOT NULL,
        -- <descr>Point to the RawExposure containing this ccd
        -- exposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Ccd name.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    raftName CHAR(3) NOT NULL,
        -- <descr>Raft name.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    filterName CHAR NULL,
        -- <descr>Filter name.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>Right Ascension of aperture center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Declination of aperture center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    equinox FLOAT NOT NULL,
        -- <descr>Equinox of World Coordinate System.</descr>
        -- <ucd>pos.equinox</ucd>
    radecSys VARCHAR(20) NULL,
        -- <descr>Coordinate system type. (Allowed systems: FK5, ICRS)</descr>
        -- <ucd>pos.frame</ucd>
    dateObs TIMESTAMP NOT NULL DEFAULT 0,
        -- <descr>Date/Time of observation start (UTC).</descr>
    url VARCHAR(255) NOT NULL,
        -- <descr>Logical URL to the actual raw image.</descr>
    ctype1 VARCHAR(20) NOT NULL,
        -- <descr>Coordinate projection type, axis 1.</descr>
        -- <ucd>pos.wcs.ctype</ucd>
    ctype2 VARCHAR(20) NOT NULL,
        -- <descr>Coordinate projection type, axis 2.</descr>
        -- <ucd>pos.wcs.ctype</ucd>
    mjdObs DOUBLE NULL,
        -- <descr>MJD of observation start.</descr>
    airmass FLOAT NULL,
        -- <descr>Airmass value for the Amp reference pixel (preferably center,
        -- but not guaranteed). Range: [-99.999, 99.999] is enough to accomodate
        -- ZD in [0, 89.433].</descr>
    crpix1 FLOAT NOT NULL,
        -- <descr>Coordinate reference pixel, axis 1.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crpix2 FLOAT NOT NULL,
        -- <descr>Coordinate reference pixel, axis 2.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crval1 DOUBLE NOT NULL,
        -- <descr>Coordinate value 1 @reference pixel.</descr>
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    crval2 DOUBLE NOT NULL,
        -- <descr>Coordinate value 2 @reference pixel.</descr>
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    cd1_1 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 1.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd1_2 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 2.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_1 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 1.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_2 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 2.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    darkTime FLOAT NULL,
        -- <descr>Total elapsed time from exposure start to end of read.</descr>
        -- <unit>s</unit>
    zd FLOAT NULL,
        -- <descr>Zenith distance at observation mid-point.</descr>
        -- <ucd>pos.az.zd</ucd>
        -- <unit>deg</unit>
    taiObs TIMESTAMP NOT NULL DEFAULT 0,
        -- <descr>TAI-OBS = UTC + offset, offset = 32 s from 1/1/1999 to
        -- 1/1/2006</descr>
    expTime FLOAT NOT NULL,
        -- <descr>Duration of exposure.</descr>
        -- <unit>s</unit>
    PRIMARY KEY (rawCcdExposureId),
    INDEX IDX_RawCcdExposure_procHistoryId (procHistoryId)
) ENGINE=MyISAM;


CREATE TABLE RawCcdExposureMetadata
    -- <descr>Generic key-value pair metadata for RawCcdExposure.</descr>
(
    rawCcdExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding RawCcdExposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    metadataValue VARCHAR(255) NULL,
    PRIMARY KEY PK_RawCcdExposureMetadata (rawCcdExposureId)
) ENGINE=MyISAM;


CREATE TABLE RawExposure
    -- <descr>Raw exposure (entire exposure, all ccds)
(
    rawExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    PRIMARY KEY PK_RawExposure (rawExposureId)
) ENGINE=MyISAM;


CREATE TABLE CcdVisit
(
    ccdVisitId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    visitId INTEGER NOT NULL,
        -- <descr>Reference to the corresponding entry in the Visit table.</descr>
        -- <ucd>meta.id;obs.exposure</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Ccd name.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    raftName CHAR(3) NOT NULL,
        -- <descr>Raft name.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    filterName CHAR NOT NULL,
        -- <descr>Filter name used for this exposure.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    ra DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    equinox FLOAT NOT NULL,
        -- <descr>Equinox of World Coordinate System.</descr>
        -- <ucd>pos.equinox</ucd>
    raDeSys VARCHAR(20) NOT NULL,
        -- <ucd>pos.frame</ucd>
    ctype1 VARCHAR(20) NOT NULL,
        -- <descr>Coordinate projection type, axis 1.</descr>
        -- <ucd>pos.wcs.ctype</ucd>
    ctype2 VARCHAR(20) NOT NULL,
        -- <descr>Coordinate projection type, axis 2.</descr>
        -- <ucd>pos.wcs.ctype</ucd>
    crpix1 FLOAT NOT NULL,
        -- <descr>Coordinate reference pixel, axis 1.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crpix2 FLOAT NOT NULL,
        -- <descr>Coordinate reference pixel, axis 2.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crval1 DOUBLE NOT NULL,
        -- <descr>Coordinate value 1 @reference pixel.</descr>
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    crval2 DOUBLE NOT NULL,
        -- <descr>Coordinate value 2 @reference pixel.</descr>
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    cd1_1 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 1.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd1_2 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 2.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_1 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 1.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_2 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 2.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    llcRa DOUBLE NOT NULL,
        -- <descr>Ra of FITS pixel coordinates (0.5, 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    llcDecl DOUBLE NOT NULL,
        -- <descr>Decl of FITS pixel coordinates (0.5, 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    ulcRa DOUBLE NOT NULL,
        -- <descr>Ra of FITS pixel coordinates
        -- (0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    ulcDecl DOUBLE NOT NULL,
        -- <descr>Decl of FITS pixel coordinates
        -- (0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    urcRa DOUBLE NOT NULL,
        -- <descr>Ra of FITS pixel coordinates
        -- (NAXIS1 + 0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    urcDecl DOUBLE NOT NULL,
        -- <descr>Decl of FITS pixel coordinates
        -- (NAXIS1 + 0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    lrcRa DOUBLE NOT NULL,
        -- <descr>Ra of FITS pixel coordinates
        -- (NAXIS1 + 0.5, 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    lrcDecl DOUBLE NOT NULL,
        -- <descr>Decl of FITS pixel coordinates
        -- (NAXIS1 + 0.5, 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    taiMjd DOUBLE NOT NULL,
        -- <descr>Time (MJD, TAI) at the start of the exposure.</descr>
        -- <ucd>time.start</ucd>
        -- <unit>d</unit>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Time (UTC, 1s precision) at the start of the
        -- exposure.</descr>
        -- <ucd>time.start</ucd>
    expMidpt VARCHAR(30) NOT NULL,
        -- <descr>Time (ISO8601 format, UTC) at the mid-point of the
        -- combined exposure.</descr>
        -- <ucd>time.epoch</ucd>
    expTime FLOAT NOT NULL,
        -- <descr>Duration of exposure.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    nCombine INTEGER NOT NULL,
        -- <descr>Number of images co-added to create a deeper image</descr>
        -- <ucd>meta.number</ucd>
    binX INTEGER NOT NULL,
        -- <descr>Binning of the ccd in x.</descr>
        -- <ucd>meta.number</ucd>
        -- <unit>pixel</unit>
    binY INTEGER NOT NULL,
        -- <descr>Binning of the ccd in y.</descr>
        -- <ucd>meta.number</ucd>
        -- <unit>pixel</unit>
    readNoise FLOAT NOT NULL,
        -- <descr>Read noise of the ccd.</descr>
        -- <ucd>instr.det.noise</ucd>
        -- <unit>adu</unit>
    saturationLimit INTEGER NOT NULL,
        -- <descr>Saturation limit for the ccd (average of the amplifiers).
        -- </descr>
        -- <ucd>instr.saturation</ucd>
    gainEff DOUBLE NOT NULL,
        -- <ucd>arith.factor;instr.det</ucd>
        -- <unit>electron/adu</unit>
    fluxMag0 FLOAT NOT NULL,
        -- <ucd>phot.flux.density</ucd>
    fluxMag0Sigma FLOAT NOT NULL,
        -- <ucd>stat.error;phot.flux.density</ucd>
    fwhm DOUBLE NOT NULL,
        -- <ucd>instr.obsty.seeing</ucd>
        -- <unit>arcsec</unit>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_Visit (ccdVisitId),
    INDEX IDX_Visit_procHistoryId (procHistoryId)
) ENGINE=MyISAM;


CREATE TABLE CcdVisitMetadata
    -- <descr>Generic key-value pair metadata for CcdVisit.</descr>
(
    ccdVisitId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY PK_CcdVisitMetadata (ccdVisitId, metadataKey),
    INDEX IDX_CcdVisitMetadata_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;


CREATE TABLE Visit
    -- <descr>Defines a single Visit.</descr>
(
    visitId INTEGER NOT NULL,
        -- <descr>Unique identifier.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    PRIMARY KEY PK_Visit (visitId)
) ENGINE=MyISAM;


CREATE TABLE VisitMetadata
    -- <descr>Visit-related generic key-value pair metadata.</descr>
(
    visitId INTEGER NOT NULL,
        -- <descr>Id of the corresponding Visit.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    metadataValue VARCHAR(255) NULL,
    PRIMARY KEY (visitId)
) ENGINE=MyISAM;


CREATE TABLE DiaSource
    -- <descr>Table to store &quot;difference image sources&quot; - sources
    -- detected at SNR >=5 on difference images.</descr>
(
    diaSourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Name of ccd where this diaSource was measured.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    visitId BIGINT NOT NULL,
        -- <descr>Id of the visit where this diaSource was measured.
        -- Note that we are allowing a diaSource to belong to multiple
        -- amplifiers, but it may not span multiple ccds.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    diaObjectId BIGINT NULL,
        -- <descr>Id of the diaObject this source was associated with, if any.
        -- If not, it is set to NULL (each diaSource will be associated with
        -- either a diaObject or ssObject).</descr>
        -- <ucd>meta.id;src</ucd>
    ssObjectId BIGINT NULL,
        -- <descr>Id of the ssObject this source was associated with, if any.
        -- If not, it is set to NULL (each diaSource will be associated with
        -- either a diaObject or ssObject).</descr>
        -- <ucd>meta.id;src</ucd>
    filterName CHAR NOT NULL,
        -- <descr>Name of the filter used to take the Visit where this
        -- diaSource was measured.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    ssObjectReassocTime DATETIME NULL,
        -- <descr>Time when this diaSource was reassociated from diaObject
        -- to ssObject (if such reassociation happens, otherwise NULL).</descr>
    midPointTai DOUBLE NOT NULL,
        -- <descr>Effective mid-exposure time for this diaSource.</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    ra DOUBLE NOT NULL,
        -- <descr>RA-coordinate of the center of this diaSource.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    raSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of ra.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr> Decl-coordinate of the center of this diaSource.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    declSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of decl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    ra_Decl_Cov FLOAT NOT NULL,
        -- <descr>Covariance between ra and decl.</descr>
        -- <unit>deg^2</unit>
    x FLOAT NOT NULL,
        -- <descr>x position computed by a centroiding algorithm.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    xSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of x.</descr>
        -- <ucd>stat.error:pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y FLOAT NOT NULL,
        -- <descr>y position computed by a centroiding algorithm.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    ySigma FLOAT NOT NULL,
        -- <descr>Uncertainty of y.</descr>
        -- <ucd>stat.error:pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    x_y_Cov FLOAT NOT NULL,
        -- <descr>Covariance between x and y.</descr>
        -- <unit>pixel^2</unit>
    snr FLOAT NOT NULL,
        -- <descr>The signal-to-noise ratio at which this source was 
        -- detected in the difference image.</descr>
    psFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model. Note 
        -- this actually measures the flux difference between the 
        -- template and the visit image.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    psFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of psFlux.</descr>
        -- <unit>nmgy</unit>
    psLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed 
        -- data given the Point Source model.</descr>
    trailFlux FLOAT NULL,
        -- <descr>Calibrated flux for a trailed source model. 
        -- Note this actually measures the flux difference 
        -- between the template and the visit image.</descr>
        -- <unit>nmgy</unit>
    trailFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of trailFlux.</descr>
        -- <unit>nmgy</unit>
    trailLength FLOAT NULL,
        -- <descr>Maximum likelihood fit of trail length.</descr>
        -- <unit>arcsec</unit>
    trailLengthSigma FLOAT NULL,
        -- <descr>Uncertainty of trailLength.</descr>
        -- <unit>nmgy</unit>
    trailAngle FLOAT NULL,
        -- <descr>Maximum likelihood fit of the angle between 
        -- the meridian through the centroid and the trail 
        -- direction (bearing).</descr>
        -- <unit>degrees</unit>
    trailAngleSigma FLOAT NULL,
        -- <descr>Uncertainty of trailAngle.</descr>
        -- <unit>nmgy</unit>
    trailLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data 
        -- given the trailed source model.</descr>
    trailFlux_trailLength_Cov FLOAT NULL,
        -- <descr>Covariance of trailFlux and trailLength</desccr>
    trailFlux_trailAngle_Cov FLOAT NULL,
        -- <descr>Covariance of trailFlux and trailAngle</descr>
    trailLength_trailAngle_Cov FLOAT NULL,
        -- <descr>Covariance of trailLength and trailAngle</descr>
    fpFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model measured 
        -- on the visit image centered at the centroid measured on
        -- the difference image (forced photometry flux).</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    fpFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of fpFlux</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
    E1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure of the source as measured 
        -- on the difference image.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    E1Sigma FLOAT NULL,
        -- <descr>Uncertainty of E1.</descr>
        -- <ucd>stat.error:phys.size.axisRatio</ucd>
    E2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure of the source as measured 
        -- on the difference image.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    E2Sigma FLOAT NULL,
        -- <descr>Uncertainty of E2.</descr>
        -- <ucd>stat.error:phys.size.axisRatio</ucd>
    E1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of E1 and E2</descr>
    mSum FLOAT NULL,
        -- <descr>Sum of second adaptive moments.</descr>
    mSumSigma FLOAT NULL,
        -- <descr>Uncertainty of mSum.</descr>
    extendedness FLOAT NULL,
        -- <descr>A measure of extendedness, Computed using a 
        -- combination of available moments and model fluxes or
        -- from a likelihood ratio of point/trailed source 
        -- models (exact algorithm TBD). extendedness = 1 implies
        -- a high degree of confidence that the source is extended.
        -- extendedness = 0 implies a high degree of confidence
        -- that the source is point-like.</descr>
    flags BIGINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd.</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_DiaSource (diaSourceId),
    INDEX IDX_DiaSource_procHistoryId (procHistoryId),
    INDEX IDX_DiaSource_visitId (visitId),
    INDEX IDX_DiaSource_diaObjectId (diaObjectId),
    INDEX IDX_DiaSource_ccObjectId (ssObjectId),
    INDEX IDX_DiaSource_filterName (filterName)
) ENGINE=MyISAM;


CREATE TABLE DiaObject
    -- <descr>The DiaObject table contains descriptions of the 
    -- astronomical objects detected on one or more difference images.
    -- </descr>
(
    diaObjectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    validityStart DATETIME NOT NULL,
        -- <descr>Time when validity of this diaObject starts.</descr>
    validityEnd DATETIME NOT NULL,
        -- <descr>Time when validity of this diaObject ends.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA-coordinate of the center of this diaObject.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    raSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of ra.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of this diaObject.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    declSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of decl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    ra_Decl_Cov FLOAT NOT NULL,
        -- <descr>Covariance between ra and decl.</descr>
        -- <unit>deg^2</unit>
    epoch DOUBLE NOT NULL,
        -- <descr>Time at which the object was at a position ra/decl.</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    muRa FLOAT NOT NULL,
        -- <descr>Proper motion (ra).</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>mas/yr</unit>
    muRaSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of muRa.</descr>
        -- <ucd>stat.error;pos.pm</ucd>
        -- <unit>mas/yr</unit>
    muDecl FLOAT NOT NULL,
        -- <descr>Proper motion (decl).</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>mas/yr</unit>
    muDecSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of muDecl.</descr>
        -- <ucd>stat.error;pos.pm</ucd>
        -- <unit>mas/yr</unit>
    muRa_muDeclCov FLOAT NOT NULL,
        -- <descr>Covariance of muRa and muDecl.</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>(mas/yr)^2</unit>
    parallax FLOAT NOT NULL,
        -- <descr>Parallax.</descr>
        -- <ucd>pos.parallax</ucd>
        -- <unit>mas</unit>
    parallaxSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of parallax.</descr>
        -- <ucd>stat.error;pos.parallax</ucd>
        -- <unit>mas</unit>
    muRa_parallax_Cov FLOAT NOT NULL,
        -- <descr>Covariance of muRa and parallax.</descr>
        -- <ucd>FIXME</ucd>
        -- <unit>FIXME</unit>
    muDecl_parallax_Cov FLOAT NOT NULL,
        -- <descr>Covariance of muDecl and parallax.</descr>
        -- <ucd>FIXME</ucd>
        -- <unit>FIXME</unit>
    uPSFlux FLOAT NULL,
        -- <descr>Weighted mean point-source model magnitude for 
        -- u filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    uPSFluxErr FLOAT NULL,
        -- <descr>Standard error of uPSFlux.</descr>
        -- <unit>nmgy</unit>
    uPSFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of uPSFlux.</descr>
        -- <unit>nmgy</unit>
    uFPFlux FLOAT NULL,
        -- <descr>Weighted mean forced photometry flux for u fliter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    uFPFluxErr FLOAT NULL,
        -- <descr>Standard error of uFPFlux.</descr>
        -- <unit>nmgy</unit>
    uFPFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of uFPFlux.</descr>
        -- <unit>nmgy</unit>
    gPSFlux FLOAT NULL,
        -- <descr>Weighted mean point-source model magnitude for 
        -- g filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    gPSFluxErr FLOAT NULL,
        -- <descr>Standard error of gPSFlux.</descr>
        -- <unit>nmgy</unit>
    gPSFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of gPSFlux.</descr>
        -- <unit>nmgy</unit>
    gFPFlux FLOAT NULL,
        -- <descr>Weighted mean forced photometry flux for g fliter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    gFPFluxErr FLOAT NULL,
        -- <descr>Standard error of gFPFlux.</descr>
        -- <unit>nmgy</unit>
    gFPFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of gFPFlux.</descr>
        -- <unit>nmgy</unit>
    rPSFlux FLOAT NULL,
        -- <descr>Weighted mean point-source model magnitude for 
        -- u filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    rPSFluxErr FLOAT NULL,
        -- <descr>Standard error of rPSFlux.</descr>
        -- <unit>nmgy</unit>
    rPSFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of rPSFlux.</descr>
        -- <unit>nmgy</unit>
    rFPFlux FLOAT NULL,
        -- <descr>Weighted mean forced photometry flux for r fliter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    rFPFluxErr FLOAT NULL,
        -- <descr>Standard error of rFPFlux.</descr>
        -- <unit>nmgy</unit>
    rFPFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of rFPFlux.</descr>
        -- <unit>nmgy</unit>
    iPSFlux FLOAT NULL,
        -- <descr>Weighted mean point-source model magnitude for 
        -- i filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    iPSFluxErr FLOAT NULL,
        -- <descr>Standard error of iPSFlux.</descr>
        -- <unit>nmgy</unit>
    iPSFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of iPSFlux.</descr>
        -- <unit>nmgy</unit>
    iFPFlux FLOAT NULL,
        -- <descr>Weighted mean forced photometry flux for i fliter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    iFPFluxErr FLOAT NULL,
        -- <descr>Standard error of iFPFlux.</descr>
        -- <unit>nmgy</unit>
    iFPFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of uFPFlux.</descr>
        -- <unit>nmgy</unit>
    zPSFlux FLOAT NULL,
        -- <descr>Weighted mean point-source model magnitude for 
        -- z filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    zPSFluxErr FLOAT NULL,
        -- <descr>Standard error of zPSFlux.</descr>
        -- <unit>nmgy</unit>
    zPSFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of zPSFlux.</descr>
        -- <unit>nmgy</unit>
    zFPFlux FLOAT NULL,
        -- <descr>Weighted mean forced photometry flux for z fliter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    zFPFluxErr FLOAT NULL,
        -- <descr>Standard error of zFPFlux.</descr>
        -- <unit>nmgy</unit>
    zFPFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of zFPFlux.</descr>
        -- <unit>nmgy</unit>
    yPSFlux FLOAT NULL,
        -- <descr>Weighted mean point-source model magnitude for 
        -- y filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    yPSFluxErr FLOAT NULL,
        -- <descr>Standard error of yPSFlux.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    yPSFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of yPSFlux.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    yFPFlux FLOAT NULL,
        -- <descr>Weighted mean forced photometry flux for y fliter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    yFPFluxErr FLOAT NULL,
        -- <descr>Standard error of yFPFlux.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    yFPFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of yFPFlux.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    flags BIGINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd.</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_DiaObject (diaObjectId, validityStart),
    INDEX IDX_DiaObject_validityStart (validityStart),
    INDEX IDX_DiaObject_procHistoryId (procHistoryId)
) ENGINE=MyISAM;


CREATE TABLE ForcedSource
    -- <descr>Forced-photometry source measurement on an individual Exposure
    -- based on a Multifit shape model derived from a deep detection.
    -- </descr>
(
    objectId BIGINT NOT NULL,
        -- <ucd>meta.id;src</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Name of the CCD where this forcedSource was measured.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    visitId BIGINT NOT NULL,
        -- <descr>Id of the visit where this forcedSource was measured.
        -- Note that we are allowing a forcedSource to belong to multiple
        -- amplifiers, but it may not span multiple ccds.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    psFlux FLOAT NOT NULL,
        -- <descr>Point Source model flux.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    psFlux_Sigma FLOAT NULL,
        -- <descr>Uncertainty of psFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
        -- <descr>x position computed by a centroiding algorithm.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    flags TINYINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_ForcedSource (objectId, ccdName, visitId),
    INDEX IDX_ForcedSource_procHistoryId (procHistoryId)
) ENGINE=MyISAM;


CREATE TABLE ForcedDiaSource
    -- <descr>Forced-photometry source measurement on an individual 
    -- difference Exposure based on a Multifit shape model derived 
    -- from a deep detection.</descr>
(
    objectId BIGINT NOT NULL,
        -- <ucd>meta.id;src</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Name of the CCD where this forcedSource was measured.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    visitId BIGINT NOT NULL,
        -- <descr>Id of the visit where this forcedSource was measured.
        -- Note that we are allowing a forcedSource to belong to multiple
        -- amplifiers, but it may not span multiple ccds.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    x FLOAT NOT NULL,
        -- <descr>x position computed using an algorithm similar 
        -- to that used by SDSS.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y FLOAT NOT NULL,
        -- <descr>y position computed using an algorithm similar 
        -- to that used by SDSS.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    psFlux FLOAT NOT NULL,
        -- <descr>Point Source model flux.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    psFlux_Sigma FLOAT NULL,
        -- <descr>Uncertainty of psFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
        -- <descr>x position computed by a centroiding algorithm.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    flags TINYINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_ForcedDiaSource (objectId, ccdName, visitId)
) ENGINE=MyISAM;


CREATE TABLE SSObject
    -- <descr>The SSObject table contains description of the Solar System
    -- (moving) Objects.</descr>
(
    ssObjectId BIGINT NOT NULL,
        -- <descr>Unique identifier.</descr>
        -- <ucd>meta.id;src</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    q DOUBLE NULL,
        -- <descr>Osculating orbital elements at epoch (q, e, i, lan, aop, 
        -- M, epoch).</descr>
    qSigma DOUBLE NULL,
        -- <descr>Uncertainty of q.</descr>
    e DOUBLE NULL,
        -- <descr>Osculating orbital elements at epoch (q, e, i, lan, aop, 
        -- M, epoch).</descr>
    eSigma DOUBLE NULL,
        -- <descr>Uncertainty of e.</descr>
    i DOUBLE NULL,
        -- <descr>Osculating orbital elements at epoch (q, e, i, lan, aop, 
        -- M, epoch).</descr>
    iSigma DOUBLE NULL,
        -- <descr>Uncertainty of i.</descr>
    lan DOUBLE NULL,
        -- <descr>Osculating orbital elements at epoch (q, e, i, lan, aop, 
        -- M, epoch).</descr>
    lanSigma DOUBLE NULL,
        -- <descr>Uncertainty of lan.</descr>
    aop DOUBLE NULL,
        -- <descr>Osculating orbital elements at epoch (q, e, i, lan, aop, 
        -- M, epoch).</descr>
    oepSigma DOUBLE NULL,
        -- <descr>Uncertainty of aop.</descr>
    M DOUBLE NULL,
        -- <descr>Osculating orbital elements at epoch (q, e, i, lan, aop, 
        -- M, epoch).</descr>
    MSigma DOUBLE NULL,
        -- <descr>Uncertainty of oe6.</descr>
    epoch DOUBLE NULL,
        -- <descr>Osculating orbital elements at epoch (q, e, i, lan, aop, 
        -- M, epoch).</descr>
    epochSigma DOUBLE NULL,
        -- <descr>Uncertainty of oe7.</descr>
    q_e_Cov DOUBLE NULL,
        -- <descr>Covariance of q and e.</descr>
    q_i_Cov DOUBLE NULL,
        -- <descr>Covariance of q and i.</descr>
    q_lan_Cov DOUBLE NULL,
        -- <descr>Covariance of q and lan.</descr>
    q_aop_Cov DOUBLE NULL,
        -- <descr>Covariance of q and aop.</descr>
    q_M_Cov DOUBLE NULL,
        -- <descr>Covariance of q and M.</descr>
    q_epoch_Cov DOUBLE NULL,
        -- <descr>Covariance of q and epoch.</descr>
    e_i_Cov DOUBLE NULL,
        -- <descr>Covariance of e and i.</descr>
    e_lan_Cov DOUBLE NULL,
        -- <descr>Covariance of e and lan.</descr>
    e_aop_Cov DOUBLE NULL,
        -- <descr>Covariance of e and aop.</descr>
    e_M_Cov DOUBLE NULL,
        -- <descr>Covariance of e and M.</descr>
    e_epoch_Cov DOUBLE NULL,
        -- <descr>Covariance of e and epoch.</descr>
    i_lan_Cov DOUBLE NULL,
        -- <descr>Covariance of i and lan.</descr>
    i_aop_Cov DOUBLE NULL,
        -- <descr>Covariance of i and aop.</descr>
    i_M_Cov DOUBLE NULL,
        -- <descr>Covariance of i and M.</descr>
    i_epoch_Cov DOUBLE NULL,
        -- <descr>Covariance of i and epoch.</descr>
    lan_aop_Cov DOUBLE NULL,
        -- <descr>Covariance of lan and aop.</descr>
    lan_M_Cov DOUBLE NULL,
        -- <descr>Covariance of lan and M.</descr>
    lan_epoch_Cov DOUBLE NULL,
        -- <descr>Covariance of lan and epoch.</descr>
    aop_M_Cov DOUBLE NULL,
        -- <descr>Covariance of aop and M.</descr>
    aop_epoch_Cov DOUBLE NULL,
        -- <descr>Covariance of aop and epoch.</descr>
    M_epoch_Cov DOUBLE NULL,
        -- <descr>Covariance of M and epoch.</descr>
    arc FLOAT NULL,
        -- <descr>Arc of observation.</descr>
        -- <unit>days</unit>
    orbFitLnL FLOAT NULL,
        -- <descr>Natural log of the likelihood of the orbital 
        -- elements fit.</descr>
    nOrbFit INTEGER NULL,
        -- <descr>Number of observations used in the fit.</descr>
    MOID1 FLOAT NULL,
        -- <descr>Minimum orbit intersection distance.</descr>
        -- <unit>AU</unit>
    MOID2 FLOAT NULL,
        -- <descr>Minimum orbit intersection distance.</descr>
        -- <unit>AU</unit>
    moidLon1 DOUBLE NULL,
        -- <descr>MOID longitudes.</descr>
        -- <unit>deg</unit>
    moidLon2 DOUBLE NULL,
        -- <descr>MOID longitudes.</descr>
        -- <unit>deg</unit>
    uH FLOAT NULL,
        -- <descr>Mean absolute magnitude for u filter.</descr>
        -- <unit>mag</unit>
    uHSigma FLOAT NULL,
        -- <descr>Uncertainty of uH.</descr>
        -- <unit>mag</unit>
    uG FLOAT NULL,
        -- <descr>Fitted slope parameter for u filter.</descr>
        -- <unit>mag</unit>
    uGSigma FLOAT NULL,
        -- <descr>Uncertainty of uG.</descr>
        -- <unit>mag</unit>
    gH FLOAT NULL,
        -- <descr>Mean absolute magnitude for g filter.</descr>
        -- <unit>mag</unit>
    gHSigma FLOAT NULL,
        -- <descr>Uncertainty of gH.</descr>
        -- <unit>mag</unit>
    gG FLOAT NULL,
        -- <descr>Fitted slope parameter for g filter.</descr>
        -- <unit>mag</unit>
    gGSigma FLOAT NULL,
        -- <descr>Uncertainty of gG.</descr>
        -- <unit>mag</unit>
    rH FLOAT NULL,
        -- <descr>Mean absolute magnitude for r filter.</descr>
        -- <unit>mag</unit>
    rHSigma FLOAT NULL,
        -- <descr>Uncertainty of rH.</descr>
        -- <unit>mag</unit>
    rG FLOAT NULL,
        -- <descr>Fitted slope parameter for r filter.</descr>
        -- <unit>mag</unit>
    rGSigma FLOAT NULL,
        -- <descr>Uncertainty of rG.</descr>
        -- <unit>mag</unit>
    iH FLOAT NULL,
        -- <descr>Mean absolute magnitude for i filter.</descr>
        -- <unit>mag</unit>
    iHSigma FLOAT NULL,
        -- <descr>Uncertainty of iH.</descr>
        -- <unit>mag</unit>
    iG FLOAT NULL,
        -- <descr>Fitted slope parameter for i filter.</descr>
        -- <unit>mag</unit>
    iGSigma FLOAT NULL,
        -- <descr>Uncertainty of iG.</descr>
        -- <unit>mag</unit>
    zH FLOAT NULL,
        -- <descr>Mean absolute magnitude for z filter.</descr>
        -- <unit>mag</unit>
    zHSigma FLOAT NULL,
        -- <descr>Uncertainty of zH.</descr>
        -- <unit>mag</unit>
    zG FLOAT NULL,
        -- <descr>Fitted slope parameter for z filter.</descr>
        -- <unit>mag</unit>
    zGSigma FLOAT NULL,
        -- <descr>Uncertainty of zG.</descr>
        -- <unit>mag</unit>
    yH FLOAT NULL,
        -- <descr>Mean absolute magnitude for y filter.</descr>
        -- <unit>mag</unit>
    yHSigma FLOAT NULL,
        -- <descr>Uncertainty of yH.</descr>
        -- <unit>mag</unit>
    yG FLOAT NULL,
        -- <descr>Fitted slope parameter for y filter.</descr>
       -- <unit>mag</unit>
    yGSigma FLOAT NULL,
        -- <descr>Uncertainty of yG.</descr>
        -- <unit>mag</unit>
    flags BIGINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd.</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_SSObject (ssObjectId),
    INDEX IDX_SSObject_procHistoryId (procHistoryId)
) ENGINE=MyISAM;


CREATE TABLE Object
    -- <descr>The Object table contains descriptions of the multi-epoch static
    -- astronomical objects, in particular their astrophysical properties as
    -- derived from analysis of the Sources that are associated with them. Note
    -- that fast moving objects are kept in the MovingObject tables. Note that
    -- less-frequently used columns are stored in a separate table called
    -- Object_Extra.</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    parentObjectId BIGINT NULL,
        -- <descr>Id of the parent object this object has been deblended
        -- from, if any.</descr>
    psEpoch DOUBLE,
        -- <descr>Point Source model: Time at which the object was at
        -- position (psRa, psDecl).</descr>
        -- <unit>time</unit>
    psRa DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the Point 
        -- Source model at time 'psEpoch'.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    psRaSigma FLOAT NULL,
        -- <descr>Uncertainty of psRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    psDecl DOUBLE NULL,
        -- <descr>Decl-coordinate of the center of the object for the Point 
        -- Source model at time 'psEpoch'.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    psDeclSigma FLOAT NULL,
        -- <descr>Uncertainty of psDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    psMuRa FLOAT NULL,
        -- <descr>Proper motion (ra) for the Point Source model.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>mas/yr</unit>
    psMuRaSigma FLOAT NULL,
        -- <descr>Uncertainty of psMuRa.</descr>
        -- <ucd>stat.error;pos.pm</ucd>
        -- <unit>mas/yr</unit>
    psMuDecl FLOAT NULL,
        -- <descr>Proper motion (decl) for the Point Source model.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>mas/yr</unit>
    psMuDeclSigma FLOAT NULL,
        -- <descr>Uncertainty of psMuDecl.</descr>
        -- <ucd>stat.error;pos.pm</ucd>
        -- <unit>mas/yr</unit>
    psParallax DOUBLE NULL,
        -- <descr>Stellar parallax. for the Point Source model.</descr>
        -- <ucd>pos.parallax</ucd>
        -- <unit>mas</unit>
    psParallaxSigma FLOAT NULL,
        -- <descr>Uncertainty of psParallax.</descr>
        -- <ucd>stat.error;pos.parallax</ucd>
        -- <unit>mas</unit>
    psFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    psFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of psFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
    psLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data given 
        -- the Point Source model.</descr>
    bdRa DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the 
        -- Bulge+Disk model at time radecTai.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    bdRaSigma FLOAT NULL,
        -- <descr>Uncertainty of bdRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    bdDecl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the object for 
        -- the Bulge+Disk model at time radecTai.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    bdDeclSigma FLOAT NULL,
        -- <descr>Uncertainty of bdDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    bdE1 FLOAT NULL,
        -- <descr>Ellipticity for the Bulge+Disk (e1).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    bdE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of bdE1.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    bdE2 FLOAT NULL,
        -- <descr>Ellipticity for Bulge+Disk model (e2).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    bdE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of bdE2.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uBdFluxB FLOAT  NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component
        -- for the Bulge+Disk model. For u filter.</descr>
        -- <unit>nmgy</unit>
    uBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of uBdFluxB.</descr>
        -- <unit>nmgy</unit>
    uBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component
        -- for the Bulge+Disk model. For u filter.</descr>
        -- <unit>nmgy</unit>
    uBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of uBdFluxD.</descr>
        -- <unit>nmgy</unit>
    gBdFluxB FLOAT  NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component
        -- for the Bulge+Disk model. For g filter.</descr>
        -- <unit>nmgy</unit>
    gBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of gBdFluxB.</descr>
        -- <unit>nmgy</unit>
    gBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component
        -- for the Bulge+Disk model. For g filter.</descr>
        -- <unit>nmgy</unit>
    gBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of gBdFluxD.</descr>
        -- <unit>nmgy</unit>
    rBdFluxB FLOAT NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component
        -- for the Bulge+Disk model. For r filter.</descr>
        -- <unit>nmgy</unit>
    rBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of rBdFluxB.</descr>
        -- <unit>nmgy</unit>
    rBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component
        -- for the Bulge+Disk model. For r filter.</descr>
        -- <unit>nmgy</unit>
    rBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of rBdFluxD.</descr>
        -- <unit>nmgy</unit>
    iBdFluxB FLOAT NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component
        -- for the Bulge+Disk model. For i filter.</descr>
        -- <unit>nmgy</unit>
    iBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of iBdFluxB.</descr>
        -- <unit>nmgy</unit>
    iBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component
        -- for the Bulge+Disk model. For i filter.</descr>
        -- <unit>nmgy</unit>
    iBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of iBdFluxD.</descr>
        -- <unit>nmgy</unit>
    zBdFluxB FLOAT NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component
        -- for the Bulge+Disk model. For z filter.</descr>
        -- <unit>nmgy</unit>
    zBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of zBdFluxB.</descr>
        -- <unit>nmgy</unit>
    zBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component
        -- for the Bulge+Disk model. For z filter.</descr>
        -- <unit>nmgy</unit>
    zBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of zBdFluxD.</descr>
        -- <unit>nmgy</unit>
    yBdFluxB FLOAT NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component
        -- for the Bulge+Disk model. For y filter.</descr>
        -- <unit>nmgy</unit>
    yBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of yBdFluxB.</descr>
        -- <unit>nmgy</unit>
    yBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component
        -- for the Bulge+Disk model. For y filter.</descr>
        -- <unit>nmgy</unit>
    yBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of yBdFluxD.</descr>
        -- <unit>nmgy</unit>
    bdReB FLOAT NULL,
        -- <descr>Effective radius of the de Vaucouleurs profile 
        -- component for the Bulge+Disk model.</descr>
        -- <unit>arcsec</unit>
    bdReBSigma FLOAT NULL,
        -- <descr>Uncertainty of bdReB.</descr>
        -- <unit>arcsec</unit>
    bdReD FLOAT NULL,
        -- <descr>Effective radius of the exponential profile
        -- component for the Bulge+Disk model.</descr>
        -- <unit>arcsec</unit>
    bdReDSigma FLOAT NULL,
        -- <descr>Uncertainty of bdReD.</descr>
        -- <unit>arcsec</unit>
    bdLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data 
        -- given the Bulge+Disk model.</descr>
    ugStd FLOAT NOT NULL,
        -- <descr>Color of the object measured in 'standard seeing'.
        -- While the exact algorithm is yet to be determined, this 
        -- color is guaranteed to be seeing-independent and suitable 
        -- for photo-Z determinations.</descr>
        -- <unit>mag</unit>
    ugStdSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of ugStd.</descr>
        -- <unit>mag</unit>
    grStd FLOAT NOT NULL,
        -- <descr>Color of the object measured in 'standard seeing'.
        -- While the exact algorithm is yet to be determined, this 
        -- color is guaranteed to be seeing-independent and suitable 
        -- for photo-Z determinations.</descr>
        -- <unit>mag</unit>
    grStdSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of grStd.</descr>
        -- <unit>mag</unit>
    riStd FLOAT NOT NULL,
        -- <descr>Color of the object measured in 'standard seeing'.
        -- While the exact algorithm is yet to be determined, this 
        -- color is guaranteed to be seeing-independent and suitable 
        -- for photo-Z determinations.</descr>
        -- <unit>mag</unit>
    riStdSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of riStd.</descr>
        -- <unit>mag</unit>
    izStd FLOAT NOT NULL,
        -- <descr>Color of the object measured in 'standard seeing'.
        -- While the exact algorithm is yet to be determined, this 
        -- color is guaranteed to be seeing-independent and suitable 
        -- for photo-Z determinations.</descr>
        -- <unit>mag</unit>
    izStdSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of izStd.</descr>
        -- <unit>mag</unit>
    zyStd FLOAT NOT NULL,
        -- <descr>Color of the object measured in 'standard seeing'.
        -- While the exact algorithm is yet to be determined, this 
        -- color is guaranteed to be seeing-independent and suitable 
        -- for photo-Z determinations.</descr>
        -- <unit>mag</unit>
    zyStdSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of zyStd.</descr>
        -- <unit>mag</unit>
    uRa DOUBLE NULL,
        -- <descr>RA-coordinate coordinate of the centroid computed
        -- for u filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    uRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of uRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    uDecl DOUBLE NULL,
        -- <descr>Decl-coordinate coordinate of the centroid computed
        -- for u filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    uDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of uDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    gRa DOUBLE NULL,
        -- <descr>RA--coordinate coordinate of the centroid computed
        -- for g filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    gRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of gRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    gDecl DOUBLE NULL,
        -- <descr>Decl--coordinate coordinate of the centroid computed
        -- for g filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    gDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of gDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    rRa DOUBLE NULL,
        -- <descr>RA-coordinate coordinate of the centroid computed
        -- for r filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    rRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of rRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    rDecl DOUBLE NULL,
        -- <descr>Decl-coordinate coordinate of the centroid computed
        -- for r filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    rDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of rDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    iRa DOUBLE NULL,
        -- <descr>RA-coordinate coordinate of the centroid computed
        -- for i filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    iRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of iRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    iDecl DOUBLE NULL,
        -- <descr>Decl-coordinate coordinate of the centroid computed
        -- for i filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    iDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of iDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    zRa DOUBLE NULL,
        -- <descr>RA-coordinate coordinate of the centroid computed
        -- for z filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    zRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of zRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    zDecl DOUBLE NULL,
        -- <descr>Decl-coordinate coordinate of the centroid computed
        -- for z filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
       -- <unit>arcsec</unit>
    zDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of zDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    yRa DOUBLE NULL,
        -- <descr>RA-coordinate coordinate of the centroid computed
        -- for y filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    yRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of yRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    yDecl DOUBLE NULL,
        -- <descr>Decl-coordinate coordinate of the centroid computed
        -- for y filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    yDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of yDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    uE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for u filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    uE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of uE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for u filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    uE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of uE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of uE1 and uE2.</descr>
    gE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for g filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    gE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of gE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    gE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for g filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    gE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of gE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    gE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of gE1 and gE2.</descr>
    rE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for r filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    rE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of rE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    rE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for r filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    rE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of rE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    rE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of rE1 and rE2.</descr>
    iE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for i filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    iE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of iE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    iE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for i filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    iE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of iE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    iE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of iE1 and iE2.</descr>
    zE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for z filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    zE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of zE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    zE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for z filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    zE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of zE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    zE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of zE1 and zE2.</descr>
    yE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for y filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    yE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of yE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    yE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for y filter. 
        -- See Bernstein and Jarvis (2002) for detailed discussion 
        -- of all adaptive-moment related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    yE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of yE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    yE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of yE1 and yE2.</descr>
    uMSum FLOAT NULL,
        -- <descr>Sum of second adaptive moments for u filter.</descr>
    uMSumSigma FLOAT NULL,
        -- <descr>Uncertainty of uMSum</descr>
    gMSum FLOAT NULL,
        -- <descr>Sum of second adaptive moments for g filter.</descr>
    gMSumSigma FLOAT NULL,
        -- <descr>Uncertainty of gMSum</descr>
    rMSum FLOAT NULL,
        -- <descr>Sum of second adaptive moments for r filter.</descr>
    rMSumSigma FLOAT NULL,
        -- <descr>Uncertainty of rMSum</descr>
    iMSum FLOAT NULL,
        -- <descr>Sum of second adaptive moments for i filter.</descr>
    iMSumSigma FLOAT NULL,
        -- <descr>Uncertainty of iMSum</descr>
    zMSum FLOAT NULL,
        -- <descr>Sum of second adaptive moments for z filter.</descr>
    zMSumSigma FLOAT NULL,
        -- <descr>Uncertainty of zMSum</descr>
    yMSum FLOAT NULL,
        -- <descr>Sum of second adaptive moments for y filter.</descr>
    yMSumSigma FLOAT NULL,
        -- <descr>Uncertainty of yMSum</descr>
    uM4 FLOAT NULL,
        -- <descr>Fourth order adaptive moment for u filter.</descr>
    gM4 FLOAT NULL,
        -- <descr>Fourth order adaptive moment for g filter.</descr>
    rM4 FLOAT NULL,
        -- <descr>Fourth order adaptive moment for r filter.</descr>
    iM4 FLOAT NULL,
        -- <descr>Fourth order adaptive moment for i filter.</descr>
    zM4 FLOAT NULL,
        -- <descr>Fourth order adaptive moment for z filter.</descr>
    yM4 FLOAT NULL,
        -- <descr>Fourth order adaptive moment for y filter.</descr>
    uPetroRad FLOAT NULL,
        -- <descr>Petrosian radius, computed using elliptical apertures 
        -- defined by the adaptive moments for u filter.</descr>
        -- <unit>arcsec</unit>
    uPetroRadSigma FLOAT NULL,
        -- <descr>Uncertainty of uPetroRad</descr>
        -- <unit>arcsec</unit>
    gPetroRad FLOAT NULL,
        -- <descr>Petrosian radius, computed using elliptical apertures 
        -- defined by the adaptive moments for g filter.</descr>
        -- <unit>arcsec</unit>
    gPetroRadSigma FLOAT NULL,
        -- <descr>Uncertainty of gPetroRad</descr>
        -- <unit>arcsec</unit>
    rPetroRad FLOAT NULL,
        -- <descr>Petrosian radius, computed using elliptical apertures 
        -- defined by the adaptive moments for r filter.</descr>
        -- <unit>arcsec</unit>
    rPetroRadSigma FLOAT NULL,
        -- <descr>Uncertainty of rPetroRad</descr>
        -- <unit>arcsec</unit>
    iPetroRad FLOAT NULL,
        -- <descr>Petrosian radius, computed using elliptical apertures 
        -- defined by the adaptive moments for i filter.</descr>
        -- <unit>arcsec</unit>
    iPetroRadSigma FLOAT NULL,
        -- <descr>Uncertainty of iPetroRad</descr>
        -- <unit>arcsec</unit>
    zPetroRad FLOAT NULL,
        -- <descr>Petrosian radius, computed using elliptical apertures 
        -- defined by the adaptive moments for z filter.</descr>
        -- <unit>arcsec</unit>
    zPetroRadSigma FLOAT NULL,
        -- <descr>Uncertainty of zPetroRad</descr>
        -- <unit>arcsec</unit>
    yPetroRad FLOAT NULL,
        -- <descr>Petrosian radius, computed using elliptical apertures 
        -- defined by the adaptive moments for y filter.</descr>
        -- <unit>arcsec</unit>
    yPetroRadSigma FLOAT NULL,
        -- <descr>Uncertainty of yPetroRad</descr>
        -- <unit>arcsec</unit>
    petroFilter CHAR NOT NULL,
        -- <descr>Name of the filter of the canonical petroRad.</descr>
    uPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of 
        -- the canonical petroRad for u filter.</descr>
        -- <unit>nmgy</unit>
    uPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of uPetroFlux.</descr>
        -- <unit>nmgy</unit>
    gPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of 
        -- the canonical petroRad for g filter.</descr>
        -- <unit>nmgy</unit>
    gPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of gPetroFlux.</descr>
        -- <unit>nmgy</unit>
    rPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of 
        -- the canonical petroRad for r filter.</descr>
        -- <unit>nmgy</unit>
    rPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of rPetroFlux.</descr>
        -- <unit>nmgy</unit>
    iPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of 
        -- the canonical petroRad for i filter.</descr>
        -- <unit>nmgy</unit>
    iPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of iPetroFlux.</descr>
        -- <unit>nmgy</unit>
    zPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of 
        -- the canonical petroRad for z filter.</descr>
        -- <unit>nmgy</unit>
    zPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of zPetroFlux.</descr>
        -- <unit>nmgy</unit>
    yPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of 
        -- the canonical petroRad for y filter.</descr>
        -- <unit>nmgy</unit>
    yPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of yPetroFlux.</descr>
        -- <unit>nmgy</unit>
    uPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux
        -- for u filter.</descr>
        -- <unit>arcsec</unit>
    uPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of uPetroRad50.</descr>
        -- <unit>arcsec</unit>
    gPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux
        -- for g filter.</descr>
        -- <unit>arcsec</unit>
    gPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of gPetroRad50.</descr>
        -- <unit>arcsec</unit>
    rPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux
        -- for r filter.</descr>
        -- <unit>arcsec</unit>
    rPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of rPetroRad50.</descr>
        -- <unit>arcsec</unit>
    iPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux
        -- for i filter.</descr>
        -- <unit>arcsec</unit>
    iPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of iPetroRad50.</descr>
        -- <unit>arcsec</unit>
    zPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux
        -- for z filter.</descr>
        -- <unit>arcsec</unit>
    zPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of zPetroRad50.</descr>
        -- <unit>arcsec</unit>
    yPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux
        -- for y filter.</descr>
        -- <unit>arcsec</unit>
    yPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of yPetroRad50.</descr>
        -- <unit>arcsec</unit>
    uPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux
        -- for u filter.</descr>
        -- <unit>arcsec</unit>
    uPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of uPetroRad90.</descr>
        -- <unit>arcsec</unit>
    gPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux
        -- for g filter.</descr>
        -- <unit>arcsec</unit>
    gPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of gPetroRad90.</descr>
        -- <unit>arcsec</unit>
    rPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux
        -- for r filter.</descr>
        -- <unit>arcsec</unit>
    rPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of rPetroRad90.</descr>
        -- <unit>arcsec</unit>
    iPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux
        -- for i filter.</descr>
        -- <unit>arcsec</unit>
    iPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of iPetroRad90.</descr>
        -- <unit>arcsec</unit>
    zPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux
        -- for z filter.</descr>
        -- <unit>arcsec</unit>
    zPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of zPetroRad90.</descr>
        -- <unit>arcsec</unit>
    yPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux
        -- for y filter.</descr>
        -- <unit>arcsec</unit>
    yPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of yPetroRad90.</descr>
        -- <unit>arcsec</unit>
    uKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical 
        -- apertures defined by the adaptive moments) for
        -- u filter.</descr>
        -- <unit>arcsec</unit>
    uKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of uKronRad.</descr>
        -- <unit>arcsec</unit>
    gKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical 
        -- apertures defined by the adaptive moments) for
        -- g filter.</descr>
        -- <unit>arcsec</unit>
    gKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of gKronRad.</descr>
        -- <unit>arcsec</unit>
    rKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical 
        -- apertures defined by the adaptive moments) for
        -- r filter.</descr>
        -- <unit>arcsec</unit>
    rKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of rKronRad.</descr>
        -- <unit>arcsec</unit>
    iKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical 
        -- apertures defined by the adaptive moments) for
        -- i filter.</descr>
        -- <unit>arcsec</unit>
    iKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of iKronRad.</descr>
        -- <unit>arcsec</unit>
    zKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical 
        -- apertures defined by the adaptive moments) for
        -- z filter.</descr>
        -- <unit>arcsec</unit>
    zKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of zKronRad.</descr>
        -- <unit>arcsec</unit>
    yKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical 
        -- apertures defined by the adaptive moments) for
        -- y filter.</descr>
        -- <unit>arcsec</unit>
    yKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of yKronRad.</descr>
        -- <unit>arcsec</unit>
    kronFilter INT NOT NULL,
        -- <descr>The filter of the canonical kronRad.</descr>
    uKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the 
        -- canonical kronRad for u filter.</descr>
        -- <unit>nmgy</unit>
    uKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of uKronFlux.</descr>
        -- <unit>nmgy</unit>
    gKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the 
        -- canonical kronRad for g filter.</descr>
        -- <unit>nmgy</unit>
    gKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of gKronFlux.</descr>
        -- <unit>nmgy</unit>
    rKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the 
        -- canonical kronRad for r filter.</descr>
        -- <unit>nmgy</unit>
    rKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of rKronFlux.</descr>
        -- <unit>nmgy</unit>
    iKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the 
        -- canonical kronRad for i filter.</descr>
        -- <unit>nmgy</unit>
    iKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of iKronFlux.</descr>
        -- <unit>nmgy</unit>
    zKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the 
        -- canonical kronRad for z filter.</descr>
        -- <unit>nmgy</unit>
    zKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of zKronFlux.</descr>
        -- <unit>nmgy</unit>
    yKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the 
        -- canonical kronRad for y filter.</descr>
        -- <unit>nmgy</unit>
    yKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of yKronFlux.</descr>
        -- <unit>nmgy</unit>
    uKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux
        -- for u filter.</descr>
        -- <unit>arcsec</unit>
    uKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of uKronRad50.</descr>
        -- <unit>arcsec</unit>
    gKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux
        -- for g filter.</descr>
        -- <unit>arcsec</unit>
    gKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of gKronRad50.</descr>
        -- <unit>arcsec</unit>
    rKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux
        -- for r filter.</descr>
        -- <unit>arcsec</unit>
    rKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of rKronRad50.</descr>
        -- <unit>arcsec</unit>
    iKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux
        -- for i filter.</descr>
        -- <unit>arcsec</unit>
    iKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of iKronRad50.</descr>
        -- <unit>arcsec</unit>
    zKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux
        -- for z filter.</descr>
        -- <unit>arcsec</unit>
    zKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of zKronRad50.</descr>
        -- <unit>arcsec</unit>
    yKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux
        -- for y filter.</descr>
        -- <unit>arcsec</unit>
    yKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of yKronRad50.</descr>
        -- <unit>arcsec</unit>
    uKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux
        -- for u filter.</descr>
        -- <unit>arcsec</unit>
    uKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of uKronRad90.</descr>
        -- <unit>arcsec</unit>
    gKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux
        -- for g filter.</descr>
        -- <unit>arcsec</unit>
    gKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of gKronRad90.</descr>
        -- <unit>arcsec</unit>
    rKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux
        -- for r filter.</descr>
        -- <unit>arcsec</unit>
    rKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of rKronRad90.</descr>
        -- <unit>arcsec</unit>
    iKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux
        -- for i filter.</descr>
        -- <unit>arcsec</unit>
    iKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of iKronRad90.</descr>
        -- <unit>arcsec</unit>
    zKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux
        -- for z filter.</descr>
        -- <unit>arcsec</unit>
    zKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of zKronRad90.</descr>
        -- <unit>arcsec</unit>
    yKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux
        -- for y filter.</descr>
        -- <unit>arcsec</unit>
    yKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of yKronRad90.</descr>
        -- <unit>arcsec</unit>
    uApN INT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) 
        -- for u filter.</descr>
    gApN INT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) 
        -- for g filter.</descr>
    rApN INT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) 
        -- for r filter.</descr>
    iApN INT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) 
        -- for i filter.</descr>
    zApN INT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) 
        -- for z filter.</descr>
    yApN INT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) 
        -- for y filter.</descr>
    extendedness FLOAT NOT NULL,
        -- <descr>A measure of extendedness, computed using a 
        -- combination of available moments and model fluxes or
        -- from a likelihood ratio of point/trailed source 
        -- models (exact algorithm TBD). extendedness = 1 implies
        -- a high degree of confidence that the source is extended.
        -- extendedness = 0 implies a high degree of confidence
        -- that the source is point-like.</descr>
    photoZ BLOB NOT NULL,
        -- <descr>Photometric redshift likelihood samp<les – pairs of 
        -- (z, logL) – computed using a to-be-determined published
        -- and widely accepted algorithm at the time of LSST
        -- Commissioning. FLOAT[2x100].</descr>
    FLAGS1 BIGINT NOT NULL,
        -- <descr>Flags, tbd.</descr>
    FLAGS2 BIGINT NOT NULL,
        -- <descr>Flags, tbd.</descr>
    PRIMARY KEY PK_Object (objectId),
    INDEX IDX_Object_procHistoryId (procHistoryId),
    INDEX IDX_Object_decl (psDecl ASC)
) ENGINE=MyISAM;


CREATE TABLE Object_Extra
    -- <descr>Less frequently used information from The Object table.</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    psCov BLOB NULL,
        -- <descr>Various covariances for Point Source model. 
        -- 60 TINYINTs.</descr>
    bdCov BLOB NULL,
        -- <descr>Covariance matrix for the Bulge+Disk model. 
        -- 153 TINYINTs.</descr>
    bdSamples BLOB NULL,
        -- <descr>Independent samples of Bulge+Disk likelihood 
        -- surface. All sampled quantities will be stored with 
        -- at least ∼ 3 significant digits of precision.
        -- The number of samples will vary from object to object, 
        -- depending on how well the object’s likelihood function 
        -- is approximated by a Gaussian. We are assuming on 
        -- average FLOAT[19][200].</descr>
    PRIMARY KEY PK_Object (objectId)
) ENGINE=MyISAM;


CREATE TABLE Object_APMean
    -- <descr>Aperture mean (per bin) for the Object table.
    -- We expect ~8 bins on average per object.</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    filterName CHAR NOT NULL,
        -- <descr>Name of the filter.</descr>
    binN TINYINT NOT NULL,
        -- <descr>A bin in radius at which the aperture
        -- measurement is being performed.</descr>
    sbMean FLOAT NOT NULL,
        -- <descr>Mean surface brightness at which the aperture 
        -- measurement is being performed.</descr>
        -- <unit>nmgy/arcsec^2</unit>
    sbSigma FLOAT NOT NULL,
        -- <descr>Standard deviation of pixel surface brightness
        -- in annulus.</descr>
    INDEX IDX_ObjectAPMean_objectId (objectId)
) ENGINE=MyISAM;


CREATE TABLE Object_Periodic
    -- <descr>Definition of periodic features for Object table.
    -- We expect about 32 per object.</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    filterName CHAR NOT NULL,
        -- <descr>Name of the filter.</descr>
    n TINYINT NOT NULL,
        -- <descr>The position in the light-curve of this
        -- periodic feature.</descr>
    lcPeriodic FLOAT NOT NULL,
        -- <descr>Periodic features extracted from light-curves 
        -- using generalized Lomb-Scargle periodogram.</descr>
    INDEX IDX_ObjectPeriodic_objectId (objectId)
) ENGINE=MyISAM;


CREATE TABLE Object_NonPeriodic
    -- <descr>Definition of non-periodic features for Object table.
    -- We expect about 20 per object.</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    filterName CHAR NOT NULL,
        -- <descr>Name of the filter.</descr>
    n TINYINT NOT NULL,
        -- <descr>The position in the light-curve of this
        -- non-periodic feature.</descr>
    lcPeriodic FLOAT NOT NULL,
        -- <descr>Non-periodic features extracted from light-curves 
        -- using generalized Lomb-Scargle periodogram.</descr>
    INDEX IDX_ObjectPeriodic_objectId (objectId)
) ENGINE=MyISAM;


CREATE TABLE Source
    -- <descr>Table to store high signal-to-noise &quot;sources&quot;. 
    -- A source is a measurement of Object's properties from a single 
    -- image that contains its footprint on the sky.</descr>
(
    sourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Name of the CCD where this source was measured.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    visitId BIGINT NOT NULL,
        -- <descr>Id of the visit where this source was measured.
        -- Note that we are allowing a source to belong to multiple
        -- amplifiers, but it may not span multiple ccds.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterName CHAR NOT NULL,
        -- <descr>Name of the filter used to take the two exposures where 
        -- this source was measured.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    objectId BIGINT NULL,
        -- <descr>Id of the corresponding object. Note that this might be
        -- NULL (each source will point to either object or ssObject).</descr>
        -- <ucd>meta.id;src</ucd>
    ssObjectId BIGINT NULL,
        -- <descr>Id of the corresponding ssObject. Note that this might be
        -- NULL (each source will point to either object or ssObject).</descr>
        -- <ucd>meta.id;src</ucd>
    parentSourceId BIGINT NULL,
        -- <descr>Id of the parent source this source has been deblended
        -- from, if any.</descr>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    htmId20 BIGINT NOT NULL,
        -- <descr>HTM index.</descr>
    psFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    psFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of psFlux.</descr>
        -- <unit>nmgy</unit>
    psX FLOAT NULL,
        -- <descr>Point source model (x) position of the object 
        -- on the CCD.</descr>
        -- <unit>pixels</unit>
    psXSigma FLOAT NULL,
        -- <descr>Uncertainty of psX.</descr>
        -- <unit>pixels</unit>
    psY FLOAT NULL,
        -- <descr>Point source model (y) position of the object 
        -- on the CCD.</descr>
    psYSigma FLOAT NULL,
        -- <descr>Uncertainty of psY.</descr>
        -- <unit>pixels</unit>
    psFlux_psX_Cov FLOAT NULL,
        -- <descr>Covariance of psFlux and psX.</descr>
    psFlux_psY_Cov FLOAT NULL,
        -- <descr>Covariance of psFlux and psY.</descr>
    psX_Y_Cov FLOAT NULL,
        -- <descr>Covariance of psX and psY.</descr>
    psLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed 
        -- data given the Point Source model.</descr>
    psRa DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the Point 
        -- Source model at time radecTai.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    psRaSigma FLOAT NULL,
        -- <descr>Uncertainty of psRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    psDecl DOUBLE NULL,
        -- <descr>Decl-coordinate of the center of the object for the Point 
        -- Source model at time radecTai.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    psDeclSigma FLOAT NULL,
        -- <descr>Uncertainty of psDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    psFlux_psRa_Cov FLOAT NULL,
        -- <descr>Covariance of psFlux and psRa.</descr>
    psFlux_psDecl_Cov FLOAT NULL,
        -- <descr>Covariance of psFlux and psRa.</descr>
    x FLOAT NOT NULL,
        -- <descr>x position computed using an algorithm similar 
        -- to that used by SDSS.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    xSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of x.</descr>
        -- <ucd>stat.error:pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y FLOAT NOT NULL,
        -- <descr>y position computed using an algorithm similar 
        -- to that used by SDSS.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    ySigma FLOAT NOT NULL,
        -- <descr>Uncertainty of y.</descr>
        -- <ucd>stat.error:pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    x_y_Cov FLOAT NOT NULL,
        -- <descr>Covariance between x and y.</descr>
        -- <unit>pixel^2</unit>
    ra DOUBLE NOT NULL,
        -- <descr>Calibrated RA-coordinate of the center of the source
        -- transformed from xy.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    raSigma FLOAT NULL,
        -- <descr>Uncertainty of ra.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Calibated Decl-coordinate of the center of the source
        -- transformed from xy.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    declSigma FLOAT NULL,
        -- <descr>Uncertainty of decl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    ra_decl_Cov FLOAT NOT NULL,
        -- <descr>Covariance of ra and decl.</descr>
        -- <unit>arcsec^2</unit>
    E1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure of the source as measured 
        -- on the difference image.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    E1Sigma FLOAT NULL,
        -- <descr>Uncertainty of E1.</descr>
        -- <ucd>stat.error:phys.size.axisRatio</ucd>
    E2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure of the source as measured 
        -- on the difference image.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    E2Sigma FLOAT NULL,
        -- <descr>Uncertainty of E2.</descr>
        -- <ucd>stat.error:phys.size.axisRatio</ucd>
    E1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of E1 and E2</descr>
    mSum FLOAT NULL,
        -- <descr>Sum of second adaptive moments.</descr>
    mSumSigma FLOAT NULL,
        -- <descr>Uncertainty of mSum.</descr>
    m4 FLOAT NULL,
        -- <descr>Fourth order adaptive moment.</descr>
    apN INT NOT NULL,
        -- <descr>Number of elliptical annuli (see below).</descr>
    flags BIGINT NOT NULL,
        -- <descr>Flags. Tbd.</descr>
    PRIMARY KEY PK_Source (sourceId),
    INDEX IDX_Source_visitId (visitId),
    INDEX IDX_Source_objectId (objectId),
    INDEX IDX_Source_ssObjectId (ssObjectId),
    INDEX IDX_Source_procHistoryId (procHistoryId),
    INDEX IDX_Source_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE Source_APMean
    -- <descr>Aperture mean (per bin) for the Source table.
    -- We expect ~8 bins on average per source.</descr>
(
    sourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    binN TINYINT NOT NULL,
        -- <descr>A bin in radius at which the aperture
        -- measurement is being performed.</descr>
    sbMean FLOAT NOT NULL,
        -- <descr>Mean surface brightness at which the aperture 
        -- measurement is being performed.</descr>
        -- <unit>nmgy/arcsec^2</unit>
    sbSigma FLOAT NOT NULL,
        -- <descr>Standard deviation of pixel surface brightness
        -- in annulus.</descr>
    INDEX IDX_SourceAPMean_sourceId (sourceId)
) ENGINE=MyISAM;


CREATE TABLE DiaObject_To_Object_Match
    -- <descr>The table stores mapping of diaObjects to the
    -- nearby objects.</descr>
(
    diaObjectId BIGINT NOT NULL,
        -- <descr>Id of diaObject.</descr>
        -- <ucd>meta.id;src</ucd>
    objectId BIGINT NOT NULL,
        -- <descr>Id of a nearby object.</descr>
        -- <ucd>meta.id;src</ucd>
    dist FLOAT NOT NULL
        -- <descr>The distance between the diaObject and the object.</descr>
        -- <unit>arcsec</unit>
) ENGINE=MyISAM;


SET FOREIGN_KEY_CHECKS=1;


ALTER TABLE prv_cnf_Node ADD CONSTRAINT FK_Config_Node_Node 
	FOREIGN KEY (nodeId) REFERENCES prv_Node (nodeId);

ALTER TABLE prv_cnf_TaskGraph2Run ADD CONSTRAINT FK_Config_TaskGraph2Run_TaskGraph2Run 
	FOREIGN KEY (taskGraph2runId) REFERENCES prv_TaskGraph2Run (taskGraph2runId);

ALTER TABLE prv_cnf_Task ADD CONSTRAINT FK_Config_Task_Node 
	FOREIGN KEY (nodeId) REFERENCES prv_Node (nodeId);

ALTER TABLE prv_cnf_Task ADD CONSTRAINT FK_Config_Task_Task 
	FOREIGN KEY (taskId) REFERENCES prv_Task (taskId);

ALTER TABLE prv_cnf_Stage2TaskGraph ADD CONSTRAINT FK_Config_Stage2TaskGraph_Stage2TaskGraph 
	FOREIGN KEY (stage2taskGraphId) REFERENCES prv_Stage2TaskGraph (stage2taskGraphId);

ALTER TABLE prv_cnf_Stage2Task ADD CONSTRAINT FK_Config_Stage2Task_Stage2Task 
	FOREIGN KEY (stage2taskId) REFERENCES prv_Stage2Task (stage2TaskId);

ALTER TABLE prv_Node ADD CONSTRAINT FK_Node_TaskConfig 
	FOREIGN KEY (taskConfigId) REFERENCES prv_TaskConfig (taskConfigId);

ALTER TABLE prv_TaskGraph ADD CONSTRAINT FK_TaskGraph_TaskConfig 
	FOREIGN KEY (taskConfigId) REFERENCES prv_TaskConfig (taskConfigId);

ALTER TABLE prv_TaskGraph2Run ADD CONSTRAINT FK_TaskGraph2Run_TaskGraph 
	FOREIGN KEY (taskGraphId) REFERENCES prv_TaskGraph (taskGraphId);

ALTER TABLE prv_TaskGraph2Run ADD CONSTRAINT FK_TaskGraph2Run_Run 
	FOREIGN KEY (runId) REFERENCES prv_Run (runId);

ALTER TABLE prv_Run ADD CONSTRAINT FK_Run_TaskConfig 
	FOREIGN KEY (taskConfigId) REFERENCES prv_TaskConfig (taskConfigId);

ALTER TABLE prv_Stage ADD CONSTRAINT FK_Stage_TaskConfig 
	FOREIGN KEY (taskConfigId) REFERENCES prv_TaskConfig (taskConfigId);

ALTER TABLE prv_Stage2Task ADD CONSTRAINT FK_ProcStep2Stage_ProcStep 
	FOREIGN KEY (taskId) REFERENCES prv_Task (taskId);

ALTER TABLE prv_Stage2UpdatableColumn ADD CONSTRAINT FK_Stage2UpdatableColumn_Config_Stage2UpdatableColumn 
	FOREIGN KEY (cStage2UpdateColumnId) REFERENCES prv_cnf_Stage2UpdatableColumn (c_stage2UpdatableColumn);

ALTER TABLE prv_Stage2UpdatableColumn ADD CONSTRAINT FK_Stage2UpdatableColumn_UpdatableColumn 
	FOREIGN KEY (columnId) REFERENCES prv_UpdatableColumn (columnId);

ALTER TABLE prv_Amp ADD CONSTRAINT FK_Amp_Ccd
	FOREIGN KEY (ccdName) REFERENCES prv_Ccd (ccdName);

ALTER TABLE prv_Ccd ADD CONSTRAINT FK_CCD_Raft 
	FOREIGN KEY (raftName) REFERENCES prv_Raft (raftName);

ALTER TABLE prv_cnf_Amp ADD CONSTRAINT FK_Config_Amp_Amp 
	FOREIGN KEY (ampName) REFERENCES prv_Amp (ampName);

ALTER TABLE prv_cnf_Ccd ADD CONSTRAINT FK_Config_Ccd_Ccd
	FOREIGN KEY (ccdName) REFERENCES prv_Ccd (ccdName);

ALTER TABLE prv_cnf_Filter ADD CONSTRAINT FK_Config_Filter_Filter 
	FOREIGN KEY (filterName) REFERENCES prv_Filter (filterName);

ALTER TABLE prv_cnf_Raft ADD CONSTRAINT FK_Config_Raft_Raft 
	FOREIGN KEY (raftName) REFERENCES prv_Raft (raftName);

ALTER TABLE prv_Snapshot ADD CONSTRAINT FK_Snapshot_ProcessingHistory 
	FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE prv_Stage2ProcHistory ADD CONSTRAINT FK_prv_Stage2ProcHistory_prv_ProcHistory 
	FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE prv_UpdatableColumn ADD CONSTRAINT FK_UpdatableColumn_UpdatableTable 
	FOREIGN KEY (tableId) REFERENCES prv_UpdatableTable (tableId);

ALTER TABLE RefObjMatch ADD CONSTRAINT FK_RefObjMatch_Object
    FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE RefObjMatch ADD CONSTRAINT FK_RefObjMatch_SimRefObject
    FOREIGN KEY (refObjectId) REFERENCES SimRefObject (refObjectId);

