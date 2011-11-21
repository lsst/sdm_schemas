
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
    r VARCHAR(255)
        -- <descr>Captures information from svn about the schema file
        -- including the file name, the revision, date and author.</descr>
) ;
INSERT INTO ZZZ_Db_Description(r) VALUES('$Id$');


CREATE TABLE prv_Activity
(
    activityId BIGINT NOT NULL,
        -- <descr>Unique id derived from prv_Run.offset.</descr>
    offset MEDIUMINT NOT NULL,
        -- <descr>Corresponding prv_Run offset.</descr>
    name VARCHAR(64) NOT NULL,
        -- <descr>A name for the activity.</descr>
    type VARCHAR(64) NOT NULL,
        -- <descr>A name indicating type of activity, e.g. &quot;launch&quot;,
        -- &quot;workflow&quot;.</descr>
    platform VARCHAR(64) NOT NULL,
        -- <descr>Name of the platform where the activity occurred (does not
        -- need to a be a DNS name).</descr>
    PRIMARY KEY (activityId, offset)
) TYPE=MyISAM;


CREATE TABLE prv_cnf_PolicyKey
(
    policyKeyId BIGINT NOT NULL,
    value TEXT NULL,
    validityBegin DATETIME NULL,
    validityEnd DATETIME NULL,
    PRIMARY KEY (policyKeyId)
) TYPE=MyISAM;


CREATE TABLE prv_cnf_SoftwarePackage
(
    packageId INTEGER NOT NULL,
    version VARCHAR(255) NOT NULL,
    directory VARCHAR(255) NOT NULL,
    validityBegin DATETIME NULL,
    validityEnd DATETIME NULL,
    PRIMARY KEY (packageId)
) TYPE=MyISAM;


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
) TYPE=MyISAM;


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
) TYPE=MyISAM;


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
    INDEX (policyFileId)
) TYPE=MyISAM;


CREATE TABLE prv_Run
(
    offset MEDIUMINT NOT NULL AUTO_INCREMENT,
    runId VARCHAR(255) NOT NULL,
    PRIMARY KEY (offset),
    UNIQUE UQ_prv_Run_runId(runId)
) TYPE=MyISAM;


CREATE TABLE prv_SoftwarePackage
(
    packageId INTEGER NOT NULL,
    packageName VARCHAR(64) NOT NULL,
    PRIMARY KEY (packageId)
) TYPE=MyISAM;


CREATE TABLE _MovingObjectToType
    -- <descr>Mapping: moving object --&amp;gt; types, with probabilities
    -- </descr>
(
    movingObjectId BIGINT NOT NULL,
        -- <descr>Pointer to entry in MovingObject table</descr>
    typeId SMALLINT NOT NULL,
        -- <descr>Pointer to entry in ObjectType table</descr>
    probability TINYINT NULL DEFAULT 100,
        -- <descr>Probability that given MovingObject is of given type. Range:
        -- 0-100 (in%)</descr>
    INDEX (typeId),
    INDEX (movingObjectId)
) TYPE=MyISAM;


CREATE TABLE _ObjectToType
    -- <descr>Mapping Object --&amp;gt; types, with probabilities</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Pointer to an entry in Object table</descr>
    typeId SMALLINT NOT NULL,
        -- <descr>Pointer to an entry in ObjectType table</descr>
    probability TINYINT NULL DEFAULT 100,
        -- <descr>Probability that given object is of given type. Range 0-100 %
        -- </descr>
    INDEX (typeId),
    INDEX (objectId)
) TYPE=MyISAM;


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
) TYPE=MyISAM;


CREATE TABLE _qservObjectIdMap
    -- <descr>Internal table used by qserv. Keeps mapping: objectId --&amp;gt;
    -- chunkId+subChunkId.</descr>
(
    objectId BIGINT NOT NULL,
    chunkId INTEGER NOT NULL,
    subChunkId INTEGER NOT NULL
) TYPE=MyISAM;


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
) TYPE=MyISAM;


CREATE TABLE _tmpl_ap_DiaSourceToNewObject
(
    first BIGINT NOT NULL,
    second BIGINT NOT NULL,
    visitId INTEGER NOT NULL,
    INDEX idx_visitId (visitId ASC)
) TYPE=MyISAM;


CREATE TABLE _tmpl_ap_DiaSourceToObjectMatches
(
    first BIGINT NOT NULL,
    second BIGINT NOT NULL,
    distance DOUBLE NOT NULL,
    visitId INTEGER NOT NULL,
    INDEX idx_visitId (visitId ASC)
) TYPE=MyISAM;


CREATE TABLE _tmpl_ap_PredToDiaSourceMatches
(
    first BIGINT NOT NULL,
    second BIGINT NOT NULL,
    distance DOUBLE NOT NULL,
    visitId INTEGER NOT NULL,
    INDEX idx_visitId (visitId ASC)
) TYPE=MyISAM;


CREATE TABLE _tmpl_Id
    -- <descr>Template table. Schema for lists of ids (e.g. for Objects to
    -- delete)</descr>
(
    id BIGINT NOT NULL
) TYPE=MyISAM;


CREATE TABLE _tmpl_IdPair
    -- <descr>Template table. Schema for list of id pairs.</descr>
(
    first BIGINT NOT NULL,
    second BIGINT NOT NULL
) TYPE=MyISAM;


CREATE TABLE _tmpl_MatchPair
    -- <descr>Template table. Schema for per-visit match result tables.</descr>
(
    first BIGINT NOT NULL,
    second BIGINT NOT NULL,
    distance DOUBLE NOT NULL
) TYPE=MyISAM;


CREATE TABLE AmpMap
    -- <descr>Mapping table to translate amp names to numbers.</descr>
(
    ampNum TINYINT NOT NULL,
    ampName CHAR(3) NOT NULL,
    PRIMARY KEY (ampNum),
    UNIQUE UQ_AmpMap_ampName(ampName)
) ;


CREATE TABLE Ccd_Detector
(
    ccdDetectorId INTEGER NOT NULL DEFAULT 1,
        -- <descr>from file name (required for raw science images)</descr>
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
) TYPE=MyISAM;


CREATE TABLE CcdMap
    -- <descr>Mapping table to translate ccd names to numbers.</descr>
(
    ccdNum TINYINT NOT NULL,
    ccdName CHAR(3) NOT NULL,
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
) TYPE=MyISAM;


CREATE TABLE Filter
(
    filterId TINYINT NOT NULL,
    filterName CHAR(255) NOT NULL,
        -- <descr>Filter name. Valid values: 'u', 'g', 'r', 'i', 'z', 'y'
        -- </descr>
    photClam FLOAT(0) NOT NULL,
        -- <descr>Filter centroid wavelength</descr>
    photBW FLOAT(0) NOT NULL,
        -- <descr>System effective bandwidth</descr>
    PRIMARY KEY (filterId)
) TYPE=MyISAM;


