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

-- ############################################################################
-- ##### CREATE TABLES: C O R E,    L E V E L 1
-- ############################################################################

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
    ra_decl_Cov FLOAT NOT NULL,
        -- <descr>Covariance between ra and decl.</descr>
        -- <unit>deg^2</unit>
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
    muDecl_parallax_Cov FLOAT NOT NULL,
        -- <descr>Covariance of muDecl and parallax.</descr>
    lnL FLOAT NOT NULL,
        -- <descr>Natural log of the likelihood of the linear
        -- proper motion parallax fit.</descr>
    chi2 FLOAT NOT NULL,
        -- <descr>Chi^2 static of the model fit.</descr>
    N INT NOT NULL,
        -- <descr>The number of data points (pixels) used to fit the model.
        -- </descr>
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
        -- <descr>Weighted mean point-source model magnitude for g filter.
        -- </descr>
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
        -- <descr>Weighted mean point-source model magnitude for u filter.
        -- </descr>
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
        -- <descr>Weighted mean point-source model magnitude for i filter.
        -- </descr>
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
        -- <descr>Weighted mean point-source model magnitude for z filter.
        -- </descr>
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
        -- <descr>Weighted mean point-source model magnitude for y filter.
        -- </descr>
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
    uLcPeriodic BLOB NULL,
        -- <descr>Periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for u filter.
        -- [32 FLOAT].</descr>
    gLcPeriodic BLOB NULL,
        -- <descr>Periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for g filter.
        -- [32 FLOAT].</descr>
    rLcPeriodic BLOB NULL,
        -- <descr>Periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for r filter.
        -- [32 FLOAT].</descr>
    iLcPeriodic BLOB NULL,
        -- <descr>Periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for i filter.
        -- [32 FLOAT].</descr>
    zLcPeriodic BLOB NULL,
        -- <descr>Periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for z filter.
        -- [32 FLOAT].</descr>
    yLcPeriodic BLOB NULL,
        -- <descr>Periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for y filter.
        -- [32 FLOAT].</descr>
    uLcNonPeriodic BLOB NULL,
        -- <descr>Non-periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for u filter.
        -- [20 FLOAT].</descr>
    gLcNonPeriodic BLOB NULL,
        -- <descr>Non-periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for g filter.
        -- [20 FLOAT].</descr>
    rLcNonPeriodic BLOB NULL,
        -- <descr>Non-periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for r filter.
        -- [20 FLOAT].</descr>
    iLcNonPeriodic BLOB NULL,
        -- <descr>Non-periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for i filter.
        -- [20 FLOAT].</descr>
    zLcNonPeriodic BLOB NULL,
        -- <descr>Non-periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for z filter.
        -- [20 FLOAT].</descr>
    yLcNonPeriodic BLOB NULL,
        -- <descr>Non-periodic features extracted from light-curves using
        -- generalized Lomb-Scargle periodogram for y filter.
        -- [20 FLOAT].</descr>
    flags BIGINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd.</descr>
        -- <ucd>meta.code</ucd>
    htmId20 BIGINT NOT NULL,
        -- <descr>HTM index.</descr>
    PRIMARY KEY PK_DiaObject (diaObjectId, validityStart),
    INDEX IDX_DiaObject_validityStart (validityStart),
    INDEX IDX_DiaObject_procHistoryId (procHistoryId),
    INDEX IDX_DiaObject_htmId20 (htmId20)
) ENGINE=MyISAM;

-- ############################################################################

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
    orbFitChi2 FLOAT NULL,
        -- <descr>Chi^2 statistic of the orbital elements fit.
        -- </descr>
    orbFitN INTEGER NULL,
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
    uG1 FLOAT NULL,
        -- <descr>Fitted G1 slope parameter for u filter.</descr>
        -- <unit>mag</unit>
    uG1Sigma FLOAT NULL,
        -- <descr>Uncertainty of uG1.</descr>
        -- <unit>mag</unit>
    uG2 FLOAT NULL,
        -- <descr>Fitted G2 slope parameter for u filter.</descr>
        -- <unit>mag</unit>
    uG2Sigma FLOAT NULL,
        -- <descr>Uncertainty of uG2.</descr>
        -- <unit>mag</unit>
    gH FLOAT NULL,
        -- <descr>Mean absolute magnitude for g filter.</descr>
        -- <unit>mag</unit>
    gHSigma FLOAT NULL,
        -- <descr>Uncertainty of gH.</descr>
        -- <unit>mag</unit>
    gG1 FLOAT NULL,
        -- <descr>Fitted G1 slope parameter for g filter.</descr>
        -- <unit>mag</unit>
    gG1Sigma FLOAT NULL,
        -- <descr>Uncertainty of gG1.</descr>
        -- <unit>mag</unit>
    gG2 FLOAT NULL,
        -- <descr>Fitted G2 slope parameter for g filter.</descr>
        -- <unit>mag</unit>
    gG2Sigma FLOAT NULL,
        -- <descr>Uncertainty of gG2.</descr>
        -- <unit>mag</unit>
    rH FLOAT NULL,
        -- <descr>Mean absolute magnitude for r filter.</descr>
        -- <unit>mag</unit>
    rHSigma FLOAT NULL,
        -- <descr>Uncertainty of rH.</descr>
        -- <unit>mag</unit>
    rG1 FLOAT NULL,
        -- <descr>Fitted G1 slope parameter for r filter.</descr>
        -- <unit>mag</unit>
    rG1Sigma FLOAT NULL,
        -- <descr>Uncertainty of rG1.</descr>
        -- <unit>mag</unit>
    rG2 FLOAT NULL,
        -- <descr>Fitted G2 slope parameter for r filter.</descr>
        -- <unit>mag</unit>
    rG2Sigma FLOAT NULL,
        -- <descr>Uncertainty of rG2.</descr>
        -- <unit>mag</unit>
    iH FLOAT NULL,
        -- <descr>Mean absolute magnitude for i filter.</descr>
        -- <unit>mag</unit>
    iHSigma FLOAT NULL,
        -- <descr>Uncertainty of iH.</descr>
        -- <unit>mag</unit>
    iG1 FLOAT NULL,
        -- <descr>Fitted G1 slope parameter for i filter.</descr>
        -- <unit>mag</unit>
    iG1Sigma FLOAT NULL,
        -- <descr>Uncertainty of iG1.</descr>
        -- <unit>mag</unit>
    iG2 FLOAT NULL,
        -- <descr>Fitted G2 slope parameter for i filter.</descr>
        -- <unit>mag</unit>
    iG2Sigma FLOAT NULL,
        -- <descr>Uncertainty of iG2.</descr>
        -- <unit>mag</unit>
    zH FLOAT NULL,
        -- <descr>Mean absolute magnitude for z filter.</descr>
        -- <unit>mag</unit>
    zHSigma FLOAT NULL,
        -- <descr>Uncertainty of zH.</descr>
        -- <unit>mag</unit>
    zG1 FLOAT NULL,
        -- <descr>Fitted G1 slope parameter for z filter.</descr>
        -- <unit>mag</unit>
    zG1Sigma FLOAT NULL,
        -- <descr>Uncertainty of zG1.</descr>
        -- <unit>mag</unit>
    zG2 FLOAT NULL,
        -- <descr>Fitted G2 slope parameter for z filter.</descr>
        -- <unit>mag</unit>
    zG2Sigma FLOAT NULL,
        -- <descr>Uncertainty of zG2.</descr>
        -- <unit>mag</unit>
    yH FLOAT NULL,
        -- <descr>Mean absolute magnitude for y filter.</descr>
        -- <unit>mag</unit>
    yHSigma FLOAT NULL,
        -- <descr>Uncertainty of yH.</descr>
        -- <unit>mag</unit>
    yG1 FLOAT NULL,
        -- <descr>Fitted G1 slope parameter for y filter.</descr>
       -- <unit>mag</unit>
    yG1Sigma FLOAT NULL,
        -- <descr>Uncertainty of yG1.</descr>
        -- <unit>mag</unit>
    yG2 FLOAT NULL,
        -- <descr>Fitted G2 slope parameter for y filter.</descr>
       -- <unit>mag</unit>
    yG2Sigma FLOAT NULL,
        -- <descr>Uncertainty of yG2.</descr>
        -- <unit>mag</unit>
    flags BIGINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd.</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_SSObject (ssObjectId),
    INDEX IDX_SSObject_procHistoryId (procHistoryId)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE DiaSource
    -- <descr>Table to store 'difference image sources'; - sources
    -- detected at SNR >=5 on difference images.</descr>
