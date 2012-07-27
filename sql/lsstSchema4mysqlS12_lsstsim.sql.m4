changecom(`###')dnl
define(`m4def', defn(`define'))dnl
-- LSST Data Management System
-- Copyright 2012 LSST Corporation.
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


-- LSST Database Schema, Summer 2012 series, lsstSim dataset
--
-- UCD definitions based on:
-- http://www.ivoa.net/Documents/REC/UCD/UCDlist-20070402.html


SET FOREIGN_KEY_CHECKS=0;


CREATE TABLE IF NOT EXISTS ZZZ_Db_Description 
    -- <descr>Internal table used for storing database description</descr>
(
    f VARCHAR(255),
        -- <descr>The schema file name.</descr>
    r VARCHAR(255)
        -- <descr>Captures information from 'git describe'.</descr>
) ENGINE=MyISAM;

INSERT INTO ZZZ_Db_Description(f) VALUES('lsstSchema4mysqlS12_lsstsim.sql');


CREATE TABLE AmpMap
    -- <descr>Mapping table to translate amp names to numbers.</descr>
(
    ampNum TINYINT NOT NULL,
        -- <ucd>meta.id;instr.det</ucd>
    ampName CHAR(3) NOT NULL,
        -- <ucd>instr.det</ucd>
    PRIMARY KEY (ampNum),
    UNIQUE UQ_AmpMap_ampName(ampName)
) ENGINE=MyISAM;


CREATE TABLE CcdMap
    -- <descr>Mapping table to translate ccd names to numbers.</descr>
(
    ccdNum TINYINT NOT NULL,
        -- <ucd>meta.id;instr.det</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <ucd>instr.det</ucd>
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
        -- <ucd>em.wl.effective;instr.filter</ucd>
        -- <unit>nm</unit>
    photBW FLOAT NOT NULL,
        -- <descr>System effective bandwidth.</descr>
        -- <ucd>instr.bandwidth</ucd>
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
    PRIMARY KEY (id)
) ENGINE=MyISAM;


CREATE TABLE ObjectType
    -- <descr>Table to store description of object types. It includes all object
    -- types: static, variables, Solar System objects, etc.</descr>
(
    typeId SMALLINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id</ucd>
    description VARCHAR(255) NULL,
        -- <ucd>meta.note</ucd>
    PRIMARY KEY (typeId)
) ENGINE=MyISAM;


CREATE TABLE RaftMap
    -- <descr>Mapping table to translate raft names to numbers.</descr>
(
    raftNum TINYINT NOT NULL,
        -- <ucd>meta.id;instr.det</ucd>
    raftName CHAR(3) NOT NULL,
        -- <ucd>instr.det</ucd>
    PRIMARY KEY (raftNum),
    UNIQUE UQ_RaftMap_raftName(raftName)
) ENGINE=MyISAM;


CREATE TABLE RefObjMatch
    -- <descr>Table containing the results of a spatial match between
    -- RefObject and Object.</descr>