CREATE TABLE LeapSeconds
(
    whenJd FLOAT(0) NOT NULL,
    offset FLOAT(0) NOT NULL,
    mjdRef FLOAT(0) NOT NULL,
    drift FLOAT(0) NOT NULL,
    whenMjdUtc FLOAT(0) NULL,
    whenUtc BIGINT NULL,
    whenTai BIGINT NULL
) TYPE=MyISAM;


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
    COMMENT TEXT NULL,
    PIPELINE VARCHAR(80) NULL,
    TYPE VARCHAR(5) NULL,
    EVENTTIME BIGINT NULL,
    PUBTIME BIGINT NULL,
    usertime FLOAT(0) NULL,
    systemtime FLOAT(0) NULL,
    PRIMARY KEY (id),
    INDEX a (RUNID ASC)
) TYPE=MyISAM;


CREATE TABLE ObjectType
    -- <descr>Table to store description of object types. It includes all object
    -- types: static, variables, Solar System objects, etc.</descr>
(
    typeId SMALLINT NOT NULL,
        -- <descr>Unique id.</descr>
    description VARCHAR(255) NULL,
    PRIMARY KEY (typeId)
) TYPE=MyISAM;


CREATE TABLE RaftMap
    -- <descr>Mapping table to translate raft names to numbers.</descr>
(
    raftNum TINYINT NOT NULL,
    raftName CHAR(3) NOT NULL,
    PRIMARY KEY (raftNum),
    UNIQUE UQ_RaftMap_raftName(raftName)
) ;


CREATE TABLE RefObjMatch
(
    refObjectId BIGINT NULL,
        -- <descr>Reference object id (pointer to SimRefObject). NULL if object
        -- has no matches.</descr>
    objectId BIGINT NULL,
        -- <descr>Object id. NULL if object has no matches.</descr>
    refRa DOUBLE NULL,
        -- <descr>ICRS reference object RA at mean epoch of object.</descr>
    refDec DOUBLE NULL,
        -- <descr>ICRS reference object Dec at mean epoch of object.</descr>
    angSep DOUBLE NULL,
        -- <descr>Angular separation between reference object and object.
        -- </descr>
    nRefMatches INTEGER NULL,
        -- <descr>Total number of matches for reference object.</descr>
    nObjMatches INTEGER NULL,
        -- <descr>Total number of matches for object.</descr>
    closestToRef TINYINT NULL,
        -- <descr>Is object the closest match for reference object?</descr>
    closestToObj TINYINT NULL,
        -- <descr>Is reference object the closest match for object?</descr>
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
    INDEX (objectId),
    INDEX (refObjectId)
) TYPE=MyISAM;


CREATE TABLE SimRefObject
(
    refObjectId BIGINT NOT NULL,
        -- <descr>Reference object id.</descr>
    isStar TINYINT NOT NULL,
        -- <descr>1 for star, 0 for galaxy.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA. ICRS.</descr>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl. ICRS.</descr>
        -- <unit>deg</unit>
    gLat DOUBLE NULL,
        -- <descr>Galactic latitude, NULL for galaxies.</descr>
        -- <unit>deg</unit>
    gLon DOUBLE NULL,
        -- <descr>Galactic longitude. Null for galaxies.</descr>
        -- <unit>deg</unit>
    sedName CHAR(32) NULL,
        -- <descr>Best-fit SED name. Null for galaxies.</descr>
    uMag DOUBLE NOT NULL,
        -- <descr>u band AB magnitude.</descr>
    gMag DOUBLE NOT NULL,
        -- <descr>g band AB magnitude.</descr>
    rMag DOUBLE NOT NULL,
        -- <descr>r band AB magnitude.</descr>
    iMag DOUBLE NOT NULL,
        -- <descr>i band AB magnitude.</descr>
    zMag DOUBLE NOT NULL,
        -- <descr>z band AB magnitude.</descr>
    yMag DOUBLE NOT NULL,
        -- <descr>y band AB magnitude.</descr>
    muRa DOUBLE NULL,
        -- <descr>dRA/dt*cos(decl). NULL for galaxies.</descr>
        -- <unit>milliarcsec/year</unit>
    muDecl DOUBLE NULL,
        -- <descr>dDec/dt. NULL for galaxies.</descr>
        -- <unit>milliarcsec/year</unit>
    parallax DOUBLE NULL,
        -- <descr>Parallal. NULL for galaxies.</descr>
        -- <unit>milliarcsec</unit>
    vRad DOUBLE NULL,
        -- <descr>Radial velocity. NULL for galaxies.</descr>
        -- <unit>km/sec</unit>
    isVar TINYINT NOT NULL,
        -- <descr>1 for variable stars, 0 for galaxies and non-variable stars.
        -- </descr>
    redshift DOUBLE NULL,
        -- <descr>Redshift. NULL for stars.</descr>
    uCov INTEGER NOT NULL,
        -- <descr>Number of u-band science CCDs containing reference object.
        -- </descr>
    gCov INTEGER NOT NULL,
        -- <descr>Number of g-band science CCDs containing reference object.
        -- </descr>
    rCov INTEGER NOT NULL,
        -- <descr>Number of r-band science CCDs containing reference object.
        -- </descr>
    iCov INTEGER NOT NULL,
        -- <descr>Number of i-band science CCDs containing reference object.
        -- </descr>
    zCov INTEGER NOT NULL,
        -- <descr>Number of z-band science CCDs containing reference object.
        -- </descr>
    yCov INTEGER NOT NULL,
        -- <descr>Number of y-band science CCDs containing reference object.
        -- </descr>
    PRIMARY KEY (refObjectId),
    INDEX IDX_decl (decl ASC)
) TYPE=MyISAM;


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
) TYPE=MyISAM;


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
) TYPE=MyISAM;


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
    metricValue DOUBLE NOT NULL,
        -- <descr>Value of this SDQA metric.</descr>
    metricSigma DOUBLE NOT NULL,
        -- <descr>Uncertainty of the value of this metric.</descr>
    PRIMARY KEY (sdqa_ratingId),
    UNIQUE UQ_sdqaRating_ForScienceAmpExposure_metricId_ampExposureId(sdqa_metricId, ampExposureId),
    INDEX (sdqa_metricId),
    INDEX (sdqa_thresholdId),
    INDEX (ampExposureId)
) TYPE=MyISAM;


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
    metricValue DOUBLE NOT NULL,
        -- <descr>Value of this SDQA metric.</descr>
    metricSigma DOUBLE NOT NULL,
        -- <descr>Uncertainty of the value of this metric.</descr>
    PRIMARY KEY (sdqa_ratingId),
    UNIQUE UQ_sdqa_Rating_ForScienceCCDExposure_metricId_ccdExposureId(sdqa_metricId, ccdExposureId),
    INDEX (sdqa_metricId),
    INDEX (sdqa_thresholdId),
    INDEX (ccdExposureId)
) TYPE=MyISAM;


