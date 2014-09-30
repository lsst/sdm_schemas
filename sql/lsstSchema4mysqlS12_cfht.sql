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

INSERT INTO ZZZ_Db_Description(f) VALUES('lsstSchema4mysqlS12_cfht.sql');


CREATE TABLE Filter
(
    filterId TINYINT NOT NULL,
        -- <descr>Unique id (primary key).</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName CHAR(3) NOT NULL,
        -- <descr>Filter name. Valid values: 'u', 'g', 'r', 'i', 'z', 'i2'</descr>
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
    -- <descr>Not filled. 
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



CREATE TABLE Science_Ccd_Exposure
(
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    runId CHAR(6) NOT NULL,
        -- <descr>Run number.</descr>
    object CHAR(2) NOT NULL,
        -- <descr>Field type.</descr>
    date CHAR(10) NOT NULL,
        -- <descr>Date.</descr>
    filterId TINYINT NOT NULL,
        -- <descr>Filter Id.</descr>
    filterName CHAR(2) NOT NULL,
        -- <descr>Filter Name.</descr>
    visit BIGINT NOT NULL,
        -- <descr>Visit Id.</descr>
    ccd SMALLINT NOT NULL,
        -- <descr>CCD Nbr.</descr>
    ccdName CHAR(5) NOT NULL,
        -- <descr>CCD Name.</descr>
    ra DOUBLE NOT NULL,
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
        -- for the exposure.</descr>
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
    fluxMag0 FLOAT NOT NULL,
        -- <ucd>phot.flux.density</ucd>
    fluxMag0Sigma FLOAT NOT NULL,
        -- <ucd>stat.error;phot.flux.density</ucd>
    fwhm DOUBLE NOT NULL,
        -- <ucd>instr.obsty.seeing</ucd>
        -- <unit>arcsec</unit>
    path VARCHAR(255) NOT NULL,
        -- <descr>CCD FITS file path relative to the SFM pipeline output
        -- directory.</descr>
    PRIMARY KEY (scienceCcdExposureId),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;

CREATE TABLE Science_Ccd_Exposure_Metadata
    -- <descr>Generic key-value pair metadata for Science_Ccd_Exposure.</descr>
(
    scienceCcdExposureId BIGINT NOT NULL,
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
        --    <li>6: Keith coadd</li>
        --  </ul></descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (scienceCcdExposureId, metadataKey),
    KEY IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;

CREATE TABLE Science_Ccd_Exposure_To_Htm10
    -- <descr>Stores a mapping between exposures in Science_Ccd_Exposure and the IDs of
    -- spatially overlapping level-10 HTM triangles.</descr>
(
    scienceCcdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to Science_Ccd_Exposure.</descr>
    htmId10 INTEGER NOT NULL,
        -- <descr>ID for Level 10 HTM triangle overlapping exposure.
        -- For each exposure in Science_Ccd_Exposure, there will be one row for every
        -- overlapping triangle.</descr>
        -- <ucd>pos.HTM</ucd>
    KEY IDX_htmId10 (htmId10 ASC),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId ASC)
) ENGINE=MyISAM;



CREATE TABLE GoodSeeingCoadd
    
(
    goodSeeingCoaddId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    tract INTEGER NOT NULL,
        -- <descr>Sky-tract number.</descr>
    patch CHAR(16) NOT NULL,
        -- <descr>Sky-patch.</descr>
    filterId TINYINT NOT NULL,
        -- <descr>Id of the filter for the band.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName CHAR(3) NOT NULL,
        -- <descr>Filter name, pulled in from the Filter table.</descr>
        -- <ucd>instr.bandpass</ucd>
    ra DOUBLE NOT NULL,
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
        -- for the exposure.</descr>
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
    PRIMARY KEY(goodSeeingCoaddId),
    KEY IDX_htmId20 (htmId20 ASC),
    KEY IDX_tract_patch_filterName (tract ASC, patch ASC, filterName ASC)
) ENGINE=MyISAM;


CREATE TABLE GoodSeeingCoadd_Metadata
    -- <descr>Generic key-value pair metadata for GoodSeeingCoadd.</descr>
(
    goodSeeingCoaddId BIGINT NOT NULL,
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
        --    <li>6: Keith coadd</li>
        --  </ul></descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (goodSeeingCoaddId, metadataKey),
    KEY IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;

CREATE TABLE GoodSeeingCoadd_To_Htm10
    -- <descr>Stores a mapping between exposures in GoodSeeingCoadd and the IDs of
    -- spatially overlapping level-10 HTM triangles.</descr>
(
    goodSeeingCoaddId BIGINT NOT NULL,
        -- <descr>Pointer to GoodSeeingCoadd.</descr>
    htmId10 INTEGER NOT NULL,
        -- <descr>ID for Level 10 HTM triangle overlapping exposure.
        -- For each exposure in GoodSeeingCoadd, there will be one row for every
        -- overlapping triangle.</descr>
        -- <ucd>pos.HTM</ucd>
    KEY IDX_htmId10 (htmId10 ASC),
    KEY IDX_goodSeeingCoaddId (goodSeeingCoaddId ASC)
) ENGINE=MyISAM;

CREATE TABLE GoodSeeingSource
    -- <descr>Table to store high signal-to-noise &quot;sources&quot;
    -- measured on the coadd exposures in GoodSeeingCoadd.</descr>
(
    goodSeeingSourceId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier)</descr>
        -- <ucd>meta.id;src</ucd>
    parentGoodSeeingSourceId BIGINT NULL,
        -- <descr>goodSeeingSourceId of parent if source is deblended, otherwise NULL.</descr>
        -- <ucd>meta.id.parent;src</ucd>
    goodSeeingCoaddId BIGINT NOT NULL,
        -- <descr>ID of the coadd the source was detected and measured on
        -- (pointer to GoodSeeingCoadd).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>ID of filter used for the coadd the source
        -- was detected and measured on.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of source centroid (x, y).</descr>
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
        -- <descr>Pixel axis 1 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y DOUBLE NOT NULL,
        -- <descr>Pixel axis 2 coordinate of source centroid,
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
        -- <descr>Uncalibrated PSF flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    psfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFlux DOUBLE NULL,
        -- <descr>Uncalibrated model flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of modelFlux</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Uncalibrated instrumental flux of source.</descr>
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
        -- <descr>Set if source was detected as significantly negative.</descr>
        -- <ucd>meta.code</ucd>
    flagBadMeasCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid algorithm used to feed centers to other
        -- measurement algorithms failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagPixEdge BIT(1) NOT NULL,
        -- <descr>Set if source is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpAny BIT(1) NOT NULL,
        -- <descr>Set if source footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpCen BIT(1) NOT NULL,
        -- <descr>Set if source center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturAny BIT(1) NOT NULL,
        -- <descr>Set if source footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturCen BIT(1) NOT NULL,
        -- <descr>Set if source center is close to
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
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (goodSeeingSourceId),
    KEY IDX_goodSeeingCoaddId (goodSeeingCoaddId ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE GoodSeeingForcedSource
    -- <descr>Table of forced-photometry sources, measured using
    -- positions of objects from GoodSeeingSource.</descr>
(
    goodSeeingForcedSourceId BIGINT NOT NULL,
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
    goodSeeingSourceId BIGINT NOT NULL,
        -- <descr>ID of object that triggered measurement
        -- of this forced-source (pointer to GoodSeeingSource).</descr>
        -- <ucd>meta.id;src</ucd>
    goodSeeingSourceRa DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of object that triggered measurement
        -- of this forced-source.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    goodSeeingSourceDecl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of object that triggered measurement
        -- of this forced-source.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of forced-source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of forced-source centroid (x, y).</descr>
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
        -- <descr>Pixel axis 1 coordinate of forced-source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y DOUBLE NOT NULL,
        -- <descr>Pixel axis 2 coordinate of forced-source centroid,
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
        -- <descr>Uncalibrated PSF flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    psfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFlux DOUBLE NULL,
        -- <descr>Uncalibrated model flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of modelFlux</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Uncalibrated instrumental flux of forced-source.</descr>
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
        -- <descr>Set if forced-source was detected as significantly negative.</descr>
        -- <ucd>meta.code</ucd>
    flagBadMeasCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid algorithm used to feed centers to other
        -- measurement algorithms failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagPixEdge BIT(1) NOT NULL,
        -- <descr>Set if forced-source is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpAny BIT(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpCen BIT(1) NOT NULL,
        -- <descr>Set if forced-source center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturAny BIT(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturCen BIT(1) NOT NULL,
        -- <descr>Set if forced-source center is close to
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
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (goodSeeingForcedSourceId),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId ASC),
    KEY IDX_filterId (filterId ASC),
    KEY IDX_objectId (goodSeeingSourceId ASC),
    KEY IDX_decl (decl ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE DeepCoadd
    -- <descr>Not filled.</descr>
(
    deepCoaddId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    tract INTEGER NOT NULL,
        -- <descr>Sky-tract number.</descr>
    patch CHAR(16) NOT NULL,
        -- <descr>Sky-patch.</descr>
    filterId TINYINT NOT NULL,
        -- <descr>Id of the filter for the band.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName CHAR(3) NOT NULL,
        -- <descr>Filter name, pulled in from the Filter table.</descr>
        -- <ucd>instr.bandpass</ucd>
    ra DOUBLE NOT NULL,
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
        -- for the exposure.</descr>
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
    PRIMARY KEY(deepCoaddId),
    KEY IDX_htmId20 (htmId20 ASC),
    KEY IDX_tract_patch_filterName (tract ASC, patch ASC, filterName ASC)
) ENGINE=MyISAM;


CREATE TABLE DeepCoadd_Metadata
    -- <descr>Not filled. Generic key-value pair metadata for DeepCoadd.</descr>
(
    deepCoaddId BIGINT NOT NULL,
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
        --    <li>6: Keith coadd</li>
        --  </ul></descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (deepCoaddId, metadataKey),
    KEY IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;

CREATE TABLE DeepCoadd_To_Htm10
    -- <descr>Not filled. Stores a mapping between exposures in DeepCoadd and the IDs of
    -- spatially overlapping level-10 HTM triangles.</descr>
(
    deepCoaddId BIGINT NOT NULL,
        -- <descr>Pointer to DeepCoadd.</descr>
    htmId10 INTEGER NOT NULL,
        -- <descr>ID for Level 10 HTM triangle overlapping exposure.
        -- For each exposure in DeepCoadd, there will be one row for every
        -- overlapping triangle.</descr>
        -- <ucd>pos.HTM</ucd>
    KEY IDX_htmId10 (htmId10 ASC),
    KEY IDX_deepCoaddId (deepCoaddId ASC)
) ENGINE=MyISAM;

CREATE TABLE DeepSource
    -- <descr>Not filled. Table to store high signal-to-noise &quot;sources&quot;
    -- measured on the coadd exposures in DeepCoadd.</descr>
(
    deepSourceId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier)</descr>
        -- <ucd>meta.id;src</ucd>
    parentDeepSourceId BIGINT NULL,
        -- <descr>deepSourceId of parent if source is deblended, otherwise NULL.</descr>
        -- <ucd>meta.id.parent;src</ucd>
    deepCoaddId BIGINT NOT NULL,
        -- <descr>ID of the coadd the source was detected and measured on
        -- (pointer to DeepCoadd).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>ID of filter used for the coadd the source
        -- was detected and measured on.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of source centroid (x, y).</descr>
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
        -- <descr>Pixel axis 1 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y DOUBLE NOT NULL,
        -- <descr>Pixel axis 2 coordinate of source centroid,
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
        -- <descr>Uncalibrated PSF flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    psfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFlux DOUBLE NULL,
        -- <descr>Uncalibrated model flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of modelFlux</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Uncalibrated instrumental flux of source.</descr>
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
        -- <descr>Set if source was detected as significantly negative.</descr>
        -- <ucd>meta.code</ucd>
    flagBadMeasCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid algorithm used to feed centers to other
        -- measurement algorithms failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagPixEdge BIT(1) NOT NULL,
        -- <descr>Set if source is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpAny BIT(1) NOT NULL,
        -- <descr>Set if source footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpCen BIT(1) NOT NULL,
        -- <descr>Set if source center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturAny BIT(1) NOT NULL,
        -- <descr>Set if source footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturCen BIT(1) NOT NULL,
        -- <descr>Set if source center is close to
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
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (deepSourceId),
    KEY IDX_deepCoaddId (deepCoaddId ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE DeepForcedSource
    -- <descr>Not filled. Table of forced-photometry sources, measured using
    -- positions of objects from DeepSource.</descr>
(
    deepForcedSourceId BIGINT NOT NULL,
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
    deepSourceId BIGINT NOT NULL,
        -- <descr>ID of object that triggered measurement
        -- of this forced-source (pointer to DeepSource).</descr>
        -- <ucd>meta.id;src</ucd>
    deepSourceRa DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of object that triggered measurement
        -- of this forced-source.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    deepSourceDecl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of object that triggered measurement
        -- of this forced-source.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of forced-source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of forced-source centroid (x, y).</descr>
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
        -- <descr>Pixel axis 1 coordinate of forced-source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y DOUBLE NOT NULL,
        -- <descr>Pixel axis 2 coordinate of forced-source centroid,
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
        -- <descr>Uncalibrated PSF flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    psfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFlux DOUBLE NULL,
        -- <descr>Uncalibrated model flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of modelFlux</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Uncalibrated instrumental flux of forced-source.</descr>
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
        -- <descr>Set if forced-source was detected as significantly negative.</descr>
        -- <ucd>meta.code</ucd>
    flagBadMeasCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid algorithm used to feed centers to other
        -- measurement algorithms failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagPixEdge BIT(1) NOT NULL,
        -- <descr>Set if forced-source is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpAny BIT(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpCen BIT(1) NOT NULL,
        -- <descr>Set if forced-source center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturAny BIT(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturCen BIT(1) NOT NULL,
        -- <descr>Set if forced-source center is close to
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
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (deepForcedSourceId),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId ASC),
    KEY IDX_filterId (filterId ASC),
    KEY IDX_objectId (deepSourceId ASC),
    KEY IDX_decl (decl ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE ChiSquaredCoadd
    -- <descr>Not filled.</descr>
(
    chiSquaredCoaddId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    tract INTEGER NOT NULL,
        -- <descr>Sky-tract number.</descr>
    patch CHAR(16) NOT NULL,
        -- <descr>Sky-patch.</descr>
    
    ra DOUBLE NOT NULL,
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
        -- for the exposure.</descr>
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
    PRIMARY KEY(chiSquaredCoaddId),
    KEY IDX_htmId20 (htmId20 ASC),
    KEY IDX_tract_patch (tract ASC, patch ASC)
) ENGINE=MyISAM;


CREATE TABLE ChiSquaredCoadd_Metadata
    -- <descr>Not filled. Generic key-value pair metadata for ChiSquaredCoadd.</descr>
(
    chiSquaredCoaddId BIGINT NOT NULL,
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
        --    <li>6: Keith coadd</li>
        --  </ul></descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (chiSquaredCoaddId, metadataKey),
    KEY IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;

CREATE TABLE ChiSquaredCoadd_To_Htm10
    -- <descr>Not filled. Stores a mapping between exposures in ChiSquaredCoadd and the IDs of
    -- spatially overlapping level-10 HTM triangles.</descr>
(
    chiSquaredCoaddId BIGINT NOT NULL,
        -- <descr>Pointer to ChiSquaredCoadd.</descr>
    htmId10 INTEGER NOT NULL,
        -- <descr>ID for Level 10 HTM triangle overlapping exposure.
        -- For each exposure in ChiSquaredCoadd, there will be one row for every
        -- overlapping triangle.</descr>
        -- <ucd>pos.HTM</ucd>
    KEY IDX_htmId10 (htmId10 ASC),
    KEY IDX_chiSquaredCoaddId (chiSquaredCoaddId ASC)
) ENGINE=MyISAM;

CREATE TABLE ChiSquaredSource
    -- <descr>Not filled. Table to store high signal-to-noise &quot;sources&quot;
    -- measured on the coadd exposures in ChiSquaredCoadd.</descr>
(
    chiSquaredSourceId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier)</descr>
        -- <ucd>meta.id;src</ucd>
    parentChiSquaredSourceId BIGINT NULL,
        -- <descr>chiSquaredSourceId of parent if source is deblended, otherwise NULL.</descr>
        -- <ucd>meta.id.parent;src</ucd>
    chiSquaredCoaddId BIGINT NOT NULL,
        -- <descr>ID of the coadd the source was detected and measured on
        -- (pointer to ChiSquaredCoadd).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    
    ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of source centroid (x, y).</descr>
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
        -- <descr>Pixel axis 1 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y DOUBLE NOT NULL,
        -- <descr>Pixel axis 2 coordinate of source centroid,
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
        -- <descr>Uncalibrated PSF flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    psfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFlux DOUBLE NULL,
        -- <descr>Uncalibrated model flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of modelFlux</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Uncalibrated instrumental flux of source.</descr>
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
        -- <descr>Set if source was detected as significantly negative.</descr>
        -- <ucd>meta.code</ucd>
    flagBadMeasCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid algorithm used to feed centers to other
        -- measurement algorithms failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagPixEdge BIT(1) NOT NULL,
        -- <descr>Set if source is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpAny BIT(1) NOT NULL,
        -- <descr>Set if source footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpCen BIT(1) NOT NULL,
        -- <descr>Set if source center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturAny BIT(1) NOT NULL,
        -- <descr>Set if source footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturCen BIT(1) NOT NULL,
        -- <descr>Set if source center is close to
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
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (chiSquaredSourceId),
    KEY IDX_chiSquaredCoaddId (chiSquaredCoaddId ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE ChiSquaredForcedSource
    -- <descr>Not filled. Table of forced-photometry sources, measured using
    -- positions of objects from ChiSquaredSource.</descr>
(
    chiSquaredForcedSourceId BIGINT NOT NULL,
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
    chiSquaredSourceId BIGINT NOT NULL,
        -- <descr>ID of object that triggered measurement
        -- of this forced-source (pointer to ChiSquaredSource).</descr>
        -- <ucd>meta.id;src</ucd>
    chiSquaredSourceRa DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of object that triggered measurement
        -- of this forced-source.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    chiSquaredSourceDecl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of object that triggered measurement
        -- of this forced-source.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of forced-source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of forced-source centroid (x, y).</descr>
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
        -- <descr>Pixel axis 1 coordinate of forced-source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y DOUBLE NOT NULL,
        -- <descr>Pixel axis 2 coordinate of forced-source centroid,
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
        -- <descr>Uncalibrated PSF flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    psfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFlux DOUBLE NULL,
        -- <descr>Uncalibrated model flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of modelFlux</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Uncalibrated instrumental flux of forced-source.</descr>
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
        -- <descr>Set if forced-source was detected as significantly negative.</descr>
        -- <ucd>meta.code</ucd>
    flagBadMeasCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid algorithm used to feed centers to other
        -- measurement algorithms failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagPixEdge BIT(1) NOT NULL,
        -- <descr>Set if forced-source is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpAny BIT(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpCen BIT(1) NOT NULL,
        -- <descr>Set if forced-source center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturAny BIT(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturCen BIT(1) NOT NULL,
        -- <descr>Set if forced-source center is close to
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
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (chiSquaredForcedSourceId),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId ASC),
    KEY IDX_filterId (filterId ASC),
    KEY IDX_objectId (chiSquaredSourceId ASC),
    KEY IDX_decl (decl ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE KeithCoadd
    -- <descr>Not filled.</descr>
(
    keithCoaddId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    run SMALLINT NOT NULL,
        -- <descr>SDSS run</descr>
    rerun SMALLINT NOT NULL,
        -- <descr>SDSS rerun</descr>
    camcol TINYINT NOT NULL,
        -- <descr>SDSS camcol</descr>
    field SMALLINT NOT NULL,
        -- <descr>SDSS field</descr>
    filterId TINYINT NOT NULL,
        -- <descr>Id of the filter for the band.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName CHAR(3) NOT NULL,
        -- <descr>Filter name, pulled in from the Filter table.</descr>
        -- <ucd>instr.bandpass</ucd>
    ra DOUBLE NOT NULL,
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
        -- for the exposure.</descr>
    fluxMag0 FLOAT NOT NULL,
        -- <ucd>phot.flux.density</ucd>
    fluxMag0Sigma FLOAT NOT NULL,
        -- <ucd>stat.error;phot.flux.density</ucd>
    fwhm DOUBLE NOT NULL,
        -- <ucd>instr.obsty.seeing</ucd>
        -- <unit>arcsec</unit>
    path VARCHAR(255) NOT NULL,
        -- <descr>FITS file path relative to the SFM pipeline output
        -- directory.</descr>
    PRIMARY KEY(keithCoaddId),
    KEY IDX_htmId20 (htmId20 ASC),
    KEY IDX_sdssIdComponents (run, camcol, field, filterName, rerun)
) ENGINE=MyISAM;

CREATE TABLE KeithCoadd_Metadata
    -- <descr>Not filled. Generic key-value pair metadata for KeithCoadd.</descr>
(
    keithCoaddId BIGINT NOT NULL,
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
        --    <li>6: Keith coadd</li>
        --  </ul></descr>
    intValue INTEGER NULL,
    doubleValue DOUBLE NULL,
    stringValue VARCHAR(255) NULL,
    PRIMARY KEY (keithCoaddId, metadataKey),
    KEY IDX_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;

CREATE TABLE KeithCoadd_To_Htm10
    -- <descr>Not filled. Stores a mapping between exposures in KeithCoadd and the IDs of
    -- spatially overlapping level-10 HTM triangles.</descr>
(
    keithCoaddId BIGINT NOT NULL,
        -- <descr>Pointer to KeithCoadd.</descr>
    htmId10 INTEGER NOT NULL,
        -- <descr>ID for Level 10 HTM triangle overlapping exposure.
        -- For each exposure in KeithCoadd, there will be one row for every
        -- overlapping triangle.</descr>
        -- <ucd>pos.HTM</ucd>
    KEY IDX_htmId10 (htmId10 ASC),
    KEY IDX_keithCoaddId (keithCoaddId ASC)
) ENGINE=MyISAM;

CREATE TABLE KeithSource
    -- <descr>Not filled. Table to store high signal-to-noise &quot;sources&quot;
    -- measured on the coadd exposures in KeithCoadd.</descr>
(
    keithSourceId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier)</descr>
        -- <ucd>meta.id;src</ucd>
    parentKeithSourceId BIGINT NULL,
        -- <descr>keithSourceId of parent if source is deblended, otherwise NULL.</descr>
        -- <ucd>meta.id.parent;src</ucd>
    keithCoaddId BIGINT NOT NULL,
        -- <descr>ID of the coadd the source was detected and measured on
        -- (pointer to KeithCoadd).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterId TINYINT NOT NULL,
        -- <descr>ID of filter used for the coadd the source
        -- was detected and measured on.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of source centroid (x, y).</descr>
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
        -- <descr>Pixel axis 1 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y DOUBLE NOT NULL,
        -- <descr>Pixel axis 2 coordinate of source centroid,
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
        -- <descr>Uncalibrated PSF flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    psfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFlux DOUBLE NULL,
        -- <descr>Uncalibrated model flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of modelFlux</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Uncalibrated instrumental flux of source.</descr>
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
        -- <descr>Set if source was detected as significantly negative.</descr>
        -- <ucd>meta.code</ucd>
    flagBadMeasCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid algorithm used to feed centers to other
        -- measurement algorithms failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagPixEdge BIT(1) NOT NULL,
        -- <descr>Set if source is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpAny BIT(1) NOT NULL,
        -- <descr>Set if source footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpCen BIT(1) NOT NULL,
        -- <descr>Set if source center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturAny BIT(1) NOT NULL,
        -- <descr>Set if source footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturCen BIT(1) NOT NULL,
        -- <descr>Set if source center is close to
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
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (keithSourceId),
    KEY IDX_keithCoaddId (keithCoaddId ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE KeithForcedSource
    -- <descr>Not filled. Table of forced-photometry sources, measured using
    -- positions of objects from KeithSource.</descr>
(
    keithForcedSourceId BIGINT NOT NULL,
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
    keithSourceId BIGINT NOT NULL,
        -- <descr>ID of object that triggered measurement
        -- of this forced-source (pointer to KeithSource).</descr>
        -- <ucd>meta.id;src</ucd>
    keithSourceRa DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of object that triggered measurement
        -- of this forced-source.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    keithSourceDecl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of object that triggered measurement
        -- of this forced-source.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of forced-source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of forced-source centroid (x, y).</descr>
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
        -- <descr>Pixel axis 1 coordinate of forced-source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y DOUBLE NOT NULL,
        -- <descr>Pixel axis 2 coordinate of forced-source centroid,
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
        -- <descr>Uncalibrated PSF flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    psfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFlux DOUBLE NULL,
        -- <descr>Uncalibrated model flux of forced-source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of modelFlux</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Uncalibrated instrumental flux of forced-source.</descr>
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
        -- <descr>Set if forced-source was detected as significantly negative.</descr>
        -- <ucd>meta.code</ucd>
    flagBadMeasCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid algorithm used to feed centers to other
        -- measurement algorithms failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagPixEdge BIT(1) NOT NULL,
        -- <descr>Set if forced-source is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpAny BIT(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpCen BIT(1) NOT NULL,
        -- <descr>Set if forced-source center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturAny BIT(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturCen BIT(1) NOT NULL,
        -- <descr>Set if forced-source center is close to
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
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (keithForcedSourceId),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId ASC),
    KEY IDX_filterId (filterId ASC),
    KEY IDX_objectId (keithSourceId ASC),
    KEY IDX_decl (decl ASC),
    KEY IDX_htmId20 (htmId20 ASC)
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

    uObsCount INTEGER NOT NULL,
        -- <descr>Number of u-filter sources associated with this object.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    uObsTimeMin DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was first observed in the
        -- u filter (earliest timeMid of associated u-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    uObsTimeMax DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was last observed in the
        -- u filter (latest timeMid of associated u-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    uPsfFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB psfFlux of u-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uPsfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of uPsfFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uPsfFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute uPsfFlux and
        -- uPsfFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    uApFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB apFlux of u-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uApFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of uApFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uApFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute uApFlux and
        -- uApFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    uModelFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB modelFlux of u-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uModelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of uModelFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uModelFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute uModelFlux and
        -- uModelFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    uInstFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB instFlux of u-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uInstFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of uInstFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    uInstFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute uInstFlux and
        -- uInstFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    uShapeIxx DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of u-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    uShapeIyy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of u-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    uShapeIxy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of u-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    uShapeIxxVar DOUBLE NULL,
        -- <descr>Variance of uShapeIxx.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    uShapeIyyVar DOUBLE NULL,
        -- <descr>Variance of uShapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    uShapeIxyVar DOUBLE NULL,
        -- <descr>Variance of uShapeIxy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    uShapeIxxIyyCov DOUBLE NULL,
        -- <descr>Covariance of uShapeIxx and uShapeIyy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    uShapeIxxIxyCov DOUBLE NULL,
        -- <descr>Covariance of uShapeIxx and uShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    uShapeIyyIxyCov DOUBLE NULL,
        -- <descr>Covariance of uShapeIyy and uShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    uShapeCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute 
        -- the uShape columns.</descr>
        -- <ucd>meta.number;stat.value</ucd>

    gObsCount INTEGER NOT NULL,
        -- <descr>Number of g-filter sources associated with this object.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    gObsTimeMin DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was first observed in the
        -- g filter (earliest timeMid of associated g-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    gObsTimeMax DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was last observed in the
        -- g filter (latest timeMid of associated g-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    gPsfFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB psfFlux of g-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gPsfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of gPsfFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gPsfFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute gPsfFlux and
        -- gPsfFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    gApFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB apFlux of g-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gApFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of gApFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gApFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute gApFlux and
        -- gApFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    gModelFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB modelFlux of g-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gModelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of gModelFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gModelFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute gModelFlux and
        -- gModelFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    gInstFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB instFlux of g-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gInstFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of gInstFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    gInstFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute gInstFlux and
        -- gInstFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    gShapeIxx DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of g-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    gShapeIyy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of g-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    gShapeIxy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of g-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    gShapeIxxVar DOUBLE NULL,
        -- <descr>Variance of gShapeIxx.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    gShapeIyyVar DOUBLE NULL,
        -- <descr>Variance of gShapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    gShapeIxyVar DOUBLE NULL,
        -- <descr>Variance of gShapeIxy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    gShapeIxxIyyCov DOUBLE NULL,
        -- <descr>Covariance of gShapeIxx and gShapeIyy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    gShapeIxxIxyCov DOUBLE NULL,
        -- <descr>Covariance of gShapeIxx and gShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    gShapeIyyIxyCov DOUBLE NULL,
        -- <descr>Covariance of gShapeIyy and gShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    gShapeCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute 
        -- the gShape columns.</descr>
        -- <ucd>meta.number;stat.value</ucd>

    rObsCount INTEGER NOT NULL,
        -- <descr>Number of r-filter sources associated with this object.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    rObsTimeMin DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was first observed in the
        -- r filter (earliest timeMid of associated r-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    rObsTimeMax DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was last observed in the
        -- r filter (latest timeMid of associated r-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    rPsfFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB psfFlux of r-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rPsfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of rPsfFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rPsfFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute rPsfFlux and
        -- rPsfFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    rApFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB apFlux of r-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rApFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of rApFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rApFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute rApFlux and
        -- rApFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    rModelFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB modelFlux of r-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rModelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of rModelFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rModelFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute rModelFlux and
        -- rModelFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    rInstFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB instFlux of r-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rInstFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of rInstFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    rInstFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute rInstFlux and
        -- rInstFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    rShapeIxx DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of r-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    rShapeIyy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of r-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    rShapeIxy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of r-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    rShapeIxxVar DOUBLE NULL,
        -- <descr>Variance of rShapeIxx.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    rShapeIyyVar DOUBLE NULL,
        -- <descr>Variance of rShapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    rShapeIxyVar DOUBLE NULL,
        -- <descr>Variance of rShapeIxy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    rShapeIxxIyyCov DOUBLE NULL,
        -- <descr>Covariance of rShapeIxx and rShapeIyy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    rShapeIxxIxyCov DOUBLE NULL,
        -- <descr>Covariance of rShapeIxx and rShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    rShapeIyyIxyCov DOUBLE NULL,
        -- <descr>Covariance of rShapeIyy and rShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    rShapeCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute 
        -- the rShape columns.</descr>
        -- <ucd>meta.number;stat.value</ucd>

    iObsCount INTEGER NOT NULL,
        -- <descr>Number of i-filter sources associated with this object.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    iObsTimeMin DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was first observed in the
        -- i filter (earliest timeMid of associated i-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    iObsTimeMax DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was last observed in the
        -- i filter (latest timeMid of associated i-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    iPsfFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB psfFlux of i-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iPsfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of iPsfFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iPsfFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute iPsfFlux and
        -- iPsfFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    iApFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB apFlux of i-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iApFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of iApFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iApFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute iApFlux and
        -- iApFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    iModelFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB modelFlux of i-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iModelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of iModelFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iModelFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute iModelFlux and
        -- iModelFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    iInstFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB instFlux of i-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iInstFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of iInstFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    iInstFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute iInstFlux and
        -- iInstFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    iShapeIxx DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of i-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    iShapeIyy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of i-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    iShapeIxy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of i-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    iShapeIxxVar DOUBLE NULL,
        -- <descr>Variance of iShapeIxx.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    iShapeIyyVar DOUBLE NULL,
        -- <descr>Variance of iShapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    iShapeIxyVar DOUBLE NULL,
        -- <descr>Variance of iShapeIxy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    iShapeIxxIyyCov DOUBLE NULL,
        -- <descr>Covariance of iShapeIxx and iShapeIyy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    iShapeIxxIxyCov DOUBLE NULL,
        -- <descr>Covariance of iShapeIxx and iShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    iShapeIyyIxyCov DOUBLE NULL,
        -- <descr>Covariance of iShapeIyy and iShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    iShapeCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute 
        -- the iShape columns.</descr>
        -- <ucd>meta.number;stat.value</ucd>

    zObsCount INTEGER NOT NULL,
        -- <descr>Number of z-filter sources associated with this object.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    zObsTimeMin DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was first observed in the
        -- z filter (earliest timeMid of associated z-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    zObsTimeMax DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was last observed in the
        -- z filter (latest timeMid of associated z-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    zPsfFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB psfFlux of z-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zPsfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of zPsfFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zPsfFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute zPsfFlux and
        -- zPsfFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    zApFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB apFlux of z-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zApFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of zApFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zApFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute zApFlux and
        -- zApFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    zModelFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB modelFlux of z-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zModelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of zModelFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zModelFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute zModelFlux and
        -- zModelFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    zInstFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB instFlux of z-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zInstFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of zInstFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    zInstFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute zInstFlux and
        -- zInstFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    zShapeIxx DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of z-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    zShapeIyy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of z-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    zShapeIxy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of z-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    zShapeIxxVar DOUBLE NULL,
        -- <descr>Variance of zShapeIxx.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    zShapeIyyVar DOUBLE NULL,
        -- <descr>Variance of zShapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    zShapeIxyVar DOUBLE NULL,
        -- <descr>Variance of zShapeIxy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    zShapeIxxIyyCov DOUBLE NULL,
        -- <descr>Covariance of zShapeIxx and zShapeIyy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    zShapeIxxIxyCov DOUBLE NULL,
        -- <descr>Covariance of zShapeIxx and zShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    zShapeIyyIxyCov DOUBLE NULL,
        -- <descr>Covariance of zShapeIyy and zShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    zShapeCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute 
        -- the zShape columns.</descr>
        -- <ucd>meta.number;stat.value</ucd>

    yObsCount INTEGER NOT NULL,
        -- <descr>Number of y-filter sources associated with this object.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    yObsTimeMin DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was first observed in the
        -- y filter (earliest timeMid of associated y-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    yObsTimeMax DOUBLE NULL,
        -- <descr>Time (MJD TAI) when this object was last observed in the
        -- y filter (latest timeMid of associated y-filter sources).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    yPsfFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB psfFlux of y-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yPsfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of yPsfFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yPsfFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute yPsfFlux and
        -- yPsfFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    yApFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB apFlux of y-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yApFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of yApFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yApFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute yApFlux and
        -- yApFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    yModelFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB modelFlux of y-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yModelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of yModelFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yModelFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute yModelFlux and
        -- yModelFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    yInstFlux DOUBLE NULL,
        -- <descr>Inverse variance weighted mean AB instFlux of y-filter
        -- sources in this object.</descr>
        -- <ucd>phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yInstFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of yInstFlux (standard deviation).</descr>
        -- <ucd>stat.error;phot.flux.density;em.opt</ucd>
        -- <unit>erg/s/cm^2/Hz</unit>
    yInstFluxCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute yInstFlux and
        -- yInstFluxSigma.</descr>
        -- <ucd>meta.number;stat.value</ucd>
    yShapeIxx DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of y-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    yShapeIyy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of y-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    yShapeIxy DOUBLE NULL,
        -- <descr>Inverse variance weighted mean second moment of y-filter
        -- sources. The coordinate system is a tangent plane centered on
        -- (ra, decl) with the standard (North,East) basis.
        -- <unit>arcsec^2</unit>
    yShapeIxxVar DOUBLE NULL,
        -- <descr>Variance of yShapeIxx.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    yShapeIyyVar DOUBLE NULL,
        -- <descr>Variance of yShapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    yShapeIxyVar DOUBLE NULL,
        -- <descr>Variance of yShapeIxy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>arcsec^4</unit>
    yShapeIxxIyyCov DOUBLE NULL,
        -- <descr>Covariance of yShapeIxx and yShapeIyy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    yShapeIxxIxyCov DOUBLE NULL,
        -- <descr>Covariance of yShapeIxx and yShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    yShapeIyyIxyCov DOUBLE NULL,
        -- <descr>Covariance of yShapeIyy and yShapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>arcsec^4</unit>
    yShapeCount INTEGER NOT NULL,
        -- <descr>Number of sources used to compute 
        -- the yShape columns.</descr>
        -- <ucd>meta.number;stat.value</ucd>


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
    ra DOUBLE NOT NULL,
        -- <descr>ICRS RA of source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec of source centroid (x, y).</descr>
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
        -- <descr>Pixel axis 1 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y DOUBLE NOT NULL,
        -- <descr>Pixel axis 2 coordinate of source centroid,
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
        -- <descr>Uncalibrated PSF flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    psfFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of psfFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFlux DOUBLE NULL,
        -- <descr>Uncalibrated aperture flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    apFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of apFlux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFlux DOUBLE NULL,
        -- <descr>Uncalibrated model flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    modelFluxSigma DOUBLE NULL,
        -- <descr>Uncertainty of modelFlux</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    instFlux DOUBLE NULL,
        -- <descr>Uncalibrated instrumental flux of source.</descr>
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
        -- <descr>Set if source was detected as significantly negative.</descr>
        -- <ucd>meta.code</ucd>
    flagBadMeasCentroid BIT(1) NOT NULL,
        -- <descr>Set if the centroid algorithm used to feed centers to other
        -- measurement algorithms failed.</descr>
        -- <ucd>meta.code.error</ucd>
    flagPixEdge BIT(1) NOT NULL,
        -- <descr>Set if source is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpAny BIT(1) NOT NULL,
        -- <descr>Set if source footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixInterpCen BIT(1) NOT NULL,
        -- <descr>Set if source center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturAny BIT(1) NOT NULL,
        -- <descr>Set if source footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flagPixSaturCen BIT(1) NOT NULL,
        -- <descr>Set if source center is close to
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
        -- <descr>Internal column used by qserv.</descr>
    PRIMARY KEY (sourceId),
    KEY IDX_parentSourceId (parentSourceId ASC),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId ASC),
    KEY IDX_filterId (filterId ASC),
    KEY IDX_objectId (objectId ASC),
    KEY IDX_decl (decl ASC),
    KEY IDX_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;


CREATE TABLE SkyTile
    -- <descr>IDs of sky-tiles for which data has been loaded.</descr>
(
    skyTileId BIGINT NOT NULL,
    PRIMARY KEY (skyTileId)
) ENGINE=MyISAM;


SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE Science_Ccd_Exposure_To_Htm10 ADD CONSTRAINT FK_Science_Ccd_Exposure_To_Htm10_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);

ALTER TABLE Science_Ccd_Exposure_Metadata ADD CONSTRAINT FK_Science_Ccd_Exposure_Metadata_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);

ALTER TABLE Science_Ccd_Exposure ADD CONSTRAINT FK_Science_Ccd_Exposure_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE GoodSeeingCoadd_To_Htm10 ADD CONSTRAINT FK_GoodSeeingCoadd_To_Htm10_goodSeeingCoaddId
    FOREIGN KEY (goodSeeingCoaddId) REFERENCES GoodSeeingCoadd (goodSeeingCoaddId);

ALTER TABLE GoodSeeingCoadd_Metadata ADD CONSTRAINT FK_GoodSeeingCoadd_Metadata_goodSeeingCoaddId
    FOREIGN KEY (goodSeeingCoaddId) REFERENCES GoodSeeingCoadd (goodSeeingCoaddId);

ALTER TABLE GoodSeeingCoadd ADD CONSTRAINT FK_GoodSeeingCoadd_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE GoodSeeingSource ADD CONSTRAINT FK_GoodSeeingSource_goodSeeingCoaddId
    FOREIGN KEY (goodSeeingCoaddId) REFERENCES GoodSeeingCoadd (goodSeeingCoaddId);
ALTER TABLE GoodSeeingSource ADD CONSTRAINT FK_GoodSeeingSource_parentGoodSeeingSourceId
    FOREIGN KEY (parentGoodSeeingSourceId) REFERENCES GoodSeeingSource (goodSeeingSourceId);
ALTER TABLE GoodSeeingSource ADD CONSTRAINT FK_GoodSeeingSource_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE GoodSeeingForcedSource ADD CONSTRAINT FK_GoodSeeingForcedSource_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);
ALTER TABLE GoodSeeingForcedSource ADD CONSTRAINT FK_GoodSeeingForcedSource_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);
ALTER TABLE GoodSeeingForcedSource ADD CONSTRAINT FK_GoodSeeingForcedSource_goodSeeingSourceId
    FOREIGN KEY (goodSeeingSourceId) REFERENCES GoodSeeingSource (goodSeeingSourceId);

ALTER TABLE DeepCoadd_To_Htm10 ADD CONSTRAINT FK_DeepCoadd_To_Htm10_deepCoaddId
    FOREIGN KEY (deepCoaddId) REFERENCES DeepCoadd (deepCoaddId);

ALTER TABLE DeepCoadd_Metadata ADD CONSTRAINT FK_DeepCoadd_Metadata_deepCoaddId
    FOREIGN KEY (deepCoaddId) REFERENCES DeepCoadd (deepCoaddId);

ALTER TABLE DeepCoadd ADD CONSTRAINT FK_DeepCoadd_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE DeepSource ADD CONSTRAINT FK_DeepSource_deepCoaddId
    FOREIGN KEY (deepCoaddId) REFERENCES DeepCoadd (deepCoaddId);
ALTER TABLE DeepSource ADD CONSTRAINT FK_DeepSource_parentDeepSourceId
    FOREIGN KEY (parentDeepSourceId) REFERENCES DeepSource (deepSourceId);
ALTER TABLE DeepSource ADD CONSTRAINT FK_DeepSource_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE DeepForcedSource ADD CONSTRAINT FK_DeepForcedSource_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);
ALTER TABLE DeepForcedSource ADD CONSTRAINT FK_DeepForcedSource_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);
ALTER TABLE DeepForcedSource ADD CONSTRAINT FK_DeepForcedSource_deepSourceId
    FOREIGN KEY (deepSourceId) REFERENCES DeepSource (deepSourceId);

ALTER TABLE ChiSquaredCoadd_To_Htm10 ADD CONSTRAINT FK_ChiSquaredCoadd_To_Htm10_chiSquaredCoaddId
    FOREIGN KEY (chiSquaredCoaddId) REFERENCES ChiSquaredCoadd (chiSquaredCoaddId);

ALTER TABLE ChiSquaredCoadd_Metadata ADD CONSTRAINT FK_ChiSquaredCoadd_Metadata_chiSquaredCoaddId
    FOREIGN KEY (chiSquaredCoaddId) REFERENCES ChiSquaredCoadd (chiSquaredCoaddId);



ALTER TABLE ChiSquaredSource ADD CONSTRAINT FK_ChiSquaredSource_chiSquaredCoaddId
    FOREIGN KEY (chiSquaredCoaddId) REFERENCES ChiSquaredCoadd (chiSquaredCoaddId);
ALTER TABLE ChiSquaredSource ADD CONSTRAINT FK_ChiSquaredSource_parentChiSquaredSourceId
    FOREIGN KEY (parentChiSquaredSourceId) REFERENCES ChiSquaredSource (chiSquaredSourceId);

ALTER TABLE ChiSquaredForcedSource ADD CONSTRAINT FK_ChiSquaredForcedSource_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);
ALTER TABLE ChiSquaredForcedSource ADD CONSTRAINT FK_ChiSquaredForcedSource_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);
ALTER TABLE ChiSquaredForcedSource ADD CONSTRAINT FK_ChiSquaredForcedSource_chiSquaredSourceId
    FOREIGN KEY (chiSquaredSourceId) REFERENCES ChiSquaredSource (chiSquaredSourceId);

ALTER TABLE KeithCoadd_To_Htm10 ADD CONSTRAINT FK_KeithCoadd_To_Htm10_keithCoaddId
    FOREIGN KEY (keithCoaddId) REFERENCES KeithCoadd (keithCoaddId);

ALTER TABLE KeithCoadd_Metadata ADD CONSTRAINT FK_KeithCoadd_Metadata_keithCoaddId
    FOREIGN KEY (keithCoaddId) REFERENCES KeithCoadd (keithCoaddId);

ALTER TABLE KeithCoadd ADD CONSTRAINT FK_KeithCoadd_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE KeithSource ADD CONSTRAINT FK_KeithSource_keithCoaddId
    FOREIGN KEY (keithCoaddId) REFERENCES KeithCoadd (keithCoaddId);
ALTER TABLE KeithSource ADD CONSTRAINT FK_KeithSource_parentKeithSourceId
    FOREIGN KEY (parentKeithSourceId) REFERENCES KeithSource (keithSourceId);
ALTER TABLE KeithSource ADD CONSTRAINT FK_KeithSource_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);

ALTER TABLE KeithForcedSource ADD CONSTRAINT FK_KeithForcedSource_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);
ALTER TABLE KeithForcedSource ADD CONSTRAINT FK_KeithForcedSource_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);
ALTER TABLE KeithForcedSource ADD CONSTRAINT FK_KeithForcedSource_keithSourceId
    FOREIGN KEY (keithSourceId) REFERENCES KeithSource (keithSourceId);

ALTER TABLE Source ADD CONSTRAINT FK_Source_scienceCcdExposureId
    FOREIGN KEY (scienceCcdExposureId) REFERENCES Science_Ccd_Exposure (scienceCcdExposureId);
ALTER TABLE Source ADD CONSTRAINT FK_Source_filterId
    FOREIGN KEY (filterId) REFERENCES Filter (filterId);
ALTER TABLE Source ADD CONSTRAINT FK_Source_objectId
    FOREIGN KEY (objectId) REFERENCES Object (objectId);
ALTER TABLE Source ADD CONSTRAINT FK_Source_parentSourceId
    FOREIGN KEY (parentSourceId) REFERENCES Source (sourceId);