(
    diaSourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    ccdVisitId BIGINT NOT NULL,
        -- <descr>Id of the ccdVisit where this diaSource was measured.
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
    parentDiaSourceId BIGINT NULL,
        -- <descr>Id of the parent diaSource this diaObject has been deblended
        -- from, if any.</descr>
        -- <ucd>meta.id;src</ucd>
    filterName CHAR(1) NOT NULL,
        -- <descr>Name of the filter used to take the Visit where this
        -- diaSource was measured.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
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
    ra_decl_Cov FLOAT NOT NULL,
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
        -- <descr>Calibrated flux for Point Source model. Note this actually
        -- measures the flux difference between the template and the visit
        -- image.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    psFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of psFlux.</descr>
        -- <unit>nmgy</unit>
    psLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data given the Point
        -- Source model.</descr>
    psChi2 FLOAT NULL,
        -- <descr>Chi^2 static of the model fit.</descr>
    psN INT NULL,
        -- <descr>The number of data points (pixels) used to fit the model.
        -- </descr>
    trailFlux FLOAT NULL,
        -- <descr>Calibrated flux for a trailed source model. Note this
        -- actually measures the flux difference between the template and the
        -- visit image.</descr>
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
        -- <descr>Maximum likelihood fit of the angle between the meridian
        -- through the centroid and the trail direction (bearing).</descr>
        -- <unit>degrees</unit>
    trailAngleSigma FLOAT NULL,
        -- <descr>Uncertainty of trailAngle.</descr>
        -- <unit>nmgy</unit>
    trailFlux_trailLength_Cov FLOAT NULL,
        -- <descr>Covariance of trailFlux and trailLength</descr>
    trailFlux_trailAngle_Cov FLOAT NULL,
        -- <descr>Covariance of trailFlux and trailAngle</descr>
    trailLength_trailAngle_Cov FLOAT NULL,
        -- <descr>Covariance of trailLength and trailAngle</descr>
    trailLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data given the trailed
        -- Point Source model.</descr>
    trailChi2 FLOAT NULL,
        -- <descr>Chi^2 static of the model fit.</descr>
    trailN INT NULL,
        -- <descr>The number of data points (pixels) used to fix the model.
        -- </descr>
    fpFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model measured on the visit
        -- image centered at the centroid measured on the difference image
        -- (forced photometry flux).</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    fpFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of fpFlux</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
    diffFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model centered on radec but
        -- measured on the difference of snaps comprising this visit.</descr>
        -- <unit>nmgy</unit>
    diffFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of diffFlux</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
    fpSky FLOAT NULL,
        -- <descr>Estimated sky background at the position (centroid) of the
        -- object.</descr>
        -- <unit>nmgy/asec^2</unit>
    fpSkySigma FLOAT NULL,
        -- <descr>Uncertainty of fpSky.</descr>
        -- <unit>nmgy/asec^2</unit>
    E1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure of the source as measured on the
        -- difference image.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    E1Sigma FLOAT NULL,
        -- <descr>Uncertainty of E1.</descr>
        -- <ucd>stat.error:phys.size.axisRatio</ucd>
    E2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure of the source as measured on the
        -- difference image.</descr>
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
        -- <descr>A measure of extendedness, Computed using a combination of
        -- available moments and model fluxes or from a likelihood ratio of
        -- point/trailed source models (exact algorithm TBD). extendedness = 1
        -- implies a high degree of confidence that the source is extended.
        -- extendedness = 0 implies a high degree of confidence that the
        -- source is point-like.</descr>
    apMeanSb01 FLOAT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
    apMeanSb01Sigma FLOAT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    apMeanSb02 FLOAT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
    apMeanSb02Sigma FLOAT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    apMeanSb03 FLOAT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
    apMeanSb03Sigma FLOAT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    apMeanSb04 FLOAT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
    apMeanSb04Sigma FLOAT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    apMeanSb05 FLOAT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
    apMeanSb05Sigma FLOAT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    apMeanSb06 FLOAT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
    apMeanSb06Sigma FLOAT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    apMeanSb07 FLOAT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
    apMeanSb07Sigma FLOAT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    apMeanSb08 FLOAT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
    apMeanSb08Sigma FLOAT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    apMeanSb09 FLOAT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
    apMeanSb09Sigma FLOAT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    apMeanSb10 FLOAT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
    apMeanSb10Sigma FLOAT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    flags BIGINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd.</descr>
        -- <ucd>meta.code</ucd>
    htmId20 BIGINT NOT NULL,
        -- <descr>HTM index.</descr>
    PRIMARY KEY PK_DiaSource (diaSourceId),
    INDEX IDX_DiaSource_procHistoryId (procHistoryId),
    INDEX IDX_DiaSource_ccdVisitId (ccdVisitId),
    INDEX IDX_DiaSource_diaObjectId (diaObjectId),
    INDEX IDX_DiaSource_ssObjectId (ssObjectId),
    INDEX IDX_DiaSource_filterName (filterName),
    INDEX IDX_DiaObject_htmId20 (htmId20)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE DiaForcedSource
    -- <descr>Forced-photometry source measurement on an individual difference
    -- Exposure based on a Multifit shape model derived from a deep
    -- detection.</descr>
(
    diaObjectId BIGINT NOT NULL,
        -- <ucd>meta.id;src</ucd>
    ccdVisitId BIGINT NOT NULL,
        -- <descr>Id of the visit where this forcedSource was measured. Note 
        -- that we are allowing a forcedSource to belong to multiple
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
    x FLOAT NOT NULL,
        -- <descr>x position at which psFlux has been measured.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y FLOAT NOT NULL,
        -- <descr>y position at which psFlux has been measured.</descr>
        -- by SDSS.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    flags TINYINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_DiaForcedSource (diaObjectId, ccdVisitId),
    INDEX IDX_DiaForcedSource_ccdVisitId (ccdVisitId)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE DiaObject_To_Object_Match
    -- <descr>The table stores mapping of diaObjects to the nearby objects.
    -- </descr>
(
    diaObjectId BIGINT NOT NULL,
        -- <descr>Id of diaObject.</descr>
        -- <ucd>meta.id;src</ucd>
    objectId BIGINT NOT NULL,
        -- <descr>Id of a nearby object.</descr>
        -- <ucd>meta.id;src</ucd>
    dist FLOAT NOT NULL,
        -- <descr>The distance between the diaObject and the object.</descr>
        -- <unit>arcsec</unit>
    lnP FLOAT NULL,
        -- <descr>Natural log of the probability that the observed diaObject
        -- is the same as the nearby object.</descr>
    INDEX IDX_DiaObjectToObjectMatch_diaObjectId (diaObjectId),
    INDEX IDX_DiaObjectToObjectMatch_objectId (objectId)
) ENGINE=MyISAM;

-- ############################################################################
-- ##### CREATE TABLES: C O R E,    L E V E L 2
-- ############################################################################

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
    parentObjectId BIGINT NULL,
        -- <descr>Id of the parent object this object has been deblended from,
        -- if any.</descr>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
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
    psParallax FLOAT NULL,
        -- <descr>Stellar parallax. for the Point Source model.</descr>
        -- <ucd>pos.parallax</ucd>
        -- <unit>mas</unit>
    psParallaxSigma FLOAT NULL,
        -- <descr>Uncertainty of psParallax.</descr>
        -- <ucd>stat.error;pos.parallax</ucd>
        -- <unit>mas</unit>
    uPsFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model for u filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    uPsFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of uPsFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
    gPsFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model for g filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    gPsFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of gPsFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
    rPsFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model for r filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    rPsFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of rPsFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
    iPsFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model for i filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    iPsFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of iPsFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
    zPsFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model for z filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    zPsFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of zPsFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
    yPsFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model for y filter.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    yPsFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of yPsFlux.</descr>
        -- <ucd>stat.error;phot.count</ucd>
        -- <unit>nmgy</unit>
    psLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data given 
        -- the Point Source model.</descr>
    psChi2 FLOAT NULL,
        -- <descr>Chi^2 static of the model fit.</descr>
    psN INT NULL,
        -- <descr>The number of data points (pixels) used to fit the model.
        -- </descr>
    uBbdRa DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the 
        -- Bulge+Disk model at time radecTai. For u filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    uBdRaSigma FLOAT NULL,
        -- <descr>Uncertainty of uBdRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    uBdDecl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the object for the
        -- Bulge+Disk model at time radecTai. For u filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    uBdDeclSigma FLOAT NULL,
        -- <descr>Uncertainty of uBdDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    uBdE1 FLOAT NULL,
        -- <descr>Ellipticity for the Bulge+Disk (e1). For u filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    uBdE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of uBdE1.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uBdE2 FLOAT NULL,
        -- <descr>Ellipticity for Bulge+Disk model (e2). For u filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    uBdE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of uBdE2.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uBdFluxB FLOAT  NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component for the
        -- Bulge+Disk model. For u filter.</descr>
        -- <unit>nmgy</unit>
    uBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of uBdFluxB.</descr>
        -- <unit>nmgy</unit>
    uBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component for the
        -- Bulge+Disk model. For u filter.</descr>
        -- <unit>nmgy</unit>
    uBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of uBdFluxD.</descr>
        -- <unit>nmgy</unit>
    uBdReB FLOAT NULL,
        -- <descr>Effective radius of the de Vaucouleurs profile component for
        -- the Bulge+Disk model. For u filter.</descr>
        -- <unit>arcsec</unit>
    uBdReBSigma FLOAT NULL,
        -- <descr>Uncertainty of uBdReB.</descr>
        -- <unit>arcsec</unit>
    uBdReD FLOAT NULL,
        -- <descr>Effective radius of the exponential profile component for the
        -- Bulge+Disk model. For u filter.</descr>
        -- <unit>arcsec</unit>
    uBdReDSigma FLOAT NULL,
        -- <descr>Uncertainty of uBdReD.</descr>
        -- <unit>arcsec</unit>
    uBdLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data given the
        -- Bulge+Disk model. For u filter.</descr>
    uBdChi2 FLOAT NULL,
        -- <descr>Chi^2 static of the model fit. For u filter.</descr>
    uBdN INT NULL,
        -- <descr>The number of data points (pixels) used to fit the model.
        -- For u filter.</descr>
    gBbdRa DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the 
        -- Bulge+Disk model at time radecTai. For g filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    gBdRaSigma FLOAT NULL,
        -- <descr>Uncertainty of gBdRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    gBdDecl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the object for the
        -- Bulge+Disk model at time radecTai. For g filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    gBdDeclSigma FLOAT NULL,
        -- <descr>Uncertainty of gBdDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    gBdE1 FLOAT NULL,
        -- <descr>Ellipticity for the Bulge+Disk (e1). For g filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    gBdE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of gBdE1.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    gBdE2 FLOAT NULL,
        -- <descr>Ellipticity for Bulge+Disk model (e2). For g filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    gBdE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of gBdE2.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    gBdFluxB FLOAT  NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component for the
        -- Bulge+Disk model. For g filter.</descr>
        -- <unit>nmgy</unit>
    gBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of gBdFluxB.</descr>
        -- <unit>nmgy</unit>
    gBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component for the
        -- Bulge+Disk model. For g filter.</descr>
        -- <unit>nmgy</unit>
    gBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of gBdFluxD.</descr>
        -- <unit>nmgy</unit>
    gBdReB FLOAT NULL,
        -- <descr>Effective radius of the de Vaucouleurs profile component for
        -- the Bulge+Disk model. For g filter.</descr>
        -- <unit>arcsec</unit>
    gBdReBSigma FLOAT NULL,
        -- <descr>Uncertainty of gBdReB.</descr>
        -- <unit>arcsec</unit>
    gBdReD FLOAT NULL,
        -- <descr>Effective radius of the exponential profile component for the
        -- Bulge+Disk model. For g filter.</descr>
        -- <unit>arcsec</unit>
    gBdReDSigma FLOAT NULL,
        -- <descr>Uncertainty of gBdReD.</descr>
        -- <unit>arcsec</unit>
    gBdLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data given the
        -- Bulge+Disk model. For g filter.</descr>
    gBdChi2 FLOAT NULL,
        -- <descr>Chi^2 static of the model fit. For g filter.</descr>
    gBdN INT NULL,
        -- <descr>The number of data points (pixels) used to fit the model.
        -- For g filter.</descr>
    rBbdRa DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the 
        -- Bulge+Disk model at time radecTai. For r filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    rBdRaSigma FLOAT NULL,
        -- <descr>Uncertainty of rBdRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    rBdDecl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the object for the
        -- Bulge+Disk model at time radecTai. For r filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    rBdDeclSigma FLOAT NULL,
        -- <descr>Uncertainty of rBdDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    rBdE1 FLOAT NULL,
        -- <descr>Ellipticity for the Bulge+Disk (e1). For r filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    rBdE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of rBdE1.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    rBdE2 FLOAT NULL,
        -- <descr>Ellipticity for Bulge+Disk model (e2). For r filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    rBdE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of rBdE2.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    rBdFluxB FLOAT NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component for the
        -- Bulge+Disk model. For r filter.</descr>
        -- <unit>nmgy</unit>
    rBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of rBdFluxB.</descr>
        -- <unit>nmgy</unit>
    rBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component for the
        -- Bulge+Disk model. For r filter.</descr>
        -- <unit>nmgy</unit>
    rBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of rBdFluxD.</descr>
        -- <unit>nmgy</unit>
    rBdReB FLOAT NULL,
        -- <descr>Effective radius of the de Vaucouleurs profile component for
        -- the Bulge+Disk model. For r filter.</descr>
        -- <unit>arcsec</unit>
    rBdReBSigma FLOAT NULL,
        -- <descr>Uncertainty of rBdReB.</descr>
        -- <unit>arcsec</unit>
    rBdReD FLOAT NULL,
        -- <descr>Effective radius of the exponential profile component for the
        -- Bulge+Disk model. For r filter.</descr>
        -- <unit>arcsec</unit>
    rBdReDSigma FLOAT NULL,
        -- <descr>Uncertainty of rBdReD.</descr>
        -- <unit>arcsec</unit>
    rBdLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data given the
        -- Bulge+Disk model. For r filter.</descr>
    rBdChi2 FLOAT NULL,
        -- <descr>Chi^2 static of the model fit. For r filter.</descr>
    rBdN INT NULL,
        -- <descr>The number of data points (pixels) used to fit the model.
        -- For r filter.</descr>
    iBbdRa DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the 
        -- Bulge+Disk model at time radecTai. For i filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    iBdRaSigma FLOAT NULL,
        -- <descr>Uncertainty of iBdRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    iBdDecl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the object for the
        -- Bulge+Disk model at time radecTai. For i filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    iBdDeclSigma FLOAT NULL,
        -- <descr>Uncertainty of iBdDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    iBdE1 FLOAT NULL,
        -- <descr>Ellipticity for the Bulge+Disk (e1). For i filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    iBdE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of iBdE1.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    iBdE2 FLOAT NULL,
        -- <descr>Ellipticity for Bulge+Disk model (e2). For i filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    iBdE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of iBdE2.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    iBdFluxB FLOAT NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component for the
        -- Bulge+Disk model. For i filter.</descr>
        -- <unit>nmgy</unit>
    iBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of iBdFluxB.</descr>
        -- <unit>nmgy</unit>
    iBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component for the
        -- Bulge+Disk model. For i filter.</descr>
        -- <unit>nmgy</unit>
    iBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of iBdFluxD.</descr>
        -- <unit>nmgy</unit>
    iBdReB FLOAT NULL,
        -- <descr>Effective radius of the de Vaucouleurs profile component for
        -- the Bulge+Disk model. For i filter.</descr>
        -- <unit>arcsec</unit>
    iBdReBSigma FLOAT NULL,
        -- <descr>Uncertainty of iBdReB.</descr>
        -- <unit>arcsec</unit>
    iBdReD FLOAT NULL,
        -- <descr>Effective radius of the exponential profile component for the
        -- Bulge+Disk model. For i filter.</descr>
        -- <unit>arcsec</unit>
    iBdReDSigma FLOAT NULL,
        -- <descr>Uncertainty of iBdReD.</descr>
        -- <unit>arcsec</unit>
    iBdLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data given the
        -- Bulge+Disk model. For i filter.</descr>
    iBdChi2 FLOAT NULL,
        -- <descr>Chi^2 static of the model fit. For i filter.</descr>
    iBdN INT NULL,
        -- <descr>The number of data points (pixels) used to fit the model.
        -- For i filter.</descr>
    zBbdRa DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the 
        -- Bulge+Disk model at time radecTai. For z filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    zBdRaSigma FLOAT NULL,
        -- <descr>Uncertainty of zBdRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    zBdDecl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the object for the
        -- Bulge+Disk model at time radecTai. For z filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    zBdDeclSigma FLOAT NULL,
        -- <descr>Uncertainty of zBdDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    zBdE1 FLOAT NULL,
        -- <descr>Ellipticity for the Bulge+Disk (e1). For z filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    zBdE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of zBdE1.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    zBdE2 FLOAT NULL,
        -- <descr>Ellipticity for Bulge+Disk model (e2). For z filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    zBdE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of zBdE2.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    zBdFluxB FLOAT NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component for the
        -- Bulge+Disk model. For z filter.</descr>
        -- <unit>nmgy</unit>
    zBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of zBdFluxB.</descr>
        -- <unit>nmgy</unit>
    zBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component for the
        -- Bulge+Disk model. For z filter.</descr>
        -- <unit>nmgy</unit>
    zBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of zBdFluxD.</descr>
        -- <unit>nmgy</unit>
    zBdReB FLOAT NULL,
        -- <descr>Effective radius of the de Vaucouleurs profile component for
        -- the Bulge+Disk model. For z filter.</descr>
        -- <unit>arcsec</unit>
    zBdReBSigma FLOAT NULL,
        -- <descr>Uncertainty of zBdReB.</descr>
        -- <unit>arcsec</unit>
    zBdReD FLOAT NULL,
        -- <descr>Effective radius of the exponential profile component for the
        -- Bulge+Disk model. For z filter.</descr>
        -- <unit>arcsec</unit>
    zBdReDSigma FLOAT NULL,
        -- <descr>Uncertainty of zBdReD.</descr>
        -- <unit>arcsec</unit>
    zBdLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data given the
        -- Bulge+Disk model. For z filter.</descr>
    zBdChi2 FLOAT NULL,
        -- <descr>Chi^2 static of the model fit. For z filter.</descr>
    zBdN INT NULL,
        -- <descr>The number of data points (pixels) used to fit the model.
        -- For z filter.</descr>
    yBbdRa DOUBLE NULL,
        -- <descr>RA-coordinate of the center of the object for the 
        -- Bulge+Disk model at time radecTai. For y filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    yBdRaSigma FLOAT NULL,
        -- <descr>Uncertainty of yBdRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>deg</unit>
    yBdDecl DOUBLE NOT NULL,
        -- <descr>Decl-coordinate of the center of the object for the
        -- Bulge+Disk model at time radecTai. For y filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    yBdDeclSigma FLOAT NULL,
        -- <descr>Uncertainty of yBdDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>deg</unit>
    yBdE1 FLOAT NULL,
        -- <descr>Ellipticity for the Bulge+Disk (e1). For y filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    yBdE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of yBdE1.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    yBdE2 FLOAT NULL,
        -- <descr>Ellipticity for Bulge+Disk model (e2). For y filter.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    yBdE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of yBdE2.</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    yBdFluxB FLOAT NULL,
        -- <descr>Integrated flux of the de Vaucouleurs component for the
        -- Bulge+Disk model. For y filter.</descr>
        -- <unit>nmgy</unit>
    yBdFluxBSigma FLOAT NULL,
        -- <descr>Uncertainty of yBdFluxB.</descr>
        -- <unit>nmgy</unit>
    yBdFluxD FLOAT NULL,
        -- <descr>Integrated flux of the exponential component for the
        -- Bulge+Disk model. For y filter.</descr>
        -- <unit>nmgy</unit>
    yBdFluxDSigma FLOAT NULL,
        -- <descr>Uncertainty of yBdFluxD.</descr>
        -- <unit>nmgy</unit>
    yBdReB FLOAT NULL,
        -- <descr>Effective radius of the de Vaucouleurs profile component for
        -- the Bulge+Disk model. For y filter.</descr>
        -- <unit>arcsec</unit>
    yBdReBSigma FLOAT NULL,
        -- <descr>Uncertainty of yBdReB.</descr>
        -- <unit>arcsec</unit>
    yBdReD FLOAT NULL,
        -- <descr>Effective radius of the exponential profile component for the
        -- Bulge+Disk model. For y filter.</descr>
        -- <unit>arcsec</unit>
    yBdReDSigma FLOAT NULL,
        -- <descr>Uncertainty of yBdReD.</descr>
        -- <unit>arcsec</unit>
    yBdLnL FLOAT NULL,
        -- <descr>Natural log likelihood of the observed data given the
        -- Bulge+Disk model. For y filter.</descr>
    yBdChi2 FLOAT NULL,
        -- <descr>Chi^2 static of the model fit. For y filter.</descr>
    yBdN INT NULL,
        -- <descr>The number of data points (pixels) used to fit the model.
        -- For y filter.</descr>
    ugStd FLOAT NOT NULL,
        -- <descr>Color of the object measured in 'standard seeing'. While
        -- the exact algorithm is yet to be determined, this color is
        -- guaranteed to be seeing-independent and suitable for photo-Z
        -- determinations.</descr>
        -- <unit>mag</unit>
    ugStdSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of ugStd.</descr>
        -- <unit>mag</unit>
    grStd FLOAT NOT NULL,
        -- <descr>Color of the object measured in 'standard seeing'. While
        -- the exact algorithm is yet to be determined, this color is
        -- guaranteed to be seeing-independent and suitable for photo-Z
        -- determinations.</descr>
        -- <unit>mag</unit>
    grStdSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of grStd.</descr>
        -- <unit>mag</unit>
    riStd FLOAT NOT NULL,
        -- <descr>Color of the object measured in 'standard seeing'. While
        -- the exact algorithm is yet to be determined, this color is
        -- is guaranteed to be seeing-independent and suitable for photo-Z
        -- determinations.</descr>
        -- <unit>mag</unit>
    riStdSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of riStd.</descr>
        -- <unit>mag</unit>
    izStd FLOAT NOT NULL,
        -- <descr>Color of the object measured in 'standard seeing'. While
        -- the exact algorithm is yet to be determined, this color is
        -- guaranteed to be seeing-independent and suitable for photo-Z
        -- determinations.</descr>
        -- <unit>mag</unit>
    izStdSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of izStd.</descr>
        -- <unit>mag</unit>
    zyStd FLOAT NOT NULL,
        -- <descr>Color of the object measured in 'standard seeing'. While
        -- the exact algorithm is yet to be determined, this color is
        -- guaranteed to be seeing-independent and suitable for photo-Z
        -- determinations.</descr>
        -- <unit>mag</unit>
    zyStdSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of zyStd.</descr>
        -- <unit>mag</unit>
    uRa DOUBLE NULL,
        -- <descr>RA-coordinate coordinate of the centroid computed for u
        -- filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    uRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of uRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    uDecl DOUBLE NULL,
        -- <descr>Decl-coordinate coordinate of the centroid computed for u
        -- filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    uDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of uDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    gRa DOUBLE NULL,
        -- <descr>RA--coordinate coordinate of the centroid computed for g
        -- filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    gRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of gRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    gDecl DOUBLE NULL,
        -- <descr>Decl--coordinate coordinate of the centroid computed for g
        -- filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    gDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of gDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    rRa DOUBLE NULL,
        -- <descr>RA-coordinate coordinate of the centroid computed for r
        -- filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    rRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of rRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    rDecl DOUBLE NULL,
        -- <descr>Decl-coordinate coordinate of the centroid computed for r
        -- filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    rDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of rDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    iRa DOUBLE NULL,
        -- <descr>RA-coordinate coordinate of the centroid computed for i
        -- filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    iRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of iRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    iDecl DOUBLE NULL,
        -- <descr>Decl-coordinate coordinate of the centroid computed for i
        -- filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    iDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of iDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    zRa DOUBLE NULL,
        -- <descr>RA-coordinate coordinate of the centroid computed for z
        -- filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    zRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of zRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    zDecl DOUBLE NULL,
        -- <descr>Decl-coordinate coordinate of the centroid computed for z
        -- filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
       -- <unit>arcsec</unit>
    zDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of zDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    yRa DOUBLE NULL,
        -- <descr>RA-coordinate coordinate of the centroid computed for y
        -- filter.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    yRaSigma DOUBLE NULL,
        -- <descr>Uncertainty of yRa.</descr>
        -- <ucd>stat.error;pos.eq.ra</ucd>
        -- <unit>arcsec</unit>
    yDecl DOUBLE NULL,
        -- <descr>Decl-coordinate coordinate of the centroid computed for y
        -- filter.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    yDeclSigma DOUBLE NULL,
        -- <descr>Uncertainty of yDecl.</descr>
        -- <ucd>stat.error;pos.eq.dec</ucd>
        -- <unit>arcsec</unit>
    uE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for u filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    uE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of uE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for u filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    uE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of uE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    uE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of uE1 and uE2.</descr>
    gE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for g filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    gE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of gE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    gE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for g filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    gE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of gE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    gE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of gE1 and gE2.</descr>
    rE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for r filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    rE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of rE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    rE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for r filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    rE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of rE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    rE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of rE1 and rE2.</descr>
    iE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for i filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    iE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of iE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    iE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for i filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    iE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of iE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    iE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of iE1 and iE2.</descr>
    zE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for z filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment 
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    zE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of zE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    zE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for z filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment 
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    zE2Sigma FLOAT NULL,
        -- <descr>Uncertainty of zE2</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    zE1_E2_Cov FLOAT NULL,
        -- <descr>Covariance of zE1 and zE2.</descr>
    yE1 FLOAT NULL,
        -- <descr>Adaptive e1 shape measure for y filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment 
        -- related quantities.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    yE1Sigma FLOAT NULL,
        -- <descr>Uncertainty of yE1</descr>
        -- <ucd>stat.error;phys.size.axisRatio</ucd>
    yE2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure for y filter. See Bernstein and
        -- Jarvis (2002) for detailed discussion of all adaptive-moment
        -- related quantities.</descr>
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
    petroFilter CHAR(1) NOT NULL,
        -- <descr>Name of the filter of the canonical petroRad.</descr>
    uPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of the canonical
        -- petroRad for u filter.</descr>
        -- <unit>nmgy</unit>
    uPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of uPetroFlux.</descr>
        -- <unit>nmgy</unit>
    gPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of the canonical 
        -- petroRad for g filter.</descr>
        -- <unit>nmgy</unit>
    gPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of gPetroFlux.</descr>
        -- <unit>nmgy</unit>
    rPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of the canonical
        -- petroRad for r filter.</descr>
        -- <unit>nmgy</unit>
    rPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of rPetroFlux.</descr>
        -- <unit>nmgy</unit>
    iPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of the canonical
        -- petroRad for i filter.</descr>
        -- <unit>nmgy</unit>
    iPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of iPetroFlux.</descr>
        -- <unit>nmgy</unit>
    zPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of the canonical
        -- petroRad for z filter.</descr>
        -- <unit>nmgy</unit>
    zPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of zPetroFlux.</descr>
        -- <unit>nmgy</unit>
    yPetroFlux FLOAT NULL,
        -- <descr>Petrosian flux within a defined multiple of the canonical
        -- petroRad for y filter.</descr>
        -- <unit>nmgy</unit>
    yPetroFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of yPetroFlux.</descr>
        -- <unit>nmgy</unit>
    uPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux for u filter.</descr>
        -- <unit>arcsec</unit>
    uPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of uPetroRad50.</descr>
        -- <unit>arcsec</unit>
    gPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux for g filter.</descr>
        -- <unit>arcsec</unit>
    gPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of gPetroRad50.</descr>
        -- <unit>arcsec</unit>
    rPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux for r filter.</descr>
        -- <unit>arcsec</unit>
    rPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of rPetroRad50.</descr>
        -- <unit>arcsec</unit>
    iPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux for i filter.</descr>
        -- <unit>arcsec</unit>
    iPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of iPetroRad50.</descr>
        -- <unit>arcsec</unit>
    zPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux for z filter.</descr>
        -- <unit>arcsec</unit>
    zPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of zPetroRad50.</descr>
        -- <unit>arcsec</unit>
    yPetroRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Petrosian flux for y filter.</descr>
        -- <unit>arcsec</unit>
    yPetroRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of yPetroRad50.</descr>
        -- <unit>arcsec</unit>
    uPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux for u filter.</descr>
        -- <unit>arcsec</unit>
    uPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of uPetroRad90.</descr>
        -- <unit>arcsec</unit>
    gPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux for g filter.</descr>
        -- <unit>arcsec</unit>
    gPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of gPetroRad90.</descr>
        -- <unit>arcsec</unit>
    rPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux for r filter.</descr>
        -- <unit>arcsec</unit>
    rPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of rPetroRad90.</descr>
        -- <unit>arcsec</unit>
    iPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux for i filter.</descr>
        -- <unit>arcsec</unit>
    iPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of iPetroRad90.</descr>
        -- <unit>arcsec</unit>
    zPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux for z filter.</descr>
        -- <unit>arcsec</unit>
    zPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of zPetroRad90.</descr>
        -- <unit>arcsec</unit>
    yPetroRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Petrosian flux for y filter.</descr>
        -- <unit>arcsec</unit>
    yPetroRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of yPetroRad90.</descr>
        -- <unit>arcsec</unit>
    uKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical apertures defined by
        -- the adaptive moments) for u filter.</descr>
        -- <unit>arcsec</unit>
    uKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of uKronRad.</descr>
        -- <unit>arcsec</unit>
    gKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical apertures defined by
        -- the adaptive moments) for g filter.</descr>
        -- <unit>arcsec</unit>
    gKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of gKronRad.</descr>
        -- <unit>arcsec</unit>
    rKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical apertures defined by
        -- the adaptive moments) for r filter.</descr>
        -- <unit>arcsec</unit>
    rKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of rKronRad.</descr>
        -- <unit>arcsec</unit>
    iKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical apertures defined by
        -- the adaptive moments) for i filter.</descr>
        -- <unit>arcsec</unit>
    iKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of iKronRad.</descr>
        -- <unit>arcsec</unit>
    zKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical apertures defined by
        -- the adaptive moments) for z filter.</descr>
        -- <unit>arcsec</unit>
    zKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of zKronRad.</descr>
        -- <unit>arcsec</unit>
    yKronRad FLOAT NULL,
        -- <descr>Kron radius (computed using elliptical apertures defined by
        -- the adaptive moments) for y filter.</descr>
        -- <unit>arcsec</unit>
    yKronRadSigma FLOAT NULL,
        -- <descr>Uncertainty of yKronRad.</descr>
        -- <unit>arcsec</unit>
    kronFilter CHAR(1) NOT NULL,
        -- <descr>The filter of the canonical kronRad.</descr>
    uKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the canonical kronRad
        -- for u filter.</descr>
        -- <unit>nmgy</unit>
    uKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of uKronFlux.</descr>
        -- <unit>nmgy</unit>
    gKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the canonical kronRad
        -- for g filter.</descr>
        -- <unit>nmgy</unit>
    gKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of gKronFlux.</descr>
        -- <unit>nmgy</unit>
    rKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the canonical kronRad
        -- for r filter.</descr>
        -- <unit>nmgy</unit>
    rKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of rKronFlux.</descr>
        -- <unit>nmgy</unit>
    iKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the canonical kronRad
        -- for i filter.</descr>
        -- <unit>nmgy</unit>
    iKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of iKronFlux.</descr>
        -- <unit>nmgy</unit>
    zKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the canonical kronRad
        -- for z filter.</descr>
        -- <unit>nmgy</unit>
    zKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of zKronFlux.</descr>
        -- <unit>nmgy</unit>
    yKronFlux FLOAT NULL,
        -- <descr>Kron flux within a defined multiple of the canonical kronRad
        -- for y filter.</descr>
        -- <unit>nmgy</unit>
    yKronFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of yKronFlux.</descr>
        -- <unit>nmgy</unit>
    uKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux for u filter.</descr>
        -- <unit>arcsec</unit>
    uKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of uKronRad50.</descr>
        -- <unit>arcsec</unit>
    gKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux for g filter.</descr>
        -- <unit>arcsec</unit>
    gKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of gKronRad50.</descr>
        -- <unit>arcsec</unit>
    rKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux for r filter.</descr>
        -- <unit>arcsec</unit>
    rKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of rKronRad50.</descr>
        -- <unit>arcsec</unit>
    iKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux for i filter.</descr>
        -- <unit>arcsec</unit>
    iKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of iKronRad50.</descr>
        -- <unit>arcsec</unit>
    zKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux for z filter.</descr>
        -- <unit>arcsec</unit>
    zKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of zKronRad50.</descr>
        -- <unit>arcsec</unit>
    yKronRad50 FLOAT NULL,
        -- <descr>Radius containing 50% of Kron flux for y filter.</descr>
        -- <unit>arcsec</unit>
    yKronRad50Sigma FLOAT NULL,
        -- <descr>Uncertainty of yKronRad50.</descr>
        -- <unit>arcsec</unit>
    uKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux for u filter.</descr>
        -- <unit>arcsec</unit>
    uKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of uKronRad90.</descr>
        -- <unit>arcsec</unit>
    gKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux for g filter.</descr>
        -- <unit>arcsec</unit>
    gKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of gKronRad90.</descr>
        -- <unit>arcsec</unit>
    rKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux for r filter.</descr>
        -- <unit>arcsec</unit>
    rKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of rKronRad90.</descr>
        -- <unit>arcsec</unit>
    iKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux for i filter.</descr>
        -- <unit>arcsec</unit>
    iKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of iKronRad90.</descr>
        -- <unit>arcsec</unit>
    zKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux for z filter.</descr>
        -- <unit>arcsec</unit>
    zKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of zKronRad90.</descr>
        -- <unit>arcsec</unit>
    yKronRad90 FLOAT NULL,
        -- <descr>Radius containing 90% of Kron flux for y filter.</descr>
        -- <unit>arcsec</unit>
    yKronRad90Sigma FLOAT NULL,
        -- <descr>Uncertainty of yKronRad90.</descr>
        -- <unit>arcsec</unit>
    uApN TINYINT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) for u filter.</descr>
    gApN TINYINT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) for g filter.</descr>
    rApN TINYINT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) for r filter.</descr>
    iApN TINYINT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) for i filter.</descr>
    zApN TINYINT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) for z filter.</descr>
    yApN TINYINT NOT NULL,
        -- <descr>Number of elliptical annuli (see below) for y filter.</descr>
    extendedness FLOAT NOT NULL,
        -- <descr>A measure of extendedness, computed using a combination of
        -- available moments and model fluxes or from a likelihood ratio of
        -- point/trailed source models (exact algorithm TBD). extendedness = 1
        -- implies a high degree of confidence that the source is extended.
        -- extendedness = 0 implies a high degree of confidence that the 
        -- source is point-like.</descr>
    FLAGS1 BIGINT NOT NULL,
        -- <descr>Flags, tbd.</descr>
    FLAGS2 BIGINT NOT NULL,
        -- <descr>Flags, tbd.</descr>
    PRIMARY KEY PK_Object (objectId),
    INDEX IDX_Object_procHistoryId (procHistoryId),
    INDEX IDX_Object_decl (psDecl ASC)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE Object_Extra
    -- <descr>Less frequently used information from The Object table.</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    psCov BLOB NULL,
        -- <descr>Various covariances for Point Source model. 66 TINYINTs.
        -- </descr>
    bdCov BLOB NULL,
        -- <descr>Covariance matrix for the Bulge+Disk model. 168 TINYINTs.
        -- [((8x9/2)-8)*6]-</descr>
    bdSamples BLOB NULL,
        -- <descr>Independent samples of Bulge+Disk likelihood surface. All
        -- sampled quantities will be stored with at lease ~3 significant
        -- digits of precision. The number of samples will vary from object to
        -- object, depending on how well the object’s likelihood function 
        -- is approximated by a Gaussian. We are assuming on average
        -- [9x200x4 FLOAT16].</descr>
    photoZ BLOB NOT NULL,
        -- <descr>Photometric redshift likelihood samples (pairs of 
        -- {z, logL}) computed using a to-be-determined published and widely
        -- accepted algorithm at the time of LSST Commissioning. 
        -- [2x100 FLOAT].</descr>
    PRIMARY KEY PK_ObjectExtra (objectId)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE Object_APMean
    -- <descr>Aperture mean (per bin) for the Object table.
    -- We expect ~8 bins on average per object.</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    filterName CHAR(1) NOT NULL,
        -- <descr>Name of the filter.</descr>
    binN TINYINT NOT NULL,
        -- <descr>A bin in radius at which the aperture measurement is being
        -- performed.</descr>
    sbMean FLOAT NOT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement is
        -- being performed.</descr>
        -- <unit>nmgy/arcsec^2</unit>
    sbSigma FLOAT NOT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    INDEX IDX_ObjectAPMean_objectId (objectId)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE Object_Periodic
    -- <descr>Definition of periodic features for Object table.
    -- We expect about 32 per object.</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    filterName CHAR(1) NOT NULL,
        -- <descr>Name of the filter.</descr>
    feature TINYINT NOT NULL,
        -- <descr>Feature/metric identifier.</descr>
    value FLOAT NOT NULL,
        -- <descr>Feature/metric value.</descr>
    INDEX IDX_ObjectPeriodic_objectId (objectId)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE Object_NonPeriodic
    -- <descr>Definition of non-periodic features for Object table.
    -- We expect about 20 per object.</descr>