CREATE TABLE sdqa_Rating_ForSnapCcdExposure
(
    sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
    sdqa_metricId SMALLINT NOT NULL,
    sdqa_thresholdId SMALLINT NOT NULL,
    ccdExposureId BIGINT NOT NULL,
    metricValue DOUBLE NOT NULL,
    metricSigma DOUBLE NOT NULL,
    PRIMARY KEY (sdqa_ratingId),
    INDEX UQ_sdqa_Rating_ForScienceCCDExposure_metricId_ccdExposureId (sdqa_metricId ASC, ccdExposureId ASC),
    INDEX sdqa_metricId (sdqa_metricId ASC),
    INDEX sdqa_thresholdId (sdqa_thresholdId ASC),
    INDEX ccdExposureId (ccdExposureId ASC)
) TYPE=MyISAM;


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
) TYPE=MyISAM;


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
    movingObjectVersion INTEGER NOT NULL,
    ra DOUBLE NOT NULL,
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <unit>degree</unit>
    mjd DOUBLE NOT NULL,
    smia DOUBLE NULL,
    smaa DOUBLE NULL,
    pa DOUBLE NULL,
    mag DOUBLE NULL,
    INDEX idx_mopsEphemeris_movingObjectId (movingObjectId ASC)
) TYPE=MyISAM;


CREATE TABLE _tmpl_mops_Prediction
(
    movingObjectId BIGINT NOT NULL,
    movingObjectVersion INTEGER NOT NULL,
    ra DOUBLE NOT NULL,
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <unit>degree</unit>
    mjd DOUBLE NOT NULL,
    smia DOUBLE NOT NULL,
    smaa DOUBLE NOT NULL,
    pa DOUBLE NOT NULL,
    mag DOUBLE NOT NULL,
    magErr FLOAT(0) NOT NULL
) TYPE=MyISAM;


CREATE TABLE mops_Event
(
    eventId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Auto-generated internal event ID</descr>
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
    ssmDescId SMALLINT NULL,
        -- <descr>Pointer to SSM description</descr>
    q DOUBLE NOT NULL,
        -- <descr>semi-major axis, AU</descr>
    e DOUBLE NOT NULL,
        -- <descr>eccentricity e (dimensionless)</descr>
    i DOUBLE NOT NULL,
        -- <descr>inclination, deg</descr>
        -- <unit>degree</unit>
    node DOUBLE NOT NULL,
        -- <descr>longitude of ascending node, deg</descr>
        -- <unit>degree</unit>
    argPeri DOUBLE NOT NULL,
        -- <descr>argument of perihelion, deg</descr>
        -- <unit>degree</unit>
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
    prefix CHAR(4) NULL,
        -- <descr>MOPS prefix code S0/S1/etc.</descr>
    description VARCHAR(100) NULL,
        -- <descr>Long description</descr>
    PRIMARY KEY (ssmDescId)
) ;


CREATE TABLE mops_Tracklet
(
    trackletId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Auto-generated internal MOPS tracklet ID</descr>
    ccdExposureId BIGINT NOT NULL,
        -- <descr>Terminating field ID - pointer to Science_Ccd_Exposure.
        -- </descr>
    procHistoryId INT NOT NULL,
        -- <descr>Pointer to processing history (prv_ProcHistory)</descr>
    ssmId BIGINT NULL,
        -- <descr>Matching SSM ID for clean classifications</descr>
    velRa DOUBLE NULL,
        -- <descr>Average RA velocity deg/day, cos(dec) applied</descr>
        -- <unit>degree/day</unit>
    velRaErr DOUBLE NULL,
        -- <descr>Uncertainty in RA velocity</descr>
        -- <unit>degree/day</unit>
    velDecl DOUBLE NULL,
        -- <descr>Average Dec velocity, deg/day)</descr>
        -- <unit>degree/day</unit>
    velDeclErr DOUBLE NULL,
        -- <descr>Uncertainty in Dec velocity</descr>
        -- <unit>degree/day</unit>
    velTot DOUBLE NULL,
        -- <descr>Average total velocity, deg/day</descr>
        -- <unit>degree/day</unit>
    accRa DOUBLE NULL,
        -- <descr>Average RA Acceleration, deg/day^2</descr>
        -- <unit>degree/day^2</unit>
    accRaErr DOUBLE NULL,
        -- <descr>Uncertainty in RA acceleration</descr>
        -- <unit>degree/day^2</unit>
    accDecl DOUBLE NULL,
        -- <descr>Average Dec Acceleration, deg/day^2</descr>
        -- <unit>degree/day^2</unit>
    accDeclErr DOUBLE NULL,
        -- <descr>Uncertainty in Dec acceleration</descr>
        -- <unit>degree/day^2</unit>
    extEpoch DOUBLE NULL,
        -- <descr>Extrapolated (central) epoch, MJD (UTC)</descr>
    extRa DOUBLE NULL,
        -- <descr>Extrapolated (central) RA, deg</descr>
        -- <unit>degree</unit>
    extRaErr DOUBLE NULL,
        -- <descr>Uncertainty in extrapolated RA, deg</descr>
        -- <unit>degree</unit>
    extDecl DOUBLE NULL,
        -- <descr>Extrapolated (central) Dec, deg</descr>
        -- <unit>degree</unit>
    extDeclErr DOUBLE NULL,
        -- <descr>Uncertainty in extrapolated Dec, deg</descr>
        -- <unit>degree</unit>
    extMag DOUBLE NULL,
        -- <descr>Extrapolated (central) magnitude</descr>
    extMagErr DOUBLE NULL,
        -- <descr>Uncertainty in extrapolated mag, deg</descr>
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
    diaSourceId BIGINT NOT NULL,
    PRIMARY KEY (trackletId, diaSourceId),
    INDEX idx_mopsTrackletsToDIASource_diaSourceId (diaSourceId ASC),
    INDEX (trackletId)
) ;


CREATE TABLE mops_TrackToTracklet
(
    trackId BIGINT NOT NULL,
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
    ccdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to entry in Raw_Ccd_Exposure table.</descr>
    INDEX (ccdExposureId),
    INDEX (visitId)
) TYPE=MyISAM;


CREATE TABLE FpaMetadata
    -- <descr>Focal-plane-related generic key-value pair metadata./descr>
(
    ccdExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding Raw or Science Ccd_Exposure.
        -- </descr>
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits tbd...</descr>
    metadataKey VARCHAR(255) NOT NULL,
    metadataValue VARCHAR(255) NULL,
    PRIMARY KEY (ccdExposureId)
) TYPE=MyISAM;


CREATE TABLE RaftMetadata
(
    raftId BIGINT NOT NULL,
        -- <descr>tbd</descr>
    metadataKey VARCHAR(255) NOT NULL,
    metadataValue VARCHAR(255) NULL,
    PRIMARY KEY (raftId)
) TYPE=MyISAM;


