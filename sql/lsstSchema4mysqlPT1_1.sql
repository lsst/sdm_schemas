
-- LSST Database Schema
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu/trac/wiki/Copyrights>
-- for copyright information.


CREATE TABLE AAA_Version_3_2_4 (version CHAR);

SET FOREIGN_KEY_CHECKS=0;



CREATE TABLE AmpMap
    -- <descr>Mapping table to translate amp names to numbers.</descr>
(
    ampNum TINYINT NOT NULL,
    ampName CHAR(3) NOT NULL,
    PRIMARY KEY (ampNum),
    UNIQUE UQ_AmpMap_ampName(ampName)
) ;


CREATE TABLE CcdMap
    -- <descr>Mapping table to translate ccd names to numbers.</descr>
(
    ccdNum TINYINT NOT NULL,
    ccdName CHAR(3) NOT NULL,
    PRIMARY KEY (ccdNum),
    UNIQUE UQ_CcdMap_ccdName(ccdName)
) ;


CREATE TABLE Filter
(
    filterId TINYINT NOT NULL,
    filterName CHAR(255) NOT NULL,
        -- <descr>Filter name. Valid values: 'u', 'g', 'r', 'i', 'z', 'y'.
        -- </descr>
    photClam FLOAT(0) NOT NULL,
        -- <descr>Filter centroid wavelength.</descr>
    photBW FLOAT(0) NOT NULL,
        -- <descr>System effective bandwidth.</descr>
    PRIMARY KEY (filterId)
) TYPE=MyISAM;


CREATE TABLE LeapSeconds
    -- <descr>Based on <a href='http://maia.usno.navy.mil/ser7/tai-utc.dat'>
    -- http://maia.usno.navy.mil/ser7/tai-utc.dat</a>.
    -- </descr>
(
    whenJd FLOAT(0) NOT NULL,
        -- <descr>JD of change in TAI-UTC difference (leap second).</descr>
    offset FLOAT(0) NOT NULL,
        -- <descr>New number of leap seconds.</descr>
    mjdRef FLOAT(0) NOT NULL,
        -- <descr>Reference MJD for drift (prior to 1972-Jan-1).</descr>
    drift FLOAT(0) NOT NULL,
        -- <descr>Drift in seconds per day (prior to 1972-Jan-1).</descr>
    whenMjdUtc FLOAT(0) NULL,
        -- <descr>MJD in UTC system of change (computed).</descr>
    whenUtc BIGINT NULL,
        -- <descr>Nanoseconds from epoch in UTC system of change (computed).
        -- </descr>
    whenTai BIGINT NULL
        -- <descr>Nanoseconds from epoch in TAI system of change (computed).
        -- </descr>
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
        -- <descr>Reference object id (pointer to SimRefObject). NULL if
        -- reference object has no matches.</descr>
    objectId BIGINT NULL,
        -- <descr>Object id. NULL if object has no matches.</descr>
    refRa DOUBLE NULL,
        -- <descr>ICRS reference object RA at mean epoch of sources assigned to
        -- object.</descr>
        -- <unit>deg</unit>
    refDec DOUBLE NULL,
        -- <descr>ICRS reference object Dec at mean epoch of sources assigned to
        -- object.</descr>
        -- <unit>deg</unit>
    angSep DOUBLE NULL,
        -- <descr>Angular separation between reference object and object.
        -- </descr>
        -- <unit>arcsec</unit>
    nRefMatches INTEGER NULL,
        -- <descr>Total number of matches for reference object.</descr>
    nObjMatches INTEGER NULL,
        -- <descr>Total number of matches for object.</descr>
    closestToRef TINYINT NULL,
        -- <descr>1 if object is the closest match for reference object, 0
        -- otherwise.</descr>
    closestToObj TINYINT NULL,
        -- <descr>1 if reference object is the closest match for object, 0
        -- otherwise.</descr>
    flags INTEGER NULL,
        -- <descr>Bitwise or of match flags.<ul><li>0x1: the reference object
        -- has proper motion.</li><li>0x2: the reference object has
        -- parallax.</li><li>0x4: a reduction for parallax from barycentric to
        -- geocentric place was applied prior to matching the reference
        -- object.</li></ul></descr>
    KEY (objectId),
    KEY (refObjectId)
) TYPE=MyISAM;