(
    objectId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    filterName CHAR(1) NOT NULL,
        -- <descr>Name of the filter.</descr>
    feature TINYINT NOT NULL,
        -- <descr>Feature/metric identifier.</descr>
    value FLOAT NOT NULL,
        -- <descr>Feature/metric value.</descr>
    INDEX IDX_ObjectNonPeriodic_objectId (objectId)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE Source
    -- <descr>Table to store high signal-to-noise &quot;sources&quot;. 
    -- A source is a measurement of Object's properties from a single 
    -- image that contains its footprint on the sky.</descr>
(
    sourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    ccdVisitId BIGINT NOT NULL,
        -- <descr>Id of the ccdVisit where this source was measured. Note that
        -- we are allowing a source to belong to multiple amplifiers, but it
        -- may not span multiple ccds.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterName CHAR(1) NOT NULL,
        -- <descr>Name of the filter used to take the two exposures where this
        -- source was measured.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    objectId BIGINT NULL,
        -- <descr>Id of the corresponding object. Note that this might be NULL
        -- (each source will point to either object or ssObject).</descr>
        -- <ucd>meta.id;src</ucd>
    ssObjectId BIGINT NULL,
        -- <descr>Id of the corresponding ssObject. Note that this might be NULL
        -- (each source will point to either object or ssObject).</descr>
        -- <ucd>meta.id;src</ucd>
    parentSourceId BIGINT NULL,
        -- <descr>Id of the parent source this source has been deblended from,
        -- if any.</descr>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    htmId20 BIGINT NOT NULL,
        -- <descr>HTM index.</descr>
    sky FLOAT NULL,
        -- <descr>Estimated sky background at the position (centroid) of the
        -- source.</descr>
        -- <unit>nmgy/asec^2</unit>
    skySigma FLOAT NULL,
        -- <descr>Uncertainty of sky.</descr>
        -- <unit>nmgy/asec^2</unit>
    psFlux FLOAT NULL,
        -- <descr>Calibrated flux for Point Source model.</descr>
        -- <ucd>phot.count</ucd>
        -- <unit>nmgy</unit>
    psFluxSigma FLOAT NULL,
        -- <descr>Uncertainty of psFlux.</descr>
        -- <unit>nmgy</unit>
    psX FLOAT NULL,
        -- <descr>Point source model (x) position of the object on the CCD.
        -- </descr>
        -- <unit>pixels</unit>
    psXSigma FLOAT NULL,
        -- <descr>Uncertainty of psX.</descr>
        -- <unit>pixels</unit>
    psY FLOAT NULL,
        -- <descr>Point source model (y) position of the object on the CCD.
        -- </descr>
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
        -- <descr>Natural log likelihood of the observed data given the 
        -- Point Source model.</descr>
    psChi2 FLOAT NULL,
        -- <descr>Chi^2 static of the model fit.</descr>
    psN INT NULL,
        -- <descr>The number of data points (pixels) used to fit the model.
        -- </descr>
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
        -- <descr>x position computed using an algorithm similar to that used
        -- by SDSS.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    xSigma FLOAT NOT NULL,
        -- <descr>Uncertainty of x.</descr>
        -- <ucd>stat.error:pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    y FLOAT NOT NULL,
        -- <descr>y position computed using an algorithm similar to that used
        -- by SDSS.</descr>
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
        -- <descr>Adaptive e1 shape measure of the source as measured on the
        -- difference image.</descr>
        -- <ucd>phys.size.axisRatio</ucd>
    E1Sigma FLOAT NULL,
        -- <descr>Uncertainty of E1.</descr>
        -- <ucd>stat.error:phys.size.axisRatio</ucd>
    E2 FLOAT NULL,
        -- <descr>Adaptive e2 shape measure of the source as measured on the
        -- difference image.</descr>
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
    apN TINYINT NOT NULL,
        -- <descr>Number of elliptical annuli.</descr>
    flags BIGINT NOT NULL,
        -- <descr>Flags. Tbd.</descr>
    PRIMARY KEY PK_Source (sourceId),
    INDEX IDX_Source_ccdVisitId (ccdVisitId),
    INDEX IDX_Source_objectId (objectId),
    INDEX IDX_Source_ssObjectId (ssObjectId),
    INDEX IDX_Source_procHistoryId (procHistoryId),
    INDEX IDX_Source_htmId20 (htmId20 ASC)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE Source_APMean
    -- <descr>Aperture mean (per bin) for the Source table.
    -- We expect ~8 bins on average per source.</descr>
(
    sourceId BIGINT NOT NULL,
        -- <descr>Unique id.</descr>
        -- <ucd>meta.id;src</ucd>
    binN TINYINT NOT NULL,
        -- <descr>A bin in radius at which the aperture measurement is being
        -- performed.</descr>
    sbMean FLOAT NOT NULL,
        -- <descr>Mean surface brightness at which the aperture measurement 
        -- is being performed.</descr>
        -- <unit>nmgy/arcsec^2</unit>
    sbSigma FLOAT NOT NULL,
        -- <descr>Standard deviation of pixel surface brightness in annulus.
        -- </descr>
    INDEX IDX_SourceAPMean_sourceId (sourceId)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE ForcedSource
    -- <descr>Forced-photometry source measurement on an individual Exposure
    -- based on a Multifit shape model derived from a deep detection.</descr>
(
    objectId BIGINT NOT NULL,
        -- <ucd>meta.id;src</ucd>
    ccdVisitId BIGINT NOT NULL,
        -- <descr>Id of the ccd visit where this forcedSource was measured.
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
    flags TINYINT NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_ForcedSource (objectId, ccdVisitId),
    INDEX IDX_ForcedSource_procHistoryId (procHistoryId)
) ENGINE=MyISAM;

-- ############################################################################
-- ##### CREATE TABLES: E X P O S U R E    M E T A D A T A
-- ############################################################################

CREATE TABLE RawAmpExposure
    -- <descr>Exposure for one amplifier (raw image).</descr>
(
    rawAmpExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    rawCcdExposureId BIGINT NOT NULL,
        -- <descr>Pointer to RawCcdExposure containing this amp exposure.
        -- </descr>
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
    filterName CHAR(1) NOT NULL,
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
    bias FLOAT NOT NULL,
        -- <descr>Bias as measured from overscan columns.</descr>
        -- <unit>DN</unit>
    biasNom FLOAT NOT NULL,
        -- <descr>Preset bias.</descr>
        -- <unit>DN</unit>
    gain FLOAT NOT NULL,
        -- <descr>Measured gain value.</descr>
        -- <unit>electrons/DN</unit>
    gainNom FLOAT NOT NULL,
        -- <descr>Preset gain.</descr>
        -- <unit>DN</unit>
    rdNoise FLOAT NOT NULL,
        -- <descr>Read noise for detector/amplifier.</descr>
        -- <unit>DN</unit>
    saturation INTEGER NOT NULL,
        -- <descr>Maximum data value for A/D converter.</descr>
        -- <unit>DN</unit>
    llcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5).</descr>
        -- <unit>pixels</unit>
    llcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5).</descr>
        -- <unit>pixels</unit>
    ulcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5+NAXIS2).</descr>
        -- <unit>pixels</unit>
    ulcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5+NAXIS2).</descr>
        -- <unit>pixels</unit>
    urcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+NAXIS1, 0.5+NAXIS2).</descr>
        -- <unit>pixels</unit>
    urcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+NAXIS1, 0.5+NAXIS2).</descr>
        -- <unit>pixels</unit>
    lrcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+NAXIS1, 0.5).</descr>
        -- <unit>pixels</unit>
    lrcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+NAXIS1, 0.5).</descr>
        -- <unit>pixels</unit>
    xSize INTEGER NOT NULL,
        -- <descr>Number of columns in the image.</descr>
    ySize INTEGER NOT NULL,
        -- <descr>Number of rows in the image.</descr>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Start of the exposure, TAI, accurate to 10ms.</descr>
        -- <ucd>time.start</ucd>
    expMidpt DOUBLE NOT NULL,
        -- <descr>Midpoint for exposure. TAI, accurate to 10ms.</descr>
        -- <ucd>time.epoch</ucd>
    expTime DOUBLE NOT NULL,
        -- <descr>Duration of exposure, accurate to 10ms.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    darkTime DOUBLE NOT NULL,
        -- <descr>Dark current accumulation time, accurate to 10ms.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_RawAmpExposure (rawAmpExposureId),
    INDEX IDX_RawAmpExposure_procHistoryId (procHistoryId)
) ENGINE=MyISAM;

