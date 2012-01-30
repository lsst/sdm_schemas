
-- LSST Database Schema
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu/trac/wiki/Copyrights>
-- for copyright information.


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


CREATE TABLE prv_Activity
(
    activityId BIGINT NOT NULL,
        -- <descr>Unique id derived from prv_Run.offset.</descr>
        -- <ucd>meta.id</ucd>
    offset MEDIUMINT NOT NULL,
        -- <descr>Corresponding prv_Run offset.</descr>
    name VARCHAR(64) NOT NULL,
        -- <descr>A name for the activity.</descr>
        -- <ucd>meta.note</ucd>
    type VARCHAR(64) NOT NULL,
        -- <descr>A name indicating type of activity, e.g. &quot;launch&quot;,
        -- &quot;workflow&quot;.</descr>
    platform VARCHAR(64) NOT NULL,
        -- <descr>Name of the platform where the activity occurred (does not
        -- need to a be a DNS name).</descr>
        -- <ucd>meta.note</ucd>
    PRIMARY KEY (activityId, offset)
) ENGINE=MyISAM;


CREATE TABLE prv_cnf_PolicyKey
(
    policyKeyId BIGINT NOT NULL,
    value TEXT NULL,
    validityBegin DATETIME NULL,
    validityEnd DATETIME NULL,
    PRIMARY KEY (policyKeyId)
) ENGINE=MyISAM;


CREATE TABLE prv_cnf_SoftwarePackage
(
    packageId INTEGER NOT NULL,
    version VARCHAR(255) NOT NULL,
    directory VARCHAR(255) NOT NULL,
    validityBegin DATETIME NULL,
    validityEnd DATETIME NULL,
    PRIMARY KEY (packageId)
) ENGINE=MyISAM;


CREATE TABLE prv_Filter
    -- <descr>One row per color - the table will have 6 rows</descr>
(
    filterId TINYINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;inst.filter</ucd>
    focalPlaneId TINYINT NOT NULL,
        -- <descr>Pointer to FocalPlane - focal plane this filter belongs to.
        -- </descr>
    name VARCHAR(80) NOT NULL,
        -- <descr>String description of the filter,e.g. 'VR SuperMacho c6027'.
        -- </descr>
        -- <ucd>meta.note</ucd>
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
) ENGINE=MyISAM;


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
) ENGINE=MyISAM;


CREATE TABLE prv_PolicyKey
(
    policyKeyId BIGINT NOT NULL,
        -- <descr>Identifier for a key within a Policy file.</descr>
    policyFileId BIGINT NOT NULL,
        -- <descr>Identifier for the Policy file.</descr>
    keyName VARCHAR(255) NOT NULL,
        -- <descr>Name of the key in the Policy file.</descr>
        -- <ucd>meta.note</ucd>
    keyType VARCHAR(16) NOT NULL,
        -- <descr>Type of the key in the Policy file.</descr>
    PRIMARY KEY (policyKeyId),
    INDEX (policyFileId)
) ENGINE=MyISAM;


CREATE TABLE prv_Run
(
    offset MEDIUMINT NOT NULL AUTO_INCREMENT,
    runId VARCHAR(255) NOT NULL,
        -- <ucd>meta.id</ucd>
    PRIMARY KEY (offset),
    UNIQUE UQ_prv_Run_runId(runId)
) ENGINE=MyISAM;


CREATE TABLE prv_SoftwarePackage
(
    packageId INTEGER NOT NULL,
        -- <ucd>meta.id</ucd>
    packageName VARCHAR(64) NOT NULL,
        -- <ucd>meta.note</ucd>
    PRIMARY KEY (packageId)
) ENGINE=MyISAM;


CREATE TABLE _MovingObjectToType
    -- <descr>Mapping: moving object --&amp;gt; types, with probabilities
    -- </descr>
(
    movingObjectId BIGINT NOT NULL,
        -- <descr>Pointer to entry in MovingObject table</descr>
        -- <ucd>meta.id</ucd>
    typeId SMALLINT NOT NULL,
        -- <descr>Pointer to entry in ObjectType table</descr>
        -- <ucd>meta.id</ucd>
    probability TINYINT NULL DEFAULT 100,
        -- <descr>Probability that given MovingObject is of given type. Range:
        -- 0-100 (in%)</descr>
    INDEX (typeId),
    INDEX (movingObjectId)
) ENGINE=MyISAM;


CREATE TABLE _ObjectToType
    -- <descr>Mapping Object --&amp;gt; types, with probabilities</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Pointer to an entry in Object table</descr>
        -- <ucd>meta.id;src</ucd>
    typeId SMALLINT NOT NULL,
        -- <descr>Pointer to an entry in ObjectType table</descr>
        -- <ucd>meta.id</ucd>
    probability TINYINT NULL DEFAULT 100,
        -- <descr>Probability that given object is of given type. Range 0-100 %
        -- </descr>
    INDEX (typeId),
    INDEX (objectId)
) ENGINE=MyISAM;


CREATE TABLE _qservChunkMap
    -- <descr>Internal table used by qserv. Keeps spatial mapping ra/decl
    -- bounding box --&amp;gt; chunkId.</descr>
(
    raMin DOUBLE NOT NULL,
        -- <unit>degree</unit>
    raMax DOUBLE NOT NULL,
        -- <unit>degree</unit>
    declMin DOUBLE NOT NULL,
        -- <unit>degree</unit>
    declMax DOUBLE NOT NULL,
        -- <unit>degree</unit>
    chunkId INTEGER NOT NULL,
    objCount INTEGER NOT NULL
        -- <descr>Number of objects in a given chunk (for cost estimation).
        -- </descr>
) ENGINE=MyISAM;


CREATE TABLE _qservObjectIdMap
    -- <descr>Internal table used by qserv. Keeps mapping: objectId --&amp;gt;
    -- chunkId+subChunkId.</descr>
(
    objectId BIGINT NOT NULL,
        -- <ucd>meta.id;src</ucd>
    chunkId INTEGER NOT NULL,
        -- <ucd>meta.id</ucd>
    subChunkId INTEGER NOT NULL
) ENGINE=MyISAM;


CREATE TABLE _qservSubChunkMap
    -- <descr>Internal table used by qserv. Keeps spatial mapping ra/decl
    -- bounding box --&amp;gt; chunkId and subChunkId.</descr>
(
    raMin DOUBLE NOT NULL,
        -- <unit>degree</unit>
    raMax DOUBLE NOT NULL,
        -- <unit>degree</unit>
    declMin DOUBLE NOT NULL,
        -- <unit>degree</unit>
    declMax DOUBLE NOT NULL,
        -- <unit>degree</unit>
    chunkId INTEGER NOT NULL,
    subChunkId INTEGER NOT NULL,
    objCount INTEGER NOT NULL
        -- <descr>Number of objects in a given subChunk (for cost
        -- estimation).</descr>
) ENGINE=MyISAM;


CREATE TABLE _tmpl_ap_DiaSourceToNewObject
(
    first BIGINT NOT NULL,
    second BIGINT NOT NULL,
    visitId INTEGER NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    INDEX idx_visitId (visitId ASC)
) ENGINE=MyISAM;


CREATE TABLE _tmpl_ap_DiaSourceToObjectMatches
(
    first BIGINT NOT NULL,
    second BIGINT NOT NULL,
    distance DOUBLE NOT NULL,
    visitId INTEGER NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    INDEX idx_visitId (visitId ASC)
) ENGINE=MyISAM;


CREATE TABLE _tmpl_ap_PredToDiaSourceMatches
(
    first BIGINT NOT NULL,
    second BIGINT NOT NULL,
    distance DOUBLE NOT NULL,
    visitId INTEGER NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    INDEX idx_visitId (visitId ASC)
) ENGINE=MyISAM;


CREATE TABLE _tmpl_Id
    -- <descr>Template table. Schema for lists of ids (e.g. for Objects to
    -- delete)</descr>
(
    id BIGINT NOT NULL
) ENGINE=MyISAM;


CREATE TABLE _tmpl_IdPair
    -- <descr>Template table. Schema for list of id pairs.</descr>
(
    first BIGINT NOT NULL,
    second BIGINT NOT NULL
) ENGINE=MyISAM;


CREATE TABLE _tmpl_MatchPair
    -- <descr>Template table. Schema for per-visit match result tables.</descr>
(
    first BIGINT NOT NULL,
    second BIGINT NOT NULL,
    distance DOUBLE NOT NULL
) ENGINE=MyISAM;


CREATE TABLE AmpMap
    -- <descr>Mapping table to translate amp names to numbers.</descr>
(
    ampNum TINYINT NOT NULL,
        -- <ucd>meta.id;inst.det</ucd>
    ampName CHAR(3) NOT NULL,
        -- <ucd>inst.det</ucd>
    PRIMARY KEY (ampNum),
    UNIQUE UQ_AmpMap_ampName(ampName)
) ;


CREATE TABLE Ccd_Detector
(
    ccdDetectorId INTEGER NOT NULL DEFAULT 1,
        -- <descr>from file name (required for raw science images)</descr>
        -- <ucd>meta.id;inst.det</ucd>
    biasSec VARCHAR(20) NOT NULL DEFAULT '[0:0,0:0]',
        -- <descr>Bias section (ex: '[2045:2108,1:4096]')</descr>
    trimSec VARCHAR(20) NOT NULL DEFAULT '[0:0,0:0]',
        -- <descr>Trim section (ex: '[1:2044,1:4096]')</descr>
    gain FLOAT(0) NULL,
        -- <descr>Detector/amplifier gain</descr>
    rdNoise FLOAT(0) NULL,
        -- <descr>Read noise for detector/amplifier</descr>
    saturate FLOAT(0) NULL,
        -- <descr>Maximum data value for A/D converter</descr>
    PRIMARY KEY (ccdDetectorId)
) ENGINE=MyISAM;


CREATE TABLE CcdMap
    -- <descr>Mapping table to translate ccd names to numbers.</descr>
(
    ccdNum TINYINT NOT NULL,
        -- <ucd>meta.id;inst.det</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <ucd>inst.det</ucd>
    PRIMARY KEY (ccdNum),
    UNIQUE UQ_CcdMap_ccdName(ccdName)
) ;


CREATE TABLE Durations
    -- <descr>Per-run durations.</descr>
(
    id INTEGER NOT NULL AUTO_INCREMENT,
    RUNID VARCHAR(80) NULL,
    name VARCHAR(80) NULL,
    workerid VARCHAR(80) NULL,
    stagename VARCHAR(80) NULL,
    SLICEID INTEGER NULL DEFAULT -1,
    duration BIGINT NULL,
    HOSTID VARCHAR(80) NULL,
    LOOPNUM INTEGER NULL DEFAULT -1,
    STAGEID INTEGER NULL DEFAULT -1,
    PIPELINE VARCHAR(80) NULL,
    COMMENT VARCHAR(255) NULL,
    start VARCHAR(80) NULL,
    userduration FLOAT(0) NULL,
    systemduration FLOAT(0) NULL,
    PRIMARY KEY (id),
    INDEX dur_runid (RUNID ASC),
    INDEX idx_durations_pipeline (PIPELINE ASC),
    INDEX idx_durations_name (name ASC)
) ENGINE=MyISAM;


CREATE TABLE Filter
(
    filterId TINYINT NOT NULL,
        -- <ucd>meta.id;inst.filter</ucd>
    filterName CHAR(255) NOT NULL,
        -- <descr>Filter name. Valid values: 'u', 'g', 'r', 'i', 'z', 'y'
        -- </descr>
        -- <ucd>instr.bandpass</ucd>
    photClam FLOAT(0) NOT NULL,
        -- <descr>Filter centroid wavelength</descr>
        -- <ucd>em.wl.effective;inst.filter</ucd>
        -- <unit>nm</unit>
    photBW FLOAT(0) NOT NULL,
        -- <descr>System effective bandwidth</descr>
        -- <ucd>inst.bandwidth</ucd>
        -- <unit>nm</unit>
    PRIMARY KEY (filterId)
) ENGINE=MyISAM;


CREATE TABLE LeapSeconds
    -- <descr>Based on <a href='http://maia.usno.navy.mil/ser7/tai-utc.dat'>
    -- http://maia.usno.navy.mil/ser7/tai-utc.dat</a>.
    -- </descr>