(
    refObjectId BIGINT NULL,
        -- <descr>Reference object id (pointer to RefObject). NULL if
        -- reference object has no matches.</descr>
        -- <ucd>meta.id</ucd>
    objectId BIGINT NULL,
        -- <descr>Object id. NULL if object has no matches.</descr>
        -- <ucd>meta.id;src</ucd>
    refRa DOUBLE NULL,
        -- <descr>ICRS reference object RA at mean epoch of sources assigned to
        -- object.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    refDecl DOUBLE NULL,
        -- <descr>ICRS reference object Dec at mean epoch of sources assigned to
        -- object.</descr>
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
    -- RefObject and Source.</descr>
(
    refObjectId BIGINT NULL,
        -- <descr>Reference object id (pointer to RefObject). NULL if
        -- reference object has no matches.</descr>
        -- <ucd>meta.id</ucd>
    sourceId BIGINT NULL,
        -- <descr>Source id. NULL if source has no matches.</descr>
        -- <ucd>meta.id</ucd>
    refRa DOUBLE NULL,
        -- <descr>ICRS reference object RA at epoch of source.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    refDecl DOUBLE NULL,
        -- <descr>ICRS reference object Dec at epoch of source.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
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


CREATE TABLE RefObject
    -- <descr>Stores properties of ImSim reference objects that fall within
    --        at least one CCD. Includes both stars and galaxies.
    -- </descr>
(
    refObjectId BIGINT NOT NULL,
        -- <descr>Unique reference object ID.</descr>
        -- <ucd>meta.id;src</ucd>
    isStar TINYINT NOT NULL,
        -- <descr>1 for stars, 0 for galaxies.</descr>
        -- <ucd>src.class.starGalaxy</ucd>
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
        -- <ucd>meta.code;src.class</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of object.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of object.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
        -- <ucd>pos.HTM</ucd>
    gLat DOUBLE NULL,
        -- <descr>Galactic latitude of star. NULL for galaxies.</descr>
        -- <ucd>pos.galactic.lat</ucd>
        -- <unit>deg</unit>
    gLon DOUBLE NULL,
        -- <descr>Galactic longitude of star. NULL for galaxies.</descr>
        -- <ucd>pos.galactic.lon</ucd>
        -- <unit>deg</unit>
    sedName VARCHAR(255) NULL,
        -- <descr>Best-fit SED name. NULL for galaxies.</descr>
        -- <ucd>src.sec</ucd>
    uMag DOUBLE NOT NULL,
        -- <descr>u-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    gMag DOUBLE NOT NULL,
        -- <descr>g-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    rMag DOUBLE NOT NULL,
        -- <descr>r-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    iMag DOUBLE NOT NULL,
        -- <descr>i-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    zMag DOUBLE NOT NULL,
        -- <descr>z-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
        -- <unit>mag</unit>
    yMag DOUBLE NOT NULL,
        -- <descr>y-band AB magnitude.</descr>
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
        -- <descr>Stellar parallax. NULL for galaxies.</descr>
        -- <ucd>pos.parallax</ucd>
        -- <unit>mas</unit>
    vRad DOUBLE NULL,
        -- <descr>Radial velocity of star. NULL for galaxies.</descr>
        -- <ucd>spect.dopplerVeloc.opt</ucd>
        -- <unit>km/s</unit>
    redshift DOUBLE NULL,
        -- <descr>Redshift. NULL for stars.</descr>
        -- <ucd>src.redshift</ucd>
    semiMajorBulge DOUBLE NULL,
        -- <descr>Semi-major axis length of galaxy bulge. NULL for stars.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    semiMinorBulge DOUBLE NULL,
        -- <descr>Semi-minor axis length of galaxy bulge. NULL for stars.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    semiMajorDisk DOUBLE NULL,
        -- <descr>Semi-major axis length of galaxy disk. NULL for stars.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    semiMinorDisk DOUBLE NULL,
        -- <descr>Semi-minor axis length of galaxy disk. NULL for stars.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    uExposureCount SMALLINT NOT NULL,
        -- <descr>Number of u-band exposures containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    gExposureCount SMALLINT NOT NULL,
        -- <descr>Number of g-band exposures containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    rExposureCount SMALLINT NOT NULL,
        -- <descr>Number of r-band exposures containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    iExposureCount SMALLINT NOT NULL,
        -- <descr>Number of i-band exposures containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    zExposureCount SMALLINT NOT NULL,
        -- <descr>Number of z-band exposures containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    yExposureCount SMALLINT NOT NULL,
        -- <descr>Number of y-band exposures containing reference object.</descr>
        -- <ucd>meta.number</ucd>
    PRIMARY KEY (refObjectId),
    KEY IDX_decl (decl ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


m4def(`M4_KEY_VALUE_TABLE',
`CREATE TABLE $1_Metadata
    -- <descr>Generic key-value pair metadata for $1.</descr>
(
    $2 BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    exposureType TINYINT NOT NULL,
        -- <descr>Type of exposure
        --  <ul>
        --    <li>1: Science CCD</li>
        --    <li>2: Difference Imaging CCD</li>
        --    <li>3: Good-seeing coadd</li>
        --    <li>4: Deep coadd</li>
        --    <li>5: Chi-squared coadd</li>
        --  </ul></descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY ($2, metadataKey),
    KEY IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;')dnl

m4def(`M4_HTM_MAPPING_TABLE',
`CREATE TABLE $1_To_Htm$3
    -- <descr>Stores a mapping between exposures in $1 and the IDs of
    -- spatially overlapping level-$3 HTM triangles.</descr>
(
    $2 BIGINT NOT NULL,
        -- <descr>Pointer to $1.</descr>
    htmId$3 INTEGER NOT NULL,
        -- <descr>ID for Level $3 HTM triangle overlapping exposure.
        -- For each exposure in $1, there will be one row for every
        -- overlapping triangle.</descr>
        -- <ucd>pos.HTM</ucd>
    KEY IDX_htmId$3 (htmId$3 ASC),
    KEY IDX_$2 ($2 ASC)
) ENGINE=MyISAM;')dnl


m4def(`M4_SPATIAL_EXPOSURE_COLUMNS',
`ra DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of image center, corresponding to FITS
        -- pixel coordinates ((NAXIS1 + 1)/2, (NAXIS2 + 1)/2).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of image center, corresponding to FITS
        -- pixel coordinates ((NAXIS1 + 1)/2, (NAXIS2 + 1)/2).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
        -- <ucd>pos.HTM</ucd>
    equinox FLOAT NOT NULL,
        -- <ucd>pos.equinox</ucd>
    raDeSys VARCHAR(20) NOT NULL,
        -- <ucd>pos.frame</ucd>
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
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    crval2 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    cd1_1 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd1_2 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_1 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_2 DOUBLE NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    corner1Ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of image corner 1, corresponding to
        -- FITS pixel coordinates (0.5, 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner1Decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of image corner 1, corresponding to
        -- FITS pixel coordinates (0.5, 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    corner2Ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of image corner 2, corresponding to
        -- FITS pixel coordinates (0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner2Decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of image corner 2, corresponding to
        -- FITS pixel coordinates (0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    corner3Ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of image corner 3, corresponding to
        -- FITS pixel coordinates (NAXIS1 + 0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner3Decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of image corner 3, corresponding to
        -- FITS pixel coordinates (NAXIS1 + 0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    corner4Ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of image corner 4, corresponding to
        -- FITS pixel coordinates (NAXIS1 + 0.5, 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner4Decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of image corner 4, corresponding to
        -- FITS pixel coordinates (NAXIS1 + 0.5, 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    poly BINARY(120) NOT NULL,
        -- <descr>binary representation of the 4-corner polygon
        -- for the exposure.</descr>')dnl

m4def(`M4_SOURCE_COLUMNS',
`ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of $1 centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of $1 centroid (x, y).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    raVar DOUBLE NULL,
        -- <descr>Variance of ra due to centroid uncertainty
        -- (xVar, xyCov, yVar).</descr>
        -- <ucd>stat.variance;pos.eq.ra</ucd>
        -- <unit>arcsec^2</unit>
    declVar DOUBLE NULL,
        -- <descr>Variance of decl due to centroid uncertainty
        -- (xVar, xyCov, yVar).</descr>
        -- <ucd>stat.variance;pos.eq.dec</ucd>
        -- <unit>arcsec^2</unit>
    radeclCov DOUBLE NULL,
        -- <descr>Covariance of ra, decl due to centroid uncertainty
        -- (xVar, xyCov, yVar).</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>arcsec^2</unit>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
        -- <ucd>pos.HTM</ucd>
    x DOUBLE NOT NULL,
        -- <descr>Pixel axis 1 coordinate of $1 centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y DOUBLE NOT NULL,
        -- <descr>Pixel axis 2 coordinate of $1 centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    xVar DOUBLE NULL,
        -- <descr>Variance of x.</descr>
        -- <ucd>stat.variance;pos.cartesian.x</ucd>
        -- <unit>pixel^2</unit>
    yVar DOUBLE NULL,
        -- <descr>Variance of y.</descr>
        -- <ucd>stat.variance;pos.cartesian.y</ucd>
        -- <unit>pixel^2</unit>
    xyCov DOUBLE NULL,
        -- <descr>Covariance of x and y</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^2</unit>
    psfFlux DOUBLE NULL,
        -- <descr>Uncalibrated PSF flux of $1.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    psfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of $1.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFlux DOUBLE NULL,
        -- <descr>Uncalibrated model flux of $1.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of modelFlux</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Uncalibrated instrumental flux of $1.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of instFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apCorrection DOUBLE NULL,
        -- <descr>Aperture correction factor applied to fluxes</descr>
        -- <ucd>arith.factor</ucd>
    apCorrectionSigma DOUBLE NULL,
        -- <descr>Aperture correction uncertainty</descr>
        -- <ucd>stat.error</ucd>
    shapeIx DOUBLE NULL,
        -- <descr>First moment.</descr>
        -- <unit>pixel</unit>
    shapeIy DOUBLE NULL,
        -- <descr>First moment.</descr>
        -- <unit>pixel</unit>
    shapeIxVar DOUBLE NULL,
         -- <descr>Variance of momentIx.</descr>
         -- <ucd>stat.variance</ucd>
         -- <unit>pixel</unit>
    shapeIyVar DOUBLE NULL,
         -- <descr>Variance of momentIy.</descr>
         -- <ucd>stat.variance</ucd>
         -- <unit>pixel</unit>
    shapeIxIyCov DOUBLE NULL,
         -- <descr>Covariance of momentIx and momentIy.</descr>
         -- <ucd>stat.variance</ucd>
         -- <unit>pixel</unit>
    shapeIxx DOUBLE NULL,
        -- <descr>Second moment.</descr>
        -- <unit>pixel^2</unit>
    shapeIyy DOUBLE NULL,
        -- <descr>Second moment.</descr>
        -- <unit>pixel^2</unit>
    shapeIxy DOUBLE NULL,
        -- <descr>Second moment.</descr>
        -- <unit>pixel^2</unit>
    shapeIxxVar DOUBLE NULL,
        -- <descr>Variance of shapeIxx.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>pixel^4</unit>
    shapeIyyVar DOUBLE NULL,
        -- <descr>Variance of shapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>pixel^4</unit>
    shapeIxyVar DOUBLE NULL,
        -- <descr>Variance of shapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>pixel^4</unit>
    shapeIxxIyyCov DOUBLE NULL,
        -- <descr>Covariance of shapeIxx and shapeIyy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^4</unit>
    shapeIxxIxyCov DOUBLE NULL,
        -- <descr>Covariance of shapeIxx and shapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^4</unit>
    shapeIyyIxyCov DOUBLE NULL,
        -- <descr>Covariance of shapeIyy and shapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^4</unit>
    extendedness FLOAT NULL,
        -- <descr>Probability of being extended.<descr>
        -- <ucd>stat.probability</ucd>
    flagNegative BIT(1) NOT NULL,
        -- <descr>Set if $1 was detected as significantly negative.</descr>
        -- <ucd>meta.code</ucd>
    flagBadMeasCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid algorithm used to feed centers to other
        -- measurement algorithms failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagPixEdge BIT(1) NOT NULL,
        -- <descr>Set if $1 is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpAny BIT(1) NOT NULL,
        -- <descr>Set if $1 footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpCen BIT(1) NOT NULL,
        -- <descr>Set if $1 center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturAny BIT(1) NOT NULL,
        -- <descr>Set if $1 footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturCen BIT(1) NOT NULL,
        -- <descr>Set if $1 center is close to
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagBadPsfFlux BIT(1) NOT NULL,
        -- <descr>Set if the psfFlux measurement failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagBadApFlux BIT(1) NOT NULL,
        -- <descr>Set if the apFlux measurement failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagBadModelFlux BIT(1) NOT NULL,
        -- <descr>Set if the modelFlux measurement failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagBadInstFlux BIT(1) NOT NULL,
        -- <descr>Set if the instFlux measurement failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagBadCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid measurement failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagBadShape BIT(1) NOT NULL,
        -- <descr>Set if the shape measurement did not completely
        -- succeed.</descr>
        -- <ucd>meta.code.error</ucd>
    chunkId INTEGER NOT NULL DEFAULT 0,
        -- <descr>Internal column used by qserv.</descr>
    subChunkId INTEGER NOT NULL DEFAULT 0,
        -- <descr>Internal column used by qserv.</descr>')dnl


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
        -- <ucd>instr.det</ucd>
    ccd TINYINT NOT NULL,
        -- <descr>CCD id from CcdMap table this exposure belongs to.</descr>
        -- <ucd>meta.id</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Ccd name, pulled in from the CcdMap table.</descr>
        -- <ucd>instr.det</ucd>
    amp TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the AmpMap table.</descr>
        -- <ucd>meta.id</ucd>
    ampName CHAR(3) NOT NULL,
        -- <descr>Amp name, pulled in from the AmpMap table.</descr>
        -- <ucd>instr.det</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>Id of the filter used for this exposure.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName CHAR(3) NOT NULL,
        -- <descr>Filter name, pulled in from the Filter table.</descr>
        -- <ucd>instr.bandpass</ucd>
    M4_SPATIAL_EXPOSURE_COLUMNS()
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
    PRIMARY KEY (rawAmpExposureId),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;

M4_KEY_VALUE_TABLE(`Raw_Amp_Exposure', `rawAmpExposureId')

M4_HTM_MAPPING_TABLE(`Raw_Amp_Exposure', `rawAmpExposureId', `11')

CREATE TABLE Raw_Amp_To_Science_Ccd_Exposure
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to the Science_Ccd_Exposure.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    snap TINYINT NOT NULL,
        -- <ucd>meta.code.multip;obs.sequence</ucd>
    amp TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the AmpMap table.
        -- </descr>
        -- <ucd>meta.id;instr.det</ucd>
    PRIMARY KEY (rawAmpExposureId),
    KEY scienceCcdExposureId (scienceCcdExposureId ASC)
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
        -- <ucd>instr.det</ucd>
    ccd TINYINT NOT NULL,
        -- <descr>Reference to the corresponding entry in the CcdMap table.</descr>
        -- <ucd>meta.id</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>CCD name, pulled in from the CcdMap table.</descr>
        -- <ucd>instr.det</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>Id of the filter used for this exposure.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName CHAR(3) NOT NULL,
        -- <descr>Filter name, pulled in from the Filter table.</descr>
        -- <ucd>instr.bandpass</ucd>
    M4_SPATIAL_EXPOSURE_COLUMNS()
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
        -- combined exposure.</descr>
        -- <ucd>time.epoch</ucd>
    expTime FLOAT NOT NULL,
        -- <descr>Duration of exposure.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    nCombine INTEGER NOT NULL,
        -- <descr>Number of images co-added to create a deeper image.</descr>
    binX INTEGER NOT NULL,
        -- <descr>Binning of the CCD in x.</descr>
        -- <ucd>meta.number</ucd>
        -- <unit>pixel</unit>
    binY INTEGER NOT NULL,
        -- <descr>Binning of the CCD in y.</descr>
        -- <ucd>meta.number</ucd>
        -- <unit>pixel</unit>
    readNoise FLOAT NOT NULL,
        -- <descr>Read noise of the CCD.</descr>
        -- <ucd>instr.det.noise</ucd>
        -- <unit>adu</unit>
    saturationLimit INTEGER NOT NULL,
        -- <descr>Saturation limit for the CCD (average of the amplifiers).
        -- </descr>
        -- <ucd>instr.saturation</ucd>
        -- <ucd>arith.factor;instr.det</ucd>
        -- <unit>electron/adu</unit>
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
    path VARCHAR(255) NOT NULL,
        -- <descr>FITS file path relative to the pipeline output
        -- directory.</descr>
    PRIMARY KEY (scienceCcdExposureId),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;

M4_KEY_VALUE_TABLE(`Science_Ccd_Exposure', `scienceCcdExposureId')

M4_HTM_MAPPING_TABLE(`Science_Ccd_Exposure', `scienceCcdExposureId', `10')

m4def(`M4_COADD_TABLES',
`CREATE TABLE $1Coadd
(
    $2CoaddId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    tract INTEGER NOT NULL,
        -- <descr>Sky-tract number.</descr>
    patch CHAR(16) NOT NULL,
        -- <descr>Sky-patch.</descr>
    ifelse(`$1', `ChiSquared', `', `filterId TINYINT NOT NULL,
        -- <descr>Id of the filter for the band.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName CHAR(3) NOT NULL,
        -- <descr>Filter name, pulled in from the Filter table.</descr>
        -- <ucd>instr.bandpass</ucd>')
    M4_SPATIAL_EXPOSURE_COLUMNS()
    fluxMag0 FLOAT NOT NULL,
        -- <ucd>phot.flux.density</ucd>
    fluxMag0Sigma FLOAT NOT NULL,
        -- <ucd>stat.error;phot.flux.density</ucd>
    matchedFwhm DOUBLE NULL,
        -- <descr>FWHM computed from PSF that was matched to during coaddition.
        -- NULL if coadds were created with PSF-matching turned off.</descr>
        -- <ucd>instr.obsty.seeing</ucd>
        -- <unit>arcsec</unit>
    measuredFwhm DOUBLE NULL,
        -- <descr>FWHM computed from measured PSF. NULL if coadds were
        -- created with PSF-matching turned on and the pipeline was
        -- configured to use the matched-to PSF.</descr>
        -- <ucd>instr.obsty.seeing</ucd>
        -- <unit>arcsec</unit>
    path VARCHAR(255) NOT NULL,
        -- <descr>FITS file path relative to the SFM pipeline output
        -- directory.</descr>
    PRIMARY KEY($2CoaddId),
    KEY IDX_htmId20 (htmId20 ASC),
    ifelse(`$1', `ChiSquared',
    `KEY IDX_tract_patch (tract ASC, patch ASC)',
    `KEY IDX_tract_patch_filterName (tract ASC, patch ASC, filterName ASC)')
) ENGINE=MyISAM;

M4_KEY_VALUE_TABLE(`$1Coadd', `$2CoaddId')

M4_HTM_MAPPING_TABLE(`$1Coadd', `$2CoaddId',`$3')

CREATE TABLE $1Source
    -- <descr>Table to store high signal-to-noise &quot;sources&quot;
    -- measured on the coadd exposures in $1Coadd.</descr>
(
    $2SourceId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier)</descr>
        -- <ucd>meta.id;src</ucd>
    parent$1SourceId BIGINT NULL,
        -- <descr>$2SourceId of parent if source is deblended, otherwise NULL.</descr>
        -- <ucd>meta.id.parent;src</ucd>
    $2CoaddId BIGINT NOT NULL,
        -- <descr>ID of the coadd the source was detected and measured on
        -- (pointer to $1Coadd).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    ifelse(`$1', `ChiSquared', `', `filterId TINYINT NOT NULL,
        -- <descr>ID of filter used for the coadd the object
        -- was detected and measured on.</descr>
        -- <ucd>meta.id;instr.filter</ucd>')
    M4_SOURCE_COLUMNS(`source')
    PRIMARY KEY ($2SourceId),
    KEY IDX_$2CoaddId ($2CoaddId ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;

CREATE TABLE Ref$1SrcMatch
    -- <descr>Table containing the results of a spatial match between
    -- RefObject and $1Source.</descr>
(
    refObjectId BIGINT NULL,
        -- <descr>Reference object id (pointer to RefObject). NULL if
        -- reference object has no matches.</descr>
        -- <ucd>meta.id</ucd>
    $2SourceId BIGINT NULL,
        -- <descr>Coadd-source id. NULL if source has no matches.</descr>
        -- <ucd>meta.id</ucd>
    angSep DOUBLE NULL,
        -- <descr>Angular separation between reference object and coadd-source.
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
    KEY ($2SourceId),
    KEY (refObjectId)
) ENGINE=MyISAM;

CREATE TABLE $1ForcedSource
    -- <descr>Table of forced-photometry sources, measured using
    -- positions of objects from $1Source.</descr>
(
    $2ForcedSourceId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier)</descr>
        -- <ucd>meta.id;src</ucd>
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>ID of CCD the forced-source was detected and measured on
        -- (pointer to Science_Ccd_Exposure).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>ID of filter used for the exposure the source
        -- was detected and measured on.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    timeMid DOUBLE NOT NULL,
        -- <descr>Middle of exposure time (MJD, TAI).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    expTime FLOAT NOT NULL,
        -- <descr>Exposure time (TAI) or, in case of measurement on coadded
        -- snap exposure pairs, the sum of snap exposure times.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    $2SourceId BIGINT NOT NULL,
        -- <descr>ID of object that triggered measurement
        -- of this forced-source (pointer to $1Source).</descr>
        -- <ucd>meta.id;src</ucd>
    $2SourceRa DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of object that triggered measurement
        -- of this forced-source.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    $2SourceDecl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of object that triggered measurement
        -- of this forced-source.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    M4_SOURCE_COLUMNS(`forced-source')
    PRIMARY KEY ($2ForcedSourceId),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId ASC),
    KEY IDX_filterId (filterId ASC),
    KEY IDX_objectId ($2SourceId ASC),
    KEY IDX_decl (decl ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;
')dnl

M4_COADD_TABLES(`GoodSeeing', `goodSeeing', `10')

M4_COADD_TABLES(`Deep', `deep', `10')

M4_COADD_TABLES(`ChiSquared', `chiSquared', `10')

m4def(`M4_PER_FILTER_OBJECT_COLUMNS',
`$1ObsCount INTEGER NOT NULL,
        -- <descr>Number of $1-filter sources associated with this object.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    $1ObsTimeMin DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was first observed in the
        -- $1 filter (earliest timeMid of associated $1-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    $1ObsTimeMax DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was last observed in the
        -- $1 filter (latest timeMid of associated $1-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    $1PsfFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB psfFlux of $1-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    $1PsfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of $1PsfFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    $1PsfFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute $1PsfFlux and
        -- $1PsfFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    $1ApFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB apFlux of $1-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    $1ApFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of $1ApFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    $1ApFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute $1ApFlux and
        -- $1ApFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    $1ModelFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB modelFlux of $1-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    $1ModelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of $1ModelFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    $1ModelFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute $1ModelFlux and
        -- $1ModelFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    $1InstFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB instFlux of $1-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    $1InstFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of $1InstFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    $1InstFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute $1InstFlux and
        -- $1InstFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    $1ShapeIxx DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of $1-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    $1ShapeIyy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of $1-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    $1ShapeIxy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of $1-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    $1ShapeIxxVar DOUBLE NULL,
        -- <descr>Variance of $1ShapeIxx.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    $1ShapeIyyVar DOUBLE NULL,
        -- <descr>Variance of $1ShapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    $1ShapeIxyVar DOUBLE NULL,
        -- <descr>Variance of $1ShapeIxy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    $1ShapeIxxIyyCov DOUBLE NULL,
        -- <descr>Covariance of $1ShapeIxx and $1ShapeIyy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    $1ShapeIxxIxyCov DOUBLE NULL,
        -- <descr>Covariance of $1ShapeIxx and $1ShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    $1ShapeIyyIxyCov DOUBLE NULL,
        -- <descr>Covariance of $1ShapeIyy and $1ShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    $1ShapeCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute 
        -- the $1Shape columns.</descr>
        -- <ucd>meta.number;stat.value</ucd>
')dnl

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
    ra DOUBLE NOT NULL,
        -- <descr>RA of mean source cluster position. Computed from the
        -- normalized sum of the unit vector positions of all sources belonging
        -- to an object, where unit vectors are computed from the Source ra
        -- and decl column values. For sources that are close together this is
        -- equivalent to minimizing the sum of the square angular separations
        -- between the source positions and the object position.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Dec of mean source cluster position. Computed from the
        -- normalized sum of the unit vector positions of all sources belonging
        -- to an object, where unit vectors are computed from the Source ra
        -- and decl column  values. For sources that are close together this is
        -- equivalent to minimizing the sum of the square angular separations
        -- between the source positions and the object position.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    raVar DOUBLE NULL,
        -- <descr>Variance of ra, taken from the sample covariance matrix
        -- of (ra, decl). The standard error of the mean ra is
        -- sqrt(raVar/obsCount)</descr>
        -- <ucd>stat.variance;pos.eq.ra</ucd>
        -- <unit>arcsec^2</unit>
    declVar DOUBLE NULL,
        -- <descr>Variance of decl, taken from the sample covariance matrix
        -- of (ra, decl). The standard error of the mean decl is
        -- sqrt(declVar/obsCount)</descr>
        -- <ucd>stat.variance;pos.eq.dec</ucd>
        -- <unit>arcsec^2</unit>
    radeclCov DOUBLE NULL,
        -- <descr>Sample covariance of ra and decl.</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>arcsec^2</unit>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
        -- <ucd>pos.HTM</ucd>
    wmRa DOUBLE NULL,
        -- <descr>Inverse variance weighted mean source cluster
        -- position RA.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    wmDecl DOUBLE NULL,
        -- <descr>Inverse variance weighted mean source cluster
        -- position Dec.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    wmRaVar DOUBLE NULL,
        -- <descr>Variance of wmRa.</descr>
        -- <ucd>stat.variance;pos.eq.ra</ucd>
        -- <unit>arcsec^2</unit>
    wmDeclVar DOUBLE NULL,
        -- <descr>Variance of wmDecl.</descr>
        -- <ucd>stat.variance;pos.eq.decl</ucd>
        -- <unit>arcsec^2</unit>
    wmRadeclCov DOUBLE NULL,
        -- <descr>Covariance of wmRa and wmDecl.</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>arcsec^2</unit>
    obsCount INTEGER NOT NULL,
        -- <descr>Number of sources associated with this object.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    obsTimeMin DOUBLE NULL,
        -- <descr>Time when this object was observed for the first time,
        -- MJD TAI (timeMid of the first Source).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    obsTimeMax DOUBLE NULL,
        -- <descr>The latest time when this object was observed, MJD TAI 
        -- (timeMid of the last Source).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    obsTimeMean DOUBLE NULL,
        -- <descr>The mean of the observation times (timeMid values) of the
        -- sources associated with this object, MJD TAI.</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    flagNoise BIT(1) NOT NULL,
        -- <descr>Set if cluster was created from a single noise source.</descr>
        -- <ucd>meta.code</ucd>

    M4_PER_FILTER_OBJECT_COLUMNS(`u')
    M4_PER_FILTER_OBJECT_COLUMNS(`g')
    M4_PER_FILTER_OBJECT_COLUMNS(`r')
    M4_PER_FILTER_OBJECT_COLUMNS(`i')
    M4_PER_FILTER_OBJECT_COLUMNS(`z')
    M4_PER_FILTER_OBJECT_COLUMNS(`y')

    chunkId INTEGER NOT NULL DEFAULT 0,
        -- <descr>Internal column used by qserv.</descr>
    subChunkId INTEGER NOT NULL DEFAULT 0,
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (objectId),
    KEY IDX_decl (decl),
    KEY IDX_htmId20 (htmId20)
) ENGINE=MyISAM;


CREATE TABLE Source
    -- <descr>Table to store high signal-to-noise &quot;sources&quot;. A source
    -- is a measurement of an astrophysical object's properties from a single
    -- exposure or coadded exposure pair that contains its footprint on the
    -- sky.</descr>
(
    sourceId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier)</descr>
        -- <ucd>meta.id;src</ucd>
    parentSourceId BIGINT NULL,
        -- <descr>sourceId of parent if source is deblended, otherwise NULL.</descr>
        -- <ucd>meta.id.parent;src</ucd>
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>ID of CCD the source was detected and measured on
        -- (pointer to Science_Ccd_Exposure).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>ID of filter used for the exposure the source
        -- was detected and measured on.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    timeMid DOUBLE NOT NULL,
        -- <descr>Middle of exposure time (MJD, TAI).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    expTime FLOAT NOT NULL,
        -- <descr>Exposure time (TAI) or, in case of measurement on coadded
        -- snap exposure pairs, the sum of snap exposure times.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    objectId BIGINT NULL,
        -- <descr>ID of object this source was assigned to. NULL if the source
        -- did not participate in spatial clustering, or if the clustering
        -- algorithm considered the source to be a 'noise' source.</descr>
        -- <ucd>meta.id;src</ucd>
    objectRa DOUBLE NULL,
        -- <descr>ICRS RA of object associated with this source, or ra if the
        -- source was not associated with any object (objectId is NULL).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    objectDecl DOUBLE NULL,
        -- <descr>ICRS Dec of object associated with this source, or decl if the
        -- source was not associated with any object (objectId is NULL).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    M4_SOURCE_COLUMNS(`source')
    PRIMARY KEY (sourceId),
    KEY IDX_parentSourceId (parentSourceId ASC),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId ASC),
    KEY IDX_filterId (filterId ASC),
    KEY IDX_objectId (objectId ASC),
    KEY IDX_decl (decl ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE Visit
    -- <descr>Defines a single Visit. 1 row per LSST visit.</descr>
(
    visitId INTEGER NOT NULL,
        -- <descr>Unique identifier.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    PRIMARY KEY (visitId)
) ENGINE=MyISAM;


CREATE TABLE SkyTile
    -- <descr>IDs of sky-tiles for which data has been loaded.</descr>
(
    skyTileId BIGINT NOT NULL,
    PRIMARY KEY (skyTileId)
) ENGINE=MyISAM;


SET FOREIGN_KEY_CHECKS=1;

m4def(`M4_COADD_CONSTRAINTS',
`ALTER TABLE $1Coadd_To_Htm$3 ADD CONSTRAINT FK_$1Coadd_To_Htm$3_$2CoaddId
    FOREIGN KEY ($2CoaddId) REFERENCES $1Coadd ($2CoaddId);

ALTER TABLE $1Coadd_Metadata ADD CONSTRAINT FK_$1Coadd_Metadata_$2CoaddId
    FOREIGN KEY ($2CoaddId) REFERENCES $1Coadd ($2CoaddId);

ifelse(`$1', `ChiSquared', `',
`ALTER TABLE $1Coadd ADD CONSTRAINT FK_$1Coadd_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE $1Source ADD CONSTRAINT FK_$1Source_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);')
ALTER TABLE $1Source ADD CONSTRAINT FK_$1Source_$2CoaddId
    FOREIGN KEY ($2CoaddId) REFERENCES $1Coadd ($2CoaddId);
ALTER TABLE $1Source ADD CONSTRAINT FK_$1Source_parent$1SourceId
    FOREIGN KEY (parent$1SourceId) REFERENCES $1Source ($2SourceId);

ALTER TABLE Ref$1SrcMatch ADD CONSTRAINT FK_Ref$1SrcMatch_$2SourceId
    FOREIGN KEY ($2SourceId) REFERENCES $1Source ($2SourceId);
ALTER TABLE Ref$1SrcMatch ADD CONSTRAINT FK_Ref$1SrcMatch_refObjectId
    FOREIGN KEY (refObjectId) REFERENCES RefObject (refObjectId);

ALTER TABLE $1ForcedSource ADD CONSTRAINT FK_$1ForcedSource_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);
ALTER TABLE $1ForcedSource ADD CONSTRAINT FK_$1ForcedSource_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);
ALTER TABLE $1ForcedSource ADD CONSTRAINT FK_$1ForcedSource_$2SourceId
    FOREIGN KEY ($2SourceId) REFERENCES $1Source ($2SourceId);
')dnl

ALTER TABLE RefObjMatch ADD CONSTRAINT FK_RefObjMatch_refObjectId
    FOREIGN KEY (refObjectId) REFERENCES RefObject (refObjectId);
ALTER TABLE RefObjMatch ADD CONSTRAINT FK_RefObjMatch_objectId
    FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE RefSrcMatch ADD CONSTRAINT FK_RefSrcMatch_refObjectId
    FOREIGN KEY (refObjectId) REFERENCES RefObject (refObjectId);
ALTER TABLE RefSrcMatch ADD CONSTRAINT FK_RefSrcMatch_sourceId
    FOREIGN KEY (sourceId) REFERENCES Source (sourceId);

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

ALTER TABLE Science_Ccd_Exposure_To_Htm10 ADD CONSTRAINT FK_ScienceCcdExposureToHtm10_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);

M4_COADD_CONSTRAINTS(`GoodSeeing', `goodSeeing', `10')

M4_COADD_CONSTRAINTS(`Deep', `deep', `10')

M4_COADD_CONSTRAINTS(`ChiSquared', `chiSquared', `10')

ALTER TABLE Source ADD CONSTRAINT FK_Source_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);
ALTER TABLE Source ADD CONSTRAINT FK_Source_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);
ALTER TABLE Source ADD CONSTRAINT FK_Source_objectId
    FOREIGN KEY (objectId) REFERENCES Object (objectId);
ALTER TABLE Source ADD CONSTRAINT FK_Source_parentSourceId
    FOREIGN KEY (parentSourceId) REFERENCES Source (sourceId);

