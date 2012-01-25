
-- LSST Database Schema
-- $Author$
-- $Revision: 18841 $
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu/trac/wiki/Copyrights>
-- for copyright information.



SET FOREIGN_KEY_CHECKS=0;


CREATE TABLE ZZZ_Db_Description 
    -- <descr>Internal table used for storing database description</descr>
(
    f VARCHAR(255),
        -- <descr>The schema file name.</desc>
    r VARCHAR(255)
        -- <descr>Captures information from 'git describe'.</descr>
) ENGINE=MyISAM;

INSERT INTO ZZZ_Db_Description(f) VALUES('lsstSchema4mysqlPT1_2.sql');


CREATE TABLE AmpMap
    -- <descr>Mapping table to translate amp names to numbers.</descr>
(
    ampNum TINYINT NOT NULL,
        -- <ucd>meta.id;inst.det</ucd>
    ampName CHAR(3) NOT NULL,
        -- <ucd>inst.det</ucd>
    PRIMARY KEY (ampNum),
    UNIQUE UQ_AmpMap_ampName(ampName)
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
) ENGINE=MyISAM;


CREATE TABLE Filter
(
    filterId TINYINT NOT NULL,
        -- <descr>Unique id (primary key).</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName CHAR(3) NOT NULL,
        -- <descr>Filter name. Valid values: 'u', 'g', 'r', 'i', 'z', 'y', 
        -- 'w', 'V'.</descr>
        -- <ucd>instr.bandpass</ucd>
    photClam FLOAT NOT NULL,
        -- <descr>Filter centroid wavelength.</descr>
        -- <ucd>em.wl.effective;inst.filter</ucd>
        -- <unit>nm</unit>
    photBW FLOAT NOT NULL,
        -- <descr>System effective bandwidth.</descr>
        -- <ucd>inst.bandwidth</ucd>
        -- <unit>nm</unit>
    PRIMARY KEY (filterId)
) ENGINE=MyISAM;


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
        -- <ucd>time.start</ucd>
        -- <unit>sec</unit>
    mjdRef FLOAT NOT NULL,
        -- <descr>Reference MJD for drift (prior to 1972-Jan-1).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    drift FLOAT NOT NULL,
        -- <descr>Drift in seconds per day (prior to 1972-Jan-1).</descr>
        -- <ucd>arith.rate</ucd>
        -- <unit>sec/day</unit>
    whenMjdUtc FLOAT NULL,
        -- <descr>MJD in UTC system of change (computed).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>day</unit>
    whenUtc BIGINT NULL,
        -- <descr>Nanoseconds from epoch in UTC system of change (computed).
        -- </descr>
        -- <ucd>time</ucd>
        -- <unit>nanosec</unit>
    whenTai BIGINT NULL
        -- <descr>Nanoseconds from epoch in TAI system of change (computed).
        -- </descr>
        -- <ucd>time</ucd>
        -- <unit>nanosec</unit>
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
    COMMENT TEXT NULL,
    PIPELINE VARCHAR(80) NULL,
    TYPE VARCHAR(5) NULL,
    EVENTTIME BIGINT NULL,
    PUBTIME BIGINT NULL,
    usertime FLOAT NULL,
    systemtime FLOAT NULL,
    PRIMARY KEY (id),
    INDEX a (RUNID ASC)
) ENGINE=MyISAM;


CREATE TABLE ObjectType
    -- <descr>Table to store description of object types. It includes all object
    -- types: static, variables, Solar System objects, etc.</descr>
(
    typeId SMALLINT NOT NULL,
        -- <descr>Unique id.</descr>
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
) ENGINE=MyISAM;


CREATE TABLE RefObjMatch
    -- <descr>Table containing the results of a spatial match between
    -- SimRefObject and Object.</descr>
(
    refObjectId BIGINT NULL,
        -- <descr>Reference object id (pointer to SimRefObject). NULL if
        -- reference object has no matches.</descr>
    objectId BIGINT NULL,
        -- <descr>Object id. NULL if object has no matches.</descr>
        -- <ucd>meta.id;src</ucd>
    refRa DOUBLE NULL,
        -- <descr>ICRS reference object RA at mean epoch of sources assigned to
        -- object.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    refDec DOUBLE NULL,
        -- <descr>ICRS reference object Dec at mean epoch of sources assigned to
        -- object.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    angSep DOUBLE NULL,
        -- <descr>Angular separation between reference object and object.
        -- </descr>
        -- <unit>arcsec</unit>
        -- <ucd>pos.angDistance</ucd>
    nRefMatches INTEGER NULL,
        -- <descr>Total number of matches for reference object.</descr>
    nObjMatches INTEGER NULL,
        -- <descr>Total number of matches for object.</descr>
        -- <ucd>meta.number</ucd>
    closestToRef TINYINT NULL,
        -- <descr>1 if object is the closest match for reference object, 0
        -- otherwise.</descr>
        -- <ucd>meta.code</ucd>
    closestToObj TINYINT NULL,
        -- <descr>1 if reference object is the closest match for object, 0
        -- otherwise.</descr>
        -- <ucd>meta.code</ucd>
    flags INTEGER NULL DEFAULT 0,
        -- <descr>Bitwise OR of match flags.
        -- <ul>
        --   <li>0x1: the reference object has proper motion.</li>
        --   <li>0x2: the reference object has parallax.</li>
        --   <li>0x4: a reduction for parallax from barycentric to geocentric 
        --       place was applied prior to matching the reference object.</li>
        -- </ul></descr>
        -- <ucd>meta.code</ucd>
    KEY (objectId),
    KEY (refObjectId)
) ENGINE=MyISAM;


CREATE TABLE RefSrcMatch
    -- <descr>Table containing the results of a spatial match between
    -- SimRefObject and Source.</descr>
(
    refObjectId BIGINT NULL,
        -- <descr>Reference object id (pointer to SimRefObject). NULL if
        -- reference object has no matches.</descr>
    sourceId BIGINT NULL,
        -- <descr>Source id. NULL if source has no matches.</descr>
    refRa DOUBLE NULL,
        -- <descr>ICRS reference object RA at epoch of source.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    refDec DOUBLE NULL,
        -- <descr>ICRS reference object Dec at epoch of source.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    angSep DOUBLE NULL,
        -- <descr>Angular separation between reference object and source.
        -- </descr>
        -- <unit>arcsec</unit>
        -- <ucd>pos.angDistance</ucd>
    nRefMatches INTEGER NULL,
        -- <descr>Total number of matches for reference object.</descr>
        -- <ucd>meta.number</ucd>
    nSrcMatches INTEGER NULL,
        -- <descr>Total number of matches for source.</descr>
        -- <ucd>meta.number</ucd>
    closestToRef TINYINT NULL,
        -- <descr>1 if source is the closest match for reference object, 0
        -- otherwise.</descr>
        -- <ucd>meta.code</ucd>
    closestToSrc TINYINT NULL,
        -- <descr>1 if reference object is the closest match for source, 0
        -- otherwise.</descr>
        -- <ucd>meta.code</ucd>
    flags INTEGER NULL DEFAULT 0,
        -- <descr>Bitwise OR of match flags.
        -- <ul>
        --   <li>0x1: the reference object has proper motion.</li>
        --   <li>0x2: the reference object has parallax.</li>
        --   <li>0x4: a reduction for parallax from barycentric to geocentric 
        --       place was applied prior to matching the reference object.</li>
        -- </ul></descr>
        -- <ucd>meta.code</ucd>
    KEY (sourceId),
    KEY (refObjectId)
) ENGINE=MyISAM;


CREATE TABLE SimRefObject
    -- <descr>Stores properties of ImSim reference objects that fall within
    --        at least one CCD. Includes both stars and galaxies.
    -- </descr>
