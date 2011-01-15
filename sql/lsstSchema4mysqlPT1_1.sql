
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
(
	ampNum TINYINT NOT NULL,
	ampName CHAR(3) NOT NULL,
	PRIMARY KEY (ampNum),
	UNIQUE UQ_AmpMap_ampName(ampName)
) ;


CREATE TABLE CcdMap
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
	photClam FLOAT(0) NOT NULL,
	photBW FLOAT(0) NOT NULL,
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


CREATE TABLE ObjectType
(
	typeId SMALLINT NOT NULL,
	description VARCHAR(255) NULL,
	PRIMARY KEY (typeId)
) TYPE=MyISAM;


CREATE TABLE RaftMap
(
	raftNum TINYINT NOT NULL,
	raftName CHAR(3) NOT NULL,
	PRIMARY KEY (raftNum),
	UNIQUE UQ_RaftMap_raftName(raftName)
) ;


CREATE TABLE RefObjMatch
(
	refObjectId BIGINT NULL,
	objectId BIGINT NULL,
	refRa DOUBLE NULL,
	refDec DOUBLE NULL,
	angSep DOUBLE NULL,
	nRefMatches INTEGER NULL,
	nObjMatches INTEGER NULL,
	closestToRef TINYINT NULL,
	closestToObj TINYINT NULL,
	flags INTEGER NULL,
	KEY (objectId),
	KEY (refObjectId)
) TYPE=MyISAM;


CREATE TABLE SimRefObject
(
	refObjectId BIGINT NOT NULL,
	isStar TINYINT NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	gLat DOUBLE NULL,
	gLon DOUBLE NULL,
	sedName CHAR(32) NULL,
	uMag DOUBLE NOT NULL,
	gMag DOUBLE NOT NULL,
	rMag DOUBLE NOT NULL,
	iMag DOUBLE NOT NULL,
	zMag DOUBLE NOT NULL,
	yMag DOUBLE NOT NULL,
	muRa DOUBLE NULL,
	muDecl DOUBLE NULL,
	parallax DOUBLE NULL,
	vRad DOUBLE NULL,
	isVar TINYINT NOT NULL,
	redshift DOUBLE NULL,
	uCov INTEGER NOT NULL,
	gCov INTEGER NOT NULL,
	rCov INTEGER NOT NULL,
	iCov INTEGER NOT NULL,
	zCov INTEGER NOT NULL,
	yCov INTEGER NOT NULL,
	PRIMARY KEY (refObjectId),
	INDEX IDX_decl (decl ASC)
) TYPE=MyISAM;


CREATE TABLE sdqa_ImageStatus
(
	sdqa_imageStatusId SMALLINT NOT NULL AUTO_INCREMENT,
	statusName VARCHAR(30) NOT NULL,
	definition VARCHAR(255) NOT NULL,
	PRIMARY KEY (sdqa_imageStatusId)
) TYPE=MyISAM;


CREATE TABLE sdqa_Metric
(
	sdqa_metricId SMALLINT NOT NULL AUTO_INCREMENT,
	metricName VARCHAR(30) NOT NULL,
	physicalUnits VARCHAR(30) NOT NULL,
	dataType CHAR(1) NOT NULL,
	definition VARCHAR(255) NOT NULL,
	PRIMARY KEY (sdqa_metricId),
	UNIQUE UQ_sdqaMetric_metricName(metricName)
) TYPE=MyISAM;


CREATE TABLE sdqa_Rating_ForScienceAmpExposure
(
	sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
	sdqa_metricId SMALLINT NOT NULL,
	sdqa_thresholdId SMALLINT NOT NULL,
	ampExposureId BIGINT NOT NULL,
	metricValue DOUBLE NOT NULL,
	metricSigma DOUBLE NOT NULL,
	PRIMARY KEY (sdqa_ratingId),
	UNIQUE UQ_sdqaRating_ForScienceAmpExposure_metricId_ampExposureId(sdqa_metricId, ampExposureId),
	KEY (sdqa_metricId),
	KEY (sdqa_thresholdId),
	KEY (ampExposureId)
) TYPE=MyISAM;