(
    whenJd FLOAT(0) NOT NULL,
        -- <descr>JD of change in TAI-UTC difference (leap second).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    offset FLOAT(0) NOT NULL,
        -- <descr>New number of leap seconds.</descr>
        -- <ucd>time.interval</ucd>
        -- <unit>s</unit>
    mjdRef FLOAT(0) NOT NULL,
        -- <descr>Reference MJD for drift (prior to 1972-Jan-1).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    drift FLOAT(0) NOT NULL,
        -- <descr>Drift in seconds per day (prior to 1972-Jan-1).</descr>
        -- <ucd>arith.rate</ucd>
        -- <unit>s/d</unit>
    whenMjdUtc FLOAT(0) NULL,
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


CREATE TABLE Logs
    -- <descr>Per-run logs.</descr>
(
    id INTEGER NOT NULL AUTO_INCREMENT,
    HOSTID VARCHAR(80) NULL,
    RUNID VARCHAR(80) NULL,
    LOG VARCHAR(80) NULL,
    workerid VARCHAR(80) NULL,
    stagename VARCHAR(80) NULL,
    SLICEID INTEGER NULL,
    STAGEID INTEGER NULL,
    LOOPNUM INTEGER NULL,
    STATUS VARCHAR(80) NULL,
    LEVEL INTEGER NULL DEFAULT 9999,
    DATE VARCHAR(30) NULL,
    TIMESTAMP BIGINT NULL,
    node INTEGER NULL,
    custom VARCHAR(4096) NULL,
    timereceived TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    visitid INTEGER NULL,
        -- <ucd>meta.id;obs.image</ucd>
    COMMENT TEXT NULL,
    PIPELINE VARCHAR(80) NULL,
    TYPE VARCHAR(5) NULL,
    EVENTTIME BIGINT NULL,
    PUBTIME BIGINT NULL,
    usertime FLOAT(0) NULL,
    systemtime FLOAT(0) NULL,
    PRIMARY KEY (id),
    INDEX a (RUNID ASC)
) ENGINE=MyISAM;


CREATE TABLE ObjectType
    -- <descr>Table to store description of object types. It includes 
    -- all object types: static, variables, Solar System objects, etc.
    -- </descr>
(
    typeId SMALLINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id</ucd>
    description VARCHAR(255) NULL,
        -- <ucd>meta.note;src</ucd>
    PRIMARY KEY (typeId)
) ENGINE=MyISAM;


CREATE TABLE RaftMap
    -- <descr>Mapping table to translate raft names to numbers.</descr>
(
    raftNum TINYINT NOT NULL,
        -- <ucd>meta.id;inst.det</ucd>
    raftName CHAR(3) NOT NULL,
        -- <ucd>inst.det</ucd>
    PRIMARY KEY (raftNum),
    UNIQUE UQ_RaftMap_raftName(raftName)
) ;


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
        -- <descr>ICRS reference object RA at mean epoch of object.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    refDec DOUBLE NULL,
        -- <descr>ICRS reference object Dec at mean epoch of object.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
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
    closestToRef TINYINT NULL,
        -- <descr>Is object the closest match for reference object?</descr>
        -- <ucd>meta.code</ucd>
    closestToObj TINYINT NULL,
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
    --        at least one CCD. Includes both stars and galaxies.
    -- </descr>
(
    refObjectId BIGINT NOT NULL,
        -- <descr>Reference object id.</descr>
        -- <ucd>meta.id;src</ucd>
    isStar TINYINT NOT NULL,
        -- <descr>1 for star, 0 for galaxy.</descr>
        -- <ucd>src.class.starGalaxy</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>RA. ICRS.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl. ICRS.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    gLat DOUBLE NULL,
        -- <descr>Galactic latitude, NULL for galaxies.</descr>
        -- <ucd>pos.galactic.lat</ucd>
        -- <unit>degree</unit>
    gLon DOUBLE NULL,
        -- <descr>Galactic longitude. Null for galaxies.</descr>
        -- <ucd>pos.galactic.lon</ucd>
        -- <unit>degree</unit>
    sedName CHAR(32) NULL,
        -- <descr>Best-fit SED name. Null for galaxies.</descr>
        -- <ucd>src.sec</ucd>
    uMag DOUBLE NOT NULL,
        -- <descr>u band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    gMag DOUBLE NOT NULL,
        -- <descr>g band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    rMag DOUBLE NOT NULL,
        -- <descr>r band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    iMag DOUBLE NOT NULL,
        -- <descr>i band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    zMag DOUBLE NOT NULL,
        -- <descr>z band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    yMag DOUBLE NOT NULL,
        -- <descr>y band AB magnitude.</descr>
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
    isVar TINYINT NOT NULL,
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


CREATE TABLE sdqa_Rating_ForScienceAmpExposure
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
    ampExposureId BIGINT NOT NULL,
        -- <descr>Pointer to Science_Amp_Exposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    metricValue DOUBLE NOT NULL,
        -- <descr>Value of this SDQA metric.</descr>
    metricSigma DOUBLE NOT NULL,
        -- <descr>Uncertainty of the value of this metric.</descr>
    PRIMARY KEY (sdqa_ratingId),
    UNIQUE UQ_sdqaRating_ForScienceAmpExposure_metricId_ampExposureId(sdqa_metricId, ampExposureId),
    INDEX (sdqa_metricId),
    INDEX (sdqa_thresholdId),
    INDEX (ampExposureId)
) ENGINE=MyISAM;


CREATE TABLE sdqa_Rating_ForScienceCcdExposure
    -- <descr>Various SDQA ratings for a given ScienceCcdExposure.</descr>
(
    sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Primary key. Auto-increment is used, we define a composite
        -- unique key, so potential duplicates will be captured.</descr>
    sdqa_metricId SMALLINT NOT NULL,
        -- <descr>Pointer to sdqa_Metric.</descr>
    sdqa_thresholdId SMALLINT NOT NULL,
        -- <descr>Pointer to sdqa_Threshold.</descr>
    ccdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to Science_Ccd_Exposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    metricValue DOUBLE NOT NULL,
        -- <descr>Value of this SDQA metric.</descr>
    metricSigma DOUBLE NOT NULL,
        -- <descr>Uncertainty of the value of this metric.</descr>
    PRIMARY KEY (sdqa_ratingId),
    UNIQUE UQ_sdqa_Rating_ForScienceCCDExposure_metricId_ccdExposureId(sdqa_metricId, ccdExposureId),
    INDEX (sdqa_metricId),
    INDEX (sdqa_thresholdId),
    INDEX (ccdExposureId)
) ENGINE=MyISAM;


CREATE TABLE sdqa_Rating_ForSnapCcdExposure
(
    sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
    sdqa_metricId SMALLINT NOT NULL,
    sdqa_thresholdId SMALLINT NOT NULL,
    ccdExposureId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    metricValue DOUBLE NOT NULL,
    metricSigma DOUBLE NOT NULL,
    PRIMARY KEY (sdqa_ratingId),
    INDEX UQ_sdqa_Rating_ForScienceCCDExposure_metricId_ccdExposureId (sdqa_metricId ASC, ccdExposureId ASC),
    INDEX sdqa_metricId (sdqa_metricId ASC),
    INDEX sdqa_thresholdId (sdqa_thresholdId ASC),
    INDEX ccdExposureId (ccdExposureId ASC)
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


CREATE TABLE _mops_Config
    -- <descr>Internal table used to ship runtime configuration data to MOPS
    -- worker nodes. This will eventually be replaced by some other
    -- mechanism. Note however that this data must be captured by the LSST
    -- software provenance tables.</descr>
(
    configId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Referring derived object</descr>
    configText TEXT NULL,
        -- <descr>Config contents</descr>
    PRIMARY KEY (configId)
) ;


CREATE TABLE _mops_EonQueue
    -- <descr>Internal table which maintains a queue of objects to be passed to
    -- the MOPS precovery pipeline. Will eventually be replaced by a
    -- different queueing mechanism.</descr>
(
    movingObjectId BIGINT NOT NULL,
        -- <descr>Referring derived object</descr>
        -- <ucd>meta.id;src</ucd>
    eventId BIGINT NOT NULL,
        -- <descr>Referring history event causing insertion</descr>
    insertTime TIMESTAMP NOT NULL,
        -- <descr>Wall clock time object was queued</descr>
    status CHAR(1) NULL DEFAULT 'I',
        -- <descr>Processing status N =&amp;gt; new, I =&amp;gt; ID1 done, P
        -- =&amp;gt; precov done, X =&amp;gt; finished</descr>
    PRIMARY KEY (movingObjectId),
    INDEX idx__mopsEonQueue_eventId (eventId ASC)
) ;


CREATE TABLE _mops_MoidQueue
    -- <descr>Internal table which maintain a queue of objects to be passed to
    -- the MOPS precovery pipeline. Will eventually be replaced by a
    -- different queueing mechanism.</descr>
(
    movingObjectId BIGINT NOT NULL,
        -- <descr>Referring derived object</descr>
    movingObjectVersion INT NOT NULL,
        -- <descr>version of referring derived object</descr>
    eventId BIGINT NOT NULL,
        -- <descr>Referring history event causing insertion</descr>
    insertTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Wall clock time object was queued</descr>
    PRIMARY KEY (movingObjectId, movingObjectVersion),
    INDEX (movingObjectId),
    INDEX idx_mopsMoidQueue_eventId (eventId ASC)
) ;


CREATE TABLE _tmpl_mops_Ephemeris
(
    movingObjectId BIGINT NOT NULL,
        -- <ucd>meta.id;src</ucd>
    movingObjectVersion INTEGER NOT NULL,
    ra DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    mjd DOUBLE NOT NULL,
        -- <ucd>time.epoch</ucd>
    smia DOUBLE NULL,
    smaa DOUBLE NULL,
    pa DOUBLE NULL,
    mag DOUBLE NULL,
    INDEX idx_mopsEphemeris_movingObjectId (movingObjectId ASC)
) ENGINE=MyISAM;


CREATE TABLE _tmpl_mops_Prediction
(
    movingObjectId BIGINT NOT NULL,
        -- <ucd>meta.id;src</ucd>
    movingObjectVersion INTEGER NOT NULL,
    ra DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    mjd DOUBLE NOT NULL,
        -- <ucd>time.epoch</ucd>
    smia DOUBLE NOT NULL,
    smaa DOUBLE NOT NULL,
    pa DOUBLE NOT NULL,
    mag DOUBLE NOT NULL,
    magSigma FLOAT(0) NOT NULL
) ENGINE=MyISAM;


CREATE TABLE mops_Event
(
    eventId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Auto-generated internal event ID</descr>
        -- <ucd>meta.id</ucd>
    procHistoryId INT NOT NULL,
        -- <descr>Pointer to processing history (prv_ProcHistory)</descr>
    eventType CHAR(1) NOT NULL,
        -- <descr>Type of event
        -- (A)ttribution/(P)recovery/(D)erivation/(I)dentification/(R)emoval
        -- </descr>
    eventTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Timestamp for event creation</descr>
    movingObjectId BIGINT NULL,
        -- <descr>Referring derived object ID</descr>
        -- <ucd>meta.id;src</ucd>
    movingObjectVersion INT NULL,
        -- <descr>Pointer to resulting orbit</descr>
    orbitCode CHAR(1) NULL,
        -- <descr>Information about computed orbit</descr>
    d3 FLOAT(0) NULL,
        -- <descr>Computed 3-parameter D-criterion</descr>
    d4 FLOAT(0) NULL,
        -- <descr>Computed 4-parameter D-criterion</descr>
    ccdExposureId BIGINT NULL,
        -- <descr>Referring to Science_Ccd_Exposure id generating the
        -- event.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    classification CHAR(1) NULL,
        -- <descr>MOPS efficiency classification for event</descr>
    ssmId BIGINT NULL,
        -- <descr>Matching SSM ID for clean classifications</descr>
    PRIMARY KEY (eventId),
    INDEX (movingObjectId),
    INDEX idx_mopsEvent_ccdExposureId (ccdExposureId ASC),
    INDEX idx_mopsEvent_movingObjectId (movingObjectId ASC, movingObjectVersion ASC),
    INDEX idx_mopsEvent_procHistoryId (procHistoryId ASC),
    INDEX idx_mopsEvent_ssmId (ssmId ASC)
) ;


CREATE TABLE mops_Event_OrbitDerivation
    -- <descr>Table for associating tracklets with derivation events. There is a
    -- one to many relationship between events and tracklets (there will be
    -- multiple rows per event).</descr>
(
    eventId BIGINT NOT NULL,
        -- <descr>Parent event ID (from mops_History table)</descr>
    trackletId BIGINT NOT NULL,
        -- <descr>Associated tracklet ID (multiple rows per event)</descr>
    PRIMARY KEY (eventId, trackletId),
    INDEX idx_mopsEventDerivation_trackletId (trackletId ASC),
    INDEX (eventId)
) ;


CREATE TABLE mops_Event_OrbitIdentification
    -- <descr>Table for associating moving objects with identification events
    -- (one object per event). The original orbit and tracklets for the child
    -- can be obtained from the MOPS_History table by looking up the child
    -- object.</descr>
(
    eventId BIGINT NOT NULL,
        -- <descr>Parent event ID (from mops_History table)</descr>
    childObjectId BIGINT NOT NULL,
        -- <descr>Matching (child) derived object ID</descr>
    PRIMARY KEY (eventId),
    INDEX idx_mopsEventOrbitIdentification2MovingObject_childObjectId (childObjectId ASC)
) ;


CREATE TABLE mops_Event_TrackletAttribution
    -- <descr>Table for associating tracklets with attribution events (one
    -- tracklet per event).</descr>
(
    eventId BIGINT NOT NULL,
        -- <descr>Parent event ID (from mops_History table)</descr>
    trackletId BIGINT NOT NULL,
        -- <descr>Attributed tracklet ID</descr>
    ephemerisDistance FLOAT(0) NOT NULL,
        -- <descr>Predicted position minus actual, arcsecs</descr>
    ephemerisUncertainty FLOAT(0) NULL,
        -- <descr>Predicted error ellipse semi-major axis, arcsecs</descr>
    PRIMARY KEY (eventId),
    INDEX idx_mopsEventTrackletAttribution_trackletId (trackletId ASC)
) ;


CREATE TABLE mops_Event_TrackletPrecovery
    -- <descr>Table for associating tracklets with precovery events (one
    -- precovery per event).</descr>
(
    eventId BIGINT NOT NULL,
        -- <descr>Parent event ID (from mops_History table)</descr>
    trackletId BIGINT NOT NULL,
        -- <descr>Precovered tracklet ID</descr>
    ephemerisDistance FLOAT(0) NOT NULL,
        -- <descr>Predicted position minus actual, arcsecs</descr>
    ephemerisUncertainty FLOAT(0) NULL,
        -- <descr>Predicted error ellipse semi-major axis, arcsecs</descr>
    PRIMARY KEY (eventId),
    INDEX idx_mopsEventTrackletPrecovery_trackletId (trackletId ASC)
) ;


CREATE TABLE mops_Event_TrackletRemoval
    -- <descr>Table for associating tracklets with removal events (one removal
    -- per event).</descr>
(
    eventId BIGINT NOT NULL,
        -- <descr>Parent event ID (from mops_History table)</descr>
    trackletId BIGINT NOT NULL,
        -- <descr>Removed tracklet ID</descr>
    PRIMARY KEY (eventId),
    INDEX idx_mopsEventTrackletRemoval_trackletId (trackletId ASC)
) ;


CREATE TABLE mops_MovingObjectToTracklet
    -- <descr>Current membership of tracklets and moving objects.</descr>
(
    movingObjectId BIGINT NOT NULL,
    trackletId BIGINT NOT NULL,
    INDEX idx_mopsMovingObjectToTracklets_movingObjectId (movingObjectId ASC),
    INDEX idx_mopsMovingObjectToTracklets_trackletId (trackletId ASC)
) ;


CREATE TABLE mops_SSM
    -- <descr>Table that contains synthetic solar system model (SSM) objects.
    -- </descr>
(
    ssmId BIGINT NOT NULL AUTO_INCREMENT,
        -- <ucd>meta.id</ucd>
    ssmDescId SMALLINT NULL,
        -- <descr>Pointer to SSM description</descr>
    q DOUBLE NOT NULL,
        -- <descr>semi-major axis, AU</descr>
    e DOUBLE NOT NULL,
        -- <descr>eccentricity e (dimensionless)</descr>
    i DOUBLE NOT NULL,
        -- <descr>inclination</descr>
        -- <unit>deg</unit>
    node DOUBLE NOT NULL,
        -- <descr>longitude of ascending node</descr>
        -- <unit>deg</unit>
    argPeri DOUBLE NOT NULL,
        -- <descr>argument of perihelion</descr>
        -- <unit>deg</unit>
    timePeri DOUBLE NOT NULL,
        -- <descr>time of perihelion, MJD (UTC)</descr>
    epoch DOUBLE NOT NULL,
        -- <descr>epoch of osculating elements, MJD (UTC)</descr>
    h_v DOUBLE NOT NULL,
        -- <descr>Absolute magnitude</descr>
    h_ss DOUBLE NULL,
        -- <descr>??</descr>
    g DOUBLE NULL,
        -- <descr>Slope parameter g, dimensionless</descr>
        -- <unit>-</unit>
    albedo DOUBLE NULL,
        -- <descr>Albedo, dimensionless</descr>
        -- <unit>-</unit>
    ssmObjectName VARCHAR(32) NOT NULL,
        -- <descr>MOPS synthetic object name</descr>
    PRIMARY KEY (ssmId),
    UNIQUE UQ_mopsSSM_ssmObjectName(ssmObjectName),
    INDEX idx_mopsSSM_ssmDescId (ssmDescId ASC),
    INDEX idx_mopsSSM_epoch (epoch ASC)
) ;


CREATE TABLE mops_SSMDesc
    -- <descr>Table containing object name prefixes and descriptions of
    -- synthetic solar system object types.</descr>
(
    ssmDescId SMALLINT NOT NULL AUTO_INCREMENT,
        -- <descr>Auto-generated row ID</descr>
        -- <ucd>meta.id</ucd>
    prefix CHAR(4) NULL,
        -- <descr>MOPS prefix code S0/S1/etc.</descr>
    description VARCHAR(100) NULL,
        -- <descr>Long description</descr>
        -- <ucd>meta.note</ucd>
    PRIMARY KEY (ssmDescId)
) ;


CREATE TABLE mops_Tracklet
(
    trackletId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Auto-generated internal MOPS tracklet ID</descr>
        -- <ucd>meta.id</ucd>
    ccdExposureId BIGINT NOT NULL,
        -- <descr>Terminating field ID - pointer to Science_Ccd_Exposure.
        -- </descr>
        -- <ucd>meta.id;obs.image</ucd>
    procHistoryId INT NOT NULL,
        -- <descr>Pointer to processing history (prv_ProcHistory)</descr>
    ssmId BIGINT NULL,
        -- <descr>Matching SSM ID for clean classifications</descr>
        -- <ucd>meta.id</ucd>
    velRa DOUBLE NULL,
        -- <descr>Average RA velocity, cos(dec) applied</descr>
        -- <unit>deg/d</unit>
    velRaSigma DOUBLE NULL,
        -- <descr>Uncertainty in RA velocity</descr>
        -- <unit>deg/d</unit>
    velDecl DOUBLE NULL,
        -- <descr>Average Dec velocity</descr>
        -- <unit>deg/d</unit>
    velDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty in Dec velocity</descr>
        -- <unit>deg/d</unit>
    velTot DOUBLE NULL,
        -- <descr>Average total velocity</descr>
        -- <unit>deg/d</unit>
    accRa DOUBLE NULL,
        -- <descr>Average RA Acceleration</descr>
        -- <unit>deg/d^2</unit>
    accRaSigma DOUBLE NULL,
        -- <descr>Uncertainty in RA acceleration</descr>
        -- <unit>deg/d^2</unit>
    accDecl DOUBLE NULL,
        -- <descr>Average Dec Acceleration</descr>
        -- <unit>deg/d^2</unit>
    accDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty in Dec acceleration</descr>
        -- <unit>deg/d^2</unit>
    extEpoch DOUBLE NULL,
        -- <descr>Extrapolated (central) epoch, MJD (UTC)</descr>
    extRa DOUBLE NULL,
        -- <descr>Extrapolated (central) RA</descr>
        -- <unit>deg</unit>
    extRaSigma DOUBLE NULL,
        -- <descr>Uncertainty in extrapolated RA</descr>
        -- <unit>deg</unit>
    extDecl DOUBLE NULL,
        -- <descr>Extrapolated (central) Dec</descr>
        -- <unit>deg</unit>
    extDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty in extrapolated Dec</descr>
        -- <unit>deg</unit>
    extMag DOUBLE NULL,
        -- <descr>Extrapolated (central) magnitude</descr>
        -- <unit>mag</unit>
    extMagSigma DOUBLE NULL,
        -- <descr>Uncertainty in extrapolated mag</descr>
        -- <unit>mag</unit>
    probability DOUBLE NULL,
        -- <descr>Likelihood tracklet is real (unused currently)</descr>
    status CHAR(1) NULL,
        -- <descr>processing status (unfound 'X', unattributed 'U', attributed
        -- 'A')</descr>
    classification CHAR(1) NULL,
        -- <descr>MOPS efficiency classification</descr>
    PRIMARY KEY (trackletId),
    INDEX idx_mopsTracklets_ccdExposureId (ccdExposureId ASC),
    INDEX idx_mopsTracklets_ssmId (ssmId ASC),
    INDEX idx_mopsTracklets_classification (classification ASC),
    INDEX idx_mopsTracklets_extEpoch (extEpoch ASC)
) ;


CREATE TABLE mops_TrackletToDiaSource
    -- <descr>Table maintaining many-to-many relationship between tracklets and
    -- detections.</descr>
(
    trackletId BIGINT NOT NULL,
        -- <ucd>meta.id</ucd>
    diaSourceId BIGINT NOT NULL,
        -- <ucd>meta.code.multip;obs.sequence</ucd>
    PRIMARY KEY (trackletId, diaSourceId),
    INDEX idx_mopsTrackletsToDIASource_diaSourceId (diaSourceId ASC),
    INDEX (trackletId)
) ;


CREATE TABLE mops_TrackToTracklet
(
    trackId BIGINT NOT NULL,
        -- <ucd>meta.id</ucd>
    trackletId BIGINT NOT NULL,
    PRIMARY KEY (trackId, trackletId),
    INDEX IDX_mopsTrackToTracklet_trackletId (trackletId ASC)
) ;


CREATE TABLE _Raw_Ccd_ExposureToVisit
    -- <descr>Mapping table: Raw_Ccd_Exposure --&amp;gt; visit</descr>
(
    visitId INTEGER NOT NULL,
        -- <descr>Pointer to entry in Visit table - visit that given Exposure
        -- belongs to.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    ccdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to entry in Raw_Ccd_Exposure table.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    INDEX (ccdExposureId),
    INDEX (visitId)
) ENGINE=MyISAM;


CREATE TABLE FpaMetadata
    -- <descr>Focal-plane-related generic key-value pair metadata./descr>
(
    ccdExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding Raw or Science Ccd_Exposure.
        -- </descr>
        -- <ucd>meta.id;obs.image</ucd>
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits tbd...</descr>
    metadataKey VARCHAR(255) NOT NULL,
    metadataValue VARCHAR(255) NULL,
    PRIMARY KEY (ccdExposureId)
) ENGINE=MyISAM;


CREATE TABLE RaftMetadata
(
    raftId BIGINT NOT NULL,
        -- <descr>tbd</descr>
        -- <ucd>meta.id;inst.det</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    metadataValue VARCHAR(255) NULL,
    PRIMARY KEY (raftId)
) ENGINE=MyISAM;


CREATE TABLE Raw_Amp_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    rawCcdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to Raw_Amp_Exposure containing this science amp
        -- exposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    visitId INTEGER NOT NULL,
        -- <descr>Visit id from Visit table this exposure belongs to.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    snap TINYINT NOT NULL,
        -- <descr>Snap id this exposure belongs to.</descr>
        -- <ucd>meta.code.multip;obs.sequence</ucd>
    raft TINYINT NOT NULL,
        -- <descr>Raft id from RaftTable this exposure belongs to.</descr>
        -- <ucd>meta.id;inst.det</ucd>
    ccd TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the CcdMap table.</descr>
        -- <ucd>meta.id;inst.det</ucd>
    amp TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the AmpMap table.</descr>
        -- <ucd>meta.id;inst.det</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>Id of the filter used for this exposure.</descr>
        -- <ucd>meta.id;inst.filter</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of amp center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of amp center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    equinox FLOAT(0) NOT NULL,
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
    crpix1 FLOAT(0) NOT NULL,
        -- <descr>Coordinate reference pixel, axis 1.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crpix2 FLOAT(0) NOT NULL,
        -- <descr>Coordinate reference pixel, axis 2.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crval1 DOUBLE NOT NULL,
        -- <descr>Coordinate value 1 @reference pixel.</descr>
        -- <ucd>pos.wcs.crvar</ucd>
        -- <unit>deg</unit>
    crval2 DOUBLE NOT NULL,
        -- <descr>Coordinate value 2 @reference pixel.</descr>
        -- <ucd>pos.wcs.crvar</ucd>
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
        -- <ucd>pos.eq.ra</ucd>
    llcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    ulcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    ulcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    urcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    urcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    lrcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    lrcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    taiMjd DOUBLE NOT NULL,
        -- <descr>Date of the start of the exposure.</descr>
        -- <ucd>time.start</ucd>
        -- <unit>d</unit>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <ucd>time.start</ucd>
    expMidpt VARCHAR(30) NOT NULL,
        -- <ucd>time.epoch</ucd>
    expTime FLOAT(0) NOT NULL,
        -- <descr>Duration of exposure.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    airmass FLOAT(0) NOT NULL,
        -- <ucd>obs.airmass</ucd>
    darkTime FLOAT(0) NOT NULL,
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    zd FLOAT(0) NULL,
        -- <ucd>pos.az.zd</ucd>
        -- <unit>deg</unit>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <ucd>meta.code</ucd>
    PRIMARY KEY (rawAmpExposureId)
) ENGINE=MyISAM;


CREATE TABLE Raw_Amp_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Raw_Amp_Exposure.</descr>
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding Raw_Amp_Exposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits: 0x1 - rawAmp, 0x2 - postIsrAmp, more
        -- tbd.</descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (rawAmpExposureId, metadataKey),
    INDEX IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;


CREATE TABLE Raw_Amp_To_Science_Ccd_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    scienceCcdExposureId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    snap TINYINT NOT NULL,
        -- <ucd>meta.code.multip;obs.sequence</ucd>
    amp TINYINT NOT NULL,
        -- <ucd>meta.id;inst.det</ucd>
    PRIMARY KEY (rawAmpExposureId),
    INDEX scienceCcdExposureId (scienceCcdExposureId ASC)
) ENGINE=MyISAM;