(
    refObjectId BIGINT NOT NULL,
        -- <descr>Unique reference object ID.</descr>
        -- <ucd>meta.id;src</ucd>
    isStar TINYINT NOT NULL,
        -- <descr>1 for stars, 0 for galaxies.</descr>
        -- <ucd>src.class</ucd>
    varClass TINYINT NOT NULL,
        -- <descr>Variability classification code:
        -- <ul>
        --    <li>0 = Non-variable</li>
        --    <li>1 = RR-Lyrae</li>
        --    <li>2 = Active galactic nucleus</li>
        --    <li>3 = Lensed Quasar</li>
        --    <li>4 = M-Dwarf flares</li>
        --    <li>5 = Eclipsing binary</li>
        --    <li>6 = Microlensing</li>
        --    <li>7 = Long duration microlensing</li>
        --    <li>8 = AM CVn</li>
        --    <li>9 = Cepheid</li>
        -- </ul>
        -- </descr>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of object.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of object.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
    gLat DOUBLE NULL,
        -- <descr>Galactic latitude of star. NULL for galaxies.</descr>
        -- <ucd>pos.galactic.lat</ucd>
        -- <unit>degree</unit>

    gLon DOUBLE NULL,
        -- <descr>Galactic longitude of star. NULL for galaxies.</descr>
        -- <ucd>pos.galactic.lon</ucd>
        -- <unit>degree</unit>
    sedName VARCHAR(255) NULL,
        -- <descr>Best-fit SED name. NULL for galaxies.</descr>
        -- <ucd>src.sec</ucd>
    uMag DOUBLE NOT NULL,
        -- <descr>u-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    gMag DOUBLE NOT NULL,
        -- <descr>g-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    rMag DOUBLE NOT NULL,
        -- <descr>r-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    iMag DOUBLE NOT NULL,
        -- <descr>i-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    zMag DOUBLE NOT NULL,
        -- <descr>z-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    yMag DOUBLE NOT NULL,
        -- <descr>y-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    muRa DOUBLE NULL,
        -- <descr>Proper motion: dRA/dt*cos(decl). NULL for galaxies.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>milliarcsec/year</unit>
    muDecl DOUBLE NULL,
        -- <descr>Proper motion: dDec/dt. NULL for galaxies.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>milliarcsec/year</unit>
    parallax DOUBLE NULL,
        -- <descr>Stellar parallax. NULL for galaxies.</descr>
        -- <ucd>pos.parallax</ucd>
        -- <unit>milliarcsec</unit>
    vRad DOUBLE NULL,
        -- <descr>Radial velocity of star. NULL for galaxies.</descr>
        -- <ucd>spect.dopplerVeloc.opt</ucd>
        -- <unit>km/sec</unit>
    redshift DOUBLE NULL,
        -- <descr>Redshift. NULL for stars.</descr>
        -- <ucd>src.redshift</ucd>
    semiMajorBulge DOUBLE NULL,
        -- <descr>Semi-major axis length of galaxy bulge. NULL for stars.</descr>
        -- <unit>arcsec</unit>
    semiMinorBulge DOUBLE NULL,
        -- <descr>Semi-minor axis length of galaxy bulge. NULL for stars.</descr>
        -- <unit>arcsec</unit>
    semiMajorDisk DOUBLE NULL,
        -- <descr>Semi-major axis length of galaxy disk. NULL for stars.</descr>
        -- <unit>arcsec</unit>
    semiMinorDisk DOUBLE NULL,
        -- <descr>Semi-minor axis length of galaxy disk. NULL for stars.</descr>
        -- <unit>arcsec</unit>
    uCov SMALLINT NOT NULL,
        -- <descr>Number of u-band science CCDs containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    gCov SMALLINT NOT NULL,
        -- <descr>Number of g-band science CCDs containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    rCov SMALLINT NOT NULL,
        -- <descr>Number of r-band science CCDs containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    iCov SMALLINT NOT NULL,
        -- <descr>Number of i-band science CCDs containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    zCov SMALLINT NOT NULL,
        -- <descr>Number of z-band science CCDs containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    yCov SMALLINT NOT NULL,
        -- <descr>Number of y-band science CCDs containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    PRIMARY KEY (refObjectId),
    KEY IDX_decl (decl ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE sdqa_ImageStatus
    -- <descr>Unique set of status names and their definitions, e.g.
    -- &quot;passed&quot;, &quot;failed&quot;, etc.</descr>
(
    sdqa_imageStatusId SMALLINT NOT NULL AUTO_INCREMENT,
        -- <descr>Primary key.</descr>
    statusName VARCHAR(30) NOT NULL,
        -- <descr>One-word, camel-case, descriptive name of a possible image
        -- status (e.g., passedAuto, marginallyPassedManual, etc.)</descr>
    definition VARCHAR(255) NOT NULL,
        -- <descr>Detailed Definition of the image status.</descr>
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
    KEY (sdqa_metricId),
    KEY (sdqa_thresholdId),
    KEY (ccdExposureId)
) ENGINE=MyISAM;


CREATE TABLE sdqa_Rating_ForScienceAmpExposure
    -- <descr>Various SDQA ratings for a post-ISR amplifier of a single snap of a ScienceCcdExposure.</descr>
(
    sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Primary key. Auto-increment is used, we define a composite
        -- unique key, so potential duplicates will be captured.</descr>
    sdqa_metricId SMALLINT NOT NULL,
        -- <descr>Pointer to sdqa_Metric.</descr>
    sdqa_thresholdId SMALLINT NOT NULL,
        -- <descr>Pointer to sdqa_Threshold.</descr>
    ampExposureId BIGINT NOT NULL,
        -- <descr>Pointer to Raw_Amp_Exposure.</descr>
    metricValue DOUBLE NOT NULL,
        -- <descr>Value of this SDQA metric.</descr>
    metricSigma DOUBLE NOT NULL,
        -- <descr>Uncertainty of the value of this metric.</descr>
    PRIMARY KEY (sdqa_ratingId),
    KEY UQ_sdqa_Rating_ForScienceAmpExposure_metricId_ampExposureId (sdqa_metricId ASC, ampExposureId ASC),
    KEY sdqa_metricId (sdqa_metricId ASC),
    KEY sdqa_thresholdId (sdqa_thresholdId ASC),
    KEY ampExposureId (ampExposureId ASC)
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
    KEY (sdqa_metricId)
) ENGINE=MyISAM;


CREATE TABLE Raw_Amp_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    visit INTEGER NOT NULL,
        -- <descr>Visit id from Visit table this exposure belongs to.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    snap TINYINT NOT NULL,
        -- <descr>Snap id this exposure belongs to.</descr>
        -- <ucd>meta.code.multip;obs.sequence</ucd>
    raft TINYINT NOT NULL,
        -- <descr>Raft id from RaftTable this exposure belongs to.</descr>
        -- <ucd>meta.id</ucd>
    raftName CHAR(3) NOT NULL,
        -- <descr>Raft name, pulled in from the RaftMap table.</descr>
        -- <ucd>inst.det</ucd>
    ccd TINYINT NOT NULL,
        -- <descr>ccd id from CcdMap table this exposure belongs to.</descr>
        -- <ucd>meta.id</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Ccd name, pulled in from the CcdMap table.</descr>
        -- <ucd>inst.det</ucd>
    amp TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the AmpMap table.</descr>
        -- <ucd>meta.id</ucd>
    ampName CHAR(3) NOT NULL,
        -- <descr>Amp name, pulled in from the AmpMap table.</descr>
        -- <ucd>inst.det</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>Id of the filter used for this exposure.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName CHAR(3) NOT NULL,
        -- <descr>Filter name, pulled in from the Filter table.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of amp center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of amp center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    equinox FLOAT NOT NULL,
        -- <ucd>pos.equinox</ucd>
    raDeSys VARCHAR(20) NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
    ctype1 VARCHAR(20) NOT NULL,
        -- <ucd>pos.wcs.ctype</ucd>
    ctype2 VARCHAR(20) NOT NULL,
        -- <ucd>pos.wcs.ctype</ucd>
    crpix1 FLOAT NOT NULL,
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crpix2 FLOAT NOT NULL,
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crval1 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.crvar</ucd>
        -- <unit>degree</unit>
    crval2 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.crvar</ucd>
        -- <unit>degree</unit>
    cd1_1 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
    cd1_2 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
    cd2_1 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
    cd2_2 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
    llcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
    llcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    ulcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    ulcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    urcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    urcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    lrcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    lrcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    taiMjd DOUBLE NOT NULL,
        -- <ucd>time.start</ucd>
        -- <unit>day</unit>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <ucd>time.start</ucd>
    expMidpt VARCHAR(30) NOT NULL,
        -- <ucd>time.epoch</ucd>
    expTime FLOAT NOT NULL,
        -- <ucd>time.duration</ucd>
        -- <unit>sec</unit>
    airmass FLOAT NOT NULL,
        -- <ucd>obs.airmass</ucd>
    darkTime FLOAT NOT NULL,
        -- <ucd>time.duration</ucd>
        -- <unit>sec</unit>
    zd FLOAT NULL,
        -- <ucd>pos.az.zd</ucd>
        -- <unit>deg</unit>
    poly BINARY(120) NOT NULL,
        -- <descr>binary representation of the 4-corner polygon for the amp.</descr>
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
        -- <descr>Meaning of the bits:
        --  <ul>
        --    <li>0x1: rawAmp</li>
        --    <li>0x2: postIsrAmp</li>
        --    <li>more tbd.</li>
        --  </ul></descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (rawAmpExposureId, metadataKey),
    KEY IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;


CREATE TABLE Raw_Amp_To_Science_Ccd_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to the Science_Ccd_Exposure.</descr>
    snap TINYINT NOT NULL,
        -- <ucd>meta.code.multip;obs.sequence</ucd>
    amp TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the AmpMap table.</descr>
    PRIMARY KEY (rawAmpExposureId),
    KEY scienceCcdExposureId (scienceCcdExposureId ASC)
) ENGINE=MyISAM;


CREATE TABLE Raw_Amp_To_Snap_Ccd_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
    amp TINYINT NOT NULL,
    snapCcdExposureId BIGINT NOT NULL,
    PRIMARY KEY (rawAmpExposureId),
    KEY snapCcdExposureId (snapCcdExposureId ASC)
) ENGINE=MyISAM;