CREATE TABLE Raw_Amp_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
    rawCcdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to Raw_Amp_Exposure containing this science amp
        -- exposure.</descr>
    visitId INTEGER NOT NULL,
        -- <descr>Visit id this exposure belongs to.</descr>

    snap TINYINT NOT NULL,
    raft TINYINT NOT NULL,
    ccd TINYINT NOT NULL,
    amp TINYINT NOT NULL,
    filterId TINYINT NOT NULL,
    ra DOUBLE NOT NULL,
    decl DOUBLE NOT NULL,
    equinox FLOAT(0) NOT NULL,
    raDeSys VARCHAR(20) NOT NULL,
    ctype1 VARCHAR(20) NOT NULL,
    ctype2 VARCHAR(20) NOT NULL,
    crpix1 FLOAT(0) NOT NULL,
    crpix2 FLOAT(0) NOT NULL,
    crval1 DOUBLE NOT NULL,
    crval2 DOUBLE NOT NULL,
    cd1_1 DOUBLE NOT NULL,
    cd1_2 DOUBLE NOT NULL,
    cd2_1 DOUBLE NOT NULL,
    cd2_2 DOUBLE NOT NULL,
    llcRa DOUBLE NOT NULL,
    llcDecl DOUBLE NOT NULL,
    ulcRa DOUBLE NOT NULL,
    ulcDecl DOUBLE NOT NULL,
    urcRa DOUBLE NOT NULL,
    urcDecl DOUBLE NOT NULL,
    lrcRa DOUBLE NOT NULL,
    lrcDecl DOUBLE NOT NULL,
    taiMjd DOUBLE NOT NULL,
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expMidpt VARCHAR(30) NOT NULL,
    expTime FLOAT(0) NOT NULL,
    airmass FLOAT(0) NOT NULL,
    darkTime FLOAT(0) NOT NULL,
    zd FLOAT(0) NULL,
    flags INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (rawAmpExposureId)
) TYPE=MyISAM;


CREATE TABLE Raw_Amp_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Raw_Amp_Exposure.</descr>
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding Raw_Amp_Exposure.</descr>
    metadataKey VARCHAR(255) NOT NULL,
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits: 0x1 - rawAmp, 0x2 - postIsrAmp, more
        -- tbd.</descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (rawAmpExposureId, metadataKey),
    INDEX IDX_metadataKey (metadataKey ASC)
) TYPE=MyISAM;


CREATE TABLE Raw_Amp_To_Science_Ccd_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
    scienceCcdExposureId BIGINT NOT NULL,
    snap TINYINT NOT NULL,
    amp TINYINT NOT NULL,
    PRIMARY KEY (rawAmpExposureId),
    INDEX scienceCcdExposureId (scienceCcdExposureId ASC)
) TYPE=MyISAM;


CREATE TABLE Raw_Amp_To_Snap_Ccd_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
    amp TINYINT NOT NULL,
    snapCcdExposureId BIGINT NOT NULL,
    PRIMARY KEY (rawAmpExposureId),
    INDEX snapCcdExposureId (snapCcdExposureId ASC)
) TYPE=MyISAM;


CREATE TABLE Raw_Ccd_Exposure
(
    rawCcdExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
    ra DOUBLE NOT NULL,
        -- <descr>Right Ascension of aperture center.</descr>
    decl DOUBLE NOT NULL,
        -- <descr>Declination of aperture center.</descr>
    filterId INTEGER NOT NULL,
    equinox FLOAT(0) NOT NULL,
        -- <descr>Equinox of World Coordinate System.</descr>
    radecSys VARCHAR(20) NULL,
        -- <descr>Coordinate system type. (Allowed systems: FK5, ICRS)</descr>
    dateObs TIMESTAMP NOT NULL DEFAULT 0,
        -- <descr>Date/Time of observation start (UTC).</descr>
    url VARCHAR(255) NOT NULL,
        -- <descr>Logical URL to the actual raw image.</descr>
    ctype1 VARCHAR(20) NOT NULL,
        -- <descr>Coordinate projection type, axis 1.</descr>
    ctype2 VARCHAR(20) NOT NULL,
        -- <descr>Coordinate projection type, axis 2.</descr>
    mjdObs DOUBLE NULL,
        -- <descr>MJD of observation start.</descr>
    airmass FLOAT(0) NULL,
        -- <descr>Airmass value for the Amp reference pixel (preferably center,
        -- but not guaranteed). Range: [-99.999, 99.999] is enough to accomodate
        -- ZD in [0, 89.433].</descr>
    crpix1 FLOAT(0) NOT NULL,
        -- <descr>Coordinate reference pixel, axis 1.</descr>
    crpix2 FLOAT(0) NOT NULL,
        -- <descr>Coordinate reference pixel, axis 2.</descr>
    crval1 DOUBLE NOT NULL,
        -- <descr>Coordinate value 1 @reference pixel.</descr>
    crval2 DOUBLE NOT NULL,
        -- <descr>Coordinate value 2 @reference pixel.</descr>
    cd11 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 1.</descr>
    cd21 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 1.</descr>
    darkTime FLOAT(0) NULL,
        -- <descr>Total elapsed time from exposure start to end of read.</descr>
    cd12 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 2.</descr>
    zd FLOAT(0) NULL,
        -- <descr>Zenith distance at observation mid-point.</descr>
    cd22 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 2.</descr>
    taiObs TIMESTAMP NOT NULL DEFAULT 0,
        -- <descr>TAI-OBS = UTC + offset, offset = 32 s from 1/1/1999 to
        -- 1/1/2006</descr>
    expTime FLOAT(0) NOT NULL,
        -- <descr>Duration of exposure.</descr>
    PRIMARY KEY (rawCcdExposureId)
) TYPE=MyISAM;


CREATE TABLE Raw_Ccd_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Raw_Ccd_Exposure.</descr>
(
    rawCcdExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding Raw_Ccd_Exposure.</descr>
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits: 0x1 - rawCcd, 0x2 - postIsrCcd, more
        -- tbd.</descr>
    metadataKey VARCHAR(255) NOT NULL,
    metadataValue VARCHAR(255) NULL,
    PRIMARY KEY (rawCcdExposureId)
) TYPE=MyISAM;


CREATE TABLE Science_Amp_Exposure
(
    scienceAmpExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to Science_Ccd_Exposure containing this science amp
        -- exposure.</descr>
    rawAmpExposureId BIGINT NULL,
    ampId INTEGER NULL,
        -- <descr>Pointer to the amplifier corresponding to this amp exposure.
        -- </descr>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
    PRIMARY KEY (scienceAmpExposureId),
    INDEX (scienceCcdExposureId),
    INDEX (rawAmpExposureId)
) TYPE=MyISAM;


CREATE TABLE Science_Amp_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Science_Amp_Exposure.</descr>
(
    scienceAmpExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding Science_Amp_Exposure.</descr>
    metadataKey VARCHAR(255) NOT NULL,
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits: 0x1 - scienceAmp, 0x2 - diffAmp, more
        -- tbd.</descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (scienceAmpExposureId, metadataKey),
    INDEX IDX_metadataKey (metadataKey ASC)
) TYPE=MyISAM;