CREATE TABLE sdqa_Rating_ForScienceCcdExposure
(
	sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
	sdqa_metricId SMALLINT NOT NULL,
	sdqa_thresholdId SMALLINT NOT NULL,
	ccdExposureId BIGINT NOT NULL,
	metricValue DOUBLE NOT NULL,
	metricSigma DOUBLE NOT NULL,
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
(
	sdqa_thresholdId SMALLINT NOT NULL AUTO_INCREMENT,
	sdqa_metricId SMALLINT NOT NULL,
	upperThreshold DOUBLE NULL,
	lowerThreshold DOUBLE NULL,
	createdDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
(
	rawAmpExposureId BIGINT NOT NULL,
	metadataKey VARCHAR(255) NOT NULL,
	exposureType TINYINT NOT NULL,
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
	visit INTEGER NOT NULL,
	raft TINYINT NOT NULL,
	ccd TINYINT NOT NULL,
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
	nCombine INTEGER NOT NULL,
	binX INTEGER NOT NULL,
	binY INTEGER NOT NULL,
	readNoise FLOAT(0) NOT NULL,
	saturationLimit INTEGER NOT NULL,
	gainEff DOUBLE NOT NULL,
	fluxMag0 FLOAT(0) NOT NULL,
	fluxMag0Sigma FLOAT(0) NOT NULL,
	fwhm DOUBLE NOT NULL,
	PRIMARY KEY (scienceCcdExposureId)
) TYPE=MyISAM;


CREATE TABLE Science_Ccd_Exposure_Metadata
(
	scienceCcdExposureId BIGINT NOT NULL,
	metadataKey VARCHAR(255) NOT NULL,
	exposureType TINYINT NOT NULL,
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
(
	visitId INTEGER NOT NULL
) TYPE=MyISAM;


CREATE TABLE Object
(
	objectId BIGINT NOT NULL,
	iauId CHAR(34) NULL,
	ra_PS DOUBLE NOT NULL,
	ra_PS_Sigma FLOAT(0) NULL,
	decl_PS DOUBLE NOT NULL,
	decl_PS_Sigma FLOAT(0) NULL,
	radecl_PS_Cov FLOAT(0) NULL,
	ra_SG DOUBLE NULL,
	ra_SG_Sigma FLOAT(0) NULL,
	decl_SG DOUBLE NULL,
	decl_SG_Sigma FLOAT(0) NULL,
	radecl_SG_Cov FLOAT(0) NULL,
	raRange FLOAT(0) NULL,
	declRange FLOAT(0) NULL,
	muRa_PS DOUBLE NULL,
	muRa_PS_Sigma FLOAT(0) NULL,
	muDecl_PS DOUBLE NULL,
	muDecl_PS_Sigma FLOAT(0) NULL,
	muRaDecl_PS_Cov FLOAT(0) NULL,
	parallax_PS DOUBLE NULL,
	parallax_PS_Sigma FLOAT(0) NULL,
	canonicalFilterId TINYINT NULL,
	extendedness FLOAT(0) NULL,
	varProb FLOAT(0) NULL,
	earliestObsTime DOUBLE NULL,
	latestObsTime DOUBLE NULL,
	flags INTEGER NULL,
	uNumObs INTEGER NULL,
	uExtendedness FLOAT(0) NULL,
	uVarProb FLOAT(0) NULL,
	uRaOffset_PS FLOAT(0) NULL,
	uRaOffset_PS_Sigma FLOAT(0) NULL,
	uDeclOffset_PS FLOAT(0) NULL,
	uDeclOffset_PS_Sigma FLOAT(0) NULL,
	uRaDeclOffset_PS_Cov FLOAT(0) NULL,
	uRaOffset_SG FLOAT(0) NULL,
	uRaOffset_SG_Sigma FLOAT(0) NULL,
	uDeclOffset_SG FLOAT(0) NULL,
	uDeclOffset_SG_Sigma FLOAT(0) NULL,
	uRaDeclOffset_SG_Cov FLOAT(0) NULL,
	uLnL_PS FLOAT(0) NULL,
	uLnL_SG FLOAT(0) NULL,
	uFlux_PS FLOAT(0) NULL,
	uFlux_PS_Sigma FLOAT(0) NULL,
	uFlux_SG FLOAT(0) NULL,
	uFlux_SG_Sigma FLOAT(0) NULL,
	uFlux_CSG FLOAT(0) NULL,
	uFlux_CSG_Sigma FLOAT(0) NULL,
	uTimescale FLOAT(0) NULL,
	uEarliestObsTime DOUBLE NULL,
	uLatestObsTime DOUBLE NULL,
	uSersicN_SG FLOAT(0) NULL,
	uSersicN_SG_Sigma FLOAT(0) NULL,
	uE1_SG FLOAT(0) NULL,
	uE1_SG_Sigma FLOAT(0) NULL,
	uE2_SG FLOAT(0) NULL,
	uE2_SG_Sigma FLOAT(0) NULL,
	uRadius_SG FLOAT(0) NULL,
	uRadius_SG_Sigma FLOAT(0) NULL,
	uFlags INTEGER NULL,
	gNumObs INTEGER NULL,
	gExtendedness FLOAT(0) NULL,
	gVarProb FLOAT(0) NULL,
	gRaOffset_PS FLOAT(0) NULL,
	gRaOffset_PS_Sigma FLOAT(0) NULL,
	gDeclOffset_PS FLOAT(0) NULL,
	gDeclOffset_PS_Sigma FLOAT(0) NULL,
	gRaDeclOffset_PS_Cov FLOAT(0) NULL,
	gRaOffset_SG FLOAT(0) NULL,
	gRaOffset_SG_Sigma FLOAT(0) NULL,
	gDeclOffset_SG FLOAT(0) NULL,
	gDeclOffset_SG_Sigma FLOAT(0) NULL,
	gRaDeclOffset_SG_Cov FLOAT(0) NULL,
	gLnL_PS FLOAT(0) NULL,
	gLnL_SG FLOAT(0) NULL,
	gFlux_PS FLOAT(0) NULL,
	gFlux_PS_Sigma FLOAT(0) NULL,
	gFlux_SG FLOAT(0) NULL,
	gFlux_SG_Sigma FLOAT(0) NULL,
	gFlux_CSG FLOAT(0) NULL,
	gFlux_CSG_Sigma FLOAT(0) NULL,
	gTimescale FLOAT(0) NULL,
	gEarliestObsTime DOUBLE NULL,
	gLatestObsTime DOUBLE NULL,
	gSersicN_SG FLOAT(0) NULL,
	gSersicN_SG_Sigma FLOAT(0) NULL,
	gE1_SG FLOAT(0) NULL,
	gE1_SG_Sigma FLOAT(0) NULL,
	gE2_SG FLOAT(0) NULL,
	gE2_SG_Sigma FLOAT(0) NULL,
	gRadius_SG FLOAT(0) NULL,
	gRadius_SG_Sigma FLOAT(0) NULL,
	gFlags INTEGER NULL,
	rNumObs INTEGER NULL,
	rExtendedness FLOAT(0) NULL,
	rVarProb FLOAT(0) NULL,
	rRaOffset_PS FLOAT(0) NULL,
	rRaOffset_PS_Sigma FLOAT(0) NULL,
	rDeclOffset_PS FLOAT(0) NULL,
	rDeclOffset_PS_Sigma FLOAT(0) NULL,
	rRaDeclOffset_PS_Cov FLOAT(0) NULL,
	rRaOffset_SG FLOAT(0) NULL,
	rRaOffset_SG_Sigma FLOAT(0) NULL,
	rDeclOffset_SG FLOAT(0) NULL,
	rDeclOffset_SG_Sigma FLOAT(0) NULL,
	rRaDeclOffset_SG_Cov FLOAT(0) NULL,
	rLnL_PS FLOAT(0) NULL,
	rLnL_SG FLOAT(0) NULL,
	rFlux_PS FLOAT(0) NULL,
	rFlux_PS_Sigma FLOAT(0) NULL,
	rFlux_SG FLOAT(0) NULL,
	rFlux_SG_Sigma FLOAT(0) NULL,
	rFlux_CSG FLOAT(0) NULL,
	rFlux_CSG_Sigma FLOAT(0) NULL,
	rTimescale FLOAT(0) NULL,
	rEarliestObsTime DOUBLE NULL,
	rLatestObsTime DOUBLE NULL,
	rSersicN_SG FLOAT(0) NULL,
	rSersicN_SG_Sigma FLOAT(0) NULL,
	rE1_SG FLOAT(0) NULL,
	rE1_SG_Sigma FLOAT(0) NULL,
	rE2_SG FLOAT(0) NULL,
	rE2_SG_Sigma FLOAT(0) NULL,
	rRadius_SG FLOAT(0) NULL,
	rRadius_SG_Sigma FLOAT(0) NULL,
	rFlags INTEGER NULL,
	iNumObs INTEGER NULL,
	iExtendedness FLOAT(0) NULL,
	iVarProb FLOAT(0) NULL,
	iRaOffset_PS FLOAT(0) NULL,
	iRaOffset_PS_Sigma FLOAT(0) NULL,
	iDeclOffset_PS FLOAT(0) NULL,
	iDeclOffset_PS_Sigma FLOAT(0) NULL,
	iRaDeclOffset_PS_Cov FLOAT(0) NULL,
	iRaOffset_SG FLOAT(0) NULL,
	iRaOffset_SG_Sigma FLOAT(0) NULL,
	iDeclOffset_SG FLOAT(0) NULL,
	iDeclOffset_SG_Sigma FLOAT(0) NULL,
	iRaDeclOffset_SG_Cov FLOAT(0) NULL,
	iLnL_PS FLOAT(0) NULL,
	iLnL_SG FLOAT(0) NULL,
	iFlux_PS FLOAT(0) NULL,
	iFlux_PS_Sigma FLOAT(0) NULL,
	iFlux_SG FLOAT(0) NULL,
	iFlux_SG_Sigma FLOAT(0) NULL,
	iFlux_CSG FLOAT(0) NULL,
	iFlux_CSG_Sigma FLOAT(0) NULL,
	iTimescale FLOAT(0) NULL,
	iEarliestObsTime DOUBLE NULL,
	iLatestObsTime DOUBLE NULL,
	iSersicN_SG FLOAT(0) NULL,
	iSersicN_SG_Sigma FLOAT(0) NULL,
	iE1_SG FLOAT(0) NULL,
	iE1_SG_Sigma FLOAT(0) NULL,
	iE2_SG FLOAT(0) NULL,
	iE2_SG_Sigma FLOAT(0) NULL,
	iRadius_SG FLOAT(0) NULL,
	iRadius_SG_Sigma FLOAT(0) NULL,
	iFlags INTEGER NULL,
	zNumObs INTEGER NULL,
	zExtendedness FLOAT(0) NULL,
	zVarProb FLOAT(0) NULL,
	zRaOffset_PS FLOAT(0) NULL,
	zRaOffset_PS_Sigma FLOAT(0) NULL,
	zDeclOffset_PS FLOAT(0) NULL,
	zDeclOffset_PS_Sigma FLOAT(0) NULL,
	zRaDeclOffset_PS_Cov FLOAT(0) NULL,
	zRaOffset_SG FLOAT(0) NULL,
	zRaOffset_SG_Sigma FLOAT(0) NULL,
	zDeclOffset_SG FLOAT(0) NULL,
	zDeclOffset_SG_Sigma FLOAT(0) NULL,
	zRaDeclOffset_SG_Cov FLOAT(0) NULL,
	zLnL_PS FLOAT(0) NULL,
	zLnL_SG FLOAT(0) NULL,
	zFlux_PS FLOAT(0) NULL,
	zFlux_PS_Sigma FLOAT(0) NULL,
	zFlux_SG FLOAT(0) NULL,
	zFlux_SG_Sigma FLOAT(0) NULL,
	zFlux_CSG FLOAT(0) NULL,
	zFlux_CSG_Sigma FLOAT(0) NULL,
	zTimescale FLOAT(0) NULL,
	zEarliestObsTime DOUBLE NULL,
	zLatestObsTime DOUBLE NULL,
	zSersicN_SG FLOAT(0) NULL,
	zSersicN_SG_Sigma FLOAT(0) NULL,
	zE1_SG FLOAT(0) NULL,
	zE1_SG_Sigma FLOAT(0) NULL,
	zE2_SG FLOAT(0) NULL,
	zE2_SG_Sigma FLOAT(0) NULL,
	zRadius_SG FLOAT(0) NULL,
	zRadius_SG_Sigma FLOAT(0) NULL,
	zFlags INTEGER NULL,
	yNumObs INTEGER NULL,
	yExtendedness FLOAT(0) NULL,
	yVarProb FLOAT(0) NULL,
	yRaOffset_PS FLOAT(0) NULL,
	yRaOffset_PS_Sigma FLOAT(0) NULL,
	yDeclOffset_PS FLOAT(0) NULL,
	yDeclOffset_PS_Sigma FLOAT(0) NULL,
	yRaDeclOffset_PS_Cov FLOAT(0) NULL,
	yRaOffset_SG FLOAT(0) NULL,
	yRaOffset_SG_Sigma FLOAT(0) NULL,
	yDeclOffset_SG FLOAT(0) NULL,
	yDeclOffset_SG_Sigma FLOAT(0) NULL,
	yRaDeclOffset_SG_Cov FLOAT(0) NULL,
	yLnL_PS FLOAT(0) NULL,
	yLnL_SG FLOAT(0) NULL,
	yFlux_PS FLOAT(0) NULL,
	yFlux_PS_Sigma FLOAT(0) NULL,
	yFlux_SG FLOAT(0) NULL,
	yFlux_SG_Sigma FLOAT(0) NULL,
	yFlux_CSG FLOAT(0) NULL,
	yFlux_CSG_Sigma FLOAT(0) NULL,
	yTimescale FLOAT(0) NULL,
	yEarliestObsTime DOUBLE NULL,
	yLatestObsTime DOUBLE NULL,
	ySersicN_SG FLOAT(0) NULL,
	ySersicN_SG_Sigma FLOAT(0) NULL,
	yE1_SG FLOAT(0) NULL,
	yE1_SG_Sigma FLOAT(0) NULL,
	yE2_SG FLOAT(0) NULL,
	yE2_SG_Sigma FLOAT(0) NULL,
	yRadius_SG FLOAT(0) NULL,
	yRadius_SG_Sigma FLOAT(0) NULL,
	yFlags INTEGER NULL,
	_chunkId INTEGER NULL,
	_subChunkId INTEGER NULL,
	PRIMARY KEY (objectId),
	INDEX IDX_Object_decl (decl_PS ASC)
) TYPE=MyISAM;


CREATE TABLE Source
(
	sourceId BIGINT NOT NULL,
	scienceCcdExposureId BIGINT NULL,
	filterId TINYINT NOT NULL,
	objectId BIGINT NULL,
	movingObjectId BIGINT NULL,
	procHistoryId INTEGER NOT NULL,
	ra DOUBLE NOT NULL,
	raErrForDetection FLOAT(0) NULL,
	raErrForWcs FLOAT(0) NOT NULL,
	decl DOUBLE NOT NULL,
	declErrForDetection FLOAT(0) NULL,
	declErrForWcs FLOAT(0) NOT NULL,
	xFlux DOUBLE NULL,
	xFluxErr FLOAT(0) NULL,
	yFlux DOUBLE NULL,
	yFluxErr FLOAT(0) NULL,
	raFlux DOUBLE NULL,
	raFluxErr FLOAT(0) NULL,
	declFlux DOUBLE NULL,
	declFluxErr FLOAT(0) NULL,
	xPeak DOUBLE NULL,
	yPeak DOUBLE NULL,
	raPeak DOUBLE NULL,
	declPeak DOUBLE NULL,
	xAstrom DOUBLE NULL,
	xAstromErr FLOAT(0) NULL,
	yAstrom DOUBLE NULL,
	yAstromErr FLOAT(0) NULL,
	raAstrom DOUBLE NULL,
	raAstromErr FLOAT(0) NULL,
	declAstrom DOUBLE NULL,
	declAstromErr FLOAT(0) NULL,
	raObject DOUBLE NULL,
	declObject DOUBLE NULL,
	taiMidPoint DOUBLE NOT NULL,
	taiRange FLOAT(0) NULL,
	psfFlux DOUBLE NOT NULL,
	psfFluxErr FLOAT(0) NOT NULL,
	apFlux DOUBLE NOT NULL,
	apFluxErr FLOAT(0) NOT NULL,
	modelFlux DOUBLE NOT NULL,
	modelFluxErr FLOAT(0) NOT NULL,
	petroFlux DOUBLE NULL,
	petroFluxErr FLOAT(0) NULL,
	instFlux DOUBLE NOT NULL,
	instFluxErr FLOAT(0) NOT NULL,
	nonGrayCorrFlux DOUBLE NULL,
	nonGrayCorrFluxErr FLOAT(0) NULL,
	atmCorrFlux DOUBLE NULL,
	atmCorrFluxErr FLOAT(0) NULL,
	apDia FLOAT(0) NULL,
	Ixx FLOAT(0) NULL,
	IxxErr FLOAT(0) NULL,
	Iyy FLOAT(0) NULL,
	IyyErr FLOAT(0) NULL,
	Ixy FLOAT(0) NULL,
	IxyErr FLOAT(0) NULL,
	snr FLOAT(0) NOT NULL,
	chi2 FLOAT(0) NOT NULL,
	sky FLOAT(0) NULL,
	skyErr FLOAT(0) NULL,
	extendedness FLOAT(0) NULL,
	flux_PS FLOAT(0) NULL,
	flux_PS_Sigma FLOAT(0) NULL,
	flux_SG FLOAT(0) NULL,
	flux_SG_Sigma FLOAT(0) NULL,
	sersicN_SG FLOAT(0) NULL,
	sersicN_SG_Sigma FLOAT(0) NULL,
	e1_SG FLOAT(0) NULL,
	e1_SG_Sigma FLOAT(0) NULL,
	e2_SG FLOAT(0) NULL,
	e2_SG_Sigma FLOAT(0) NULL,
	radius_SG FLOAT(0) NULL,
	radius_SG_Sigma FLOAT(0) NULL,
	flux_flux_SG_Cov FLOAT(0) NULL,
	flux_e1_SG_Cov FLOAT(0) NULL,
	flux_e2_SG_Cov FLOAT(0) NULL,
	flux_radius_SG_Cov FLOAT(0) NULL,
	flux_sersicN_SG_Cov FLOAT(0) NULL,
	e1_e1_SG_Cov FLOAT(0) NULL,
	e1_e2_SG_Cov FLOAT(0) NULL,
	e1_radius_SG_Cov FLOAT(0) NULL,
	e1_sersicN_SG_Cov FLOAT(0) NULL,
	e2_e2_SG_Cov FLOAT(0) NULL,
	e2_radius_SG_Cov FLOAT(0) NULL,
	e2_sersicN_SG_Cov FLOAT(0) NULL,
	radius_radius_SG_Cov FLOAT(0) NULL,
	radius_sersicN_SG_Cov FLOAT(0) NULL,
	sersicN_sersicN_SG_Cov FLOAT(0) NULL,
	flagForAssociation SMALLINT NULL,
	flagForDetection SMALLINT NULL,
	flagForWcs SMALLINT NULL,
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