-- ############################################################################

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
    PRIMARY KEY PK_rawAmpExposureMetadata (rawAmpExposureId, metadataKey),
    INDEX IDX_rawAmpExposureMetadata_metadataKey (metadataKey ASC)
) ENGINE=MyISAM;

-- ############################################################################

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
    filterName CHAR(1) NOT NULL,
        -- <descr>Filter name.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA of field of view center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Declination of field of view center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    zenithDistance FLOAT NOT NULL,
        -- <descr>Zenith distance at observation mid-point.</descr>
        -- <ucd>pos.az.zd</ucd>
        -- <unit>deg</unit>
    airmass FLOAT NOT NULL,
        -- <descr>Airmass at the observed line of sight.</descr>
    llcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5).</descr>
        -- <unit>pixels</unit>
    llcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5).</descr>
        -- <unit>pixels</unit>
    ulcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5+ySize).</descr>
        -- <unit>pixels</unit>
    ulcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5+ySize).</descr>
        -- <unit>pixels</unit>
    urcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+xSize, 0.5+ySize).</descr>
        -- <unit>pixels</unit>
    urcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+xSize, 0.5+ySize).</descr>
        -- <unit>pixels</unit>
    lrcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+xSize, 0.5).</descr>
        -- <unit>pixels</unit>
    lrcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+xSize, 0.5).</descr>
        -- <unit>pixels</unit>
    xSize INTEGER NOT NULL,
        -- <descr>Number of rows in the image.</descr>
    ySize INTEGER NOT NULL,
        -- <descr>Number of columns in the image.</descr>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Start of the exposure, TAI, accurate to 10ms.</descr>
        -- <ucd>time.start</ucd>
    expMidpt DOUBLE NOT NULL,
        -- <descr>Midpoint for exposure. TAI, accurate to 10ms.</descr>
        -- <ucd>time.epoch</ucd>
    expTime DOUBLE NOT NULL,
        -- <descr>Duration of exposure, accurate to 10ms.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    darkTime DOUBLE NOT NULL,
        -- <descr>Dark current accumulation time, accurate to 10ms.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    ccdTemp FLOAT NOT NULL,
        -- <descr>Temperature measured on the Ccd.</descr>
    binX INTEGER NOT NULL,
        -- <descr>Binning of the ccd in x (row) direction.</descr>
        -- <ucd>meta.number</ucd>
        -- <unit>pixel</unit>
    binY INTEGER NOT NULL,
        -- <descr>Binning of the ccd in y (column) direction.</descr>
        -- <ucd>meta.number</ucd>
        -- <unit>pixel</unit>
    WCS BLOB NULL,
        -- <descr>A nominal WCS derives from telescope pointing information
        -- (not fitted). [10x8 BYTES].</descr>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_RawCcdExposure (rawCcdExposureId),
    INDEX IDX_RawCcdExposure_procHistoryId (procHistoryId)
) ENGINE=MyISAM;