CREATE TABLE Science_Ccd_Exposure
(
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
    visit INTEGER NOT NULL,
    raft TINYINT NOT NULL,
    ccd TINYINT NOT NULL,
    filterId TINYINT NOT NULL,
        -- <descr>Pointer to filter.</descr>
    ra DOUBLE NOT NULL,
    decl DOUBLE NOT NULL,
    equinox FLOAT(0) NOT NULL,
        -- <descr>Equinox of World Coordinate System.</descr>
    raDeSys VARCHAR(20) NOT NULL,
    ctype1 VARCHAR(20) NOT NULL,
        -- <descr>Coordinate projection type, axis 1.</descr>
    ctype2 VARCHAR(20) NOT NULL,
        -- <descr>Coordinate projection type, axis 2.</descr>
    crpix1 FLOAT(0) NOT NULL,
        -- <descr>Coordinate reference pixel, axis 1.</descr>
    crpix2 FLOAT(0) NOT NULL,
        -- <descr>Coordinate reference pixel, axis 2.</descr>
    crval1 DOUBLE NOT NULL,
        -- <descr>Coordinate value 1 @reference pixel.</descr>
    crval2 DOUBLE NOT NULL,
        -- <descr>Coordinate value 2 @reference pixel.</descr>
    cd1_1 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 1.</descr>
    cd1_2 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 2.</descr>
    cd2_1 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 1.</descr>
    cd2_2 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 2.</descr>
    llcRa DOUBLE NOT NULL,
    llcDecl DOUBLE NOT NULL,
    ulcRa DOUBLE NOT NULL,
    ulcDecl DOUBLE NOT NULL,
    urcRa DOUBLE NOT NULL,
    urcDecl DOUBLE NOT NULL,
    lrcRa DOUBLE NOT NULL,
    lrcDecl DOUBLE NOT NULL,
    taiMjd DOUBLE NOT NULL,
        -- <descr>Date of the start of the exposure</descr>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expMidpt VARCHAR(30) NOT NULL,
    expTime FLOAT(0) NOT NULL,
        -- <descr>Duration of exposure.</descr>
    nCombine INTEGER NOT NULL,
        -- <descr>Number of images co-added to create a deeper image</descr>
    binX INTEGER NOT NULL,
        -- <descr>Binning of the ccd in x.</descr>
    binY INTEGER NOT NULL,
        -- <descr>Binning of the ccd in y.</descr>
    readNoise FLOAT(0) NOT NULL,
        -- <descr>Read noise of the ccd.</descr>
    saturationLimit INTEGER NOT NULL,
        -- <descr>Saturation limit for the ccd (average of the amplifiers).
        -- </descr>
    gainEff DOUBLE NOT NULL,
    fluxMag0 FLOAT(0) NOT NULL,
    fluxMag0Sigma FLOAT(0) NOT NULL,
    fwhm DOUBLE NOT NULL,
    flags INTEGER NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
    PRIMARY KEY (scienceCcdExposureId)
) TYPE=MyISAM;


CREATE TABLE Science_Ccd_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Science_Ccd_Exposure.</descr>
(
    scienceCcdExposureId BIGINT NOT NULL,
    metadataKey VARCHAR(255) NOT NULL,
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits: 0x1 - scienceCcd, 0x2 - diffCcd, more
        -- tbd.</descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (scienceCcdExposureId, metadataKey),
    INDEX IDX_metadataKey (metadataKey ASC)
) TYPE=MyISAM;


CREATE TABLE Snap_Ccd_To_Science_Ccd_Exposure
(
    snapCcdExposureId BIGINT NOT NULL,
    snap TINYINT NOT NULL,
    scienceCcdExposureId BIGINT NOT NULL,
    PRIMARY KEY (snapCcdExposureId),
    INDEX scienceCcdExposureId (scienceCcdExposureId ASC)
) TYPE=MyISAM;


CREATE TABLE Visit
    -- <descr>Defines a single Visit. 1 row per LSST visit.</descr>
(
    visitId INTEGER NOT NULL,
        -- <descr>Unique identifier.</descr>
    PRIMARY KEY (visitId)
) TYPE=MyISAM;


CREATE TABLE CalibSource
    -- <descr>Table to store measured sources corresponding to sources from 
    -- the astrometric and photometric catalogs. They are used for calibration
    -- (as input for WCS determination).</descr>
(
    calibSourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
    ccdExposureId BIGINT NULL,
        -- <descr>Pointer to CcdExposure where this source was measured. Note
        -- that we do not allow a source to belong to multiple CcdExposures (it
        -- may not span multiple CcdExposures).</descr>
    filterId TINYINT NULL,
        -- <descr>Pointer to an entry in Filter table: filter used to take the
        -- Exposure where this Source was measured.</descr>
    astroRefCatId BIGINT NULL,
        -- <descr>Pointer to the corresponding object from the Astrometric
        -- Reference Catalog.</descr>
    photoRefCatId BIGINT NULL,
        -- <descr>Pointer to the corresponding object in the Photometric
        -- Reference Catalog.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA-coordinate of the center of the calibSource.</descr>
        -- <unit>degree</unit>
    raSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of ra.</descr>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the calibSource.</descr>
        -- <unit>degree</unit>
    declSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of decl.</descr>
        -- <unit>degree</unit>
    xAstrom DOUBLE NOT NULL,
        -- <descr>x position computed by a centroiding algorithm.</descr>
        -- <unit>degree</unit>
    xAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of xAstrom.</descr>
        -- <unit>degree</unit>
    yAstrom DOUBLE NOT NULL,
        -- <descr>y position computed by a centroiding algorithm.</descr>
        -- <unit>degree</unit>
    yAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of yAstrom.</descr>
        -- <unit>degree</unit>
    xyAstromCov FLOAT(0) NOT NULL,
        -- <descr>Covariance between the xAstrom and the yAstrom.</descr>
    psfFlux DOUBLE NOT NULL,
        -- <descr>Psf flux.</descr>
    psfFluxSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of the psfFlux.</descr>
    apFlux DOUBLE NOT NULL,
        -- <descr>Aperture flux. Needed for aperture correction
        -- calculation.</descr>
    apFluxSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of apFlux.</descr>
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
    _chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (calibSourceId),
    INDEX (ccdExposureId),
    INDEX (filterId),
    INDEX (xAstromSigma)
) TYPE=MyISAM;


CREATE TABLE DiaSource
    -- <descr>Table to store &quot;difference image sources&quot; - sources
    -- detected on a difference image during Alert Production.</descr>