CREATE TABLE Raw_Amp_Exposure_To_Htm11
    -- <descr>Stores a mapping between raw amplifier exposures and the IDs of 
    -- spatially overlapping level-11 HTM triangles.</descr>
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <descr>Pointer to Raw_Amp_Exposure.</descr>
    htmId11 INTEGER NOT NULL,
        -- <descr>ID for Level 11 HTM triangle overlapping raw amp exposure.
        -- For each amp exposure, there will be one row for every overlapping
        -- triangle.</descr>
    PRIMARY KEY (htmId11, rawAmpExposureId),
    KEY IDX_rawAmpExposureId (rawAmpExposureId ASC)
) ENGINE=MyISAM;


CREATE TABLE Science_Ccd_Exposure
(
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    visit INTEGER NOT NULL,
        -- <descr>Reference to the corresponding entry in the Visit table.</descr>
        -- <ucd>obs.exposure</ucd>
    raft TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the RaftMap table.</descr>
        -- <ucd>meta.id</ucd>
    raftName CHAR(3) NOT NULL,
        -- <descr>Raft name, pulled in from the RaftMap table.</descr>
        -- <ucd>inst.det</ucd>
    ccd TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the CcdMap table.</descr>
        -- <ucd>meta.id</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Ccd name, pulled in from the CcdMap table.</descr>
        -- <ucd>inst.det</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>Id of the filter used for this exposure.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName CHAR(3) NOT NULL,
        -- <descr>Filter name, pulled in from the Filter table.</descr>
        -- <ucd>instr.bandpass</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of CCD center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of CCD center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    equinox FLOAT NOT NULL,
        -- <descr>Equinox of World Coordinate System.</descr>
        -- <ucd>pos.equinox</ucd>
    raDeSys VARCHAR(20) NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
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
        -- <ucd>pos.wcs.crvar</ucd>
        -- <unit>degree</unit>
    crval2 DOUBLE NOT NULL,
        -- <descr>Coordinate value 2 @reference pixel.</descr>
        -- <ucd>pos.wcs.crvar</ucd>
        -- <unit>degree</unit>
    cd1_1 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 1.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
    cd1_2 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 1 w.r.t. axis 2.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
    cd2_1 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 1.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
    cd2_2 DOUBLE NOT NULL,
        -- <descr>First derivative of coordinate 2 w.r.t. axis 2.</descr>
        -- <ucd>pos.wcs.cdmatrix</ucd>
    llcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
    llcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    ulcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    ulcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    urcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    urcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    lrcRa DOUBLE NOT NULL,
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    lrcDecl DOUBLE NOT NULL,
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    taiMjd DOUBLE NOT NULL,
        -- <descr>Date of the start of the exposure.</descr>
        -- <ucd>time.start</ucd>
        -- <unit>day</unit>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <ucd>time.start</ucd>
    expMidpt VARCHAR(30) NOT NULL,
        -- <ucd>time.epoch</ucd>
    expTime FLOAT NOT NULL,
        -- <descr>Duration of exposure.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>sec</unit>
    nCombine INTEGER NOT NULL,
        -- <descr>Number of images co-added to create a deeper image.</descr>
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
        -- <ucd>inst.det.noise</ucd>
        -- <unit>adu</unit>
    saturationLimit INTEGER NOT NULL,
        -- <descr>Saturation limit for the ccd (average of the amplifiers).
        -- </descr>
        -- <ucd>inst.saturation</ucd>
        -- <ucd>arith.factor;inst.det</ucd>
        -- <unit>electron/adu</unit>
    gainEff DOUBLE NOT NULL,
        -- <ucd>arith.factor;inst.det</ucd>
        -- <unit>electron/adu</unit>
    fluxMag0 FLOAT NOT NULL,
        -- <ucd>phot.flux.density</ucd>
    fluxMag0Sigma FLOAT NOT NULL,
        -- <ucd>stat.error;phot.flux.density</ucd>
    fwhm DOUBLE NOT NULL,
        -- <ucd>instr.obsty.seeing</ucd>
        -- <unit>arcsec</unit>
    poly BINARY(120) NOT NULL,
        -- <descr>Binary representation of the 4-corner polygon for the ccd.
        -- </descr>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <descr>Flags, meaning of the bits:
        -- <ul>
        --   <li>0x01 PROCESSING_FAILED: The pipeline failed to process this 
        --       CCD</li>
	--   <li>0x02 BAD_PSF_ZEROPOINT: The PSF flux zero-point appears to 
        --       be bad</li>
	--   <li>0x04 BAD_PSF_SCATTER: The PSF flux for stars shows excess 
        --       scatter</li>
        -- </ul></descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY (scienceCcdExposureId)
) ENGINE=MyISAM;


CREATE TABLE Science_Ccd_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Science_Ccd_Exposure.</descr>
(
    scienceCcdExposureId BIGINT NOT NULL,
    metadataKey VARCHAR(255) NOT NULL,
    exposureType TINYINT NOT NULL,
        -- <descr>Meaning of the bits:
        --  <ul>
        --    <li>0x1: scienceCcd</li>
        --    <li>0x2: diffCcd</li>
        --    <li>more tbd.</li>
        --  </ul></descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (scienceCcdExposureId, metadataKey),
    KEY IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;


CREATE TABLE Snap_Ccd_To_Science_Ccd_Exposure
(
    snapCcdExposureId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    snap TINYINT NOT NULL,
        -- <ucd>meta.code.multip;obs.sequence</ucd>
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the Science_Ccd_Exposure table.</descr>
    PRIMARY KEY (snapCcdExposureId),
    KEY scienceCcdExposureId (scienceCcdExposureId ASC)
) ENGINE=MyISAM;


CREATE TABLE Science_Ccd_Exposure_To_Htm10
    -- <descr>Stores a mapping between science CCD exposures and the IDs of 
    -- spatially overlapping level-10 HTM triangles.</descr>
(
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to Science_Ccd_Exposure.</descr>
    htmId10 INTEGER NOT NULL,
        -- <descr>ID for Level 10 HTM triangle overlapping science CCD exposure.
        -- For each CCD exposure, there will be one row for every overlapping
        -- triangle.</descr>
    PRIMARY KEY (htmId10, scienceCcdExposureId),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId ASC)
) ENGINE=MyISAM;


CREATE TABLE Visit
    -- <descr>Defines a single Visit. 1 row per LSST visit.</descr>