CREATE TABLE SimRefObject
(
    refObjectId BIGINT NOT NULL,
        -- <descr>Reference object id.</descr>
    isStar TINYINT NOT NULL,
        -- <descr>1 for stars, 0 for galaxies.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA, ICRS.</descr>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Dec, ICRS.</descr>
        -- <unit>deg</unit>
    gLat DOUBLE NULL,
        -- <descr>Galactic latitude. NULL for galaxies.</descr>
        -- <unit>deg</unit>
    gLon DOUBLE NULL,
        -- <descr>Galactic longitude, deg. NULL for galaxies.</descr>
        -- <unit>deg</unit>
    sedName CHAR(32) NULL,
        -- <descr>Best-fit SED name. NULL for galaxies.</descr>
    uMag DOUBLE NOT NULL,
        -- <descr>u band AB magnitude</descr>
    gMag DOUBLE NOT NULL,
        -- <descr>g band AB magnitude</descr>
    rMag DOUBLE NOT NULL,
        -- <descr>r band AB magnitude</descr>
    iMag DOUBLE NOT NULL,
        -- <descr>i band AB magnitude</descr>
    zMag DOUBLE NOT NULL,
        -- <descr>z band AB magnitude</descr>
    yMag DOUBLE NOT NULL,
        -- <descr>y band AB magnitude</descr>
    muRa DOUBLE NULL,
        -- <descr>dRA/dt*cos(decl). NULL for galaxies.</descr>
        -- <unit>milliarcsec/year</unit>
    muDecl DOUBLE NULL,
        -- <descr>dDec/dt. NULL for galaxies.</descr>
        -- <unit>milliarcsec/year</unit>
    parallax DOUBLE NULL,
        -- <descr>Stellar parallax. NULL for galaxies.</descr>
        -- <unit>milliarcsec</unit>
    vRad DOUBLE NULL,
        -- <descr>Radial velocity. NULL for galaxies.</descr>
        -- <unit>km/s</unit>
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
        -- <descr>Primary key.</descr>
    statusName VARCHAR(30) NOT NULL,
        -- <descr>One-word, camel-case, descriptive name of a possible image
        -- status (e.g., passedAuto, marginallyPassedManual, etc.)</descr>
    definition VARCHAR(255) NOT NULL,
        -- <descr>Detailed Definition of the image status.</descr>
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
    KEY (sdqa_metricId),
    KEY (sdqa_thresholdId),
    KEY (ampExposureId)
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
    KEY (sdqa_metricId),
    KEY (sdqa_thresholdId),
    KEY (ccdExposureId)
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
    KEY (sdqa_metricId)
) TYPE=MyISAM;


CREATE TABLE Raw_Amp_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
    visit INTEGER NOT NULL,
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
    PRIMARY KEY (rawAmpExposureId)
) TYPE=MyISAM;