(
    diaSourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
    ccdExposureId BIGINT NULL,
        -- <descr>Pointer to the CcdExpsoure where this diaSource was measured.
        -- Note that we are allowing a diaSource to belong to multiple
        -- AmpExposures, but it may not span multiple CcdExposures.</descr>
    filterId TINYINT NOT NULL,
        -- <descr>Pointer to an entry in Filter table: filter used to take
        -- Exposure where this diaSource was measured.</descr>
    objectId BIGINT NULL,
        -- <descr>Pointer to Object table. Might be NULL (each diaSource will
        -- point to either MovingObject or Object)</descr>
    movingObjectId BIGINT NULL,
        -- <descr>Pointer to MovingObject table. Might be NULL (each diaSource
        -- will point to either MovingObject or Object)</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA-coordinate of the center of the diaSource.</descr>
        -- <unit>degree</unit>
    raSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of ra.</descr>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the diaSource.</descr>
        -- <unit>degree</unit>
    declSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of decl.</descr>
        -- <unit>degree</unit>
    xAstrom FLOAT(0) NOT NULL,
        -- <descr>x position computed by a centroiding algorithm for the
        -- purposes of astrometry using Dave Monet's algorithm.</descr>
        -- <unit>degree</unit>
    xAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of xAstrom.</descr>
        -- <unit>degree</unit>
    yAstrom FLOAT(0) NOT NULL,
        -- <descr>y position computed by a centroiding algorithm for the
        -- purposes of astrometry using Dave Monet's algorithm.</descr>
        -- <unit>degree</unit>
    yAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of yAstrom.</descr>
        -- <unit>degree</unit>
    xyAstromCov FLOAT(0) NOT NULL,
        -- <descr>Covariance between the xAstrom and the yAstrom.</descr>
        -- <unit>degree</unit>
    xOther FLOAT(0) NOT NULL,
        -- <descr>x position computed by a centroiding algorithm for the
        -- purposes of astrometry using &quot;other&quot; centroiding
        -- algorithm.</descr>
        -- <unit>degree</unit>
    xOtherSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of xOther.</descr>
    yOther FLOAT(0) NOT NULL,
        -- <descr>y position computed by a centroiding algorithm for the
        -- purposes of astrometry using &quot;other&quot; centroiding
        -- algorithm.</descr>
    yOtherSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of yOther.</descr>
    xyOtherCov FLOAT(0) NOT NULL,
        -- <descr>Covariance between the xOther and yOther.</descr>
    astromRefrRa FLOAT(0) NULL,
        -- <descr>Astrometric refraction in ra.</descr>
        -- <unit>degree</unit>
    astromRefrRaSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of astromRefrRa.</descr>
        -- <unit>degree</unit>
    astromRefrDecl FLOAT(0) NULL,
        -- <descr>Astrometric refraction in decl.</descr>
        -- <unit>degree</unit>
    astromRefrDeclSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of astromRefrDecl.</descr>
    sky FLOAT(0) NOT NULL,
        -- <descr>Sky background.</descr>
    skySigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of sky.</descr>
    psfLnL FLOAT(0) NULL,
        -- <descr>ln(likelihood) of being a PSF.</descr>
    lnL_SG FLOAT(0) NULL,
        -- <descr>Log-likelihood of being a Small Galaxy.</descr>
    flux_PS FLOAT(0) NOT NULL,
        -- <descr>Calibrated flux for Point Source model.</descr>
    flux_PS_Sigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of flux_PS.</descr>
    flux_SG FLOAT(0) NOT NULL,
        -- <descr>Calibrated flux for Small Galaxy model.</descr>
    flux_SG_Sigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of flux_SG.</descr>
    flux_CSG FLOAT(0) NOT NULL,
        -- <descr>Calibrated flux for Cannonical Small Galaxy model.
        -- </descr>
    flux_CSG_Sigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainly of flux_CSG.</descr>
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
    _chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (diaSourceId),
    INDEX (ccdExposureId),
    INDEX (filterId),
    INDEX (movingObjectId),
    INDEX (objectId)
) TYPE=MyISAM;


CREATE TABLE ForcedSource
    -- <descr>Forced-photometry source measurement on an individual Exposure
    -- based on a Multifit shape model derived from a deep detection.
    -- </descr>
(
    objectId BIGINT NOT NULL,
    visitId INTEGER NOT NULL,
        -- <descr>Pointer to the entry in Visit table where this forcedSource
        -- was measured.</descr>
    flux FLOAT(0) NOT NULL,
        -- <descr>Flux.</descr>
    flux_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of flux.</descr>
    x FLOAT(0) NULL,
        -- <descr>x position computed by a centroiding algorithm.</descr>
    y FLOAT(0) NULL,
        -- <descr>y position computed by a centroiding algorithm.</descr>
    flags TINYINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
    PRIMARY KEY (objectId, visitId)
) TYPE=MyISAM;


CREATE TABLE MovingObject
    -- <descr>The movingObject table contains description of the Solar System
    -- (moving) Objects.</descr>