(
    visitId INTEGER NOT NULL,
        -- <descr>Unique identifier.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    PRIMARY KEY (visitId)
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
        -- <descr>Unique object id.</descr>
        -- <ucd>meta.id;src</ucd>
    iauId CHAR(34) NULL,
        -- <descr>Not set for PT1.2. IAU compliant name for the object. Example:
        -- &quot;LSST-DR11 J001234.65-123456.18 GAL&quot;. The last 3 characters
        -- identify classification. Note that it will not accommodate multiple
        -- classifications.</descr>
    ra_PS DOUBLE NOT NULL,
        -- <descr>RA of mean source cluster position. Computed from the
        -- normalized sum of the unit vector positions of all sources belonging
        -- to an object, where unit vectors are computed from the Source ra
        -- and decl column values. For sources that are close together this is
        -- equivalent to minimizing the sum of the square angular separations
        -- between the source positions and the object position.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    ra_PS_Sigma FLOAT NULL,
        -- <descr>Uncertainty of ra_PS (standard deviation).</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>degree</unit>
    decl_PS DOUBLE NOT NULL,
        -- <descr>Dec of mean source cluster position. Computed from the
        -- normalized sum of the unit vector positions of all sources belonging
        -- to an object, where unit vectors are computed from the Source ra
        -- and decl column  values. For sources that are close together this is
        -- equivalent to minimizing the sum of the square angular separations
        -- between the source positions and the object position.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    decl_PS_Sigma FLOAT NULL,
        -- <descr>Uncertainty of decl_PS (standard deviation).</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>degree</unit>
    radecl_PS_Cov FLOAT NULL,
        -- <descr>Covariance of ra_PS and decl_PS.</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>deg^2</unit>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra_PS, decl_PS)</descr>
    ra_SG DOUBLE NULL,
        -- <descr>Inverse variance weighted mean source cluster position RA.
        -- This position is computed using the same source positions (Source
        -- ra and decl column values) as ra_PS, decl_PS.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    ra_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of ra_SG (standard deviation).</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>degree</unit>
    decl_SG DOUBLE NULL,
        -- <descr>Inverse variance weighted mean source cluster position Dec.
        -- This position is computed using the same source positions (Source
        -- ra and decl column values) as ra_PS, decl_PS.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    decl_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of decl_SG (standard deviation).</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>degree</unit>
    radecl_SG_Cov FLOAT NULL,
        -- <descr>Covariance of ra_SG and decl_SG.</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>deg^2</unit>
    raRange FLOAT NULL,
        -- <descr>Not set for PT1.2. Width in RA of the bounding box on the sky
        -- that fully encloses the footprint of this object for the canonical
        -- model (Small Galaxy) and canonical filter.</descr>
        -- <unit>degree</unit>
    declRange FLOAT NULL,
        -- <descr>Not set for PT1.2. Height in Dec of the bounding box on the
        -- sky that fully encloses the footprint of this object in the canonical
        -- model (Small Galaxy) and canonical filter.</descr>
        -- <unit>degree</unit>
    muRa_PS DOUBLE NULL,
        -- <descr>Not set for PT1.2. Proper motion (ra) for the Point Source
        -- model.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>degree/year</unit>
    muRa_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of muRa_PS.</descr>
        -- <ucd>stat.error;pos.pm</ucd>
        -- <unit>degree/year</unit>
    muDecl_PS DOUBLE NULL,
        -- <descr>Not set for PT1.2. Proper motion (decl) for the Point Source
        -- model.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>degree/year</unit>
    muDecl_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of muDecl_PS.</descr>
        -- <ucd>stat.error;pos.pm</ucd>
        -- <unit>degree/year</unit>
    muRaDecl_PS_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of muRa_PS and muDecl_PS.
        -- </descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>(degree/year)^2</unit>
    parallax_PS DOUBLE NULL,
        -- <descr>Not set for PT1.2. Parallax for Point Source model.</descr>
        -- <ucd>pos.parallax</ucd>
        -- <unit>degree/year</unit>
    parallax_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of parallax_PS.</descr>
        -- <ucd>stat.error;pos.parallax</ucd>
        -- <unit>degree/year</unit>
    canonicalFilterId TINYINT NULL,
        -- <descr>Not set for PT1.2. Id of the filter which is the canonical
        -- filter for size, ellipticity and Sersic index parameters.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    extendedness SMALLINT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is an extended
        -- object. Valid range: 0-10,000 (divide by 100 to get the actual
        -- probability in the range 0-100% with 2 digit precision).</descr>
    varProb FLOAT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is variable.
        -- Valid range: 0-1, where 1 indicates a variable object with 100%
        -- probability.</descr>
    earliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time
        -- (taiMidPoint of the first Source).</descr>
        -- <ucd>time.start</ucd>
        -- <unit>TAI</unit>
    latestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed (taiMidPoint of
        -- the last Source).</descr>
        -- <ucd>time.end</ucd>
        -- <unit>TAI</unit>
    meanObsTime DOUBLE NULL,
        -- <descr>The mean of the observation times (taiMidPoint) of the
        -- sources associated with this object.</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>day</unit>
    flags INTEGER NULL,
        -- <descr>Always 0 in PT1.2.</descr>
        -- <ucd>meta.code</ucd>
    uNumObs INTEGER NULL,
        -- <descr>Number of u-band sources associated with this object.</descr>
    uExtendedness SMALLINT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is an extended
        -- object for u filter. Valid range: 0-10,000 (divide by 100 to get the 
        -- actual probability in the range 0-100% with 2 digit precision).
        -- </descr>
    uVarProb FLOAT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is variable
        -- for u filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    uRaOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of ra_PS for u filter.
        -- </descr>
    uRaOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of uRaOffset_PS.</descr>
    uDeclOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_PS for u filter.
        -- </descr>
    uDeclOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of uDeclOffset_PS.</descr>
    uRaDeclOffset_PS_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of uRaOffset_PS and
        -- uDeclOffset_PS.</descr>
    uRaOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of raOffset_SG for u
        -- filter.</descr>
    uRaOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of uRaOffset_SG.</descr>
    uDeclOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_SG for u filter.
        -- </descr>
    uDeclOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of uDeclOffset_SG.</descr>
    uRaDeclOffset_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of uRaOffset_SG and
        -- uDeclOffset_SG.</descr>
    uLnL_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Point Source for
        -- u filter.</descr>
    uLnL_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Small Galaxy for
        -- u filter.</descr>
    uFlux_PS FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of u-band sources
        -- belonging to this object.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uFlux_PS_Sigma FLOAT NULL,
        -- <descr>Uncertainty of uFlux_PS (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uFlux_ESG FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of u-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an Experimental Small Galaxy model.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    uFlux_ESG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of uFlux_ESG (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    uFlux_Gaussian FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of u-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an elliptical Gaussian model.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uFlux_Gaussian_Sigma FLOAT NULL,
        -- <descr>Uncertainty of uFlux_Gaussian (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uTimescale FLOAT NULL,
        -- <descr>Not set for PT1.2. Characteristic timescale of flux variations
        -- for u filter.</descr>
        -- <unit>day</unit>
    uEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- u filter.</descr>
        -- <unit>mjd</unit>
    uLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in u
        -- filter.</descr>
        -- <ucd>time.end</ucd>
        -- <unit>mjd</unit>
    uSersicN_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Sersic index for Small Galaxy model for u
        -- filter.</descr>
    uSersicN_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of uSersicN_SG.</descr>
    uE1_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean u-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    uE1_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of uE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uE2_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean u-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    uE2_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of uE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uRadius_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean u-band radius of source
        -- cluster. Radii are derived from source adaptive second moments
        -- (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    uRadius_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of uRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    uFlux_PS_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute uFlux_PS.</descr>
    uFlux_ESG_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute uFlux_ESG.</descr>
    uFlux_Gaussian_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute uFlux_Gaussian.</descr>
    uEllipticity_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute uE1_SG, uE2_SG, and uRadius_SG.</descr>
    uFlags INTEGER NULL,
        -- <descr>Not set for PT1.2.</descr>
    gNumObs INTEGER NULL,
        -- <descr>Number of g-band sources associated with this object.</descr>
    gExtendedness SMALLINT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is an extended
        -- object for g filter. Valid range: 0-10,000 (divide by 100 to get the 
        -- actual probability in the range 0-100% with 2 digit precision).
        -- </descr>
    gVarProb FLOAT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is variable
        -- for g filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    gRaOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of ra_PS for g filter.
        -- </descr>
    gRaOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of gRaOffset_PS.</descr>
    gDeclOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_PS for g filter.
        -- </descr>
    gDeclOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of gDeclOffset_PS.</descr>
    gRaDeclOffset_PS_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of gRaOffset_PS and
        -- gDeclOffset_PS.</descr>
    gRaOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of raOffset_SG for g
        -- filter.</descr>
    gRaOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of gRaOffset_SG.</descr>
    gDeclOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_SG for g filter.
        -- </descr>
    gDeclOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of gDeclOffset_SG.</descr>
    gRaDeclOffset_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of gRaOffset_SG and
        -- gDeclOffset_SG.</descr>
    gLnL_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Point Source for
        -- g filter.</descr>
    gLnL_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Small Galaxy for
        -- g filter.</descr>
    gFlux_PS FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of g-band sources
        -- belonging to this object.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gFlux_PS_Sigma FLOAT NULL,
        -- <descr>Uncertainty of gFlux_PS (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gFlux_ESG FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of g-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an Experimental Small Galaxy model.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    gFlux_ESG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of gFlux_ESG (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    gFlux_Gaussian FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of g-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an elliptical Gaussian model.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gFlux_Gaussian_Sigma FLOAT NULL,
        -- <descr>Uncertainty of gFlux_Gaussian (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gTimescale FLOAT NULL,
        -- <descr>Not set for PT1.2. Characteristic timescale of flux variations
        -- for g filter.</descr>
        -- <unit>day</unit>
    gEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- g filter.</descr>
        -- <unit>mjd</unit>
    gLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in g
        -- filter.</descr>
        -- <ucd>time.end</ucd>
        -- <unit>mjd</unit>
    gSersicN_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Sersic index for Small Galaxy model for g
        -- filter.</descr>
    gSersicN_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of gSersicN_SG.</descr>
    gE1_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean g-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    gE1_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of gE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    gE2_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean g-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    gE2_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of gE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    gRadius_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean g-band radius of source
        -- cluster. Radii are derived from source adaptive second moments
        -- (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    gRadius_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of gRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    gFlux_PS_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute gFlux_PS.</descr>
    gFlux_ESG_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute gFlux_ESG.</descr>
    gFlux_Gaussian_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute gFlux_Gaussian.</descr>
    gEllipticity_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute gE1_SG, gE2_SG, and gRadius_SG.</descr>
    gFlags INTEGER NULL,
        -- <descr>Not set for PT1.2.</descr>
    rNumObs INTEGER NULL,
        -- <descr>Number of r-band sources associated with this object.</descr>
    rExtendedness SMALLINT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is an extended
        -- object for r filter. Valid range: 0-10,000 (divide by 100 to get the 
        -- actual probability in the range 0-100% with 2 digit precision).
        -- </descr>
    rVarProb FLOAT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is variable
        -- for r filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    rRaOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of ra_PS for r filter.
        -- </descr>
    rRaOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of rRaOffset_PS.</descr>
    rDeclOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_PS for r filter.
        -- </descr>
    rDeclOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of rDeclOffset_PS.</descr>
    rRaDeclOffset_PS_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of rRaOffset_PS and
        -- rDeclOffset_PS.</descr>
    rRaOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of raOffset_SG for r
        -- filter.</descr>
    rRaOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of rRaOffset_SG.</descr>
    rDeclOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_SG for r filter.
        -- </descr>
    rDeclOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of rDeclOffset_SG.</descr>
    rRaDeclOffset_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of rRaOffset_SG and
        -- rDeclOffset_SG.</descr>
    rLnL_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Point Source for
        -- r filter.</descr>
    rLnL_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Small Galaxy for
        -- r filter.</descr>
    rFlux_PS FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of r-band sources
        -- belonging to this object.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rFlux_PS_Sigma FLOAT NULL,
        -- <descr>Uncertainty of rFlux_PS (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rFlux_ESG FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of r-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an Experimental Small Galaxy model.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    rFlux_ESG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of rFlux_ESG (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    rFlux_Gaussian FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of r-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an elliptical Gaussian model.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rFlux_Gaussian_Sigma FLOAT NULL,
        -- <descr>Uncertainty of rFlux_Gaussian (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rTimescale FLOAT NULL,
        -- <descr>Not set for PT1.2. Characteristic timescale of flux variations
        -- for r filter.</descr>
        -- <unit>day</unit>
    rEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- r filter.</descr>
        -- <unit>mjd</unit>
    rLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in r
        -- filter.</descr>
        -- <ucd>time.end</ucd>
        -- <unit>mjd</unit>
    rSersicN_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Sersic index for Small Galaxy model for r
        -- filter.</descr>
    rSersicN_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of rSersicN_SG.</descr>
    rE1_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean r-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    rE1_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of rE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    rE2_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean r-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    rE2_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of rE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    rRadius_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean r-band radius of source
        -- cluster. Radii are derived from source adaptive second moments
        -- (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    rRadius_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of rRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    rFlux_PS_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute rFlux_PS.</descr>
    rFlux_ESG_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute rFlux_ESG.</descr>
    rFlux_Gaussian_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute rFlux_Gaussian.</descr>
    rEllipticity_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute rE1_SG, rE2_SG, and rRadius_SG.</descr>
    rFlags INTEGER NULL,
        -- <descr>Not set for PT1.2.</descr>
    iNumObs INTEGER NULL,
        -- <descr>Number of i-band sources associated with this object.</descr>
    iExtendedness SMALLINT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is an extended
        -- object for i filter. Valid range: 0-10,000 (divide by 100 to get the 
        -- actual probability in the range 0-100% with 2 digit precision).
        -- </descr>
    iVarProb FLOAT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is variable
        -- for i filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    iRaOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of ra_PS for i filter.
        -- </descr>
    iRaOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of iRaOffset_PS.</descr>
    iDeclOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_PS for i filter.
        -- </descr>
    iDeclOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of iDeclOffset_PS.</descr>
    iRaDeclOffset_PS_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of iRaOffset_PS and
        -- iDeclOffset_PS.</descr>
    iRaOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of raOffset_SG for i
        -- filter.</descr>
    iRaOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of iRaOffset_SG.</descr>
    iDeclOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_SG for i filter.
        -- </descr>
    iDeclOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of iDeclOffset_SG.</descr>
    iRaDeclOffset_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of iRaOffset_SG and
        -- iDeclOffset_SG.</descr>
    iLnL_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Point Source for
        -- i filter.</descr>
    iLnL_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Small Galaxy for
        -- i filter.</descr>
    iFlux_PS FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of i-band sources
        -- belonging to this object.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iFlux_PS_Sigma FLOAT NULL,
        -- <descr>Uncertainty of iFlux_PS (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iFlux_ESG FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of i-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an Experimental Small Galaxy model.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    iFlux_ESG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of iFlux_ESG (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    iFlux_Gaussian FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of i-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an elliptical Gaussian model.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iFlux_Gaussian_Sigma FLOAT NULL,
        -- <descr>Uncertainty of iFlux_Gaussian (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iTimescale FLOAT NULL,
        -- <descr>Not set for PT1.2. Characteristic timescale of flux variations
        -- for i filter.</descr>
        -- <unit>day</unit>
    iEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- i filter.</descr>
        -- <unit>mjd</unit>
    iLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in i
        -- filter.</descr>
        -- <ucd>time.end</ucd>
        -- <unit>mjd</unit>
    iSersicN_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Sersic index for Small Galaxy model for i
        -- filter.</descr>
    iSersicN_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of iSersicN_SG.</descr>
    iE1_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean i-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    iE1_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of iE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    iE2_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean i-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    iE2_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of iE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    iRadius_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean i-band radius of source
        -- cluster. Radii are derived from source adaptive second moments
        -- (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    iRadius_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of iRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    iFlux_PS_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute iFlux_PS.</descr>
    iFlux_ESG_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute iFlux_ESG.</descr>
    iFlux_Gaussian_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute iFlux_Gaussian.</descr>
    iEllipticity_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute iE1_SG, iE2_SG, and iRadius_SG.</descr>
    iFlags INTEGER NULL,
        -- <descr>Not set for PT1.2.</descr>
    zNumObs INTEGER NULL,
        -- <descr>Number of z-band sources associated with this object.</descr>
    zExtendedness SMALLINT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is an extended
        -- object for z filter. Valid range: 0-10,000 (divide by 100 to get the 
        -- actual probability in the range 0-100% with 2 digit precision).
        -- </descr>
    zVarProb FLOAT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is variable
        -- for z filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    zRaOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of ra_PS for z filter.
        -- </descr>
    zRaOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of zRaOffset_PS.</descr>
    zDeclOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_PS for z filter.
        -- </descr>
    zDeclOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of zDeclOffset_PS.</descr>
    zRaDeclOffset_PS_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of zRaOffset_PS and
        -- zDeclOffset_PS.</descr>
    zRaOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of raOffset_SG for z
        -- filter.</descr>
    zRaOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of zRaOffset_SG.</descr>
    zDeclOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_SG for z filter.
        -- </descr>
    zDeclOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of zDeclOffset_SG.</descr>
    zRaDeclOffset_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of zRaOffset_SG and
        -- zDeclOffset_SG.</descr>
    zLnL_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Point Source for
        -- z filter.</descr>
    zLnL_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Small Galaxy for
        -- z filter.</descr>
    zFlux_PS FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of z-band sources
        -- belonging to this object.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zFlux_PS_Sigma FLOAT NULL,
        -- <descr>Uncertainty of zFlux_PS (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zFlux_ESG FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of z-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an Experimental Small Galaxy model.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    zFlux_ESG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of zFlux_ESG (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    zFlux_Gaussian FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of z-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an elliptical Gaussian model.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zFlux_Gaussian_Sigma FLOAT NULL,
        -- <descr>Uncertainty of zFlux_Gaussian (standard deviation).</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zTimescale FLOAT NULL,
        -- <descr>Not set for PT1.2. Characteristic timescale of flux variations
        -- for z filter.</descr>
        -- <unit>day</unit>
    zEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- z filter.</descr>
        -- <unit>mjd</unit>
    zLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in z
        -- filter.</descr>
        -- <ucd>time.end</ucd>
        -- <unit>mjd</unit>
    zSersicN_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Sersic index for Small Galaxy model for z
        -- filter.</descr>
    zSersicN_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of zSersicN_SG.</descr>
    zE1_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean z-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    zE1_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of zE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    zE2_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean z-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    zE2_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of zE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    zRadius_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean z-band radius of source
        -- cluster. Radii are derived from source adaptive second moments
        -- (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    zRadius_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of zRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    zFlux_PS_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute zFlux_PS.</descr>
    zFlux_ESG_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute zFlux_ESG.</descr>
    zFlux_Gaussian_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute zFlux_Gaussian.</descr>
    zEllipticity_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute zE1_SG, zE2_SG, and zRadius_SG.</descr>
    zFlags INTEGER NULL,
        -- <descr>Not set for PT1.2.</descr>
    yNumObs INTEGER NULL,
        -- <descr>Number of y-band sources associated with this object.</descr>
    yExtendedness SMALLINT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is an extended
        -- object for y filter. Valid range: 0-10,000 (divide by 100 to get the 
        -- actual probability in the range 0-100% with 2 digit precision).
        -- </descr>
    yVarProb FLOAT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is variable
        -- for y filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    yRaOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of ra_PS for y filter.
        -- </descr>
    yRaOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of yRaOffset_PS.</descr>
    yDeclOffset_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_PS for y filter.
        -- </descr>
    yDeclOffset_PS_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of yDeclOffset_PS.</descr>
    yRaDeclOffset_PS_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of yRaOffset_PS and
        -- yDeclOffset_PS.</descr>
    yRaOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of raOffset_SG for y
        -- filter.</descr>
    yRaOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of yRaOffset_SG.</descr>
    yDeclOffset_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Center correction of decl_SG for y filter.
        -- </descr>
    yDeclOffset_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of yDeclOffset_SG.</descr>
    yRaDeclOffset_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of yRaOffset_SG and
        -- yDeclOffset_SG.</descr>
    yLnL_PS FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Point Source for
        -- y filter.</descr>
    yLnL_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Log-likelihood of being a Small Galaxy for
        -- y filter.</descr>
    yFlux_PS FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of y-band sources
        -- belonging to this object.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yFlux_PS_Sigma FLOAT NULL,
        -- <descr>Uncertainty of yFlux_PS (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yFlux_ESG FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of y-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an Experimental Small Galaxy model.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    yFlux_ESG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of yFlux_ESG (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    yFlux_Gaussian FLOAT NULL,
        -- <descr>Inverse variance weighted mean AB flux of y-band sources
        -- belonging to this object. Fluxes of individual sources estimated
        -- using an elliptical Gaussian model.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yFlux_Gaussian_Sigma FLOAT NULL,
        -- <descr>Uncertainty of yFlux_Gaussian (standard deviation).</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yTimescale FLOAT NULL,
        -- <descr>Not set for PT1.2. Characteristic timescale of flux variations
        -- for y filter.</descr>
        -- <unit>day</unit>
    yEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- y filter.</descr>
        -- <unit>mjd</unit>
    yLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in y
        -- filter.</descr>
        -- <ucd>time.end</ucd>
        -- <unit>mjd</unit>
    ySersicN_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Sersic index for Small Galaxy model for y
        -- filter.</descr>
    ySersicN_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of ySersicN_SG.</descr>
    yE1_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean y-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    yE1_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of yE1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    yE2_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean y-band ellipticity of source
        -- cluster in a tangent plane centered on (ra_PS, decl_PS) and with
        -- the standard N,E basis. Ellipticities are derived from source
        -- adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    yE2_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of yE2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    yRadius_SG FLOAT NULL,
        -- <descr>Inverse variance weighted mean y-band radius of source
        -- cluster. Radii are derived from source adaptive second moments
        -- (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    yRadius_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of yRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    yFlux_PS_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute yFlux_PS.</descr>
    yFlux_ESG_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute yFlux_ESG.</descr>
    yFlux_Gaussian_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute yFlux_Gaussian.</descr>
    yEllipticity_Num SMALLINT NULL,
        -- <descr>Number of sources used to compute yE1_SG, yE2_SG, and yRadius_SG.</descr>
    yFlags INTEGER NULL,
        -- <descr>Not set for PT1.2.</descr>
    chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    subChunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (objectId),
    KEY IDX_decl (decl_PS ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE Source
(
    sourceId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier)</descr>
        -- <ucd>meta.id;src</ucd>
    scienceCcdExposureId BIGINT NULL,
        -- <descr>Identifier for the CCD the source was detected/measured on
        -- (pointer to Science_Ccd_Exposure).</descr>
        -- <ucd>meta.id;src</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>Id of the filter used for this source.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    objectId BIGINT NULL,
        -- <descr>The object this source was assigned to. NULL if the PT1.2
        -- clustering algorithm generated a single-source object for this
        -- source.</descr>
        -- <ucd>meta.id;src</ucd>
    movingObjectId BIGINT NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>meta.id;src</ucd>
    procHistoryId INTEGER NOT NULL,
        -- <descr>Not set for PT1.2.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA of source centroid (equal to raAstrom).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    raSigmaForDetection FLOAT NULL,
        -- <descr>Component of ra uncertainty due to detection uncertainty
        -- (xAstromSigma, yAstromSigma).</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>degree</unit>
    raSigmaForWcs FLOAT NOT NULL,
        -- <descr>Not set for PT1.2. Component of ra uncertainty due to
        -- uncertainty in WCS solution.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Declination of source centroid (equal to declAstrom).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    declSigmaForDetection FLOAT NULL,
        -- <descr>Component of decl uncertainty due to detection uncertainty
        -- (xAstromSigma, yAstromSigma).</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>degree</unit>
    declSigmaForWcs FLOAT NOT NULL,
        -- <descr>Not set for PT1.2. Component of decl uncertainty due to
        -- uncertainty in WCS solution.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>degree</unit>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
    xFlux DOUBLE NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    xFluxSigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of xFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    yFlux DOUBLE NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    yFluxSigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of yFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    raFlux DOUBLE NULL,
        -- <descr>Not set for PT1.2. RA of (xFlux, yFlux).</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    raFluxSigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of raFlux.</descr>
        -- <ucd>stat.err;phot.count</ucd>
        -- <unit>adu</unit>
    declFlux DOUBLE NULL,
        -- <descr>Not set for PT1.2. Dec of (xFlux, yFlux).</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    declFluxSigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of declFlux.</descr>
        -- <ucd>stat.err;phot.count</ucd>
        -- <unit>adu</unit>
    xPeak DOUBLE NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <unit>pixel</unit>
    yPeak DOUBLE NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <unit>pixel</unit>
    raPeak DOUBLE NULL,
        -- <descr>Not set for PT1.2. RA of (xPeak, yPeak).</descr>
    declPeak DOUBLE NULL,
        -- <descr>Not set for PT1.2. Dec of (xPeak, yPeak).</descr>
    xAstrom DOUBLE NULL,
        -- <descr>Position (x) measured for purposes of astrometry.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    xAstromSigma FLOAT NULL,
        -- <descr>Uncertainty of xAstrom.</descr>
        -- <ucd>stat.error;pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    yAstrom DOUBLE NULL,
        -- <descr>Position (y) measured for purposes of astrometry.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    yAstromSigma FLOAT NULL,
        -- <descr>Uncertainty of yAstrom.</descr>
        -- <ucd>stat.error;pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    raAstrom DOUBLE NULL,
        -- <descr>RA of (xAstrom, yAstrom).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    raAstromSigma FLOAT NULL,
        -- <descr>Uncertainty of raAstrom.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>degree</unit>
    declAstrom DOUBLE NULL,
        -- <descr>Dec of (xAstrom, yAstrom).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    declAstromSigma FLOAT NULL,
        -- <descr>Uncertainty of declAstrom.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>degree</unit>
    raObject DOUBLE NULL,
        -- <descr>ra_PS of object associated with this source, or ra if the
        -- source was not associated with any object (objectId is NULL).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    declObject DOUBLE NULL,
        -- <descr>decl_PS of object associated with this source, or decl if the
        -- source was not associated with any object (objectId is NULL).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    taiMidPoint DOUBLE NOT NULL,
        -- <descr>Middle of exposure time (TAI).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>mjd</unit>
    taiRange FLOAT NULL,
        -- <descr>Exposure time.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>sec</unit>
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
    modelFlux DOUBLE NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    modelFluxSigma FLOAT NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    petroFlux DOUBLE NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    petroFluxSigma FLOAT NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    instFluxSigma FLOAT NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    nonGrayCorrFlux DOUBLE NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    nonGrayCorrFluxSigma FLOAT NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    atmCorrFlux DOUBLE NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    atmCorrFluxSigma FLOAT NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    apDia FLOAT NULL,
        -- <descr>Not set for PT1.2</descr>
    Ixx FLOAT NULL,
        -- <descr>Adaptive second moment.</descr>
    IxxSigma FLOAT NULL,
        -- <descr>Uncertainty of Ixx.</descr>
    Iyy FLOAT NULL,
        -- <descr>Adaptive second moment.</descr>
    IyySigma FLOAT NULL,
        -- <descr>Uncertainty of Iyy.</descr>
    Ixy FLOAT NULL,
        -- <descr>Adaptive second moment.</descr>
    IxySigma FLOAT NULL,
        -- <descr>Uncertainty of Ixy.</descr>
    psfIxx FLOAT NULL,
        -- <descr>PSF adaptive second moment.</descr>
    psfIxxSigma FLOAT NULL,
        -- <descr>ncertainty of psfIxx.</descr>
    psfIyy FLOAT NULL,
        -- <descr>PSF adaptive second moment.</descr>
    psfIyySigma FLOAT NULL,
        -- <descr>Uncertainty of psfIyy.</descr>
    psfIxy FLOAT NULL,
        -- <descr>PSF adaptive second moment.</descr>
    psfIxySigma FLOAT NULL,
        -- <descr>Uncertainty of psfIxy.</descr>
    e1_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Ellipticity for the Small Galaxy described
        -- through e1/e2.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    e1_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of e1_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    e2_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Ellipticity for the Small Galaxy described 
        -- through e1/e2.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    e2_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of e2_SG.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    resolution_SG FLOAT NULL,
        -- <descr>Diagnostic output of shape measurement for the Small Galaxy
        -- model. It represents how well resolved the measured source was 
        -- compared to the psf.  0 = unresolved, 1 = well resolved. 
        -- Effectively, it's: 1-(psfSize)/(psf-convolvedImageSize).</descr>
    shear1_SG FLOAT NULL,
        -- <descr>Ellipticity for the Small Galaxy model described through 
        -- shear1/shear2.</descr>
        -- <ucd>src.ellipticity</ucd>
    shear1_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of shear1_SG.</descr>
        -- <ucd>stat.error;src.ellipticity</ucd>
    shear2_SG FLOAT NULL,
        -- <descr>Ellipticity for the Small Galaxy model described through 
        -- shear1/shear2.</descr>
        -- <ucd>src.ellipticity</ucd>
    shear2_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of shear2_SG.</descr>
        -- <ucd>stat.error;src.ellipticity</ucd>
    sourceWidth_SG FLOAT NULL,
        -- <descr>The width of an un-psf-corrected source for the Small Galaxy
        -- model, calculated as: (Ixx*Iyy - Ixy^2)^(1/4).</descr>
        -- <ucd>phys.angSize</ucd>
        -- <unit>pixel</unit>
    sourceWidth_SG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of sourceWidth_SG.</descr>
        -- <ucd>stat.error;phys.angSize</ucd>
        -- <unit>pixel</unit>
    shapeFlag_SG SMALLINT NULL,
        -- <descr>Flag containing information about the shape-fitting for the
        -- Small Galaxy model. The meaning of the flag bits is to-be-decided.
        -- </descr>
        -- <ucd>meta.code</ucd>
    snr FLOAT NOT NULL,
        -- <descr>Not set for PT1.2.</descr>
    chi2 FLOAT NOT NULL,
        -- <descr>Not set for PT1.2.</descr>
    sky FLOAT NULL,
        -- <descr>Not set for PT1.2.</descr>
    skySigma FLOAT NULL,
        -- <descr>Not set for PT1.2.</descr>
    extendedness SMALLINT NULL,
        -- <descr>Not set for PT1.2. Probability that this object is an extended
        -- object. Valid range: 0-10,000 (divide by 100 to get the actual
        -- probability in the range 0-100% with 2 digit precision).</descr>
    flux_Gaussian DOUBLE NULL,
        -- <descr>Uncalibrated flux estimated using an elliptical Gaussian model.</descr>
        -- <ucd>photo.flux.density;em.opt</ucd>
        -- <unit>adu</unit>
    flux_Gaussian_Sigma FLOAT NULL,
        -- <descr>Uncertainty of flux_Gaussian.</descr>
        -- <ucd>stat.error;photo.flux.density;em.opt</ucd>
        -- <unit>adu</unit>
    flux_ESG DOUBLE NULL,
        -- <descr>Uncalibrated flux for Experimental Small Galaxy model.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>adu</unit>
    flux_ESG_Sigma FLOAT NULL,
        -- <descr>Uncertainty of flux_ESG.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>adu</unit>
    sersicN_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Sersic index for Small Galaxy model.
        -- </descr>
    sersicN_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of sersicN_SG.</descr>
    radius_SG FLOAT NULL,
        -- <descr>Not set for PT1.2. Size of Small Galaxy model.</descr>
    radius_SG_Sigma FLOAT NULL,
        -- <descr>Not set for PT1.2. Uncertainty of radius_SG.</descr>
    flux_flux_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of flux and flux for Small
        -- Galaxy model.</descr>
    flux_e1_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of flux and e1 for Small Galaxy
        -- model.</descr>
    flux_e2_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of flux and e2 for Small Galaxy
        -- model.</descr>
    flux_radius_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of flux and radius for Small
        -- Galaxy model.</descr>
    flux_sersicN_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of flux and sersicN for Small
        -- Galaxy model.</descr>
    e1_e1_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of e1 and e1 for Small Galaxy
        -- model.</descr>
    e1_e2_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of e1 and e2 for Small Galaxy
        -- model.</descr>
    e1_radius_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of e1 and radius for Small
        -- Galaxy model.</descr>
    e1_sersicN_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of e1 and sersicN for Small
        -- Galaxy model.</descr>
    e2_e2_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of e2 and e2 for Small Galaxy
        -- model.</descr>
    e2_radius_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of e2 and radius for Small
        -- Galaxy model.</descr>
    e2_sersicN_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of e2 and sersicN for Small
        -- Galaxy model.</descr>
    radius_radius_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of radius and radius for Small
        -- Galaxy model.</descr>
    radius_sersicN_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance of radius and sersicN for Small
        -- Galaxy model.</descr>
    sersicN_sersicN_SG_Cov FLOAT NULL,
        -- <descr>Not set for PT1.2. Covariance for sersicN and sersicN for
        -- Small Galaxy model.</descr>
    flagForAssociation SMALLINT NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>meta.code</ucd>
    flagForDetection BIGINT NULL,
        -- <descr>Bitwise-or of detection flags.
        -- <ul>
        --   <li>0x000001 EDGE: source is in region labelled EDGE.</li>
        --   <li>0x000002 SHAPE_SHIFT: centroid shifted while estimating 
        --       adaptive moments.</li>
        --   <li>0x000004 SHAPE_MAXITER: too many iterations for adaptive 
        --       moments.</li>
        --   <li>0x000008 SHAPE_UNWEIGHTED: &quot;adaptive&quot; moments are
        --       unweighted.</li>
        --   <li>0x000010 SHAPE_UNWEIGHTED_PSF: the PSF's &quot;adaptive&quot; 
        --       moments are unweighted.</li>
        --   <li>0x000020 SHAPE_UNWEIGHTED_BAD: even the unweighted moments were
        --       bad.</li>
        --   <li>0x000040 PEAKCENTER: given centre is position of peak pixel.
        --       </li>
        --   <li>0x000080 BINNED1: source was found in 1x1 binned image.</li>
        --   <li>0x000100 INTERP: source's footprint includes interpolated 
        --       pixels.</li>
        --   <li>0x000200 INTERP_CENTER: source's centre is close to 
        --       interpolated pixels.</li>
        --   <li>0x000400 SATUR: source's footprint includes saturated pixels.
        --       </li>
        --   <li>0x000800 SATUR_CENTER: source's centre is close to saturated 
        --       pixels.</li>
        --   <li>0x001000 DETECT_NEGATIVE: source was detected as being 
        --       significantly negative.</li>
        --   <li>0x002000 STAR: source is thought to be point-like.</li>
        --   <li>0x004000 NO_EXPOSURE</li>
        --   <li>0x008000 NO_PSF</li>
        --   <li>0x010000 NO_SOURCE</li>
        --   <li>0x020000 NO_BASIS</li>
        --   <li>0x040000 NO_FOOTPRINT</li>
        --   <li>0x080000 BAD_INITIAL_MOMENTS</li>
        --   <li>0x100000 OPTIMIZER_FAILED</li>
        --   <li>0x200000 GALAXY_MODEL_FAILED</li>
        --   <li>0x400000 UNSAFE_INVERSION</li>
        -- </ul></descr>
        -- <ucd>meta.code</ucd>
    flagForWcs SMALLINT NULL,
        -- <descr>Not set for PT1.2.</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY (sourceId),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId ASC),
    KEY IDX_filterId (filterId ASC),
    KEY IDX_movingObjectId (movingObjectId ASC),
    KEY IDX_objectId (objectId ASC),
    KEY IDX_procHistoryId (procHistoryId ASC),
    KEY IDX_decl (decl ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


SET FOREIGN_KEY_CHECKS=1;


ALTER TABLE RefObjMatch ADD CONSTRAINT FK_RefObjMatch_SimRefObject
    FOREIGN KEY (refObjectId) REFERENCES SimRefObject (refObjectId);

ALTER TABLE RefObjMatch ADD CONSTRAINT FK_RefObjMatch_Object
    FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE sdqa_Rating_ForScienceCcdExposure ADD CONSTRAINT FK_sdqaRatingForScienceCcdExposure_metricId
    FOREIGN KEY (sdqa_metricId) REFERENCES sdqa_Metric (sdqa_metricId);

ALTER TABLE sdqa_Rating_ForScienceCcdExposure ADD CONSTRAINT FK_sdqaRatingForScienceCcdExposure_thresholdId
    FOREIGN KEY (sdqa_thresholdId) REFERENCES sdqa_Threshold (sdqa_thresholdId);

ALTER TABLE sdqa_Rating_ForScienceCcdExposure ADD CONSTRAINT FK_sdqaRatingForScienceCcdExposure_ccdExposureId
    FOREIGN KEY (ccdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);

ALTER TABLE sdqa_Rating_ForScienceAmpExposure ADD CONSTRAINT FK_sdqaRatingForScienceAmpExposure_metricId
    FOREIGN KEY (sdqa_metricId) REFERENCES sdqa_Metric (sdqa_metricId);

ALTER TABLE sdqa_Rating_ForScienceAmpExposure ADD CONSTRAINT FK_sdqaRatingForScienceAmpExposure_thresholdId
    FOREIGN KEY (sdqa_thresholdId) REFERENCES sdqa_Threshold (sdqa_thresholdId);

ALTER TABLE sdqa_Rating_ForScienceAmpExposure ADD CONSTRAINT FK_sdqaRatingForScienceAmpExposure_ampExposureId
    FOREIGN KEY (ampExposureId) REFERENCES Raw_Amp_Exposure (rawAmpExposureId);

ALTER TABLE sdqa_Threshold ADD CONSTRAINT FK_sdqaThreshold_sdqaMetricId
    FOREIGN KEY (sdqa_metricId) REFERENCES sdqa_Metric (sdqa_metricId);

ALTER TABLE Raw_Amp_Exposure ADD CONSTRAINT FK_RawAmpExposure_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE Raw_Amp_Exposure ADD CONSTRAINT FK_RawAmpExposure_visit
    FOREIGN KEY (visit) REFERENCES Visit (visitId);

ALTER TABLE Raw_Amp_Exposure ADD CONSTRAINT FK_RawAmpExposure_raft
    FOREIGN KEY (raft) REFERENCES RaftMap (raftNum);

ALTER TABLE Raw_Amp_Exposure ADD CONSTRAINT FK_RawAmpExposure_ccd
    FOREIGN KEY (ccd) REFERENCES CcdMap (ccdNum);

ALTER TABLE Raw_Amp_Exposure ADD CONSTRAINT FK_RawAmpExposure_amp
    FOREIGN KEY (amp) REFERENCES AmpMap (ampNum);

ALTER TABLE Raw_Amp_Exposure ADD CONSTRAINT FK_RawAmpExposure_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE Raw_Amp_Exposure_Metadata ADD CONSTRAINT FK_RawAmpExposureMetadata_rawAmpExposureId
    FOREIGN KEY (rawAmpExposureId) REFERENCES Raw_Amp_Exposure (rawAmpExposureId);

ALTER TABLE Raw_Amp_Exposure_To_Htm11 ADD CONSTRAINT FK_RawAmpExposureToHtm11_rawAmpExposureId
    FOREIGN KEY (rawAmpExposureId) REFERENCES Raw_Amp_Exposure (rawAmpExposureId);

ALTER TABLE Raw_Amp_To_Science_Ccd_Exposure ADD CONSTRAINT FK_RawAmpToScienceExposure_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);

ALTER TABLE Raw_Amp_To_Science_Ccd_Exposure ADD CONSTRAINT FK_RawAmpToScienceExposure_amp
    FOREIGN KEY (amp) REFERENCES AmpMap (ampNum);

ALTER TABLE Science_Ccd_Exposure ADD CONSTRAINT FK_ScienceCcdExposure_visit
    FOREIGN KEY (visit) REFERENCES Visit (visitId);

ALTER TABLE Science_Ccd_Exposure ADD CONSTRAINT FK_ScienceCcdExposure_raft
    FOREIGN KEY (raft) REFERENCES RaftMap (raftNum);

ALTER TABLE Science_Ccd_Exposure ADD CONSTRAINT FK_ScienceCcdExposure_ccd
    FOREIGN KEY (ccd) REFERENCES CcdMap (ccdNum);

ALTER TABLE Science_Ccd_Exposure ADD CONSTRAINT FK_ScienceCcdExposure_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE Snap_Ccd_To_Science_Ccd_Exposure ADD CONSTRAINT FK_SnapCcdToScienceCcdExposure_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);

ALTER TABLE Science_Ccd_Exposure_To_Htm10 ADD CONSTRAINT FK_ScienceCcdExposureToHtm10_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);

ALTER TABLE Source ADD CONSTRAINT FK_Source_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);

ALTER TABLE Source ADD CONSTRAINT FK_Source_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE Source ADD CONSTRAINT FK_Source_objectId
    FOREIGN KEY (objectId) REFERENCES Object (objectId);