CREATE TABLE Raw_Amp_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Raw_Amp_Exposure.</descr>
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <descr>Id of the corresponding Raw_Amp_Exposure.</descr>
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
        -- <descr>Date of the start of the exposure.</descr>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expMidpt VARCHAR(30) NOT NULL,
    expTime FLOAT(0) NOT NULL,
        -- <descr>Duration of exposure.</descr>
    nCombine INTEGER NOT NULL,
        -- <descr>Number of images co-added to create a deeper image.</descr>
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
    PRIMARY KEY (scienceCcdExposureId)
) TYPE=MyISAM;


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
    visitId INTEGER NOT NULL
        -- <descr>Unique identifier.</descr>
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
        -- <descr>Unique object id.</descr>
    iauId CHAR(34) NULL,
        -- <descr>Not set for PT1.1. IAU compliant name for the object. Example:
        -- &quot;LSST-DR11 J001234.65-123456.18 GAL&quot;. The last 3 characters
        -- identify classification. Note that it will not accommodate multiple
        -- classifications.</descr>
    ra_PS DOUBLE NOT NULL,
        -- <descr>RA of mean source cluster position. Computed from the
        -- normalized sum of the unit vector positions of all sources belonging
        -- to an object; for sources that are close together this is equivalent
        -- to minimizing the sum of the square angular separations between the
        -- source positions and the object position.</descr>
        -- <unit>deg</unit>
    ra_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of ra_PS (standard deviation).</descr>
        -- <unit>deg</unit>
    decl_PS DOUBLE NOT NULL,
        -- <descr>Dec of mean source cluster position. Computed from the
        -- normalized sum of the unit vector positions of all sources belonging
        -- to an object; for sources that are close together this is equivalent
        -- to minimizing the sum of the square angular separations between the
        -- source positions and the object position.</descr>
        -- <unit>deg</unit>
    decl_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of decl_PS (standard deviation).</descr>
        -- <unit>deg</unit>
    radecl_PS_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra_PS and decl_PS.</descr>
        -- <unit>deg^2</unit>
    ra_SG DOUBLE NULL,
        -- <descr>Inverse variance weighted mean source cluster position RA.
        -- Note that PT1.1 contains no small galaxy model code - this position
        -- is computed using the same point source model source positions as
        -- ra_PS, decl_PS.</descr>
        -- <unit>deg</unit>
    ra_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of ra_SG (standard deviation).</descr>
        -- <unit>deg</unit>
    decl_SG DOUBLE NULL,
        -- <descr>Inverse variance weighted mean source cluster position Dec.
        -- Note that PT1.1 contains no small galaxy model code - this position
        -- is computed using the same point source model source positions as
        -- ra_PS, decl_PS.</descr>
        -- <unit>deg</unit>
    decl_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertain of decl_SG (standard deviation).</descr>
        -- <unit>deg</unit>
    radecl_SG_Cov FLOAT(0) NULL,
        -- <descr>Covariance of ra_SG and decl_SG.</descr>
        -- <unit>deg^2</unit>
    raRange FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Width in RA of the bounding box on the sky
        -- that fully encloses the footprint of this object for the canonical
        -- model (Small Galaxy) and canonical filter.</descr>
        -- <unit>deg</unit>
    declRange FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Height in Dec of the bounding box on the
        -- sky that fully encloses the footprint of this object in the canonical
        -- model (Small Galaxy) and canonical filter.</descr>
        -- <unit>deg</unit>
    muRa_PS DOUBLE NULL,
        -- <descr>Not set for PT1.1. Proper motion (ra) for the Point Source
        -- model.</descr>
        -- <unit>miliarcsec/year</unit>
    muRa_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of muRa_PS.</descr>
        -- <unit>miliarcsec/year</unit>
    muDecl_PS DOUBLE NULL,
        -- <descr>Not set for PT1.1. Proper motion (decl) for the Point Source
        -- model.</descr>
        -- <unit>miliarcsec/year</unit>
    muDecl_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of muDecl_PS.</descr>
        -- <unit>miliarcsec/year</unit>
    muRaDecl_PS_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of muRa_PS and muDecl_PS.
        -- </descr>
    parallax_PS DOUBLE NULL,
        -- <descr>Not set for PT1.1. Parallax for Point Source model.</descr>
        -- <unit>miliarcsec</unit>
    parallax_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of parallax_PS.</descr>
        -- <unit>miliarcsec</unit>
    canonicalFilterId TINYINT NULL,
        -- <descr>Not set for PT1.1. Id of the filter which is the canonical
        -- filter for size, ellipticity and Sersic index parameters.</descr>
    extendedness FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is an extended
        -- object. Valid range: 0-1, where 1 indicates an extended object with
        -- 100% probability.</descr>
    varProb FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is variable.
        -- Valid range: 0-1, where 1 indicates a variable object with 100%
        -- probability.</descr>
    earliestObsTime DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time
        -- (taiMidPoint of the first Source).</descr>
        -- <unit>mjd</unit>
    latestObsTime DOUBLE NULL,
        -- <descr>The latest time when this object was observed (taiMidPoint of
        -- the last Source).</descr>
        -- <unit>mjd</unit>
    flags INTEGER NULL,
        -- <descr>Always 0 in PT1.1.</descr>
    uNumObs INTEGER NULL,
        -- <descr>Number of u-band sources associated with this object.</descr>
    uExtendedness FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is an extended
        -- object for u filter. Valid range: 0-1, where 1 indicates an extended
        -- object with 100% probability.</descr>
    uVarProb FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is variable
        -- for u filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    uRaOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of ra_PS for u filter.
        -- </descr>
    uRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of uRaOffset_PS.</descr>
    uDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_PS for u filter.
        -- </descr>
    uDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of uDeclOffset_PS.</descr>
    uRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of uRaOffset_PS and
        -- uDeclOffset_PS.</descr>
    uRaOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of raOffset_SG for u
        -- filter.</descr>
    uRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of uRaOffset_SG.</descr>
    uDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_SG for u filter.
        -- </descr>
    uDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of uDeclOffset_SG.</descr>
    uRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of uRaOffset_SG and
        -- uDeclOffset_SG.</descr>
    uLnL_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Point Source for
        -- u filter.</descr>
    uLnL_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Small Galaxy for
        -- u filter.</descr>
    uFlux_PS FLOAT(0) NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of u-band sources
        -- belonging to this object.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    uFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertain of uFlux_PS (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    uFlux_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Small Galaxy model for u filter.
        -- </descr>
    uFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of uFlux_SG.</descr>
    uFlux_CSG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Canonical Small Galaxy model for u
        -- filter.</descr>
    uFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of uFlux_CSG.</descr>
    uTimescale FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Characteristic timescale of flux variations
        -- for u filter.</descr>
        -- <unit>day</unit>
    uEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- u filter.</descr>
        -- <unit>mjd</unit>
    uLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in u
        -- filter.</descr>
        -- <unit>mjd</unit>
    uSersicN_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Sersic index for Small Galaxy model for u
        -- filter.</descr>
    uSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of uSersicN_SG.</descr>
    uE1_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean u-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    uE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of uE1_SG.</descr>
    uE2_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean u-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    uE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of uE2_SG.</descr>
    uRadius_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean u-band radius of source cluster. Note that
        -- PT1.1 contains no small galaxy model code - radii are derived from
        -- source adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    uRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of uRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    uFlags INTEGER NULL,
        -- <descr>Encodes the number of u-band sources used to determine mean
        -- flux/ellipticity. Equal to N_flux_samples +
        -- N_ellipticity_samples*4096.</descr>
    gNumObs INTEGER NULL,
        -- <descr>Number of g-band sources associated with this object.</descr>
    gExtendedness FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is an extended
        -- object for g filter. Valid range: 0-1, where 1 indicates an extended
        -- object with 100% probability.</descr>
    gVarProb FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is variable
        -- for g filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    gRaOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of ra_PS for g filter.
        -- </descr>
    gRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of gRaOffset_PS.</descr>
    gDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_PS for g filter.
        -- </descr>
    gDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of gDeclOffset_PS.</descr>
    gRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of gRaOffset_PS and
        -- gDeclOffset_PS.</descr>
    gRaOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of raOffset_SG for g
        -- filter.</descr>
    gRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of gRaOffset_SG.</descr>
    gDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_SG for g filter.
        -- </descr>
    gDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of gDeclOffset_SG.</descr>
    gRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of gRaOffset_SG and
        -- gDeclOffset_SG.</descr>
    gLnL_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Point Source for
        -- g filter.</descr>
    gLnL_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Small Galaxy for
        -- g filter.</descr>
    gFlux_PS FLOAT(0) NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of g-band sources
        -- belonging to this object.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    gFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gFlux_PS (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    gFlux_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Small Galaxy model for g filter.
        -- </descr>
    gFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of gFlux_SG.</descr>
    gFlux_CSG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Canonical Small Galaxy model for g
        -- filter.</descr>
    gFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of gFlux_CSG.</descr>
    gTimescale FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Characteristic timescale of flux variations
        -- for g filter.</descr>
        -- <unit>day</unit>
    gEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- g filter.</descr>
        -- <unit>mjd</unit>
    gLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in g
        -- filter.</descr>
        -- <unit>mjd</unit>
    gSersicN_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Sersic index for Small Galaxy model for g
        -- filter.</descr>
    gSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of gSersicN_SG.</descr>
    gE1_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean g-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    gE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of gE1_SG.</descr>
    gE2_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean g-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    gE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of gE2_SG.</descr>
    gRadius_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean g-band radius of source cluster. Note that
        -- PT1.1 contains no small galaxy model code - radii are derived from
        -- source adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    gRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of gRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    gFlags INTEGER NULL,
        -- <descr>Encodes the number of g-band sources used to determine mean
        -- flux/ellipticity. Equal to N_flux_samples +
        -- N_ellipticity_samples*4096.</descr>
    rNumObs INTEGER NULL,
        -- <descr>Number of r-band sources associated with this object.</descr>
    rExtendedness FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is an extended
        -- object for r filter. Valid range: 0-1, where 1 indicates an extended
        -- object with 100% probability.</descr>
    rVarProb FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is variable
        -- for r filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    rRaOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of ra_PS for r filter.
        -- </descr>
    rRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of rRaOffset_PS.</descr>
    rDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_PS for r filter.
        -- </descr>
    rDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of rDeclOffset_PS.</descr>
    rRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of rRaOffset_PS and
        -- rDeclOffset_PS.</descr>
    rRaOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of raOffset_SG for r
        -- filter.</descr>
    rRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of rRaOffset_SG.</descr>
    rDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_SG for r filter.
        -- </descr>
    rDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of rDeclOffset_SG.</descr>
    rRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of rRaOffset_SG and
        -- rDeclOffset_SG.</descr>
    rLnL_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Point Source for
        -- r filter.</descr>
    rLnL_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Small Galaxy for
        -- r filter.</descr>
    rFlux_PS FLOAT(0) NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of r-band sources
        -- belonging to this object.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    rFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rFlux_PS (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    rFlux_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Small Galaxy model for r filter.
        -- </descr>
    rFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of rFlux_SG.</descr>
    rFlux_CSG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Canonical Small Galaxy model for r
        -- filter.</descr>
    rFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of rFlux_CSG.</descr>
    rTimescale FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Characteristic timescale of flux variations
        -- for r filter.</descr>
        -- <unit>day</unit>
    rEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- r filter.</descr>
        -- <unit>mjd</unit>
    rLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in r
        -- filter.</descr>
        -- <unit>mjd</unit>
    rSersicN_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Sersic index for Small Galaxy model for r
        -- filter.</descr>
    rSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of rSersicN_SG.</descr>
    rE1_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean r-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    rE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of rE1_SG.</descr>
    rE2_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean r-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    rE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of rE2_SG.</descr>
    rRadius_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean r-band radius of source cluster. Note that
        -- PT1.1 contains no small galaxy model code - radii are derived from
        -- source adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    rRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of rRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    rFlags INTEGER NULL,
        -- <descr>Encodes the number of r-band sources used to determine mean
        -- flux/ellipticity. Equal to N_flux_samples +
        -- N_ellipticity_samples*4096.</descr>
    iNumObs INTEGER NULL,
        -- <descr>Number of i-band sources associated with this object.</descr>
    iExtendedness FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is an extended
        -- object for i filter. Valid range: 0-1, where 1 indicates an extended
        -- object with 100% probability.</descr>
    iVarProb FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is variable
        -- for i filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    iRaOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of ra_PS for i filter.
        -- </descr>
    iRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of iRaOffset_PS.</descr>
    iDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_PS for i filter.
        -- </descr>
    iDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of iDeclOffset_PS.</descr>
    iRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of iRaOffset_PS and
        -- iDeclOffset_PS.</descr>
    iRaOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of raOffset_SG for i
        -- filter.</descr>
    iRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of iRaOffset_SG.</descr>
    iDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_SG for i filter.
        -- </descr>
    iDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of iDeclOffset_SG.</descr>
    iRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of iRaOffset_SG and
        -- iDeclOffset_SG.</descr>
    iLnL_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Point Source for
        -- i filter.</descr>
    iLnL_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Small Galaxy for
        -- i filter.</descr>
    iFlux_PS FLOAT(0) NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of i-band sources
        -- belonging to this object.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    iFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iFlux_PS (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    iFlux_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Small Galaxy model for i filter.
        -- </descr>
    iFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of iFlux_SG.</descr>
    iFlux_CSG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Canonical Small Galaxy model for i
        -- filter.</descr>
    iFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of iFlux_CSG.</descr>
    iTimescale FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Characteristic timescale of flux variations
        -- for i filter.</descr>
        -- <unit>day</unit>
    iEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- i filter.</descr>
        -- <unit>mjd</unit>
    iLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in i
        -- filter.</descr>
        -- <unit>mjd</unit>
    iSersicN_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Sersic index for Small Galaxy model for i
        -- filter.</descr>
    iSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of iSersicN_SG.</descr>
    iE1_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean i-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    iE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of iE1_SG.</descr>
    iE2_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean i-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    iE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of iE2_SG.</descr>
    iRadius_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean i-band radius of source cluster. Note that
        -- PT1.1 contains no small galaxy model code - radii are derived from
        -- source adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    iRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of iRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    iFlags INTEGER NULL,
        -- <descr>Encodes the number of i-band sources used to determine mean
        -- flux/ellipticity. Equal to N_flux_samples +
        -- N_ellipticity_samples*4096.</descr>
    zNumObs INTEGER NULL,
        -- <descr>Number of z-band sources associated with this object.</descr>
    zExtendedness FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is an extended
        -- object for z filter. Valid range: 0-1, where 1 indicates an extended
        -- object with 100% probability.</descr>
    zVarProb FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is variable
        -- for z filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    zRaOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of ra_PS for z filter.
        -- </descr>
    zRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of zRaOffset_PS.</descr>
    zDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_PS for z filter.
        -- </descr>
    zDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of zDeclOffset_PS.</descr>
    zRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of zRaOffset_PS and
        -- zDeclOffset_PS.</descr>
    zRaOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of raOffset_SG for z
        -- filter.</descr>
    zRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of zRaOffset_SG.</descr>
    zDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_SG for z filter.
        -- </descr>
    zDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of zDeclOffset_SG.</descr>
    zRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of zRaOffset_SG and
        -- zDeclOffset_SG.</descr>
    zLnL_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Point Source for
        -- z filter.</descr>
    zLnL_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Small Galaxy for
        -- z filter.</descr>
    zFlux_PS FLOAT(0) NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of z-band sources
        -- belonging to this object.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    zFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zFlux_PS (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    zFlux_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Small Galaxy model for z filter.
        -- </descr>
    zFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of zFlux_SG.</descr>
    zFlux_CSG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Canonical Small Galaxy model for z
        -- filter.</descr>
    zFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of zFlux_CSG.</descr>
    zTimescale FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Characteristic timescale of flux variations
        -- for z filter.</descr>
        -- <unit>day</unit>
    zEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- z filter.</descr>
        -- <unit>mjd</unit>
    zLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in z
        -- filter.</descr>
        -- <unit>mjd</unit>
    zSersicN_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Sersic index for Small Galaxy model for z
        -- filter.</descr>
    zSersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of zSersicN_SG.</descr>
    zE1_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean z-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    zE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of zE1_SG.</descr>
    zE2_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean z-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    zE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of zE2_SG.</descr>
    zRadius_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean z-band radius of source cluster. Note that
        -- PT1.1 contains no small galaxy model code - radii are derived from
        -- source adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    zRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of zRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    zFlags INTEGER NULL,
        -- <descr>Encodes the number of z-band sources used to determine mean
        -- flux/ellipticity. Equal to N_flux_samples +
        -- N_ellipticity_samples*4096.</descr>
    yNumObs INTEGER NULL,
        -- <descr>Number of y-band sources associated with this object.</descr>
    yExtendedness FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is an extended
        -- object for y filter. Valid range: 0-1, where 1 indicates an extended
        -- object with 100% probability.</descr>
    yVarProb FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this object is variable
        -- for y filter. Valid range: 0-1, where 1 indicates a variable object
        -- with 100% probability.</descr>
    yRaOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of ra_PS for y filter.
        -- </descr>
    yRaOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of yRaOffset_PS.</descr>
    yDeclOffset_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_PS for y filter.
        -- </descr>
    yDeclOffset_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of yDeclOffset_PS.</descr>
    yRaDeclOffset_PS_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of yRaOffset_PS and
        -- yDeclOffset_PS.</descr>
    yRaOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of raOffset_SG for y
        -- filter.</descr>
    yRaOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of yRaOffset_SG.</descr>
    yDeclOffset_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Center correction of decl_SG for y filter.
        -- </descr>
    yDeclOffset_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of yDeclOffset_SG.</descr>
    yRaDeclOffset_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of yRaOffset_SG and
        -- yDeclOffset_SG.</descr>
    yLnL_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Point Source for
        -- y filter.</descr>
    yLnL_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Log-likelihood of being a Small Galaxy for
        -- y filter.</descr>
    yFlux_PS FLOAT(0) NULL,
        -- <descr>Inverse variance weighted mean AB PSF flux of y-band sources
        -- belonging to this object.</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    yFlux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yFlux_PS (standard deviation).</descr>
        -- <unit>erg/s/cm^2/Hz</unit>
    yFlux_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Small Galaxy model for y filter.
        -- </descr>
    yFlux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of yFlux_SG.</descr>
    yFlux_CSG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Flux for Canonical Small Galaxy model for y
        -- filter.</descr>
    yFlux_CSG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of yFlux_CSG.</descr>
    yTimescale FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Characteristic timescale of flux variations
        -- for y filter.</descr>
        -- <unit>day</unit>
    yEarliestObsTime DOUBLE NULL,
        -- <descr>Time (TAI) when this object was observed for the first time in
        -- y filter.</descr>
        -- <unit>mjd</unit>
    yLatestObsTime DOUBLE NULL,
        -- <descr>The latest time (TAI) when this object was observed in y
        -- filter.</descr>
        -- <unit>mjd</unit>
    ySersicN_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Sersic index for Small Galaxy model for y
        -- filter.</descr>
    ySersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of ySersicN_SG.</descr>
    yE1_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean y-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    yE1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of yE1_SG.</descr>
    yE2_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean y-band ellipticity of source cluster in a
        -- tangent plane centered on (ra_PS, decl_PS) and with the standard N,E
        -- basis. Note that PT1.1 contains no small galaxy model code -
        -- ellipticities are derived from source adaptive second moments (Ixx,
        -- Iyy, Ixy).</descr>
    yE2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of yE2_SG.</descr>
    yRadius_SG FLOAT(0) NULL,
        -- <descr>Unweighted mean y-band radius of source cluster. Note that
        -- PT1.1 contains no small galaxy model code - radii are derived from
        -- source adaptive second moments (Ixx, Iyy, Ixy).</descr>
        -- <unit>arcsec</unit>
    yRadius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Uncertainty of yRadius_SG (standard deviation).</descr>
        -- <unit>arcsec</unit>
    yFlags INTEGER NULL,
        -- <descr>Encodes the number of y-band sources used to determine mean
        -- flux/ellipticity. Equal to N_flux_samples +
        -- N_ellipticity_samples*4096.</descr>
    _chunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    _subChunkId INTEGER NULL,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (objectId),
    INDEX IDX_Object_decl (decl_PS ASC)
) TYPE=MyISAM;


CREATE TABLE Source
(
    sourceId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier)</descr>
    scienceCcdExposureId BIGINT NULL,
        -- <descr>Identifier for the CCD the source was detected/measured on
        -- (pointer to Science_Ccd_Exposure).</descr>
    filterId TINYINT NOT NULL,
        -- <descr>Pointer to Filter table; 0='u', 1='g', 2='r', 3='i', 4='z',
        -- 5='y'.</descr>
    objectId BIGINT NULL,
        -- <descr>The object this source was assigned to. NULL if the PT1.1
        -- clustering algorithm generated a single-source object for this
        -- source.</descr>
    movingObjectId BIGINT NULL,
        -- <descr>Not set for PT1.1.</descr>
    procHistoryId INTEGER NOT NULL,
        -- <descr>Not set for PT1.1.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA of source centroid (equal to raAstrom).</descr>
        -- <unit>deg</unit>
    raErrForDetection FLOAT(0) NULL,
        -- <descr>Component of ra uncertainty due to detection uncertainty
        -- (xAstromErr, yAstromErr).</descr>
        -- <unit>deg</unit>
    raErrForWcs FLOAT(0) NOT NULL,
        -- <descr>Not set for PT1.1. Component of ra uncertainty due to
        -- uncertainty in WCS solution.</descr>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Declination of source centroid (equal to declAstrom).</descr>
        -- <unit>deg</unit>
    declErrForDetection FLOAT(0) NULL,
        -- <descr>Component of decl uncertainty due to detection uncertainty
        -- (xAstromErr, yAstromErr).</descr>
        -- <unit>deg</unit>
    declErrForWcs FLOAT(0) NOT NULL,
        -- <descr>Not set for PT1.1. Component of decl uncertainty due to
        -- uncertainty in WCS solution.</descr>
        -- <unit>deg</unit>
    xFlux DOUBLE NULL,
        -- <descr>Not set for PT1.1.</descr>
        -- <unit>pix</unit>
    xFluxErr FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of xFlux.</descr>
        -- <unit>pix</unit>
    yFlux DOUBLE NULL,
        -- <descr>Not set for PT1.1.</descr>
        -- <unit>pix</unit>
    yFluxErr FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of yFlux.</descr>
        -- <unit>pix</unit>
    raFlux DOUBLE NULL,
        -- <descr>Not set for PT1.1. RA of (xFlux, yFlux).</descr>
        -- <unit>deg</unit>
    raFluxErr FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of raFlux.</descr>
        -- <unit>deg</unit>
    declFlux DOUBLE NULL,
        -- <descr>Not set for PT1.1. Dec of (xFlux, yFlux).</descr>
        -- <unit>deg</unit>
    declFluxErr FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of declFlux.</descr>
        -- <unit>deg</unit>
    xPeak DOUBLE NULL,
        -- <descr>Not set for PT1.1.</descr>
        -- <unit>pix</unit>
    yPeak DOUBLE NULL,
        -- <descr>Not set for PT1.1.</descr>
        -- <unit>pix</unit>
    raPeak DOUBLE NULL,
        -- <descr>Not set for PT1.1. RA of (xPeak, yPeak).</descr>
        -- <unit>deg</unit>
    declPeak DOUBLE NULL,
        -- <descr>Not set for PT1.1. Dec of (xPeak, yPeak).</descr>
        -- <unit>deg</unit>
    xAstrom DOUBLE NULL,
        -- <descr>Position (x) measured for purposes of astrometry.</descr>
        -- <unit>pix</unit>
    xAstromErr FLOAT(0) NULL,
        -- <descr>Uncertainty of xAstrom.</descr>
        -- <unit>pix</unit>
    yAstrom DOUBLE NULL,
        -- <descr>Position (y) measured for purposes of astrometry.</descr>
        -- <unit>pix</unit>
    yAstromErr FLOAT(0) NULL,
        -- <descr>Uncertainty of yAstrom.</descr>
        -- <unit>pix</unit>
    raAstrom DOUBLE NULL,
        -- <descr>RA of (xAstrom, yAstrom).</descr>
        -- <unit>deg</unit>
    raAstromErr FLOAT(0) NULL,
        -- <descr>Uncertainty of raAstrom.</descr>
        -- <unit>deg</unit>
    declAstrom DOUBLE NULL,
        -- <descr>Dec of (xAstrom, yAstrom).</descr>
        -- <unit>deg</unit>
    declAstromErr FLOAT(0) NULL,
        -- <descr>Uncertainty of declAstrom.</descr>
        -- <unit>deg</unit>
    raObject DOUBLE NULL,
        -- <descr>ra_PS of object associated with this source, or ra if the
        -- source was not associated with any object (objectId is NULL).</descr>
        -- <unit>deg</unit>
    declObject DOUBLE NULL,
        -- <descr>decl_PS of object associated with this source, or decl if the
        -- source was not associated with any object (objectId is NULL).</descr>
        -- <unit>deg</unit>
    taiMidPoint DOUBLE NOT NULL,
        -- <descr>Middle of exposure time (TAI).</descr>
        -- <unit>mjd</unit>
    taiRange FLOAT(0) NULL,
        -- <descr>Exposure time.</descr>
        -- <unit>s</unit>
    psfFlux DOUBLE NOT NULL,
        -- <descr>Uncalibrated PSF flux of source.</descr>
        -- <unit>DN</unit>
    psfFluxErr FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <unit>DN</unit>
    apFlux DOUBLE NOT NULL,
        -- <descr>Uncalibrated aperture flux of source.</descr>
        -- <unit>DN</unit>
    apFluxErr FLOAT(0) NOT NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <unit>DN</unit>
    modelFlux DOUBLE NOT NULL,
        -- <descr>Not set for PT1.1.</descr>
    modelFluxErr FLOAT(0) NOT NULL,
        -- <descr>Not set for PT1.1.</descr>
    petroFlux DOUBLE NULL,
        -- <descr>Not set for PT1.1.</descr>
    petroFluxErr FLOAT(0) NULL,
        -- <descr>Not set for PT1.1.</descr>
    instFlux DOUBLE NOT NULL,
        -- <descr>Not set for PT1.1.</descr>
    instFluxErr FLOAT(0) NOT NULL,
        -- <descr>Not set for PT1.1.</descr>
    nonGrayCorrFlux DOUBLE NULL,
        -- <descr>Not set for PT1.1.</descr>
    nonGrayCorrFluxErr FLOAT(0) NULL,
        -- <descr>Not set for PT1.1.</descr>
    atmCorrFlux DOUBLE NULL,
        -- <descr>Not set for PT1.1.</descr>
    atmCorrFluxErr FLOAT(0) NULL,
        -- <descr>Not set for PT1.1.</descr>
    apDia FLOAT(0) NULL,
        -- <descr>Not set for PT1.1</descr>
    Ixx FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    IxxErr FLOAT(0) NULL,
        -- <descr>Uncertainty of Ixx.</descr>
    Iyy FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    IyyErr FLOAT(0) NULL,
        -- <descr>Uncertainty of Iyy.</descr>
    Ixy FLOAT(0) NULL,
        -- <descr>Adaptive second moment.</descr>
    IxyErr FLOAT(0) NULL,
        -- <descr>Uncertainty of Ixy.</descr>
    snr FLOAT(0) NOT NULL,
        -- <descr>Not set for PT1.1.</descr>
    chi2 FLOAT(0) NOT NULL,
    sky FLOAT(0) NULL,
        -- <descr>Not set for PT1.1.</descr>
    skyErr FLOAT(0) NULL,
        -- <descr>Not set for PT1.1.</descr>
    extendedness FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Probability that this source is an extended
        -- source. Valid range: 0-1, where 1 indicates an extended source with
        -- 100% probability.</descr>
    flux_PS FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Calibrated flux for Point Source model.
        -- </descr>
    flux_PS_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of flux_PS.</descr>
    flux_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Calibrated flux for Small Galaxy model.
        -- </descr>
    flux_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of flux_SG.</descr>
    sersicN_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Sersic index for Small Galaxy model.
        -- </descr>
    sersicN_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of sersicN_SG.</descr>
    e1_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Ellipticity for Small Galaxy.</descr>
    e1_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of e1_SG.</descr>
    e2_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of e2_SG.</descr>
    e2_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of e2_SG.</descr>
    radius_SG FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Size of Small Galaxy model.</descr>
    radius_SG_Sigma FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Uncertainty of radius_SG.</descr>
    flux_flux_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of flux and flux for Small
        -- Galaxy model.</descr>
    flux_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of flux and e1 for Small Galaxy
        -- model.</descr>
    flux_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of flux and e2 for Small Galaxy
        -- model.</descr>
    flux_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of flux and radius for Small
        -- Galaxy model.</descr>
    flux_sersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of flux and sersicN for Small
        -- Galaxy model.</descr>
    e1_e1_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of e1 and e1 for Small Galaxy
        -- model.</descr>
    e1_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of e1 and e2 for Small Galaxy
        -- model.</descr>
    e1_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of e1 and radius for Small
        -- Galaxy model.</descr>
    e1_sersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of e1 and sersicN for Small
        -- Galaxy model.</descr>
    e2_e2_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of e2 and e2 for Small Galaxy
        -- model.</descr>
    e2_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of e2 and radius for Small
        -- Galaxy model.</descr>
    e2_sersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of e2 and sersicN for Small
        -- Galaxy model.</descr>
    radius_radius_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of radius and radius for Small
        -- Galaxy model.</descr>
    radius_sersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance of radius and sersicN for Small
        -- Galaxy model.</descr>
    sersicN_sersicN_SG_Cov FLOAT(0) NULL,
        -- <descr>Not set for PT1.1. Covariance for sersicN and sersicN for
        -- Small Galaxy model.</descr>
    flagForAssociation SMALLINT NULL,
        -- <descr>Not set for PT1.1.</descr>
    flagForDetection SMALLINT NULL,
        -- <descr>Bitwise-or of detection flags.
        -- <ul>
        --   <li>0x0001 EDGE: source is in region labelled EDGE.</li>
        --   <li>0x0002 SHAPE_SHIFT: centroid shifted while estimating 
        --       adaptive moments.</li>
        --   <li>0x0004 SHAPE_MAXITER: too many iterations for adaptive 
        --       moments.</li>
        --   <li>0x0008 SHAPE_UNWEIGHTED: &quot;adaptive&quot; moments are
        --       unweighted.</li>
        --   <li>0x0010 SHAPE_UNWEIGHTED_PSF: the PSF's &quot;adaptive&quot; 
        --       moments are unweighted.</li>
        --   <li>0x0020 SHAPE_UNWEIGHTED_BAD: even the unweighted moments were
        --       bad.</li>
        --   <li>0x0040 PEAKCENTER: given centre is position of peak pixel.</li>
        --   <li>0x0080 BINNED1: source was found in 1x1 binned image.</li>
        --   <li>0x0100 INTERP: source's footprint includes interpolated 
        --       pixels.</li>
        --   <li>0x0200 INTERP_CENTER: source's centre is close to interpolated
        --       pixels.</li>
        --   <li>0x0400 SATUR: source's footprint includes saturated pixels.
        --       </li>
        --   <li>0x0800 SATUR_CENTER: source's centre is close to saturated 
        --       pixels.</li>
        --   <li>0x1000 DETECT_NEGATIVE: source was detected as being 
        --       significantly negative.</li>
        --   <li>0x2000 STAR: source is thought to be point-like.</ul></descr>
    flagForWcs SMALLINT NULL,
        -- <descr>Not set for PT1.1.</descr>
    PRIMARY KEY (sourceId),
    INDEX IDX_scienceCcdExposureId (scienceCcdExposureId ASC),
    INDEX IDX_filterId (filterId ASC),
    INDEX IDX_movingObjectId (movingObjectId ASC),
    INDEX IDX_objectId (objectId ASC),
    INDEX IDX_procHistoryId (procHistoryId ASC),
    INDEX IDX_Source_decl (decl ASC)
) TYPE=MyISAM;


SET FOREIGN_KEY_CHECKS=1;


ALTER TABLE RefObjMatch ADD CONSTRAINT FK_RefObjMatch_Object
    FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE RefObjMatch ADD CONSTRAINT FK_RefObjMatch_SimRefObject
    FOREIGN KEY (refObjectId) REFERENCES SimRefObject (refObjectId);