(
    movingObjectId BIGINT NOT NULL,
        -- <descr>Moving object unique identified.</descr>
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
        -- <descr>Rotation period, days</descr>
    rotationEpoch DOUBLE NULL,
        -- <descr>Rotation time origin, MJD (UTC)</descr>
    albedo DOUBLE NULL,
        -- <descr>Albedo (dimensionless)</descr>
    poleLat DOUBLE NULL,
        -- <descr>Rotation pole latitude (degrees)</descr>
    poleLon DOUBLE NULL,
        -- <descr>Rotation pole longitude (degrees)</descr>
    d3 DOUBLE NULL,
        -- <descr>3-parameter D-criterion (dimensionless) WRT SSM object</descr>
    d4 DOUBLE NULL,
        -- <descr>4-parameter D-criterion (dimensionless) WRT SSM object</descr>
    orbFitResidual DOUBLE NOT NULL,
        -- <descr>Orbit fit RMS residual.</descr>
        -- <unit>argsec</unit>
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
    uMagErr FLOAT(0) NULL,
        -- <descr>Uncertainty of uMag.</descr>
    uAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for u
        -- filter</descr>
    uPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for u filter</descr>
    gMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in g filter.</descr>
    gMagErr FLOAT(0) NULL,
        -- <descr>Uncertainty of gMag.</descr>
    gAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for g
        -- filter</descr>
    gPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for g filter</descr>
    rMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in r filter.</descr>
    rMagErr FLOAT(0) NULL,
        -- <descr>Uncertainty of rMag.</descr>
    rAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for r
        -- filter</descr>
    rPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for r filter</descr>
    iMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in i filter.</descr>
    iMagErr FLOAT(0) NULL,
        -- <descr>Uncertainty of iMag.</descr>
    iAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for i
        -- filter</descr>
    iPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for i filter</descr>
    zMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in z filter.</descr>
    zMagErr FLOAT(0) NULL,
        -- <descr>Uncertainty of zMag.</descr>
    zAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for z
        -- filter</descr>
    zPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for z filter</descr>
    yMag DOUBLE NULL,
        -- <descr>Weighted average apparent magnitude in y filter.</descr>
    yMagErr FLOAT(0) NULL,
        -- <descr>Uncertainty of yMag.</descr>
    yAmplitude FLOAT(0) NULL,
        -- <descr>Characteristic magnitude scale of the flux variations for y
        -- filter</descr>
    yPeriod FLOAT(0) NULL,
        -- <descr>Period of flux variations (if regular) for y filter</descr>
    flags INTEGER NULL DEFAULT 0,
        -- <descr>Problem/special condition flag.</descr>
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
) TYPE=MyISAM;


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
    iauId CHAR(34) NULL,
        -- <descr>IAU compliant name for the object. Example: &quot;LSST-DR11
        -- J001234.65-123456.18 GAL&quot;. The last 3 characters identify
        -- classification. Note that it will not accommodate multiple
        -- classifications.</descr>
    ra_PS DOUBLE NOT NULL,
        -- <descr>RA-coordinate of the center of the object for the Point Source
        -- model for the cannonical filter.</descr>
        -- <unit>degree</unit>
    ra_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of ra_PS.</descr>
        -- <unit>degree</unit>
    decl_PS DOUBLE NOT NULL,
        -- <descr>Dec-coordinate of the center of the object for the Point
        -- Source model for the cannonical filter.</descr>
        -- <unit>degree</unit>
    decl_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of decl_PS.</descr>
        -- <unit>degree</unit>
    radecl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra_PS and decl_PS.</descr>
    ra_SG DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the Small Galaxy
        -- model for the cannonical filter.</descr>
        -- <unit>degree</unit>
    ra_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of ra_SG.</descr>
        -- <unit>degree</unit>
    decl_SG DOUBLE NULL,
        -- <descr>Dec-coordinate of the center of the object for the Small
        -- Galaxy model for the cannonical filter.</descr>
        -- <unit>degree</unit>
    decl_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of decl_SG.</descr>
        -- <unit>degree</unit>
    radecl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra_SG and decl_SG.</descr>
    raRange FLOAT(0) NULL,
        -- <descr>Ra part of the bounding box on the sky that fully encloses
        -- footprint of this object for the cannonical model (Small Galaxy) and
        -- cannonical filter.</descr>
        -- <unit>degree</unit>
    declRange FLOAT(0) NULL,
        -- <descr>Decl part of the bounding box on the sky that fully encloses
        -- footprint of this object for the cannonical model (Small Galaxy) and
        -- cannonical filter.</descr>
        -- <unit>degree</unit>
    muRa_PS DOUBLE NULL,
        -- <descr>Proper motion (ra) for the Point Source model.</descr>
        -- <unit>degree/year</unit>
    muRa_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of muRa_PS.</descr>
        -- <unit>degree/year</unit>
    muDecl_PS DOUBLE NULL,
        -- <descr>Proper motion (decl) for the Point Source model.</descr>
        -- <unit>degree/year</unit>
    muDecl_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of muDecl_PS.</descr>
        -- <unit>degree/year</unit>
    muRaDecl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of muRa_PS and muDecl_PS.</descr>
    parallax_PS DOUBLE NULL,
        -- <descr>Parallax for Point Source model.</descr>
        -- <unit>degree/year</unit>
    parallax_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of parallax_PS.</descr>
        -- <unit>degree/year</unit>
    canonicalFilterId TINYINT NULL,
        -- <descr>Id of the filter which is the canonical filter for size,
        -- ellipticity and Sersic index parameters.</descr>
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
        -- <unit>TAI</unit>
    latestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed (taiMidPoint of
        -- the last Source).</descr>
        -- <unit>TAI</unit>
    flags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
    uNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for u
        -- filter.</descr>
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
        -- <descr>Flux for Point Source model for u filter.</descr>
    uFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uFlux_PS.</descr>
    uFlux_SG FLOAT(0) NULL,
        -- <descr>Flux for Small Galaxy model for u filter.</descr>
    uFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uFlux_SG.</descr>
    uFlux_CSG FLOAT(0) NULL,
        -- <descr>Flux for Cannonical Small Galaxy model for u filter.
        -- </descr>
    uFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uFlux_CSG.</descr>
    uTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for u filter.
        -- </descr>
        -- <unit>day</unit>
    uEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in u
        -- filter.</descr>
    uLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in u
        -- filter.</descr>
    uSersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for u filter.</descr>
    uSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uSersicN_SG.</descr>
    uE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for u filter.</descr>
    uE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uE1_SG.</descr>
    uE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for u filter.</descr>
    uE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uE2_SG.</descr>
    uRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for u filter.</descr>
    uRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uRadius_SG.</descr>
    uFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
    gNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for g
        -- filter.</descr>
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
        -- <descr>Flux for Point Source model for g filter.</descr>
    gFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gFlux_PS.</descr>
    gFlux_SG FLOAT(0) NULL,
        -- <descr>Flux for Small Galaxy model for g filter.</descr>
    gFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gFlux_SG.</descr>
    gFlux_CSG FLOAT(0) NULL,
        -- <descr>Flux for Cannonical Small Galaxy model for g filter.
        -- </descr>
    gFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gFlux_CSG.</descr>
    gTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for g filter.
        -- </descr>
        -- <unit>day</unit>
    gEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in g
        -- filter.</descr>
    gLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in g
        -- filter.</descr>
    gSersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for g filter.</descr>
    gSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gSersicN_SG.</descr>
    gE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for g filter.</descr>
    gE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gE1_SG.</descr>
    gE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for g filter.</descr>
    gE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gE2_SG.</descr>
    gRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for g filter.</descr>
    gRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gRadius_SG.</descr>
    gFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
    rNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for r
        -- filter.</descr>
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
        -- <descr>Flux for Point Source model for r filter.</descr>
    rFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rFlux_PS.</descr>
    rFlux_SG FLOAT(0) NULL,
        -- <descr>Flux for Small Galaxy model for r filter.</descr>
    rFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rFlux_SG.</descr>
    rFlux_CSG FLOAT(0) NULL,
        -- <descr>Flux for Cannonical Small Galaxy model for r filter.
        -- </descr>
    rFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rFlux_CSG.</descr>
    rTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for r filter.
        -- </descr>
        -- <unit>day</unit>
    rEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in g
        -- filter.</descr>
    rLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in g
        -- filter.</descr>
    rSersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for r filter.</descr>
    rSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rSersicN_SG.</descr>
    rE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for r filter.</descr>
    rE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rE1_SG.</descr>
    rE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for r filter.</descr>
    rE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rE2_SG.</descr>
    rRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for r filter.</descr>
    rRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rRadius_SG.</descr>
    rFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
    iNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for i
        -- filter.</descr>
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
        -- <descr>Flux for Point Source model for i filter.</descr>
    iFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iFlux_PS.</descr>
    iFlux_SG FLOAT(0) NULL,
        -- <descr>Flux for Small Galaxy model for i filter.</descr>
    iFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iFlux_SG.</descr>
    iFlux_CSG FLOAT(0) NULL,
        -- <descr>Flux for Cannonical Small Galaxy model for i filter.
        -- </descr>
    iFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iFlux_CSG.</descr>
    iTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for i filter.
        -- </descr>
        -- <unit>day</unit>
    iEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in g
        -- filter.</descr>
    iLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in g
        -- filter.</descr>
    iSersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for i filter.</descr>
    iSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iSersicN_SG.</descr>
    iE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for i filter.</descr>
    iE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iE1_SG.</descr>
    iE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for i filter.</descr>
    iE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iE2_SG.</descr>
    iRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for i filter.</descr>
    iRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iRadius_SG.</descr>
    iFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
    zNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for z
        -- filter.</descr>
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
        -- <descr>Flux for Point Source model for z filter.</descr>
    zFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zFlux_PS.</descr>
    zFlux_SG FLOAT(0) NULL,
        -- <descr>Flux for Small Galaxy model for z filter.</descr>
    zFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zFlux_SG.</descr>
    zFlux_CSG FLOAT(0) NULL,
        -- <descr>Flux for Cannonical Small Galaxy model for z filter.
        -- </descr>
    zFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zFlux_CSG.</descr>
    zTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for z filter.
        -- </descr>
        -- <unit>day</unit>
    zEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in g
        -- filter.</descr>
    zLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in g
        -- filter.</descr>
    zSersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for z filter.</descr>
    zSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zSersicN_SG.</descr>
    zE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for z filter.</descr>
    zE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zE1_SG.</descr>
    zE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for z filter.</descr>
    zE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zE2_SG.</descr>
    zRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for z filter.</descr>
    zRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zRadius_SG.</descr>
    zFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
    yNumObs INTEGER NULL,
        -- <descr>Number of forced sources associated with this object for y
        -- filter.</descr>
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
        -- <descr>Flux for Point Source model for y filter.</descr>
    yFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yFlux_PS.</descr>
    yFlux_SG FLOAT(0) NULL,
        -- <descr>Flux for Small Galaxy model for y filter.</descr>
    yFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yFlux_SG.</descr>
    yFlux_CSG FLOAT(0) NULL,
        -- <descr>Flux for Cannonical Small Galaxy model for y filter.
        -- </descr>
    yFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yFlux_CSG.</descr>
    yTimescale FLOAT(0) NULL,
        -- <descr>Characteristic timescale of flux variations for y filter.
        -- </descr>
        -- <unit>day</unit>
    yEarliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time in g
        -- filter.</descr>
    yLatestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed in g
        -- filter.</descr>
    ySersicN_SG FLOAT(0) NULL,
        -- <descr>Sersic index for Small Galaxy model for y filter.</descr>
    ySersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of ySersicN_SG.</descr>
    yE1_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for y filter.</descr>
    yE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yE1_SG.</descr>
    yE2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model for y filter.</descr>
    yE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yE2_SG.</descr>
    yRadius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model for y filter.</descr>
    yRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yRadius_SG.</descr>
    yFlags INTEGER NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
    _chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    _subChunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (objectId),
    INDEX IDX_Object_decl (decl_PS ASC)
) TYPE=MyISAM;