-- ############################################################################

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

-- ############################################################################

CREATE TABLE RawExposure
    -- <descr>Raw exposure (entire exposure, all ccds).</descr>
(
    rawExposureId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier.)</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterName CHAR(1) NOT NULL,
        -- <descr>Filter name.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>Right Ascension of focal plane center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Declination of focal plane center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    altitude DOUBLE NOT NULL,
        -- <descr>Altitude of focal plane center.</descr>
        -- <unit>deg</unit>
    azimuth DOUBLE NOT NULL,
        -- <descr>Azimuth of focal plane center.</descr>
        -- <unit>deg</unit>
    rotation DOUBLE NOT NULL,
        -- <descr>Rotation of the camera.</descr>
        -- <unit>deg</unit>
    programId INT NOT NULL,
        -- <descr>Observing program id (e.g., universal cadence, or one of 
        -- the deep drilling programs, etc.).</descr>
    exposureType TINYINT NOT NULL,
        -- <descr>Type of exposure (science exposure, dark, flat, etc.).
        -- </descr>
    zenithDistance FLOAT NOT NULL,
        -- <descr>Zenith distance at observation mid-point.</descr>
        -- <ucd>pos.az.zd</ucd>
        -- <unit>deg</unit>
    airmass FLOAT NOT NULL,
        -- <descr>Airmass of the observed line of sight.</descr>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Start of the exposure, TAI, accurate to 10ms.</descr>
        -- <ucd>time.start</ucd>
    expMidpt DOUBLE NOT NULL,
        -- <descr>Midpoint for exposure. TAI, accurate to 10ms.</descr>
        -- <ucd>time.epoch</ucd>
    expTime DOUBLE NOT NULL,
        -- <descr>Duration of exposure, accurate to 10ms.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    cameraTemp FLOAT NOT NULL,
        -- <descr>Temperature measured of the camera.</descr>
        -- <unit>K</unit>
    mirror1Temp FLOAT NOT NULL,
        -- <descr>Primary mirror temperature.</descr>
        -- <unit>K</unit>
    mirror2Temp FLOAT NOT NULL,
        -- <descr>Secondary mirror temperature.</descr>
        -- <unit>K</unit>
    mirror3Temp FLOAT NOT NULL,
        -- <descr>Tertiary mirror temperature.</descr>
        -- <unit>K</unit>
    domeTemp FLOAT NOT NULL,
        -- <descr>Dome temperature.</descr>
        -- <unit>K</unit>
    externalTemp FLOAT NOT NULL,
        -- <descr>Temperature outside the dome.</descr>
        -- <unit>K</unit>
    dimmSeeing FLOAT NOT NULL, 
        -- <descr>Seeing measured by the differential image motion monitor.
        -- </descr>
        -- <unit>arcsec</unit>
    pwvGPS FLOAT NOT NULL,
        -- <descr> GPS-based measurement of precipitable water vapor (PVW).
        -- </descr>
        -- <unit>mm</unit>
    pwvMW FLOAT NOT NULL,
        -- <descr>Microwave radiometer measurement of PVW.</descr>
        -- <unit>mm</unit>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_RawExposure (rawExposureId)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE CcdVisit