CREATE TABLE Raw_Amp_To_Snap_Ccd_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    amp TINYINT NOT NULL,
        -- <ucd>meta.id;inst.det</ucd>
    snapCcdExposureId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    PRIMARY KEY (rawAmpExposureId),
    INDEX snapCcdExposureId (snapCcdExposureId ASC)
) ENGINE=MyISAM;


CREATE TABLE Raw_Ccd_Exposure
(
    rawCcdExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>Right Ascension of aperture center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Declination of aperture center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    filterId INTEGER NOT NULL,
        -- <ucd>meta.id;inst.filter</ucd>
    equinox FLOAT(0) NOT NULL,
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
    airmass FLOAT(0) NULL,
        -- <descr>Airmass value for the Amp reference pixel (preferably center,
        -- but not guaranteed). Range: [-99.999, 99.999] is enough to accomodate
        -- ZD in [0, 89.433].</descr>
    crpix1 FLOAT(0) NOT NULL,
        -- <descr>Coordinate reference pixel, axis 1.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crpix2 FLOAT(0) NOT NULL,
        -- <descr>Coordinate reference pixel, axis 2.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crval1 DOUBLE NOT NULL,
        -- <descr>Coordinate value 1 @reference pixel.</descr>
        -- <ucd>pos.wcs.crvar</ucd>
        -- <unit>deg</unit>
    crval2 DOUBLE NOT NULL,
        -- <descr>Coordinate value 2 @reference pixel.</descr>
        -- <ucd>pos.wcs.crvar</ucd>
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
    darkTime FLOAT(0) NULL,
        -- <descr>Total elapsed time from exposure start to end of read.</descr>
        -- <unit>s</unit>
    zd FLOAT(0) NULL,
        -- <descr>Zenith distance at observation mid-point.</descr>
        -- <ucd>pos.az.zd</ucd>
        -- <unit>deg</unit>
    taiObs TIMESTAMP NOT NULL DEFAULT 0,
        -- <descr>TAI-OBS = UTC + offset, offset = 32 s from 1/1/1999 to
        -- 1/1/2006</descr>
    expTime FLOAT(0) NOT NULL,
        -- <descr>Duration of exposure.</descr>
        -- <unit>s</unit>
    PRIMARY KEY (rawCcdExposureId)
) ENGINE=MyISAM;