CREATE TABLE ObjectExtras
    -- <descr>This table contains less-frequently used columns from the Object
    -- table.</descr>
(
    objectId BIGINT NOT NULL,
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
) TYPE=MyISAM;


CREATE TABLE Source
    -- <descr>Table to store high signal-to-noise &quot;sources&quot;. A source
    -- is a measurement of Object's properties from a single image that contains
    -- its footprint on the sky.</descr>
(
    sourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
    ccdExposureId BIGINT NULL,
        -- <descr>Pointer to the CcdExpsoure where this source was measured.
        -- Note that we are allowing a source to belong to multiple
        -- AmpExposures, but it may not span multiple CcdExposures.</descr>
    filterId TINYINT NOT NULL,
        -- <descr>Pointer to an entry in Filter table: filter used to take
        -- Exposure where this Source was measured.</descr>
    objectId BIGINT NULL,
        -- <descr>Pointer to Object table. Might be NULL (each Source will point
        -- to either MovingObject or Object)</descr>
    movingObjectId BIGINT NULL,
        -- <descr>Pointer to MovingObject table. Might be NULL (each Source will
        -- point to either MovingObject or Object)</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA-coordinate of the center of the source.</descr>
        -- <unit>degree</unit>
    raSigmaForDetection FLOAT NULL,
        -- <descr>Component of ra uncertainty due to detection uncertainty
        -- (xAstromSigma, yAstromSigma).</descr>
        -- <unit>degree</unit>
    raSigmaForWcs FLOAT NOT NULL,
        -- <descr>Component of ra uncertainty due to
        -- uncertainty in WCS solution.</descr>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the source.</descr>
        -- <unit>degree</unit>
    declSigmaForDetection FLOAT NULL,
        -- <descr>Component of decl uncertainty due to detection uncertainty
        -- (xAstromSigma, yAstromSigma).</descr>
        -- <unit>degree</unit>
    declSigmaForWcs FLOAT NOT NULL,
        -- <descr>Component of decl uncertainty due to
        -- uncertainty in WCS solution.</descr>
        -- <unit>degree</unit>
    xAstrom FLOAT(0) NOT NULL,
        -- <descr>x position computed by a centroiding algorithm for the
        -- purposes of astrometry using Dave Monet's algorithm.</descr>
        -- <unit>degree</unit>
    xAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of xAstrom.</descr>
        -- <unit>degree</unit>
    yAstrom FLOAT(0) NOT NULL,
        -- <descr>y position computed by a centroiding algorithm for the
        -- purposes of astrometry using Dave Monet's algorithm.</descr>
        -- <unit>degree</unit>
    yAstromSigma FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of yAstrom.</descr>
        -- <unit>degree</unit>
    xyAstromCov FLOAT(0) NOT NULL,
        -- <descr>Covariance between the xAstrom and the yAstrom.</descr>
        -- <unit>degree</unit>
    astromRefrRa FLOAT(0) NULL,
        -- <descr>Astrometric refraction in ra.</descr>
        -- <unit>degree</unit>
    astromRefrRaSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of astromRefrRa.</descr>
        -- <unit>degree</unit>
    astromRefrDecl FLOAT(0) NULL,
        -- <descr>Astrometric refraction in decl.</descr>
        -- <unit>degree</unit>
    astromRefrDeclSigma FLOAT(0) NULL,
        -- <descr>Uncertainty of astromRefrDecl.</descr>
        -- <unit>degree</unit>
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
        -- <unit>mjd</unit>
    taiRange FLOAT NULL,
        -- <descr>Exposure time.</descr>
        -- <unit>s</unit>
    xFlux DOUBLE NULL,
    xFluxErr FLOAT(0) NULL,
    yFlux DOUBLE NULL,
    yFluxErr FLOAT(0) NULL,
    xPeak DOUBLE NULL,
    yPeak DOUBLE NULL,
    raPeak DOUBLE NULL,
    declPeak DOUBLE NULL,
    flux_PS FLOAT(0) NULL,
        -- <descr>Calibrated flux for Point Source model.</descr>
    flux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of flux_PS.</descr>
    flux_SG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Small Galaxy model.</descr>
    flux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of flux_SG.</descr>
    flux_CSG FLOAT(0) NULL,
        -- <descr>Calibrated flux for Cannonical Small Galaxy model.
        -- </descr>
    flux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainly of flux_CSG.</descr>
    psfFlux DOUBLE NULL,
        -- <descr>Uncalibrated PSF flux of source.</descr>
        -- <unit>DN</unit>
    psfFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <unit>DN</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of source.</descr>
        -- <unit>DN</unit>
    apFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <unit>DN</unit>
    petroFlux DOUBLE NULL,
        -- <descr>Petrosian flux.</descr>
    petroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of petroFlux.</descr>
    instFlux DOUBLE NULL,
        -- <descr>Instrumental flux.</descr>
    instFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of instFlux.</descr>
    nonGrayCorrFlux DOUBLE NULL,
    nonGrayCorrFluxErr FLOAT(0) NULL,
    atmCorrFlux DOUBLE NULL,
    atmCorrFluxErr FLOAT(0) NULL,
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
    e1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of e1_SG.</descr>
    e2_SG FLOAT(0) NULL,
        -- <descr>Ellipticity for Small Galaxy model.</descr>
    e2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of e2_SG.</descr>
    radius_SG FLOAT(0) NULL,
        -- <descr>Size of Small Galaxy model.</descr>
    radius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of radius_SG.</descr>
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
    flagsForDetection INT NULL DEFAULT 0,
        -- <descr>Flags related to detection.</descr>
    flagsForWcs INT NULL DEFAULT 0,
        -- <descr>Flags related to WCS.</descr>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
    _chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (sourceId),
    INDEX (objectId),
    INDEX (ccdExposureId),
    INDEX (filterId),
    INDEX (movingObjectId),
    INDEX (objectId),
    INDEX IDX_htmId20 (htmId20 ASC)
) TYPE=MyISAM;



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