(
    ccdVisitId BIGINT NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    visitId INTEGER NOT NULL,
        -- <descr>Reference to the corresponding entry in the Visit table.
        -- </descr>
        -- <ucd>meta.id;obs.exposure</ucd>
    ccdName CHAR(3) NOT NULL,
        -- <descr>Ccd name.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    raftName CHAR(3) NOT NULL,
        -- <descr>Raft name.</descr>
        -- <ucd>meta.id;instr.det</ucd>
    filterName CHAR(1) NOT NULL,
        -- <descr>Filter name used for this exposure.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    procHistoryId BIGINT NOT NULL,
        -- <descr>Pointer to ProcessingHistory table.</descr>
    nExposures INT NOT NULL,
        -- <descr>Number of exposures combined to produce this visit.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA of Ccd center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl of Ccd center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    zenithDistance FLOAT NOT NULL,
        -- <descr>Zenith distance at observation mid-point.</descr>
        -- <ucd>pos.az.zd</ucd>
        -- <unit>deg</unit>
    llcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5).</descr>
        -- <unit>pixels</unit>
    llcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5).</descr>
        -- <unit>pixels</unit>
    ulcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5+ySize).</descr>
        -- <unit>pixels</unit>
    ulcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5, 0.5+ySize).</descr>
        -- <unit>pixels</unit>
    urcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+xSize, 0.5+ySize).</descr>
        -- <unit>pixels</unit>
    urcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+xSize, 0.5+ySize).</descr>
        -- <unit>pixels</unit>
    lrcx INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+xSize, 0.5).</descr>
        -- <unit>pixels</unit>
    lrcy INTEGER NOT NULL,
        -- <descr>FITS pixel coordinates (0.5+xSize, 0.5).</descr>
        -- <unit>pixels</unit>
    xSize INTEGER NOT NULL,
        -- <descr>Number of columns in the image.</descr>
    ySize INTEGER NOT NULL,
        -- <descr>Number of rows in the image.</descr>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Start of the exposure, TAI, accurate to 10ms.</descr>
        -- <ucd>time.start</ucd>
    expMidpt DOUBLE NOT NULL,
        -- <descr>Midpoint for exposure. TAI, accurate to 10ms.</descr>
        -- <ucd>time.epoch</ucd>
    expTime DOUBLE NOT NULL,
        -- <descr>Average duration of exposure, accurate to 10ms.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    darkTime DOUBLE NOT NULL,
        -- <descr>Average dark current accumulation time, accurate to 10ms.
        -- </descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    ccdTemp FLOAT NOT NULL,
        -- <descr>Temperature measured on the Ccd.</descr>
    binX INTEGER NOT NULL,
        -- <descr>Binning of the ccd in x (row) direction.</descr>
        -- <ucd>meta.number</ucd>
        -- <unit>pixel</unit>
    binY INTEGER NOT NULL,
        -- <descr>Binning of the ccd in y (column) direction.</descr>
        -- <ucd>meta.number</ucd>
        -- <unit>pixel</unit>
    WCS BLOB NULL,
        -- <descr>Precise WCS solution for the Ccd. [100x4 BYTES].</descr>
    zeroPoint FLOAT NOT NULL,
        -- <descr>Zero-point for the Ccd, estimated at Ccd center.</descr>
    seeing FLOAT NOT NULL,
        -- <descr>Mean measured FWHM of the PSF.</descr>
        -- <unit>arcsec</unit>
    skyBg FLOAT NOT NULL,
        -- <descr>Average sky background.</descr>
        -- <unit>DN</unit>
    skyNoise FLOAT NOT NULL,
        -- <descr>RMS noise of the sky background.</descr>
        -- <unit>DN</unit>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_CcdVisit (ccdVisitId),
    INDEX IDX_CcdVisit_procHistoryId (procHistoryId)
) ENGINE=MyISAM;

-- ############################################################################

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

-- ############################################################################

CREATE TABLE Visit
    -- <descr>Defines a single Visit.</descr>