CREATE TABLE Raw_Ccd_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Raw_Ccd_Exposure.</descr>
(
    rawCcdExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding Raw_Ccd_Exposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits: 0x1 - rawCcd, 0x2 - postIsrCcd, more
        -- tbd.</descr>
    metadataKey VARCHAR(255) NOT NULL,
    metadataValue VARCHAR(255) NULL,
    PRIMARY KEY (rawCcdExposureId)
) ENGINE=MyISAM;


CREATE TABLE Science_Amp_Exposure
(
    scienceAmpExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to Science_Ccd_Exposure containing this science amp
        -- exposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    rawAmpExposureId BIGINT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    ampId INTEGER NULL,
        -- <descr>Pointer to the amplifier corresponding to this amp exposure.
        -- </descr>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY (scienceAmpExposureId),
    INDEX (scienceCcdExposureId),
    INDEX (rawAmpExposureId)
) ENGINE=MyISAM;


CREATE TABLE Science_Amp_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Science_Amp_Exposure.</descr>
(
    scienceAmpExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding Science_Amp_Exposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits: 0x1 - scienceAmp, 0x2 - diffAmp, more
        -- tbd.</descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (scienceAmpExposureId, metadataKey),
    INDEX IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;


CREATE TABLE Science_Ccd_Exposure
(
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    visit INTEGER NOT NULL,
        -- <descr>Reference to the corresponding entry in the Visit table.</descr>
        -- <ucd>meta.id;obs.exposure</ucd>
    raft TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the RaftMap table.</descr>
        -- <ucd>meta.id;inst.det</ucd>
    ccd TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the CcdMap table.</descr>
        -- <ucd>meta.id;inst.det</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>Id of the filter used for this exposure.</descr>
        -- <ucd>meta.id;inst.filter</ucd>
    ra DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    equinox FLOAT(0) NOT NULL,
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
    crpix1 FLOAT(0) NOT NULL,
        -- <descr>Coordinate reference pixel, axis 1.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crpix2 FLOAT(0) NOT NULL,
        -- <descr>Coordinate reference pixel, axis 2.</descr>
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crval1 DOUBLE NOT NULL,
        -- <descr>Coordinate value 1 @reference pixel.</descr>
        -- <ucd>pos.wcs.crvar</ucd>
        -- <unit>deg</unit>
    crval2 DOUBLE NOT NULL,
        -- <descr>Coordinate value 2 @reference pixel.</descr>
        -- <ucd>pos.wcs.crvar</ucd>
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
        -- <unit>deg</unit>
    llcDecl DOUBLE NOT NULL,
        -- <unit>deg</unit>
    ulcRa DOUBLE NOT NULL,
        -- <unit>deg</unit>
    ulcDecl DOUBLE NOT NULL,
        -- <unit>deg</unit>
    urcRa DOUBLE NOT NULL,
        -- <unit>deg</unit>
    urcDecl DOUBLE NOT NULL,
        -- <unit>deg</unit>
    lrcRa DOUBLE NOT NULL,
        -- <unit>deg</unit>
    lrcDecl DOUBLE NOT NULL,
        -- <unit>deg</unit>
    taiMjd DOUBLE NOT NULL,
        -- <descr>Date of the start of the exposure</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <ucd>time.start</ucd>
    expMidpt VARCHAR(30) NOT NULL,
        -- <ucd>time.epoch</ucd>
    expTime FLOAT(0) NOT NULL,
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
    readNoise FLOAT(0) NOT NULL,
        -- <descr>Read noise of the ccd.</descr>
        -- <ucd>inst.det.noise</ucd>
        -- <unit>adu</unit>
    saturationLimit INTEGER NOT NULL,
        -- <descr>Saturation limit for the ccd (average of the amplifiers).
        -- </descr>
        -- <ucd>inst.saturation</ucd>
    gainEff DOUBLE NOT NULL,
        -- <ucd>arith.factor;inst.det</ucd>
        -- <unit>electron/adu</unit>
    fluxMag0 FLOAT(0) NOT NULL,
        -- <ucd>phot.flux.density</ucd>
    fluxMag0Sigma FLOAT(0) NOT NULL,
        -- <ucd>stat.error;phot.flux.density</ucd>
    fwhm DOUBLE NOT NULL,
        -- <ucd>inst.obsty.seeing</ucd>
        -- <unit>arcsec</unit>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY (scienceCcdExposureId)
) ENGINE=MyISAM;


CREATE TABLE Science_Ccd_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Science_Ccd_Exposure.</descr>
(
    scienceCcdExposureId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits: 0x1 - scienceCcd, 0x2 - diffCcd, more
        -- tbd.</descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (scienceCcdExposureId, metadataKey),
    INDEX IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;


CREATE TABLE Snap_Ccd_To_Science_Ccd_Exposure
(
    snapCcdExposureId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    snap TINYINT NOT NULL,
        -- <ucd>meta.code.multip;obs.sequence</ucd>
    scienceCcdExposureId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    PRIMARY KEY (snapCcdExposureId),
    INDEX scienceCcdExposureId (scienceCcdExposureId ASC)
) ENGINE=MyISAM;


CREATE TABLE Visit
    -- <descr>Defines a single Visit. 1 row per LSST visit.</descr>
(
    visitId INTEGER NOT NULL,
        -- <descr>Unique identifier.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    PRIMARY KEY (visitId)
) ENGINE=MyISAM;


CREATE TABLE CalibSource
    -- <descr>Table to store measured sources corresponding to sources from 
    -- the astrometric and photometric catalogs. They are used for calibration
    -- (as input for WCS determination).</descr>
(
    calibSourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.code.multip;obs.sequence</ucd>
    ccdExposureId BIGINT NULL,
        -- <descr>Pointer to CcdExposure where this source was measured. Note
        -- that we do not allow a source to belong to multiple CcdExposures (it
        -- may not span multiple CcdExposures).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterId TINYINT NULL,
        -- <descr>Pointer to an entry in Filter table: filter used to take the
        -- Exposure where this Source was measured.</descr>
        -- <ucd>meta.id;inst.filter</ucd>
    astroRefCatId BIGINT NULL,
        -- <descr>Pointer to the corresponding object from the Astrometric
        -- Reference Catalog.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    photoRefCatId BIGINT NULL,
        -- <descr>Pointer to the corresponding object in the Photometric
        -- Reference Catalog.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>RA-coordinate of the center of the calibSource.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    raSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of ra.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the calibSource.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    declSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of decl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    xAstrom DOUBLE NOT NULL,
        -- <descr>x position computed by a centroiding algorithm.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    xAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of xAstrom.</descr>
        -- <ucd>stat.error;pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    yAstrom DOUBLE NOT NULL,
        -- <descr>y position computed by a centroiding algorithm.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    yAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of yAstrom.</descr>
        -- <ucd>stat.error;pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    xyAstromCov FLOAT(0) NOT NULL,
        -- <descr>Covariance between the xAstrom and the yAstrom.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^2</unit>
    psfFlux DOUBLE NOT NULL,
        -- <descr>Psf flux.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    psfFluxSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of the psfFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NOT NULL,
        -- <descr>Aperture flux. Needed for aperture correction
        -- calculation.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    apFluxSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    momentIxx FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    momentIxxSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIxx: sqrt(covariance(x, x))</descr>
    momentIyy FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    momentIyySigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIyy: sqrt(covariance(y, y))</descr>
    momentIxy FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    momentIxySigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIxy: sqrt(covariance(x, y))</descr>
    flags BIGINT NULL DEFAULT 0,
        -- <descr>Flag for capturing various conditions/statuses.</descr>
        -- <ucd>meta.code</ucd>
    _chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (calibSourceId),
    INDEX (ccdExposureId),
    INDEX (filterId),
    INDEX (xAstromSigma)
) ENGINE=MyISAM;


CREATE TABLE DiaSource
    -- <descr>Table to store &quot;difference image sources&quot; - sources
    -- detected on a difference image during Alert Production.</descr>
(
    diaSourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    ccdExposureId BIGINT NULL,
        -- <descr>Pointer to the CcdExpsoure where this diaSource was measured.
        -- Note that we are allowing a diaSource to belong to multiple
        -- AmpExposures, but it may not span multiple CcdExposures.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>Pointer to an entry in Filter table: filter used to take
        -- Exposure where this diaSource was measured.</descr>
        -- <ucd>meta.id;inst.filter</ucd>
    objectId BIGINT NULL,
        -- <descr>Pointer to Object table. Might be NULL (each diaSource will
        -- point to either MovingObject or Object)</descr>
        -- <ucd>meta.id;src</ucd>
    movingObjectId BIGINT NULL,
        -- <descr>Pointer to MovingObject table. Might be NULL (each diaSource
        -- will point to either MovingObject or Object)</descr>
        -- <ucd>meta.id;src</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>RA-coordinate of the center of the diaSource.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    raSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of ra.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the diaSource.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    declSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of decl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    xAstrom FLOAT(0) NOT NULL,
        -- <descr>x position computed by a centroiding algorithm for the
        -- purposes of astrometry using Dave Monet's algorithm.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    xAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of xAstrom.</descr>
        -- <ucd>stat.error;pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    yAstrom FLOAT(0) NOT NULL,
        -- <descr>y position computed by a centroiding algorithm for the
        -- purposes of astrometry using Dave Monet's algorithm.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    yAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of yAstrom.</descr>
        -- <ucd>stat.error;pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    xyAstromCov FLOAT(0) NOT NULL,
        -- <descr>Covariance between the xAstrom and the yAstrom.</descr>
        -- <ucd>pos.cartesian</ucd>
        -- <unit>pixel^2</unit>
    xOther FLOAT(0) NOT NULL,
        -- <descr>x position computed by a centroiding algorithm for the
        -- purposes of astrometry using &quot;other&quot; centroiding
        -- algorithm.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    xOtherSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of xOther.</descr>
        -- <ucd>stat.error;pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    yOther FLOAT(0) NOT NULL,
        -- <descr>y position computed by a centroiding algorithm for the
        -- purposes of astrometry using &quot;other&quot; centroiding
        -- algorithm.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    yOtherSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of yOther.</descr>
        -- <ucd>stat.error;pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    xyOtherCov FLOAT(0) NOT NULL,
        -- <descr>Covariance between the xOther and yOther.</descr>
        -- <ucd>pos.cartesian</ucd>
        -- <unit>pixel^2</unit>
    astromRefrRa FLOAT(0) NULL,
        -- <descr>Astrometric refraction in ra.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    astromRefrRaSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of astromRefrRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    astromRefrDecl FLOAT(0) NULL,
        -- <descr>Astrometric refraction in decl.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    astromRefrDeclSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of astromRefrDecl.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    sky FLOAT(0) NOT NULL,
        -- <descr>Sky background.</descr>
    skySigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of sky.</descr>
    psfLnL FLOAT(0) NULL,
        -- <descr>ln(likelihood) of being a PSF.</descr>
    lnL_SG FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Small Galaxy.</descr>
    flux_PS FLOAT(0) NOT NULL,
        -- <descr>Uncalibrated flux for Point Source model.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    flux_PS_Sigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of flux_PS.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    flux_SG FLOAT(0) NOT NULL,
        -- <descr>Uncalibrated flux for Small Galaxy model.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    flux_SG_Sigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of flux_SG.</descr>
        -- <ucd>stat.error;phot.count</ucd>
    flux_CSG FLOAT(0) NOT NULL,
        -- <descr>Uncalibrated flux for Cannonical Small Galaxy model.
        -- </descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    flux_CSG_Sigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainly of flux_CSG.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    extendedness FLOAT(0) NULL,
        -- <descr>Probability that this DiaSource is an extended source. Valid
        -- range: 0-1, where 1 indicates an extended source with 100%
        -- probability.</descr>
    galExtinction FLOAT(0) NULL,
        -- <descr>Galactic extinction.</descr>
    apCorrection FLOAT(0) NOT NULL,
        -- <descr>Photometric correction: aperture correction.</descr>
    grayExtinction FLOAT(0) NOT NULL,
        -- <descr>Photometric correction: gray extinction.</descr>
    nonGrayExtinction FLOAT(0) NOT NULL,
        -- <descr>Photometric correction: non-gray extinction.</descr>
    midPoint FLOAT(0) NOT NULL,
        -- <descr>Corrected midpoint of the exposure (tai).</descr>
    momentIx FLOAT(0) NULL,
        -- <descr>Adaptive first moment.</descr>
    momentIxSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIx.</descr>
    momentIy FLOAT(0) NULL,
        -- <descr>Adaptive first moment.</descr>
    momentIySigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIy.</descr>
    momentIxx FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    momentIxxSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIxx.</descr>
    momentIyy FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    momentIyySigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIyy.</descr>
    momentIxy FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    momentIxySigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIx.</descr>
    flags BIGINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    _chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (diaSourceId),
    INDEX (ccdExposureId),
    INDEX (filterId),
    INDEX (movingObjectId),
    INDEX (objectId)
) ENGINE=MyISAM;


CREATE TABLE ForcedSource
    -- <descr>Forced-photometry source measurement on an individual Exposure
    -- based on a Multifit shape model derived from a deep detection.
    -- </descr>
(
    objectId BIGINT NOT NULL,
        -- <ucd>meta.id;src</ucd>
    visitId INTEGER NOT NULL,
        -- <descr>Pointer to the entry in Visit table where this forcedSource
        -- was measured.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    flux FLOAT(0) NOT NULL,
        -- <descr>Uncalibrated flux.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    flux_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of flux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    x FLOAT(0) NULL,
        -- <descr>x position computed by a centroiding algorithm.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y FLOAT(0) NULL,
        -- <descr>y position computed by a centroiding algorithm.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    flags TINYINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY (objectId, visitId)
) ENGINE=MyISAM;


CREATE TABLE MovingObject
    -- <descr>The movingObject table contains description of the Solar System
    -- (moving) Objects.</descr>
(
    movingObjectId BIGINT NOT NULL,
        -- <descr>Moving object unique identified.</descr>
        -- <ucd>meta.id;src</ucd>
    movingObjectVersion INT NOT NULL DEFAULT '1',
        -- <descr>Version number for the moving object. Updates to orbital
        -- parameters will result in a new version (row) of the object,
        -- preserving the orbit refinement history</descr>
    procHistoryId INTEGER NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    taxonomicTypeId SMALLINT NULL,
        -- <descr>Pointer to ObjectType table for asteroid taxonomic type
        -- </descr>
    ssmObjectName VARCHAR(32) NULL,
        -- <descr>MOPS base-64 SSM object name, included for convenience. This
        -- name can be obtained from `mops_SSM` by joining on `ssmId`</descr>
    q DOUBLE NOT NULL,
        -- <descr>semi-major axis of the orbit (AU)</descr>
    e DOUBLE NOT NULL,
        -- <descr>eccentricity e (dimensionless)</descr>
    i DOUBLE NOT NULL,
        -- <descr>Inclination of the orbit.</descr>
        -- <unit>deg</unit>
    node DOUBLE NOT NULL,
        -- <descr>Longitude of ascending node.</descr>
        -- <unit>deg</unit>
    meanAnom DOUBLE NOT NULL,
        -- <descr>Mean anomaly of the orbit</descr>
    argPeri DOUBLE NOT NULL,
        -- <descr>Argument of perihelion.</descr>
        -- <unit>deg</unit>
    distPeri DOUBLE NOT NULL,
        -- <descr>perihelion distance (AU)</descr>
    timePeri DOUBLE NOT NULL,
        -- <descr>time of perihelion passage, MJD (UTC)</descr>
    epoch DOUBLE NOT NULL,
        -- <descr>epoch of osculating elements, MJD (UTC)</descr>
    h_v DOUBLE NOT NULL,
        -- <descr>Absolute magnitude</descr>
    g DOUBLE NULL DEFAULT 0.15,
        -- <descr>Slope parameter g</descr>
    rotationPeriod DOUBLE NULL,
        -- <descr>Rotation period</descr>
        -- <unit>d</unit>
    rotationEpoch DOUBLE NULL,
        -- <descr>Rotation time origin, MJD (UTC)</descr>
    albedo DOUBLE NULL,
        -- <descr>Albedo (dimensionless)</descr>
    poleLat DOUBLE NULL,
        -- <descr>Rotation pole latitude (degs)</descr>
    poleLon DOUBLE NULL,
        -- <descr>Rotation pole longitude (degs)</descr>
    d3 DOUBLE NULL,
        -- <descr>3-parameter D-criterion (dimensionless) WRT SSM object</descr>
    d4 DOUBLE NULL,
        -- <descr>4-parameter D-criterion (dimensionless) WRT SSM object</descr>
    orbFitResidual DOUBLE NOT NULL,
        -- <descr>Orbit fit RMS residual.</descr>
        -- <unit>arcsec</unit>
    orbFitChi2 DOUBLE NULL,
        -- <descr>orbit fit chi-squared statistic</descr>
    classification CHAR(1) NULL,
        -- <descr>MOPS efficiency classification ('C'/'M'/'B'/'N'/'X')</descr>
    ssmId BIGINT NULL,
        -- <descr>Source SSM object for C classification</descr>
    mopsStatus CHAR(1) NULL,
        -- <descr>NULL, or set to 'M' when DO is merged with parent</descr>
    stablePass CHAR(1) NULL,
        -- <descr>NULL, or set to 'Y' when stable precovery pass completed
        -- </descr>
    timeCreated TIMESTAMP NULL,
        -- <descr>Timestamp for row creation (this is the time of moving object
        -- creation for the first version of that object)</descr>
    uMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in u filter.</descr>
        -- <unit>mag</unit>
    uMagSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uMag.</descr>
        -- <unit>mag</unit>
    uAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for u
        -- filter</descr>
    uPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for u filter</descr>
    gMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in g filter.</descr>
        -- <unit>mag</unit>
    gMagSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gMag.</descr>
        -- <unit>mag</unit>
    gAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for g
        -- filter</descr>
    gPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for g filter</descr>
    rMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in r filter.</descr>
        -- <unit>mag</unit>
    rMagSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rMag.</descr>
        -- <unit>mag</unit>
    rAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for r
        -- filter</descr>
    rPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for r filter</descr>
    iMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in i filter.</descr>
        -- <unit>mag</unit>
    iMagSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iMag.</descr>
        -- <unit>mag</unit>
    iAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for i
        -- filter</descr>
    iPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for i filter</descr>
    zMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in z filter.</descr>
        -- <unit>mag</unit>
    zMagSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zMag.</descr>
        -- <unit>mag</unit>
    zAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for z
        -- filter</descr>
    zPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for z filter</descr>
    yMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in y filter.</descr>
        -- <unit>mag</unit>
    yMagSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yMag.</descr>
        -- <unit>mag</unit>
    yAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for y
        -- filter</descr>
    yPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for y filter</descr>
    flags INTEGER NULL DEFAULT 0,
        -- <descr>Problem/special condition flag.</descr>
        -- <ucd>meta.code</ucd>
    src01 DOUBLE NULL,
        -- <descr>square root of covariance EC EC (see SQL documentation)
        -- </descr>
    src02 DOUBLE NULL,
        -- <descr>square root of covariance EC QR (see SQL documentation)
        -- </descr>
    src03 DOUBLE NULL,
        -- <descr>square root of covariance QR QR (see SQL documentation)
        -- </descr>
    src04 DOUBLE NULL,
        -- <descr>square root of covariance EC TP (see SQL documentation)
        -- </descr>
    src05 DOUBLE NULL,
        -- <descr>square root of covariance QR TP (see SQL documentation)
        -- </descr>
    src06 DOUBLE NULL,
        -- <descr>square root of covariance TP TP (see SQL documentation)
        -- </descr>
    src07 DOUBLE NULL,
        -- <descr>square root of covariance EC OM (see SQL documentation)
        -- </descr>
    src08 DOUBLE NULL,
        -- <descr>square root of covariance QR OM (see SQL documentation)
        -- </descr>
    src09 DOUBLE NULL,
        -- <descr>square root of covariance TP OM (see SQL documentation)
        -- </descr>
    src10 DOUBLE NULL,
        -- <descr>square root of covariance OM OM (see SQL documentation)
        -- </descr>
    src11 DOUBLE NULL,
        -- <descr>square root of covariance EC W (see SQL documentation)</descr>
    src12 DOUBLE NULL,
        -- <descr>square root of covariance QR W (see SQL documentation)</descr>
    src13 DOUBLE NULL,
        -- <descr>square root of covariance TP W (see SQL documentation)</descr>
    src14 DOUBLE NULL,
        -- <descr>square root of covariance OM W (see SQL documentation)</descr>
    src15 DOUBLE NULL,
        -- <descr>square root of covariance W W (see SQL documentation)</descr>
    src16 DOUBLE NULL,
        -- <descr>square root of covariance EC IN (see SQL documentation)
        -- </descr>
    src17 DOUBLE NULL,
        -- <descr>square root of covariance QR IN (see SQL documentation)
        -- </descr>
    src18 DOUBLE NULL,
        -- <descr>square root of covariance TP IN (see SQL documentation)
        -- </descr>
    src19 DOUBLE NULL,
        -- <descr>square root of covariance OM IN (see SQL documentation)
        -- </descr>
    src20 DOUBLE NULL,
        -- <descr>square root of covariance W IN (see SQL documentation)</descr>
    src21 DOUBLE NULL,
        -- <descr>square root of covariance IN IN (see SQL documentation)
        -- </descr>
    convCode VARCHAR(8) NULL,
        -- <descr>JPL convergence code</descr>
    o_minus_c DOUBLE NULL,
        -- <descr>Vestigial observed-computed position, essentially RMS residual
        -- </descr>
    moid1 DOUBLE NULL,
        -- <descr>Minimum orbital intersection distance (MOID) solution 1
        -- </descr>
    moidLong1 DOUBLE NULL,
        -- <descr>Longitude of MOID 1</descr>
    moid2 DOUBLE NULL,
        -- <descr>Minimum orbital intersection distance (MOID) solution 2
        -- </descr>
    moidLong2 DOUBLE NULL,
        -- <descr>Longitude of MOID 2</descr>
    arcLengthDays DOUBLE NULL,
        -- <descr>Arc length of detections used to compute orbit</descr>
    PRIMARY KEY (movingObjectId, movingObjectVersion),
    INDEX (procHistoryId),
    INDEX idx_MovingObject_taxonomicTypeId (taxonomicTypeId ASC),
    INDEX idx_MovingObject_ssmId (ssmId ASC),
    INDEX idx_MovingObject_ssmObjectName (ssmObjectName ASC),
    INDEX idx_MovingObject_status (mopsStatus ASC)
) ENGINE=MyISAM;


CREATE TABLE Object
    -- <descr>The Object table contains descriptions of the multi-epoch static
    -- astronomical objects, in particular their astrophysical properties as
    -- derived from analysis of the Sources that are associated with them. Note
    -- that fast moving objects are kept in the MovingObject tables. Note that
    -- less-frequently used columns are stored in a separate table called
    -- ObjectExtras.</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    iauId CHAR(34) NULL,
        -- <descr>IAU compliant name for the object. Example: &quot;LSST-DR11
        -- J001234.65-123456.18 GAL&quot;. The last 3 characters identify
        -- classification. Note that it will not accommodate multiple
        -- classifications.</descr>
    ra_PS DOUBLE NOT NULL,
        -- <descr>RA-coordinate of the center of the object for the Point 
        -- Source model for the cannonical filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    ra_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of ra_PS.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl_PS DOUBLE NOT NULL,
        -- <descr>Dec-coordinate of the center of the object for the Point
        -- Source model for the cannonical filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    decl_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of decl_PS.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    radecl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra_PS and decl_PS.</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>deg^2</unit>
    ra_SG DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the 
        -- Small Galaxy model for the cannonical filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    ra_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of ra_SG.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl_SG DOUBLE NULL,
        -- <descr>Dec-coordinate of the center of the object for the Small
        -- Galaxy model for the cannonical filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    decl_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of decl_SG.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    radecl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra_SG and decl_SG.</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>deg^2</unit>
    raRange FLOAT(0) NULL,
        -- <descr>Ra part of the bounding box on the sky that fully encloses
        -- footprint of this object for the cannonical model (Small Galaxy) 
        -- and cannonical filter.</descr>
        -- <unit>deg</unit>
    declRange FLOAT(0) NULL,
        -- <descr>Decl part of the bounding box on the sky that fully encloses
        -- footprint of this object for the cannonical model (Small Galaxy) and
        -- cannonical filter.</descr>
        -- <unit>deg</unit>
    muRa_PS DOUBLE NULL,
        -- <descr>Proper motion (ra) for the Point Source model.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>deg/yr</unit>
    muRa_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of muRa_PS.</descr>
        -- <ucd>stat.error;pos.pm</ucd>
        -- <unit>deg/yr</unit>
    muDecl_PS DOUBLE NULL,
        -- <descr>Proper motion (decl) for the Point Source model.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>deg/yr</unit>
    muDecl_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of muDecl_PS.</descr>
        -- <ucd>stat.error;pos.pm</ucd>
        -- <unit>deg/yr</unit>
    muRaDecl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of muRa_PS and muDecl_PS.</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>(deg/yr)^2</unit>
    parallax_PS DOUBLE NULL,
        -- <descr>Parallax for Point Source model.</descr>
        -- <ucd>pos.parallax</ucd>
        -- <unit>deg/yr</unit>
    parallax_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of parallax_PS.</descr>
        -- <ucd>stat.error;pos.parallax</ucd>
        -- <unit>deg/yr</unit>
    canonicalFilterId TINYINT NULL,
        -- <descr>Id of the filter which is the canonical filter for size,
        -- ellipticity and Sersic index parameters.</descr>
        -- <ucd>meta.id;inst.filter</ucd>
    extendedness FLOAT(0) NULL,
        -- <descr>Probability that this object is an extended object. Valid
        -- range: 0-1, where 1 indicates an extended object with 100%
        -- probability.</descr>
    varProb FLOAT(0) NULL,
        -- <descr>Probability that this object is variable. Valid range: 0-1,
        -- where 1 indicates a variable object with 100% probability.
        -- </descr>
    earliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time
        -- (taiMidPoint of the first Source)</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>TAI</unit>
    latestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed 
        -- (taiMidPoint of the last Source).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>TAI</unit>
    flags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    uNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for u
        -- filter.</descr>
        -- <ucd>stat.value</ucd>
    uExtendedness FLOAT(0) NULL,
        -- <descr>Probability that this object is an extended object for u
        -- filter. Valid range: 0-1, where 1 indicates an extended object with
        -- 100% probability.</descr>
    uVarProb FLOAT(0) NULL,
        -- <descr>Probability that this object is variable for u filter. Valid
        -- range: 0-1, where 1 indicates a variable object with 100%
        -- probability.</descr>
    uRaOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of ra_PS for u filter.</descr>
    uRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uRaOffset_PS.</descr>
    uDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of decl_PS for u filter.</descr>
    uDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uDeclOffset_PS.</descr>
    uRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of uRaOffset_PS and uDeclOffset_PS.</descr>
    uRaOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of raOffset_SG for u filter.</descr>
    uRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uRaOffset_SG.</descr>
    uDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of decl_SG for u filter.</descr>
    uDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uDeclOffset_SG.</descr>
    uRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of uRaOffset_SG and uDeclOffset_SG.</descr>
    uLnL_PS FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Point Source for u filter.
        -- </descr>
    uLnL_SG FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Small Galaxy for u filter.
        -- </descr>
    uFlux_PS FLOAT(0) NULL,
        -- <descr>Calibrated flux for Point Source model for u filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    uFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uFlux_PS.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    uFlux_SG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Small Galaxy model for u filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    uFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uFlux_SG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    uFlux_CSG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Cannonical Small Galaxy model 
        -- for u filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    uFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uFlux_CSG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    uTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for u filter.
        -- </descr>
        -- <unit>d</unit>
    uEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in u
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>TAI</unit>
    uLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in u
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
    uSersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for u filter.</descr>
    uSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uSersicN_SG.</descr>
    uE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for u filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    uE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for u filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    uE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for u filter.</descr>
        -- <ucd>phys.angSize</ucd>
        -- <unit>arcsec</unit>
    uRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uRadius_SG.</descr>
        -- <ucd>stat.error;phys.angSize</ucd>
        -- <unit>arcsec</unit>
    uFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    gNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for g
        -- filter.</descr>
        -- <ucd>stat.value</ucd>
    gExtendedness FLOAT(0) NULL,
        -- <descr>Probability that this object is an extended object for g
        -- filter. Valid range: 0-1, where 1 indicates an extended object with
        -- 100% probability.</descr>
    gVarProb FLOAT(0) NULL,
        -- <descr>Probability that this object is variable for g filter. Valid
        -- range: 0-1, where 1 indicates a variable object with 100%
        -- probability.</descr>
    gRaOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of ga_PS for g filter.</descr>
    gRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gRaOffset_PS.</descr>
    gDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of decl_PS for g filter.</descr>
    gDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gDeclOffset_PS.</descr>
    gRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of gRaOffset_PS and gDeclOffset_PS.</descr>
    gRaOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of gaOffset_SG for g filter.</descr>
    gRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gRaOffset_SG.</descr>
    gDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of decl_SG for g filter.</descr>
    gDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gDeclOffset_SG.</descr>
    gRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of gRaOffset_SG and gDeclOffset_SG.</descr>
    gLnL_PS FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Point Source for g filter.
        -- </descr>
    gLnL_SG FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Small Galaxy for g filter.
        -- </descr>
    gFlux_PS FLOAT(0) NULL,
        -- <descr>Calibrated flux for Point Source model for g filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    gFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gFlux_PS.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    gFlux_SG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Small Galaxy model for g filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    gFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gFlux_SG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    gFlux_CSG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Cannonical Small Galaxy model 
        -- for g filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    gFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gFlux_CSG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    gTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for g filter.
        -- </descr>
        -- <unit>d</unit>
    gEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in g
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>TAI</unit>
    gLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in g
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
    gSersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for g filter.</descr>
    gSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gSersicN_SG.</descr>
    gE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for g filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    gE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    gE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for g filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    gE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    gRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for g filter.</descr>
        -- <ucd>phys.angSize</ucd>
        -- <unit>arcsec</unit>
    gRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gRadius_SG.</descr>
        -- <ucd>stat.error;phys.angSize</ucd>
        -- <unit>arcsec</unit>
    gFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    rNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for r
        -- filter.</descr>
        -- <ucd>stat.value</ucd>
    rExtendedness FLOAT(0) NULL,
        -- <descr>Probability that this object is an extended object for r
        -- filter. Valid range: 0-1, where 1 indicates an extended object with
        -- 100% probability.</descr>
    rVarProb FLOAT(0) NULL,
        -- <descr>Probability that this object is variable for r filter. Valid
        -- range: 0-1, where 1 indicates a variable object with 100%
        -- probability.</descr>
    rRaOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of ra_PS for r filter.</descr>
    rRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rRaOffset_PS.</descr>
    rDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of decl_PS for r filter.</descr>
    rDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rDeclOffset_PS.</descr>
    rRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of rRaOffset_PS and gDeclOffset_PS.</descr>
    rRaOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of raOffset_SG for r filter.</descr>
    rRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rRaOffset_SG.</descr>
    rDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of decl_SG for r filter.</descr>
    rDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rDeclOffset_SG.</descr>
    rRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of rRaOffset_SG and gDeclOffset_SG.</descr>
    rLnL_PS FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Point Source for r filter.
        -- </descr>
    rLnL_SG FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Small Galaxy for r filter.
        -- </descr>
    rFlux_PS FLOAT(0) NULL,
        -- <descr>Calibrated flux for Point Source model for r filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    rFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rFlux_PS.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    rFlux_SG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Small Galaxy model for r filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    rFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rFlux_SG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    rFlux_CSG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Cannonical Small Galaxy model 
        -- for r filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    rFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rFlux_CSG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    rTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for r filter.
        -- </descr>
        -- <unit>d</unit>
    rEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in g
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>TAI</unit>
    rLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in g
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
    rSersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for r filter.</descr>
    rSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rSersicN_SG.</descr>
    rE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for r filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    rE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    rE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for r filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    rE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    rRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for r filter.</descr>
        -- <ucd>phys.angSize</ucd>
        -- <unit>arcsec</unit>
    rRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rRadius_SG.</descr>
        -- <ucd>stat.error;phys.angSize</ucd>
        -- <unit>arcsec</unit>
    rFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    iNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for i
        -- filter.</descr>
        -- <ucd>stat.value</ucd>
    iExtendedness FLOAT(0) NULL,
        -- <descr>Probability that this object is an extended object for i
        -- filter. Valid range: 0-1, where 1 indicates an extended object with
        -- 100% probability.</descr>
    iVarProb FLOAT(0) NULL,
        -- <descr>Probability that this object is variable for i filter. Valid
        -- range: 0-1, where 1 indicates a variable object with 100%
        -- probability.</descr>
    iRaOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of ia_PS for i filter.</descr>
    iRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iRaOffset_PS.</descr>
    iDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of decl_PS for i filter.</descr>
    iDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iDeclOffset_PS.</descr>
    iRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of iRaOffset_PS and gDeclOffset_PS.</descr>
    iRaOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of iaOffset_SG for i filter.</descr>
    iRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iRaOffset_SG.</descr>
    iDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of decl_SG for i filter.</descr>
    iDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iDeclOffset_SG.</descr>
    iRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of iRaOffset_SG and gDeclOffset_SG.</descr>
    iLnL_PS FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Point Source for i filter.
        -- </descr>
    iLnL_SG FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Small Galaxy for i filter.
        -- </descr>
    iFlux_PS FLOAT(0) NULL,
        -- <descr>Calibrated flux for Point Source model for i filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    iFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iFlux_PS.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    iFlux_SG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Small Galaxy model for i filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    iFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iFlux_SG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    iFlux_CSG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Cannonical Small Galaxy model 
        -- for i filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    iFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iFlux_CSG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    iTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for i filter.
        -- </descr>
        -- <unit>d</unit>
    iEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in g
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>TAI</unit>
    iLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in g
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
    iSersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for i filter.</descr>
    iSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iSersicN_SG.</descr>
    iE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for i filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    iE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    iE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for i filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    iE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    iRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for i filter.</descr>
        -- <ucd>phys.angSize</ucd>
        -- <unit>arcsec</unit>
    iRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iRadius_SG.</descr>
        -- <ucd>stat.error;phys.angSize</ucd>
        -- <unit>arcsec</unit>
    iFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    zNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for z
        -- filter.</descr>
        -- <ucd>stat.value</ucd>
    zExtendedness FLOAT(0) NULL,
        -- <descr>Probability that this object is an extended object for z
        -- filter. Valid range: 0-1, where 1 indicates an extended object with
        -- 100% probability.</descr>
    zVarProb FLOAT(0) NULL,
        -- <descr>Probability that this object is variable for z filter. Valid
        -- range: 0-1, where 1 indicates a variable object with 100%
        -- probability.</descr>
    zRaOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of za_PS for z filter.</descr>
    zRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zRaOffset_PS.</descr>
    zDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of decl_PS for z filter.</descr>
    zDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zDeclOffset_PS.</descr>
    zRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of zRaOffset_PS and gDeclOffset_PS.</descr>
    zRaOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of zaOffset_SG for z filter.</descr>
    zRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zRaOffset_SG.</descr>
    zDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of decl_SG for z filter.</descr>
    zDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zDeclOffset_SG.</descr>
    zRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of zRaOffset_SG and gDeclOffset_SG.</descr>
    zLnL_PS FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Point Source for z filter.
        -- </descr>
    zLnL_SG FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Small Galaxy for z filter.
        -- </descr>
    zFlux_PS FLOAT(0) NULL,
        -- <descr>Calibrated flux for Point Source model for z filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    zFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zFlux_PS.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    zFlux_SG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Small Galaxy model for z filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    zFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zFlux_SG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    zFlux_CSG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Cannonical Small Galaxy model 
        -- for z filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    zFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zFlux_CSG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    zTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for z filter.
        -- </descr>
        -- <unit>d</unit>
    zEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in g
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>TAI</unit>
    zLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in g
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
    zSersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for z filter.</descr>
    zSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zSersicN_SG.</descr>
    zE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for z filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    zE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    zE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for z filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    zE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    zRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for z filter.</descr>
        -- <ucd>phys.angSize</ucd>
        -- <unit>arcsec</unit>
    zRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zRadius_SG.</descr>
        -- <ucd>stat.error;phys.angSize</ucd>
        -- <unit>arcsec</unit>
    zFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    yNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for y
        -- filter.</descr>
        -- <ucd>stat.value</ucd>
    yExtendedness FLOAT(0) NULL,
        -- <descr>Probability that this object is an extended object for y
        -- filter. Valid range: 0-1, where 1 indicates an extended object with
        -- 100% probability.</descr>
    yVarProb FLOAT(0) NULL,
        -- <descr>Probability that this object is variable for y filter. Valid
        -- range: 0-1, where 1 indicates a variable object with 100%
        -- probability.</descr>
    yRaOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of ya_PS for y filter.</descr>
    yRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yRaOffset_PS.</descr>
    yDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Center correction of decl_PS for y filter.</descr>
    yDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yDeclOffset_PS.</descr>
    yRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of yRaOffset_PS and gDeclOffset_PS.</descr>
    yRaOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of yaOffset_SG for y filter.</descr>
    yRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yRaOffset_SG.</descr>
    yDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Center correction of decl_SG for y filter.</descr>
    yDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yDeclOffset_SG.</descr>
    yRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of yRaOffset_SG and gDeclOffset_SG.</descr>
    yLnL_PS FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Point Source for y filter.
        -- </descr>
    yLnL_SG FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Small Galaxy for y filter.
        -- </descr>
    yFlux_PS FLOAT(0) NULL,
        -- <descr>Calibrated flux for Point Source model for y filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    yFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yFlux_PS.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    yFlux_SG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Small Galaxy model for y filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    yFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yFlux_SG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    yFlux_CSG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Cannonical Small Galaxy model 
        -- for y filter.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    yFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yFlux_CSG.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2</unit>
    yTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for y filter.
        -- </descr>
        -- <unit>d</unit>
    yEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in g
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    yLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in g
        -- filter.</descr>
        -- <ucd>time.epoch</ucd>
    ySersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for y filter.</descr>
    ySersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of ySersicN_SG.</descr>
    yE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for y filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    yE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    yE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for y filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    yE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    yRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for y filter.</descr>
        -- <ucd>phys.angSize</ucd>
        -- <unit>arcsec</unit>
    yRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yRadius_SG.</descr>
        -- <ucd>stat.error;phys.angSize</ucd>
        -- <unit>arcsec</unit>
    yFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    _chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    _subChunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (objectId),
    INDEX IDX_Object_decl (decl_PS ASC)
) ENGINE=MyISAM;


CREATE TABLE ObjectExtras
    -- <descr>This table contains less-frequently used columns from the Object
    -- table.</descr>
(
    objectId BIGINT NOT NULL,
        -- <ucd>meta.id;src</ucd>
    uFlux_ra_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Point Source model for u
        -- filter.</descr>
    uFlux_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Point Source model for u
        -- filter.</descr>
    uRa_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and decl for Point Source model for u
        -- filter.</descr>
    uFlux_ra_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Small Galaxy model for u
        -- filter.</descr>
    uFlux_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Small Galaxy model for u
        -- filter.</descr>
    uFlux_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and SersicN for Small Galaxy model for u
        -- filter.</descr>
    uFlux_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e1 for Small Galaxy model for u
        -- filter.</descr>
    uFlux_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e2 for Small Galaxy model for u
        -- filter.</descr>
    uFlux_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and radius for Small Galaxy model for u
        -- filter.</descr>
    uRa_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and decl for Small Galaxy model for u
        -- filter.</descr>
    uRa_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and SersicN for Small Galaxy for u
        -- filter.</descr>
    uRa_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and e1 for Small Galaxy model for u
        -- filter.</descr>
    uRa_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and e2 for Small Galaxy model for u
        -- filter.</descr>
    uRa_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and radius for small galaxy model for u
        -- filter.</descr>
    uDecl_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and SersicN for Small Galaxy for u
        -- filter.</descr>
    uDecl_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e1 for Small Galaxy for u filter.
        -- </descr>
    uDecl_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e2 for Small Galaxy for u filter.
        -- </descr>
    uDecl_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and radius for Small Galaxy for u
        -- filter.</descr>
    uSersicN_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e1 for Small Galaxy Model for u
        -- filter.</descr>
    uSersicN_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e2 for Small Galaxy for u
        -- filter.</descr>
    uSersicN_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and radius for Small Galaxy for u
        -- filter.</descr>
    uE1_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and e2 for Small Galaxy for u filter.
        -- </descr>
    uE1_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and radius for Small Galaxy for u
        -- filter.</descr>
    uE2_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e2 and radius for Small Galaxy for u
        -- filter.</descr>
    gFlux_ra_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Point Source model for g
        -- filter.</descr>
    gFlux_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Point Source model for g
        -- filter.</descr>
    gRa_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ga and decl for Point Source model for g
        -- filter.</descr>
    gFlux_ra_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Small Galaxy model for g
        -- filter.</descr>
    gFlux_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Small Galaxy model for g
        -- filter.</descr>
    gFlux_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and SersicN for Small Galaxy model for g
        -- filter.</descr>
    gFlux_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e1 for Small Galaxy model for g
        -- filter.</descr>
    gFlux_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e2 for Small Galaxy model for g
        -- filter.</descr>
    gFlux_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and radius for Small Galaxy model for g
        -- filter.</descr>
    gRa_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ga and decl for Small Galaxy model for g
        -- filter.</descr>
    gRa_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ga and SersicN for Small Galaxy for g
        -- filter.</descr>
    gRa_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ga and e1 for Small Galaxy model for g
        -- filter.</descr>
    gRa_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ga and e2 for Small Galaxy model for g
        -- filter.</descr>
    gRa_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ga and radius for small galaxy model for g
        -- filter.</descr>
    gDecl_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and SersicN for Small Galaxy for g
        -- filter.</descr>
    gDecl_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e1 for Small Galaxy for g filter.
        -- </descr>
    gDecl_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e2 for Small Galaxy for g filter.
        -- </descr>
    gDecl_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and radius for Small Galaxy for g
        -- filter.</descr>
    gSersicN_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e1 for Small Galaxy Model for g
        -- filter.</descr>
    gSersicN_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e2 for Small Galaxy for g
        -- filter.</descr>
    gSersicN_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and radius for Small Galaxy for g
        -- filter.</descr>
    gE1_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and e2 for Small Galaxy for g filter.
        -- </descr>
    gE1_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and radius for Small Galaxy for g
        -- filter.</descr>
    gE2_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e2 and radius for Small Galaxy for g
        -- filter.</descr>
    rFlux_ra_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Point Source model for r
        -- filter.</descr>
    rFlux_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Point Source model for r
        -- filter.</descr>
    rRa_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and decl for Point Source model for r
        -- filter.</descr>
    rFlux_ra_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Small Galaxy model for r
        -- filter.</descr>
    rFlux_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Small Galaxy model for r
        -- filter.</descr>
    rFlux_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and SersicN for Small Galaxy model for r
        -- filter.</descr>
    rFlux_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e1 for Small Galaxy model for r
        -- filter.</descr>
    rFlux_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e2 for Small Galaxy model for r
        -- filter.</descr>
    rFlux_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and radius for Small Galaxy model for r
        -- filter.</descr>
    rRa_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and decl for Small Galaxy model for r
        -- filter.</descr>
    rRa_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and SersicN for Small Galaxy for r
        -- filter.</descr>
    rRa_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and e1 for Small Galaxy model for r
        -- filter.</descr>
    rRa_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and e2 for Small Galaxy model for r
        -- filter.</descr>
    rRa_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra and radius for small galaxy model for r
        -- filter.</descr>
    rDecl_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and SersicN for Small Galaxy for r
        -- filter.</descr>
    rDecl_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e1 for Small Galaxy for r filter.
        -- </descr>
    rDecl_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e2 for Small Galaxy for r filter.
        -- </descr>
    rDecl_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and radius for Small Galaxy for r
        -- filter.</descr>
    rSersicN_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e1 for Small Galaxy Model for r
        -- filter.</descr>
    rSersicN_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e2 for Small Galaxy for r
        -- filter.</descr>
    rSersicN_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and radius for Small Galaxy for r
        -- filter.</descr>
    rE1_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and e2 for Small Galaxy for r filter.
        -- </descr>
    rE1_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and radius for Small Galaxy for r
        -- filter.</descr>
    rE2_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e2 and radius for Small Galaxy for r
        -- filter.</descr>
    iFlux_ra_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Point Source model for i
        -- filter.</descr>
    iFlux_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Point Source model for i
        -- filter.</descr>
    iRa_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ia and decl for Point Source model for i
        -- filter.</descr>
    iFlux_ra_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Small Galaxy model for i
        -- filter.</descr>
    iFlux_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Small Galaxy model for i
        -- filter.</descr>
    iFlux_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and SersicN for Small Galaxy model for i
        -- filter.</descr>
    iFlux_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e1 for Small Galaxy model for i
        -- filter.</descr>
    iFlux_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e2 for Small Galaxy model for i
        -- filter.</descr>
    iFlux_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and radius for Small Galaxy model for i
        -- filter.</descr>
    iRa_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ia and decl for Small Galaxy model for i
        -- filter.</descr>
    iRa_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ia and SersicN for Small Galaxy for i
        -- filter.</descr>
    iRa_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ia and e1 for Small Galaxy model for i
        -- filter.</descr>
    iRa_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ia and e2 for Small Galaxy model for i
        -- filter.</descr>
    iRa_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ia and radius for small galaxy model for i
        -- filter.</descr>
    iDecl_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and SersicN for Small Galaxy for i
        -- filter.</descr>
    iDecl_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e1 for Small Galaxy for i filter.
        -- </descr>
    iDecl_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e2 for Small Galaxy for i filter.
        -- </descr>
    iDecl_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and radius for Small Galaxy for i
        -- filter.</descr>
    iSersicN_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e1 for Small Galaxy Model for i
        -- filter.</descr>
    iSersicN_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e2 for Small Galaxy for i
        -- filter.</descr>
    iSersicN_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and radius for Small Galaxy for i
        -- filter.</descr>
    iE1_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and e2 for Small Galaxy for i filter.
        -- </descr>
    iE1_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and radius for Small Galaxy for i
        -- filter.</descr>
    iE2_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e2 and radius for Small Galaxy for i
        -- filter.</descr>
    zFlux_ra_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Point Source model for z
        -- filter.</descr>
    zFlux_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Point Source model for z
        -- filter.</descr>
    zRa_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of za and decl for Point Source model for z
        -- filter.</descr>
    zFlux_ra_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Small Galaxy model for z
        -- filter.</descr>
    zFlux_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Small Galaxy model for z
        -- filter.</descr>
    zFlux_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and SersicN for Small Galaxy model for z
        -- filter.</descr>
    zFlux_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e1 for Small Galaxy model for z
        -- filter.</descr>
    zFlux_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e2 for Small Galaxy model for z
        -- filter.</descr>
    zFlux_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and radius for Small Galaxy model for z
        -- filter.</descr>
    zRa_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of za and decl for Small Galaxy model for z
        -- filter.</descr>
    zRa_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of za and SersicN for Small Galaxy for z
        -- filter.</descr>
    zRa_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of za and e1 for Small Galaxy model for z
        -- filter.</descr>
    zRa_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of za and e2 for Small Galaxy model for z
        -- filter.</descr>
    zRa_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of za and radius for small galaxy model for z
        -- filter.</descr>
    zDecl_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and SersicN for Small Galaxy for z
        -- filter.</descr>
    zDecl_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e1 for Small Galaxy for z filter.
        -- </descr>
    zDecl_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e2 for Small Galaxy for z filter.
        -- </descr>
    zDecl_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and radius for Small Galaxy for z
        -- filter.</descr>
    zSersicN_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e1 for Small Galaxy Model for z
        -- filter.</descr>
    zSersicN_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e2 for Small Galaxy for z
        -- filter.</descr>
    zSersicN_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and radius for Small Galaxy for z
        -- filter.</descr>
    zE1_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and e2 for Small Galaxy for z filter.
        -- </descr>
    zE1_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and radius for Small Galaxy for z
        -- filter.</descr>
    zE2_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e2 and radius for Small Galaxy for z
        -- filter.</descr>
    yFlux_ra_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Point Source model for y
        -- filter.</descr>
    yFlux_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Point Source model for y
        -- filter.</descr>
    yRa_decl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ya and decl for Point Source model for y
        -- filter.</descr>
    yFlux_ra_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and ra for Small Galaxy model for y
        -- filter.</descr>
    yFlux_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and decl for Small Galaxy model for y
        -- filter.</descr>
    yFlux_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and SersicN for Small Galaxy model for y
        -- filter.</descr>
    yFlux_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e1 for Small Galaxy model for y
        -- filter.</descr>
    yFlux_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and e2 for Small Galaxy model for y
        -- filter.</descr>
    yFlux_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of flux and radius for Small Galaxy model for y
        -- filter.</descr>
    yRa_decl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ya and decl for Small Galaxy model for y
        -- filter.</descr>
    yRa_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ya and SersicN for Small Galaxy for y
        -- filter.</descr>
    yRa_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ya and e1 for Small Galaxy model for y
        -- filter.</descr>
    yRa_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ya and e2 for Small Galaxy model for y
        -- filter.</descr>
    yRa_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ya and radius for small galaxy model for y
        -- filter.</descr>
    yDecl_SersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and SersicN for Small Galaxy for y
        -- filter.</descr>
    yDecl_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e1 for Small Galaxy for y filter.
        -- </descr>
    yDecl_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and e2 for Small Galaxy for y filter.
        -- </descr>
    yDecl_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of decl and radius for Small Galaxy for y
        -- filter.</descr>
    ySersicN_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e1 for Small Galaxy Model for y
        -- filter.</descr>
    ySersicN_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and e2 for Small Galaxy for y
        -- filter.</descr>
    ySersicN_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of SersicN and radius for Small Galaxy for y
        -- filter.</descr>
    yE1_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and e2 for Small Galaxy for y filter.
        -- </descr>
    yE1_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e1 and radius for Small Galaxy for y
        -- filter.</descr>
    yE2_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of e2 and radius for Small Galaxy for y
        -- filter.</descr>
    _chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    _subChunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (objectId)
) ENGINE=MyISAM;


CREATE TABLE Source
    -- <descr>Table to store high signal-to-noise &quot;sources&quot;. A source
    -- is a measurement of Object's properties from a single image that contains
    -- its footprint on the sky.</descr>
(
    sourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    ccdExposureId BIGINT NULL,
        -- <descr>Pointer to the CcdExpsoure where this source was measured.
        -- Note that we are allowing a source to belong to multiple
        -- AmpExposures, but it may not span multiple CcdExposures.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>Pointer to an entry in Filter table: filter used to take
        -- Exposure where this Source was measured.</descr>
        -- <ucd>meta.id;inst.filter</ucd>
    objectId BIGINT NULL,
        -- <descr>Pointer to Object table. Might be NULL (each Source will 
        -- point to either MovingObject or Object)</descr>
        -- <ucd>meta.id;src</ucd>
    movingObjectId BIGINT NULL,
        -- <descr>Pointer to MovingObject table. Might be NULL (each Source will
        -- point to either MovingObject or Object)</descr>
        -- <ucd>meta.id;src</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>RA-coordinate of the center of the source.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    raSigmaForDetection FLOAT NULL,
        -- <descr>Component of ra uncertainty due to detection uncertainty
        -- (xAstromSigma, yAstromSigma).</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    raSigmaForWcs FLOAT NOT NULL,
        -- <descr>Component of ra uncertainty due to
        -- uncertainty in WCS solution.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the source.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    declSigmaForDetection FLOAT NULL,
        -- <descr>Component of decl uncertainty due to detection uncertainty
        -- (xAstromSigma, yAstromSigma).</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    declSigmaForWcs FLOAT NOT NULL,
        -- <descr>Component of decl uncertainty due to
        -- uncertainty in WCS solution.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    xAstrom FLOAT(0) NOT NULL,
        -- <descr>x position computed by a centroiding algorithm for the
        -- purposes of astrometry using Dave Monet's algorithm.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    xAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of xAstrom.</descr>
        -- <ucd>stat.error;pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    yAstrom FLOAT(0) NOT NULL,
        -- <descr>y position computed by a centroiding algorithm for the
        -- purposes of astrometry using Dave Monet's algorithm.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    yAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of yAstrom.</descr>
        -- <ucd>stat.error;pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    xyAstromCov FLOAT(0) NOT NULL,
        -- <descr>Covariance between the xAstrom and the yAstrom.</descr>
        -- <ucd>pos.cartesian</ucd>
        -- <unit>pixel^2</unit>
    astromRefrRa FLOAT(0) NULL,
        -- <descr>Astrometric refraction in ra.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    astromRefrRaSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of astromRefrRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    astromRefrDecl FLOAT(0) NULL,
        -- <descr>Astrometric refraction in decl.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    astromRefrDeclSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of astromRefrDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    snr FLOAT(0) NOT NULL,
        -- <descr>Signal to noise ratio.</descr>
    chi2 FLOAT(0) NOT NULL,
    sky FLOAT(0) NOT NULL,
        -- <descr>Sky background.</descr>
    skySigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of sky.</descr>
    psfLnL FLOAT(0) NULL,
        -- <descr>ln(likelihood) of being a PSF.</descr>
    lnL_SG FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Small Galaxy.</descr>
    taiMidPoint DOUBLE NOT NULL,
        -- <descr>Middle of exposure time (TAI).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    taiRange FLOAT NULL,
        -- <descr>Exposure time.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    xFlux DOUBLE NULL,
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    xFluxSigma FLOAT(0) NULL,
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    yFlux DOUBLE NULL,
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    yFluxSigma FLOAT(0) NULL,
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    xPeak DOUBLE NULL,
    yPeak DOUBLE NULL,
    raPeak DOUBLE NULL,
    declPeak DOUBLE NULL,
    flux_PS FLOAT(0) NULL,
        -- <descr>Calibrated flux for Point Source model.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    flux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of flux_PS.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    flux_SG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Small Galaxy model.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    flux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of flux_SG.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    flux_CSG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Cannonical Small Galaxy model.
        -- </descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    flux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainly of flux_CSG.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    psfFlux DOUBLE NULL,
        -- <descr>Uncalibrated PSF flux of source.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    psfFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of source.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    apFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    petroFlux DOUBLE NULL,
        -- <descr>Petrosian flux.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    petroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of petroFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Instrumental flux.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    instFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of instFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    nonGrayCorrFlux DOUBLE NULL,
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    nonGrayCorrFluxSigma FLOAT(0) NULL,
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    atmCorrFlux DOUBLE NULL,
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    atmCorrFluxSigma FLOAT(0) NULL,
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    apDia FLOAT(0) NULL,
    extendedness FLOAT(0) NULL,
        -- <descr>Probability that this source is an extended source. Valid
        -- range: 0-1, where 1 indicates an extended source with 100%
        -- probability.</descr>
    galExtinction FLOAT(0) NULL,
        -- <descr>Galactic extinction.</descr>
    sersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model.</descr>
    sersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of sersicN_SG.</descr>
    e1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    e1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of e1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    e2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    e2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of e2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    radius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model.</descr>
        -- <ucd>phys.angSize</ucd>
    radius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of radius_SG.</descr>
        -- <ucd>stat.error;phys.angSize</ucd>
    midPoint FLOAT(0) NOT NULL,
        -- <descr>Corrected midPoint of the exposure (tai).</descr>
    apCorrection FLOAT(0) NOT NULL,
        -- <descr>Photometric correction: aperture correction.</descr>
    grayExtinction FLOAT(0) NOT NULL,
        -- <descr>Photometric correction: gray extinction.</descr>
    nonGrayExtinction FLOAT(0) NOT NULL,
        -- <descr>Photometric correction: non gray extinction.</descr>
    momentIx FLOAT(0) NULL,
        -- <descr>Adaptive first moment. The moments are primarily for the
        -- moving objects, but should carry some information about defects,
        -- cosmics, etc. too.</descr>
    momentIxSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIx.</descr>
    momentIy FLOAT(0) NULL,
        -- <descr>Adaptive first moment.</descr>
    momentIySigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIy.</descr>
    momentIxx FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    momentIxxSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIxx.</descr>
    momentIyy FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    momentIyySigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIyy.</descr>
    momentIxy FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    momentIxySigma FLOAT(0) NULL,
        -- <descr>Uncertainty of momentIxy.</descr>
    flux_flux_SG_Cov FLOAT NULL,
        -- <descr>Covariance of flux and flux for Small
        -- Galaxy model.</descr>
    flux_e1_SG_Cov FLOAT NULL,
        -- <descr>Covariance of flux and e1 for Small Galaxy
        -- model.</descr>
    flux_e2_SG_Cov FLOAT NULL,
        -- <descr>Covariance of flux and e2 for Small Galaxy
        -- model.</descr>
    flux_radius_SG_Cov FLOAT NULL,
        -- <descr>Covariance of flux and radius for Small
        -- Galaxy model.</descr>
    flux_sersicN_SG_Cov FLOAT NULL,
        -- <descr>Covariance of flux and sersicN for Small
        -- Galaxy model.</descr>
    e1_e1_SG_Cov FLOAT NULL,
        -- <descr>Covariance of e1 and e1 for Small Galaxy
        -- model.</descr>
    e1_e2_SG_Cov FLOAT NULL,
        -- <descr>Covariance of e1 and e2 for Small Galaxy
        -- model.</descr>
    e1_radius_SG_Cov FLOAT NULL,
        -- <descr>Covariance of e1 and radius for Small
        -- Galaxy model.</descr>
    e1_sersicN_SG_Cov FLOAT NULL,
        -- <descr>Covariance of e1 and sersicN for Small
        -- Galaxy model.</descr>
    e2_e2_SG_Cov FLOAT NULL,
        -- <descr>Covariance of e2 and e2 for Small Galaxy
        -- model.</descr>
    e2_radius_SG_Cov FLOAT NULL,
        -- <descr>Covariance of e2 and radius for Small
        -- Galaxy model.</descr>
    e2_sersicN_SG_Cov FLOAT NULL,
        -- <descr>Covariance of e2 and sersicN for Small
        -- Galaxy model.</descr>
    radius_radius_SG_Cov FLOAT NULL,
        -- <descr>Covariance of radius and radius for Small
        -- Galaxy model.</descr>
    radius_sersicN_SG_Cov FLOAT NULL,
        -- <descr>Covariance of radius and sersicN for Small
        -- Galaxy model.</descr>
    sersicN_sersicN_SG_Cov FLOAT NULL,
        -- <descr>Covariance for sersicN and sersicN for
        -- Small Galaxy model.</descr>
    flagsForAssociation INT NULL DEFAULT 0,
        -- <descr>Flags related to association.</descr>
        -- <ucd>meta.code</ucd>
    flagsForDetection INT NULL DEFAULT 0,
        -- <descr>Flags related to detection.</descr>
        -- <ucd>meta.code</ucd>
    flagsForWcs INT NULL DEFAULT 0,
        -- <descr>Flags related to WCS.</descr>
        -- <ucd>meta.code</ucd>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
        -- <ucd>pos.HTM</ucd>
    _chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (sourceId),
    INDEX (objectId),
    INDEX (ccdExposureId),
    INDEX (filterId),
    INDEX (movingObjectId),
    INDEX IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;



SET FOREIGN_KEY_CHECKS=1;


ALTER TABLE prv_cnf_PolicyKey ADD CONSTRAINT FK_prv_cnf_PolicyKey_prv_PolicyKey
    FOREIGN KEY (policyKeyId) REFERENCES prv_PolicyKey (policyKeyId);

ALTER TABLE prv_cnf_SoftwarePackage ADD CONSTRAINT FK_prv_cnf_SoftwarePackage_prv_SoftwarePackage
    FOREIGN KEY (packageId) REFERENCES prv_SoftwarePackage (packageId);

ALTER TABLE prv_PolicyKey ADD CONSTRAINT FK_prv_PolicyKey_prv_PolicyFile
    FOREIGN KEY (policyFileId) REFERENCES prv_PolicyFile (policyFileId);

ALTER TABLE RefObjMatch ADD CONSTRAINT FK_RefObjMatch_Object
    FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE RefObjMatch ADD CONSTRAINT FK_RefObjMatch_SimRefObject
    FOREIGN KEY (refObjectId) REFERENCES SimRefObject (refObjectId);

ALTER TABLE _mops_EonQueue ADD CONSTRAINT FK__mopsEonQueue_MovingObject
    FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE _mops_MoidQueue ADD CONSTRAINT FK__mops_MoidQueue_MovingObject
    FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE mops_SSM ADD CONSTRAINT FK_mopsSSM_mopsSSMDesc
    FOREIGN KEY (ssmDescId) REFERENCES mops_SSMDesc (ssmDescId);

ALTER TABLE mops_Tracklet ADD CONSTRAINT FK_mopsTracklets_mopsSSM
    FOREIGN KEY (ssmId) REFERENCES mops_SSM (ssmId);