(
    visitId INTEGER NOT NULL,
        -- <descr>Unique identifier.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    filterName CHAR(1) NOT NULL,
        -- <descr>Filter name.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    nExposures INT NOT NULL,
        -- <descr>Number of exposures combined to produce this visit.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>RA of focal plane center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl DOUBLE NOT NULL,
        -- <descr>Decl of focal plane center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    altitude DOUBLE NOT NULL,
        -- <descr>Altitude of focal plane center.</descr>
        -- <unit>deg</unit>
    azimuth DOUBLE NOT NULL,
        -- <descr>Azimuth of focal plane center.</descr>
        -- <unit>deg</unit>
    rotation DOUBLE NOT NULL,
        -- <descr>Rotation of the camera.</descr>
        -- <unit>deg</unit>
    programId INT NOT NULL,
        -- <descr>Observing program id (e.g., universal cadence, or one of 
        -- the deep drilling programs, etc.).</descr>
    exposureType TINYINT NOT NULL,
        -- <descr>Type of exposure (science exposure, dark, flat, etc.).
        -- </descr>
    zenithDistance FLOAT NOT NULL,
        -- <descr>Zenith distance at observation mid-point.</descr>
        -- <ucd>pos.az.zd</ucd>
        -- <unit>deg</unit>
    airmass FLOAT NOT NULL,
        -- <descr>Airmass of the observed line of sight.</descr>
    obsStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Start of the exposure at the fiducial center of the
       -- focal plane array, TAI, accurate to 10ms.</descr>
        -- <ucd>time.start</ucd>
    expMidpt DOUBLE NOT NULL,
        -- <descr>Midpoint for exposure at the fiducial center of the
        -- focal plane array. TAI, accurate to 10ms.</descr>
        -- <ucd>time.epoch</ucd>
    expTime DOUBLE NOT NULL,
        -- <descr>Average duration of exposure, accurate to 10ms.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    cameraTemp FLOAT NOT NULL,
        -- <descr>Temperature measured of the camera.</descr>
        -- <unit>K</unit>
    mirror1Temp FLOAT NOT NULL,
        -- <descr>Primary mirror temperature.</descr>
        -- <unit>K</unit>
    mirror2Temp FLOAT NOT NULL,
        -- <descr>Secondary mirror temperature.</descr>
        -- <unit>K</unit>
    mirror3Temp FLOAT NOT NULL,
        -- <descr>Tertiary mirror temperature.</descr>
        -- <unit>K</unit>
    domeTemp FLOAT NOT NULL,
        -- <descr>Dome temperature.</descr>
        -- <unit>K</unit>
    externalTemp FLOAT NOT NULL,
        -- <descr>Temperature outside the dome.</descr>
        -- <unit>K</unit>
    dimmSeeing FLOAT NOT NULL, 
        -- <descr>Seeing measured by the differential image motion monitor.
        -- </descr>
        -- <unit>arcsec</unit>
    pwvGPS FLOAT NOT NULL,
        -- <descr> GPS-based measurement of precipitable water vapor (PVW).
        -- </descr>
        -- <unit>mm</unit>
    pwvMW FLOAT NOT NULL,
        -- <descr>Microwave radiometer measurement of PVW.</descr>
        -- <unit>mm</unit>
    flags INTEGER NOT NULL DEFAULT 0,
        -- <descr>Flags, bitwise OR tbd</descr>
        -- <ucd>meta.code</ucd>
    PRIMARY KEY PK_Visit (visitId)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE VisitMetadata
    -- <descr>Visit-related generic key-value pair metadata.</descr>
(
    visitId INTEGER NOT NULL,
        -- <descr>Id of the corresponding Visit.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey VARCHAR(255) NOT NULL,
    metadataValue VARCHAR(255) NULL,
    PRIMARY KEY PK_VisitMetadata (visitId)
) ENGINE=MyISAM;

-- ############################################################################

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

-- ############################################################################
-- ##### CREATE TABLES: P R O V E N A N C E
-- ############################################################################

CREATE TABLE prv_ProcHistory 
    -- <descr>This table is responsible for producing a new procHistoryId
    -- whenever something changes in the configuration.</descr>
(
    procHistoryId BIGINT NOT NULL AUTO_INCREMENT,
        -- <descr>Unique id</descr>
        -- <ucd>meta.id;src</ucd>
    PRIMARY KEY PK_prvProcHistory (procHistoryId)
) ENGINE=InnoDB;

-- ############################################################################

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
    PRIMARY KEY PK_prvCnfAmp (cAmpId),
    INDEX IDX_prvCnfAmp_ampName (ampName)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_Ccd
(
    cCcdId SMALLINT NOT NULL,
    ccdName CHAR(3) NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    serialN INTEGER NOT NULL,
    PRIMARY KEY PK_prvCnfCcd (cCcdId),
    INDEX IDX_prvCnfCcd_ccdName (ccdName)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_Filter
(
    cFilterId SMALLINT NOT NULL,
    filterName CHAR,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY PK_prvCnfFilter (cFilterId),
    INDEX IDX_prvCnfFilter_filterName (filterName)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_Fpa
(
    cFpaId SMALLINT NOT NULL,
    fpaId TINYINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    versionN SMALLINT NOT NULL,
    PRIMARY KEY PK_prvCnfFpa (cFpaId),
    INDEX IDX_prvCnfFpa_fpaId (fpaId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_InputDataSet
(
    cInputDataSetId INTEGER NOT NULL,
    inputDataSetId INTEGER NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY PK_prvCnfInputDataSet (cInputDataSetId),
    INDEX IDX_prvCnfInputDataSet (inputDataSetId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_Node
(
    cNodeId INTEGER NOT NULL,
    nodeId INTEGER NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY PK_prvCnfNode (cNodeId),
    INDEX IDX_prvCnfNode_nodeId (nodeId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_Raft
(
    cRaftId SMALLINT NOT NULL,
    raftName CHAR(3) NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    serialN INTEGER NOT NULL,
    PRIMARY KEY PK_prvCnfRaft (cRaftId),
    INDEX IDX_prvCnfRaft_raftName (raftName)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_Run
(
    cRunId MEDIUMINT NOT NULL,
    runId MEDIUMINT NOT NULL,
    PRIMARY KEY PK_prvCnfRun (cRunId),
    INDEX IDX_prvCnfRun_runId (runId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_Task
(
    cTaskId MEDIUMINT NOT NULL,
    taskId SMALLINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY PK_prvCnfTask (cTaskId),
    INDEX IDX_prvCnfTask_taskId (taskId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_Task2TaskExecution
(
    cTask2TaskExecutionId MEDIUMINT NOT NULL,
    task2taskExecutionId MEDIUMINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY PK_prvCnfTask2TaskExecution (cTask2TaskExecutionId),
    INDEX IDX_prvCnfTask2TaskExecution_task2taskExecutionId (task2taskExecutionId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_Task2TaskGraph
(
    cTask2TaskGraphId MEDIUMINT NOT NULL,
    task2taskGraphId MEDIUMINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY PK_prvCnfTask2TaskGraph (cTask2TaskGraphId),
    INDEX IDX_prvCnfTask2TaskGraph_task2taskGraphId (task2taskGraphId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_TaskExecution
(
    cTaskExecutionId MEDIUMINT NOT NULL,
    taskExecutionId MEDIUMINT NOT NULL,
    nodeId INTEGER NOT NULL,
    inputDataSetId INTEGER NOT NULL,
    procHistoryId BIGINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY PK_prvCnfTaskExecution (cTaskExecutionId),
    INDEX IDX_prvCnfTaskExecution_nodeId (nodeId),
    INDEX IDX_prvCnfTaskExecution_taskExecutionId (taskExecutionId),
    INDEX IDX_prvCnfTaskExecution_inputDataSetId (inputDataSetId),
    INDEX IDX_prvCnfTaskExecution_procHistoryId (procHistoryId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_TaskGraph
(
    cTaskGraphId SMALLINT NOT NULL,
    taskGraphId SMALLINT NOT NULL,
    PRIMARY KEY PK_prvCnfTaskGraph (cTaskGraphId),
    INDEX IDX_prvCnfTaskGraph_taskGraphId (taskGraphId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_cnf_TaskGraph2Run
(
    cTaskGraph2RunId MEDIUMINT NOT NULL,
    taskGraph2runId MEDIUMINT NOT NULL,
    validityBegin DATETIME NOT NULL,
    validityEnd DATETIME NOT NULL,
    PRIMARY KEY PK_prvCnfTaskGraph2Run (cTaskGraph2RunId),
    INDEX IDX_prvCnfTaskGraph2Run_taskGraph2runId (taskGraph2runId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Amp
(
    ampName CHAR(3) NOT NULL,
    ccdName CHAR(3) NOT NULL,
    raftName CHAR(3) NOT NULL,
    PRIMARY KEY PK_prvAmp (raftName, ccdName, ampName),
    INDEX IDX_prvAmp_ampName (ampName)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Ccd
(
    ccdName CHAR(3) NOT NULL,
    raftName CHAR(3) NOT NULL,
    PRIMARY KEY PK_prvCcd (raftName, ccdName),
    INDEX IDX_prvCcd_ccdName (ccdName)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Filter
    -- <descr>One row per color - the table will have 6 rows</descr>
(
    filterName CHAR(1) NOT NULL,
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
    PRIMARY KEY PK_prvFilter (filterName)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Fpa
(
    fpaId TINYINT NOT NULL,
    PRIMARY KEY PK_prvFpa (fpaId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_InputDataSet
(
    inputDataSetId INTEGER NOT NULL,
    name VARCHAR(80) NOT NULL,    
    PRIMARY KEY PK_prvInputDataSet (inputDataSetId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Node
(
    nodeId INTEGER NOT NULL,
    PRIMARY KEY PK_prvNode (nodeId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Raft
(
    raftName CHAR(3) NOT NULL,
    fpaId TINYINT NOT NULL,
    PRIMARY KEY PK_prvRaft (raftName)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Run
(
    runId MEDIUMINT NOT NULL,
    PRIMARY KEY PK_prvRun (runId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Snapshot
(
    snapshotId MEDIUMINT NOT NULL,
    procHistoryId BIGINT NOT NULL,
    snapshotDescr VARCHAR(255) NULL,
    PRIMARY KEY PK_prvSnapshot (snapshotId),
    INDEX IDX_prvSnapshot_procHistoryId (procHistoryId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Task
(
    taskId SMALLINT NOT NULL,
    taskName VARCHAR(255) NULL,
    PRIMARY KEY PK_prvTask (taskId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Task2TaskExecution
(
    task2TaskExecutionId MEDIUMINT NOT NULL,
    taskExecutionId MEDIUMINT NOT NULL,
    taskId SMALLINT NOT NULL,
    PRIMARY KEY (task2TaskExecutionId),
    INDEX PK_prvTask2TaskExecution (taskId),
    INDEX IDX_prvTask2TaskExecution_taskExecutionId(taskExecutionId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_Task2TaskGraph
(
    task2taskGraphId MEDIUMINT NOT NULL,
    taskId SMALLINT NOT NULL,
    taskGraphId SMALLINT NOT NULL,
    PRIMARY KEY PK_prvTask2TaskGraph (task2taskGraphId),
    INDEX IDX_prvTask2TaskGraph_taskGraphId (taskGraphId),
    INDEX IDX_prvTask2TaskGraph_taskId (taskId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_TaskExecution
(
    taskExecutionId MEDIUMINT NOT NULL,
    PRIMARY KEY PK_prvTaskExecution (taskExecutionId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_TaskGraph
(
    taskGraphId SMALLINT NOT NULL,
    taskGraphName VARCHAR(64) NULL,
    PRIMARY KEY PK_prvTaskGraph (taskGraphId)
) ENGINE=InnoDB;

-- ############################################################################

CREATE TABLE prv_TaskGraph2Run
(
    taskGraph2runId MEDIUMINT NOT NULL,
    runId MEDIUMINT NOT NULL,
    taskGraphId SMALLINT NOT NULL,
    PRIMARY KEY (taskGraph2runId),
    INDEX PK_prvTaskGraph2Run (taskGraphId),
    INDEX IDX_prvTaskGraph2Run_runId (runId)
) ENGINE=InnoDB;

-- ############################################################################
-- ##### CREATE TABLES: S D Q A
-- ############################################################################

CREATE TABLE sdqa_ImageStatus
    -- <descr>Unique set of status names and their definitions, e.g.
    -- 'passed', 'failed', etc.</descr>
(
    sdqa_imageStatusId SMALLINT NOT NULL AUTO_INCREMENT,
        -- <descr>Primary key</descr>
    statusName VARCHAR(30) NOT NULL,
        -- <descr>One-word, camel-case, descriptive name of a possible image
        -- status (e.g., passedAuto, marginallyPassedManual, etc.)</descr>
    definition VARCHAR(255) NOT NULL,
        -- <descr>Detailed Definition of the image status</descr>
    PRIMARY KEY PK_sdqaImageStatus (sdqa_imageStatusId)
) ENGINE=MyISAM;

-- ############################################################################

CREATE TABLE sdqa_Metric
    -- <descr>Unique set of metric names and associated metadata (e.g.,
    -- 'nDeadPix';, 'median';, etc.). There will be
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
    PRIMARY KEY PK_sdqaMetric (sdqa_metricId),
    UNIQUE UQ_sdqaMetric_metricName (metricName)
) ENGINE=MyISAM;

-- ############################################################################

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
    PRIMARY KEY PK_sdqaRatingForAmpVisit (sdqa_ratingId),
    UNIQUE UQ_sdqaRatingForAmpVisit_metricId_ampVisitId (sdqa_metricId, ampVisitId),
    INDEX IDX_sdqaRatingForAmpVisit_metricId (sdqa_metricId),
    INDEX IDX_sdqaRatingForAmpVisit_thresholdId (sdqa_thresholdId),
    INDEX IDX_sdqaRatingForAmpVisit_ampVisitId (ampVisitId)
) ENGINE=MyISAM;

-- ############################################################################

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
    PRIMARY KEY PK_sdqaRatingCcdVisit (sdqa_ratingId),
    UNIQUE UQ_sdqaRatingCcdVisit_metricId_ccdVisitId(sdqa_metricId, ccdVisitId),
    INDEX IDX_sdqaRatingCcdVisit_metricId (sdqa_metricId),
    INDEX IDX_sdqaRatingCcdVisit_thresholdId (sdqa_thresholdId),
    INDEX IDX_sdqaRatingCcdVisit_ccdVisitId (ccdVisitId)
) ENGINE=MyISAM;

-- ############################################################################

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
    PRIMARY KEY PK_sdqaThreshold (sdqa_thresholdId),
    INDEX IDX_sdqaThreshold_metricId (sdqa_metricId)
) ENGINE=MyISAM;

-- ############################################################################
-- ##### CREATE TABLES: O T H E R S
-- ############################################################################

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

-- ############################################################################

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
    PRIMARY KEY PK_ApertureBins (binN)
) ENGINE=MyISAM;

-- ############################################################################
-- ############################################################################
-- ############################################################################

SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE DiaObject ADD CONSTRAINT FK_DiaObject_prvProcHistory
        FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE SSObject ADD CONSTRAINT FK_SSObject_prvProcHistory
        FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE DiaSource ADD CONSTRAINT FK_DiaSource_CcdVisit
        FOREIGN KEY (ccdVisitId) REFERENCES CcdVisit (ccdVisitId);

ALTER TABLE DiaSource ADD CONSTRAINT FK_DiaSource_prvFilter
        FOREIGN KEY (filterName) REFERENCES prv_Filter (filterName);

ALTER TABLE DiaSource ADD CONSTRAINT FK_DiaSource_prvProcHistory
        FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE DiaForcedSource ADD CONSTRAINT FK_DiaForcedSource_CcdVisit
        FOREIGN KEY (ccdVisitId) REFERENCES CcdVisit (ccdVisitId);

ALTER TABLE DiaForcedSource ADD CONSTRAINT FK_DiaForcedSource_prvProcHistory
        FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE DiaObject_To_Object_Match ADD CONSTRAINT FK_DiaObjectToObjectMatch_DiaObject
        FOREIGN KEY (diaObjectId) REFERENCES DiaObject (diaObjectId);

ALTER TABLE DiaObject_To_Object_Match ADD CONSTRAINT FK_DiaObjectToObjectMatch_Object
        FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE Object ADD CONSTRAINT FK_Object_Object
        FOREIGN KEY (parentObjectId) REFERENCES Object (objectId);

ALTER TABLE Object ADD CONSTRAINT FK_Object_prvProcHistory
        FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE Object_Extra ADD CONSTRAINT FK_ObjectExtra_Object
        FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE Object_APMean ADD CONSTRAINT FK_ObjectAPMean_Object
        FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE Object_APMean ADD CONSTRAINT FK_ObjectAPMean_prvFilter
        FOREIGN KEY (filterName) REFERENCES prv_Filter (filterName);

ALTER TABLE Object_APMean ADD CONSTRAINT FK_ObjectAPMean_ApertureBins
        FOREIGN KEY (binN) REFERENCES ApertureBins (binN);

ALTER TABLE Object_Periodic ADD CONSTRAINT FK_ObjectPeriodic_Object
        FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE Object_Periodic ADD CONSTRAINT FK_ObjectPeriodic_prvFilter
        FOREIGN KEY (filterName) REFERENCES prv_Filter (filterName);

ALTER TABLE Object_NonPeriodic ADD CONSTRAINT FK_ObjectNonPeriodic_Object
        FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE Object_NonPeriodic ADD CONSTRAINT FK_ObjectNonPeriodic_prvFilter
        FOREIGN KEY (filterName) REFERENCES prv_Filter (filterName);

ALTER TABLE Source ADD CONSTRAINT FK_Source_CcdVisit
        FOREIGN KEY (ccdVisitId) REFERENCES CcdVisit (ccdVisitId);

ALTER TABLE Source ADD CONSTRAINT FK_Source_prvFilter
        FOREIGN KEY (filterName) REFERENCES prv_Filter (filterName);

ALTER TABLE Source ADD CONSTRAINT FK_Source_Object
        FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE Source ADD CONSTRAINT FK_Source_SSObject
        FOREIGN KEY (ssObjectId) REFERENCES SSObject (ssObjectId);

ALTER TABLE Source ADD CONSTRAINT FK_Source_Source
        FOREIGN KEY (parentSourceId) REFERENCES Source (sourceId);

ALTER TABLE Source ADD CONSTRAINT FK_Source_prvProcHistory
        FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE Source_APMean ADD CONSTRAINT FK_SourceAPMean_Source
        FOREIGN KEY (sourceId) REFERENCES Source (sourceId);

ALTER TABLE Source_APMean ADD CONSTRAINT FK_SourceAPMean_ApertureBins
        FOREIGN KEY (binN) REFERENCES ApertureBins (binN);

ALTER TABLE ForcedSource ADD CONSTRAINT FK_ForcedSource_Object
        FOREIGN KEY (objectId) REFERENCES Object (objectId);

ALTER TABLE ForcedSource ADD CONSTRAINT FK_ForcedSource_CcdVisit
        FOREIGN KEY (ccdVisitId) REFERENCES CcdVisit (ccdVisitId);

ALTER TABLE ForcedSource ADD CONSTRAINT FK_ForcedSource_prvProcHistory
        FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE RawAmpExposure ADD CONSTRAINT FK_RawAmpExposure_RawCcdExposure
        FOREIGN KEY (rawCcdExposureId) REFERENCES RawCcdExposure (rawCcdExposureId);

ALTER TABLE RawAmpExposure ADD CONSTRAINT FK_RawAmpExposure_prvAmp
        FOREIGN KEY (ampName) REFERENCES prv_Amp (ampName);

ALTER TABLE RawAmpExposure ADD CONSTRAINT FK_RawAmpExposure_prvCcd
        FOREIGN KEY (ccdName) REFERENCES prv_Ccd (ccdName);

ALTER TABLE RawAmpExposure ADD CONSTRAINT FK_RawAmpExposure_prvRaft
        FOREIGN KEY (raftName) REFERENCES prv_Raft (raftName);

ALTER TABLE RawAmpExposure ADD CONSTRAINT FK_RawAmpExposure_prvFilter
        FOREIGN KEY (filterName) REFERENCES prv_Filter (filterName);

ALTER TABLE RawAmpExposureMetadata ADD CONSTRAINT FK_RawAmpExposure_RawAmpExposure
        FOREIGN KEY (rawAmpExposureId) REFERENCES RawAmpExposure (rawAmpExposureId);

ALTER TABLE RawCcdExposure ADD CONSTRAINT FK_RawCcdExposure_RawExposure
        FOREIGN KEY (rawExposureId) REFERENCES RawExposure (rawExposureId);

ALTER TABLE RawCcdExposure ADD CONSTRAINT FK_RawCcdExposure_prvCcd
        FOREIGN KEY (ccdName) REFERENCES prv_Ccd (ccdName);

ALTER TABLE RawCcdExposure ADD CONSTRAINT FK_RawCcdExposure_prvRaft
        FOREIGN KEY (raftName) REFERENCES prv_Raft (raftName);

ALTER TABLE RawCcdExposure ADD CONSTRAINT FK_RawCcdExposure_prvFilter
        FOREIGN KEY (filterName) REFERENCES prv_Filter (filterName);

ALTER TABLE RawCcdExposure ADD CONSTRAINT FK_RawCcdExposure_prvProcHistory
        FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE RawCcdExposureMetadata ADD CONSTRAINT FK_RawCcdExposureMetadata_RawCcdExposure
        FOREIGN KEY (rawCcdExposureId) REFERENCES RawCcdExposure (rawCcdExposureId);

ALTER TABLE CcdVisit ADD CONSTRAINT FK_CcdVisit_Visit
        FOREIGN KEY (visitId) REFERENCES Visit (visitId);

ALTER TABLE CcdVisit ADD CONSTRAINT FK_CcdVisit_prvCcd
        FOREIGN KEY (ccdName) REFERENCES prv_Ccd (ccdName);

ALTER TABLE CcdVisit ADD CONSTRAINT FK_CcdVisit_prvRaft
        FOREIGN KEY (raftName) REFERENCES prv_Raft (raftName);

ALTER TABLE CcdVisit ADD CONSTRAINT FK_CcdVisit_prvFilter
        FOREIGN KEY (filterName) REFERENCES prv_Filter (filterName);

ALTER TABLE CcdVisit ADD CONSTRAINT FK_CcdVisit_prvProcHistory
        FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE CcdVisitMetadata ADD CONSTRAINT FK_CcdVisitMetadata_CcdVisit
        FOREIGN KEY (ccdVisitId) REFERENCES CcdVisit (ccdVisitId);

ALTER TABLE VisitMetadata ADD CONSTRAINT FK_VisitMetadata_Visit
        FOREIGN KEY (visitId) REFERENCES Visit (visitId);

ALTER TABLE Visit_To_RawExposure ADD CONSTRAINT FK_VisitToRawExposure_Visit
        FOREIGN KEY (visitId) REFERENCES Visit (visitId);

ALTER TABLE Visit_To_RawExposure ADD CONSTRAINT FK_VisitToRawExposure_RawExposure
        FOREIGN KEY (rawExposureId) REFERENCES RawExposure (rawExposureId);

ALTER TABLE prv_cnf_Amp ADD CONSTRAINT FK_prvCnfAmp_prvAmp 
	FOREIGN KEY (ampName) REFERENCES prv_Amp (ampName);

ALTER TABLE prv_cnf_Ccd ADD CONSTRAINT FK_prvCnfCcd_prvCcd
	FOREIGN KEY (ccdName) REFERENCES prv_Ccd (ccdName);

ALTER TABLE prv_cnf_Filter ADD CONSTRAINT FK_prvCnfFilter_prvFilter
	FOREIGN KEY (filterName) REFERENCES prv_Filter (filterName);

ALTER TABLE prv_cnf_Fpa ADD CONSTRAINT FK_prvCnfFpa_prvFpa
	FOREIGN KEY (fpaId) REFERENCES prv_Fpa (fpaId);

ALTER TABLE prv_cnf_InputDataSet ADD CONSTRAINT FK_prvCnfInputDataSet_prvInputDataSet
	FOREIGN KEY (inputDataSetId) REFERENCES prv_InputDataSet (inputDataSetId);

ALTER TABLE prv_cnf_Node ADD CONSTRAINT FK_prvCnfNode_prvNode 
	FOREIGN KEY (nodeId) REFERENCES prv_Node (nodeId);

ALTER TABLE prv_cnf_Raft ADD CONSTRAINT FK_prvCnfRaft_prvRaft 
	FOREIGN KEY (raftName) REFERENCES prv_Raft (raftName);

ALTER TABLE prv_cnf_Run ADD CONSTRAINT FK_prvCnfRun_prvRun
	FOREIGN KEY (runId) REFERENCES prv_Run (runId);

ALTER TABLE prv_cnf_Task ADD CONSTRAINT FK_prvCnfTask_prvTask
	FOREIGN KEY (taskId) REFERENCES prv_Task (taskId);

ALTER TABLE prv_cnf_Task2TaskExecution ADD CONSTRAINT FK_prvCnfTask2TaskExecution_prvTask2TaskExecution 
	FOREIGN KEY (task2taskExecutionId) REFERENCES prv_Task2TaskExecution (task2TaskExecutionId);

ALTER TABLE prv_cnf_Task2TaskGraph ADD CONSTRAINT FK_prvCnfTask2TaskGraph_prvTask2TaskGraph 
	FOREIGN KEY (task2taskGraphId) REFERENCES prv_Task2TaskGraph (task2taskGraphId);

ALTER TABLE prv_cnf_TaskExecution ADD CONSTRAINT FK_prvCnfTaskExecution_prvTaskExecution 
	FOREIGN KEY (taskExecutionId) REFERENCES prv_TaskExecution (taskExecutionId);

ALTER TABLE prv_cnf_TaskExecution ADD CONSTRAINT FK_prvCnfTaskExecution_prvNode 
	FOREIGN KEY (nodeId) REFERENCES prv_Node (nodeId);

ALTER TABLE prv_cnf_TaskExecution ADD CONSTRAINT FK_prvCnfTaskExecution_prvInputDataSet 
	FOREIGN KEY (inputDataSetId) REFERENCES prv_InputDataSet (inputDataSetId);

ALTER TABLE prv_cnf_TaskExecution ADD CONSTRAINT FK_prvCnfTaskExecution_prvProcHistory 
	FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE prv_cnf_TaskGraph ADD CONSTRAINT FK_prvCnfTaskGraph_prvTaskGraph 
	FOREIGN KEY (taskGraphId) REFERENCES prv_TaskGraph (taskGraphId);

ALTER TABLE prv_cnf_TaskGraph2Run ADD CONSTRAINT FK_prvCnfTaskGraph2Run_prvTaskGraph2Run 
	FOREIGN KEY (taskGraph2runId) REFERENCES prv_TaskGraph2Run (taskGraph2runId);

ALTER TABLE prv_Amp ADD CONSTRAINT FK_prvAmp_prvCcd
	FOREIGN KEY (ccdName) REFERENCES prv_Ccd (ccdName);

ALTER TABLE prv_Ccd ADD CONSTRAINT FK_prvCcd_prvRaft 
	FOREIGN KEY (raftName) REFERENCES prv_Raft (raftName);

ALTER TABLE prv_Raft ADD CONSTRAINT FK_prvRaft_prvFpa
	FOREIGN KEY (fpaId) REFERENCES prv_Fpa (fpaId);

ALTER TABLE prv_Snapshot ADD CONSTRAINT FK_prvSnapshot_prvProcessingHistory 
	FOREIGN KEY (procHistoryId) REFERENCES prv_ProcHistory (procHistoryId);

ALTER TABLE prv_Task2TaskExecution ADD CONSTRAINT FK_prvTask2TaskExecution_prvTask
	FOREIGN KEY (taskId) REFERENCES prv_Task (taskId);

ALTER TABLE prv_Task2TaskExecution ADD CONSTRAINT FK_prvTask2TaskExecution_prvTaskExecution
	FOREIGN KEY (taskExecutionId) REFERENCES prv_TaskExecution (taskExecutionId);

ALTER TABLE prv_Task2TaskGraph ADD CONSTRAINT FK_prvTask2TaskGraph_prvTask
	FOREIGN KEY (taskId) REFERENCES prv_Task (taskId);

ALTER TABLE prv_Task2TaskGraph ADD CONSTRAINT FK_prvTask2TaskGraph_prvTaskGraph
	FOREIGN KEY (taskGraphId) REFERENCES prv_TaskGraph (taskGraphId);

ALTER TABLE prv_TaskGraph2Run ADD CONSTRAINT FK_prvTaskGraph2Run_prvRun 
	FOREIGN KEY (runId) REFERENCES prv_Run (runId);

ALTER TABLE prv_TaskGraph2Run ADD CONSTRAINT FK_prvTaskGraph2Run_prvTaskGraph 
	FOREIGN KEY (taskGraphId) REFERENCES prv_TaskGraph (taskGraphId);
