
-- LSST Database Schema
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu:8100/trac/wiki/Copyrights>
-- for copyright information.


CREATE TABLE AAA_Version_DC2_2_0 (version CHAR);

CREATE TABLE Science_CCD_Exposure
(
	scienceCCDExposureId BIGINT NOT NULL,
	scienceFPAExposureId BIGINT NOT NULL,
	rawCCDExposureId BIGINT NOT NULL,
	ccdDetectorId INTEGER NULL,
	filterId INTEGER NULL,
	equinox FLOAT(0) NULL,
	url VARCHAR(255) NOT NULL,
	ctype1 VARCHAR(20) NOT NULL,
	ctype2 VARCHAR(20) NOT NULL,
	crpix1 FLOAT(0) NOT NULL,
	crpix2 FLOAT(0) NOT NULL,
	crval1 DOUBLE NOT NULL,
	crval2 DOUBLE NOT NULL,
	cd1_1 DOUBLE NOT NULL,
	cd2_1 DOUBLE NOT NULL,
	cd1_2 DOUBLE NOT NULL,
	cd2_2 DOUBLE NOT NULL,
	dateObs TIMESTAMP NOT NULL DEFAULT 0,
	expTime FLOAT(0) NULL,
	photoFlam FLOAT(0) NOT NULL,
	photoZP FLOAT(0) NOT NULL,
	nCombine INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY (scienceCCDExposureId),
	KEY (rawCCDExposureId),
	KEY (scienceFPAExposureId)
) ;


CREATE TABLE DIASource
(
	diaSourceId BIGINT NOT NULL,
	ccdExposureId BIGINT NOT NULL,
	filterId TINYINT NOT NULL,
	objectId BIGINT NULL,
	movingObjectId BIGINT NULL,
	scId INTEGER NOT NULL,
	colc DOUBLE NOT NULL,
	colcErr FLOAT(0) NOT NULL,
	rowc DOUBLE NOT NULL,
	rowcErr FLOAT(0) NOT NULL,
	dcol DOUBLE NOT NULL,
	drow DOUBLE NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	raErr4detection DOUBLE NOT NULL,
	decErr4detection DOUBLE NOT NULL,
	raErr4wcs DOUBLE NULL,
	decErr4wcs DOUBLE NULL,
	cx DOUBLE NOT NULL,
	cy DOUBLE NOT NULL,
	cz DOUBLE NOT NULL,
	taiMidPoint DOUBLE NOT NULL,
	taiRange DOUBLE NOT NULL,
	fwhmA FLOAT(0) NOT NULL,
	fwhmB FLOAT(0) NOT NULL,
	fwhmTheta FLOAT(0) NOT NULL,
	flux DOUBLE NOT NULL,
	fluxErr DOUBLE NOT NULL,
	psfMag DOUBLE NOT NULL,
	psfMagErr DOUBLE NOT NULL,
	apMag DOUBLE NOT NULL,
	apMagErr DOUBLE NOT NULL,
	modelMag DOUBLE NOT NULL,
	modelMagErr DOUBLE NOT NULL,
	apDia FLOAT(0) NULL,
	Ixx FLOAT(0) NULL,
	IxxErr FLOAT(0) NULL,
	Iyy FLOAT(0) NULL,
	IyyErr FLOAT(0) NULL,
	Ixy FLOAT(0) NULL,
	IxyErr FLOAT(0) NULL,
	snr FLOAT(0) NOT NULL,
	chi2 FLOAT(0) NOT NULL,
	flag4association SMALLINT NULL,
	flag4detection SMALLINT NULL,
	flag4wcs SMALLINT NULL,
	_dataSource TINYINT NOT NULL,
	PRIMARY KEY (diaSourceId),
	KEY (ccdExposureId),
	KEY (filterId),
	KEY (movingObjectId),
	KEY (objectId),
	KEY (scId)
) TYPE=MyISAM;


CREATE TABLE Visit
(
	visitId INTEGER NOT NULL,
	exposureId BIGINT NOT NULL,
	KEY (exposureId)
) ;


CREATE TABLE Raw_CCD_Exposure
(
	rawCCDExposureId BIGINT NOT NULL,
	ccdDetectorId INTEGER NOT NULL,
	rawFPAExposureId BIGINT NOT NULL,
	radecSys VARCHAR(20) NULL,
	url VARCHAR(255) NOT NULL,
	ctype1 VARCHAR(20) NOT NULL,
	ctype2 VARCHAR(20) NOT NULL,
	crpix1 FLOAT(0) NOT NULL,
	crpix2 FLOAT(0) NOT NULL,
	crval1 DOUBLE NOT NULL,
	crval2 DOUBLE NOT NULL,
	cd11 DOUBLE NOT NULL,
	cd21 DOUBLE NOT NULL,
	cd12 DOUBLE NOT NULL,
	cd22 DOUBLE NOT NULL,
	taiObs TIMESTAMP NOT NULL DEFAULT 0,
	darkTime FLOAT(0) NULL,
	zd FLOAT(0) NULL,
	PRIMARY KEY (rawCCDExposureId),
	KEY (rawFPAExposureId),
	KEY (ccdDetectorId)
) ;


CREATE TABLE _Science_FPA_Exposure2TemplateImage
(
	scienceFPAExposureId BIGINT NOT NULL,
	templateImageId INTEGER NOT NULL,
	KEY (scienceFPAExposureId),
	KEY (templateImageId),
	KEY (scienceFPAExposureId)
) ;


CREATE TABLE _Raw_FPA_Exposure2Visit
(
	visitId INTEGER NOT NULL,
	exposureId BIGINT NOT NULL,
	KEY (exposureId),
	KEY (exposureId),
	KEY (visitId)
) ;


CREATE TABLE _Object2Type
(
	objectId BIGINT NOT NULL,
	typeId SMALLINT NOT NULL,
	probability TINYINT NULL DEFAULT 100,
	KEY (objectId),
	KEY (typeId)
) ;


CREATE TABLE _MovingObject2Type
(
	movingObjectId BIGINT NOT NULL,
	typeId SMALLINT NOT NULL,
	probability TINYINT NULL DEFAULT 100,
	KEY (movingObjectId),
	KEY (typeId)
) ;


CREATE TABLE Object
(
	objectId BIGINT NOT NULL,
	procHistoryId INTEGER NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	__zoneId_placeholder INTEGER NULL,
	muRA DOUBLE NULL,
	muDecl DOUBLE NULL,
	muRAErr DOUBLE NULL,
	muDecErr DOUBLE NULL,
	parallax FLOAT(0) NULL,
	parallaxErr FLOAT(0) NULL,
	earliestObsTime TIMESTAMP NOT NULL DEFAULT 0,
	latestObsTime TIMESTAMP NOT NULL DEFAULT 0,
	ugColor DOUBLE NULL,
	grColor DOUBLE NULL,
	riColor DOUBLE NULL,
	izColor DOUBLE NULL,
	zyColor DOUBLE NULL,
	cx DOUBLE NULL,
	cxErr DOUBLE NULL,
	cy DOUBLE NULL,
	cyErr DOUBLE NULL,
	cz DOUBLE NULL,
	czErr DOUBLE NULL,
	flag4stage1 INTEGER NULL,
	flag4stage2 INTEGER NULL,
	flag4stage3 INTEGER NULL,
	isProvisional BOOL NULL DEFAULT FALSE,
	uMag DOUBLE NULL,
	uMagErr DOUBLE NULL,
	uErrA DOUBLE NULL,
	uErrB DOUBLE NULL,
	uErrTheta DOUBLE NULL,
	uNumObs INTEGER NULL,
	uVarProb SMALLINT NULL,
	uAmplitude FLOAT(0) NULL,
	uPeriod FLOAT(0) NULL,
	uPetroMag FLOAT(0) NULL,
	uPetroMagErr FLOAT(0) NULL,
	uIxx FLOAT(0) NULL,
	uIxxErr FLOAT(0) NULL,
	uIyy FLOAT(0) NULL,
	uIyyErr FLOAT(0) NULL,
	uIxy FLOAT(0) NULL,
	uIxyErr FLOAT(0) NULL,
	uTimescale DOUBLE NULL,
	gMag DOUBLE NULL,
	gMagErr DOUBLE NULL,
	gErrA DOUBLE NULL,
	gErrB DOUBLE NULL,
	gErrTheta DOUBLE NULL,
	gNumObs INTEGER NULL,
	gVarProb SMALLINT NULL,
	gAmplitude FLOAT(0) NULL,
	gPeriod FLOAT(0) NULL,
	gPetroMag FLOAT(0) NULL,
	gPetroMagErr FLOAT(0) NULL,
	gIxx FLOAT(0) NULL,
	gIxxErr FLOAT(0) NULL,
	gIyy FLOAT(0) NULL,
	gIyyErr FLOAT(0) NULL,
	gIxy FLOAT(0) NULL,
	gIxyErr FLOAT(0) NULL,
	gTimescale DOUBLE NULL,
	rMag DOUBLE NULL,
	rMagErr DOUBLE NULL,
	rErrA DOUBLE NULL,
	rErrB DOUBLE NULL,
	rErrTheta DOUBLE NULL,
	rNumObs INTEGER NULL,
	rVarProb SMALLINT NULL,
	rAmplitude FLOAT(0) NULL,
	rPeriod FLOAT(0) NULL,
	rPetroMag FLOAT(0) NULL,
	rPetroMagErr FLOAT(0) NULL,
	rIxx FLOAT(0) NULL,
	rIxxErr FLOAT(0) NULL,
	rIyy FLOAT(0) NULL,
	rIyyErr FLOAT(0) NULL,
	rIxy FLOAT(0) NULL,
	rIxyErr FLOAT(0) NULL,
	rTimescale DOUBLE NULL,
	iMag DOUBLE NULL,
	iMagErr DOUBLE NULL,
	iErrA DOUBLE NULL,
	iErrB DOUBLE NULL,
	iErrTheta DOUBLE NULL,
	iNumObs INTEGER NULL,
	iVarProb SMALLINT NULL,
	iAmplitude FLOAT(0) NULL,
	iPeriod FLOAT(0) NULL,
	iPetroMag FLOAT(0) NULL,
	iPetroMagErr FLOAT(0) NULL,
	iIxx FLOAT(0) NULL,
	iIxxErr FLOAT(0) NULL,
	iIyy FLOAT(0) NULL,
	iIyyErr FLOAT(0) NULL,
	iIxy FLOAT(0) NULL,
	iIxyErr FLOAT(0) NULL,
	iTimescale DOUBLE NULL,
	zMag DOUBLE NULL,
	zMagErr DOUBLE NULL,
	zErrA DOUBLE NULL,
	zErrB DOUBLE NULL,
	zErrTheta DOUBLE NULL,
	zNumObs INTEGER NULL,
	zVarProb SMALLINT NULL,
	zAmplitude FLOAT(0) NULL,
	zPeriod FLOAT(0) NULL,
	zPetroMag FLOAT(0) NULL,
	zPetroMagErr FLOAT(0) NULL,
	zIxx FLOAT(0) NULL,
	zIxxErr FLOAT(0) NULL,
	zIyy FLOAT(0) NULL,
	zIyyErr FLOAT(0) NULL,
	zIxy FLOAT(0) NULL,
	zIxyErr FLOAT(0) NULL,
	zTimescale DOUBLE NULL,
	yMag DOUBLE NULL,
	yMagErr DOUBLE NULL,
	yErrA DOUBLE NULL,
	yErrB DOUBLE NULL,
	yErrTheta DOUBLE NULL,
	yNumObs INTEGER NULL,
	yVarProb SMALLINT NULL,
	yAmplitude FLOAT(0) NULL,
	yPeriod FLOAT(0) NULL,
	yPetroMag FLOAT(0) NULL,
	yPetroMagErr FLOAT(0) NULL,
	yIxx FLOAT(0) NULL,
	yIxxErr FLOAT(0) NULL,
	yIyy FLOAT(0) NULL,
	yIyyErr FLOAT(0) NULL,
	yIxy FLOAT(0) NULL,
	yIxyErr FLOAT(0) NULL,
	yTimescale DOUBLE NULL,
	uScalegram01 FLOAT(0) NULL,
	uScalegram02 FLOAT(0) NULL,
	uScalegram03 FLOAT(0) NULL,
	uScalegram04 FLOAT(0) NULL,
	uScalegram05 FLOAT(0) NULL,
	uScalegram06 FLOAT(0) NULL,
	uScalegram07 FLOAT(0) NULL,
	uScalegram08 FLOAT(0) NULL,
	uScalegram09 FLOAT(0) NULL,
	uScalegram10 FLOAT(0) NULL,
	uScalegram11 FLOAT(0) NULL,
	uScalegram12 FLOAT(0) NULL,
	uScalegram13 FLOAT(0) NULL,
	uScalegram14 FLOAT(0) NULL,
	uScalegram15 FLOAT(0) NULL,
	uScalegram16 FLOAT(0) NULL,
	uScalegram17 FLOAT(0) NULL,
	uScalegram18 FLOAT(0) NULL,
	uScalegram19 FLOAT(0) NULL,
	uScalegram20 FLOAT(0) NULL,
	uScalegram21 FLOAT(0) NULL,
	uScalegram22 FLOAT(0) NULL,
	uScalegram23 FLOAT(0) NULL,
	uScalegram24 FLOAT(0) NULL,
	uScalegram25 FLOAT(0) NULL,
	gScalegram01 FLOAT(0) NULL,
	gScalegram02 FLOAT(0) NULL,
	gScalegram03 FLOAT(0) NULL,
	gScalegram04 FLOAT(0) NULL,
	gScalegram05 FLOAT(0) NULL,
	gScalegram06 FLOAT(0) NULL,
	gScalegram07 FLOAT(0) NULL,
	gScalegram08 FLOAT(0) NULL,
	gScalegram09 FLOAT(0) NULL,
	gScalegram10 FLOAT(0) NULL,
	gScalegram11 FLOAT(0) NULL,
	gScalegram12 FLOAT(0) NULL,
	gScalegram13 FLOAT(0) NULL,
	gScalegram14 FLOAT(0) NULL,
	gScalegram15 FLOAT(0) NULL,
	gScalegram16 FLOAT(0) NULL,
	gScalegram17 FLOAT(0) NULL,
	gScalegram18 FLOAT(0) NULL,
	gScalegram19 FLOAT(0) NULL,
	gScalegram20 FLOAT(0) NULL,
	gScalegram21 FLOAT(0) NULL,
	gScalegram22 FLOAT(0) NULL,
	gScalegram23 FLOAT(0) NULL,
	gScalegram24 FLOAT(0) NULL,
	gScalegram25 FLOAT(0) NULL,
	rScalegram01 FLOAT(0) NULL,
	rScalegram02 FLOAT(0) NULL,
	rScalegram03 FLOAT(0) NULL,
	rScalegram04 FLOAT(0) NULL,
	rScalegram05 FLOAT(0) NULL,
	rScalegram06 FLOAT(0) NULL,
	rScalegram07 FLOAT(0) NULL,
	rScalegram08 FLOAT(0) NULL,
	rScalegram09 FLOAT(0) NULL,
	rScalegram10 FLOAT(0) NULL,
	rScalegram11 FLOAT(0) NULL,
	rScalegram12 FLOAT(0) NULL,
	rScalegram13 FLOAT(0) NULL,
	rScalegram14 FLOAT(0) NULL,
	rScalegram15 FLOAT(0) NULL,
	rScalegram16 FLOAT(0) NULL,
	rScalegram17 FLOAT(0) NULL,
	rScalegram18 FLOAT(0) NULL,
	rScalegram19 FLOAT(0) NULL,
	rScalegram20 FLOAT(0) NULL,
	rScalegram21 FLOAT(0) NULL,
	rScalegram22 FLOAT(0) NULL,
	rScalegram23 FLOAT(0) NULL,
	rScalegram24 FLOAT(0) NULL,
	rScalegram25 FLOAT(0) NULL,
	iScalegram01 FLOAT(0) NULL,
	iScalegram02 FLOAT(0) NULL,
	iScalegram03 FLOAT(0) NULL,
	iScalegram04 FLOAT(0) NULL,
	iScalegram05 FLOAT(0) NULL,
	iScalegram06 FLOAT(0) NULL,
	iScalegram07 FLOAT(0) NULL,
	iScalegram08 FLOAT(0) NULL,
	iScalegram09 FLOAT(0) NULL,
	iScalegram10 FLOAT(0) NULL,
	iScalegram11 FLOAT(0) NULL,
	iScalegram12 FLOAT(0) NULL,
	iScalegram13 FLOAT(0) NULL,
	iScalegram14 FLOAT(0) NULL,
	iScalegram15 FLOAT(0) NULL,
	iScalegram16 FLOAT(0) NULL,
	iScalegram17 FLOAT(0) NULL,
	iScalegram18 FLOAT(0) NULL,
	iScalegram19 FLOAT(0) NULL,
	iScalegram20 FLOAT(0) NULL,
	iScalegram21 FLOAT(0) NULL,
	iScalegram22 FLOAT(0) NULL,
	iScalegram23 FLOAT(0) NULL,
	iScalegram24 FLOAT(0) NULL,
	iScalegram25 FLOAT(0) NULL,
	zScalegram01 FLOAT(0) NULL,
	zScalegram02 FLOAT(0) NULL,
	zScalegram03 FLOAT(0) NULL,
	zScalegram04 FLOAT(0) NULL,
	zScalegram05 FLOAT(0) NULL,
	zScalegram06 FLOAT(0) NULL,
	zScalegram07 FLOAT(0) NULL,
	zScalegram08 FLOAT(0) NULL,
	zScalegram09 FLOAT(0) NULL,
	zScalegram10 FLOAT(0) NULL,
	zScalegram11 FLOAT(0) NULL,
	zScalegram12 FLOAT(0) NULL,
	zScalegram13 FLOAT(0) NULL,
	zScalegram14 FLOAT(0) NULL,
	zScalegram15 FLOAT(0) NULL,
	zScalegram16 FLOAT(0) NULL,
	zScalegram17 FLOAT(0) NULL,
	zScalegram18 FLOAT(0) NULL,
	zScalegram19 FLOAT(0) NULL,
	zScalegram20 FLOAT(0) NULL,
	zScalegram21 FLOAT(0) NULL,
	zScalegram22 FLOAT(0) NULL,
	zScalegram23 FLOAT(0) NULL,
	zScalegram24 FLOAT(0) NULL,
	zScalegram25 FLOAT(0) NULL,
	yScalegram01 FLOAT(0) NULL,
	yScalegram02 FLOAT(0) NULL,
	yScalegram03 FLOAT(0) NULL,
	yScalegram04 FLOAT(0) NULL,
	yScalegram05 FLOAT(0) NULL,
	yScalegram06 FLOAT(0) NULL,
	yScalegram07 FLOAT(0) NULL,
	yScalegram08 FLOAT(0) NULL,
	yScalegram09 FLOAT(0) NULL,
	yScalegram10 FLOAT(0) NULL,
	yScalegram11 FLOAT(0) NULL,
	yScalegram12 FLOAT(0) NULL,
	yScalegram13 FLOAT(0) NULL,
	yScalegram14 FLOAT(0) NULL,
	yScalegram15 FLOAT(0) NULL,
	yScalegram16 FLOAT(0) NULL,
	yScalegram17 FLOAT(0) NULL,
	yScalegram18 FLOAT(0) NULL,
	yScalegram19 FLOAT(0) NULL,
	yScalegram20 FLOAT(0) NULL,
	yScalegram21 FLOAT(0) NULL,
	yScalegram22 FLOAT(0) NULL,
	yScalegram23 FLOAT(0) NULL,
	yScalegram24 FLOAT(0) NULL,
	yScalegram25 FLOAT(0) NULL,
	redshift FLOAT(0) NULL,
	redshiftErr FLOAT(0) NULL,
	probability TINYINT NULL,
	photoZ1 FLOAT(0) NULL,
	photoZ1Err FLOAT(0) NULL,
	photoZ2 FLOAT(0) NULL,
	photoZ2Err FLOAT(0) NULL,
	photoZ1Outlier FLOAT(0) NULL,
	photoZ2Outlier FLOAT(0) NULL,
	uApMag DOUBLE NULL,
	uApMagErr DOUBLE NULL,
	uIsoAreaImage DOUBLE NULL,
	uMuMax DOUBLE NULL,
	uFluxRadius DOUBLE NULL,
	gApMag DOUBLE NULL,
	gApMagErr DOUBLE NULL,
	gIsoAreaImage DOUBLE NULL,
	gMuMax DOUBLE NULL,
	gFluxRadius DOUBLE NULL,
	rApMag DOUBLE NULL,
	rApMagErr DOUBLE NULL,
	rIsoAreaImage DOUBLE NULL,
	rMuMax DOUBLE NULL,
	rFluxRadius DOUBLE NULL,
	iApMag DOUBLE NULL,
	iApMagErr DOUBLE NULL,
	iIsoAreaImage DOUBLE NULL,
	iMuMax DOUBLE NULL,
	iFluxRadius DOUBLE NULL,
	zApMag DOUBLE NULL,
	zApMagErr DOUBLE NULL,
	zIsoAreaImage DOUBLE NULL,
	zMuMax DOUBLE NULL,
	zFluxRadius DOUBLE NULL,
	yApMag DOUBLE NULL,
	yApMagErr DOUBLE NULL,
	yIsoAreaImage DOUBLE NULL,
	yMuMax DOUBLE NULL,
	yFluxRadius DOUBLE NULL,
	uFlags INTEGER NULL,
	gFlags INTEGER NULL,
	rFlags INTEGER NULL,
	iFlags INTEGER NULL,
	zFlags INTEGER NULL,
	yFlags INTEGER NULL,
	PRIMARY KEY (objectId),
	INDEX idx_Object_ugColor (ugColor ASC),
	INDEX idx_Object_grColor (grColor ASC),
	INDEX idx_Object_riColor (riColor ASC),
	INDEX idx_Object_izColor (izColor ASC),
	INDEX idx_Object_zyColor (zyColor ASC),
	INDEX idx_Object_latestObsTime (latestObsTime ASC),
	KEY (procHistoryId)
) TYPE=MyISAM;


CREATE TABLE MovingObject
(
	movingObjectId BIGINT NOT NULL,
	procHistoryId INTEGER NULL,
	a FLOAT(0) NULL,
	incl FLOAT(0) NULL,
	e FLOAT(0) NULL,
	periTAI FLOAT(0) NULL,
	periDist FLOAT(0) NULL,
	omega FLOAT(0) NULL,
	node FLOAT(0) NULL,
	meanAnom FLOAT(0) NULL,
	qual FLOAT(0) NULL,
	uMag DOUBLE NULL,
	uMagErr DOUBLE NULL,
	uAmplitude FLOAT(0) NULL,
	uPeriod FLOAT(0) NULL,
	gMag DOUBLE NULL,
	gMagErr DOUBLE NULL,
	gAmplitude FLOAT(0) NULL,
	gPeriod FLOAT(0) NULL,
	rMag DOUBLE NULL,
	rMagErr DOUBLE NULL,
	rAmplitude FLOAT(0) NULL,
	rPeriod FLOAT(0) NULL,
	iMag DOUBLE NULL,
	iMagErr DOUBLE NULL,
	iAmplitude FLOAT(0) NULL,
	iPeriod FLOAT(0) NULL,
	zMag DOUBLE NULL,
	zMagErr DOUBLE NULL,
	zAmplitude FLOAT(0) NULL,
	zPeriod FLOAT(0) NULL,
	yMag DOUBLE NULL,
	yMagErr DOUBLE NULL,
	yAmplitude FLOAT(0) NULL,
	yPeriod FLOAT(0) NULL,
	flag INTEGER NULL,
	PRIMARY KEY (movingObjectId),
	KEY (procHistoryId)
) ;


CREATE TABLE MatchPair
(
	first BIGINT NOT NULL,
	second BIGINT NOT NULL,
	distance DOUBLE NOT NULL
) ;


CREATE TABLE IdPair
(
	first BIGINT NOT NULL,
	second BIGINT NOT NULL
) ;


CREATE TABLE Id
(
	id BIGINT NOT NULL
) ;


CREATE TABLE Science_FPA_Exposure
(
	scienceFPAExposureId BIGINT NOT NULL,
	PRIMARY KEY (scienceFPAExposureId)
) ;


CREATE TABLE Raw_FPA_Exposure
(
	rawFPAExposureId BIGINT NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	filterId INTEGER NOT NULL,
	equinox FLOAT(0) NOT NULL,
	dateObs TIMESTAMP NOT NULL DEFAULT 0,
	mjdObs DOUBLE NULL,
	expTime FLOAT(0) NOT NULL,
	airmass FLOAT(0) NULL,
	PRIMARY KEY (rawFPAExposureId)
) ;


CREATE TABLE _Science_FPA_Exposure_Group
(
	cseGroupId MEDIUMINT NOT NULL,
	darkTime TIMESTAMP NOT NULL DEFAULT 0,
	biasTime TIMESTAMP NOT NULL DEFAULT 0,
	u_fringeTime TIMESTAMP NOT NULL DEFAULT 0,
	g_fringeTime TIMESTAMP NOT NULL DEFAULT 0,
	r_fringeTime TIMESTAMP NOT NULL DEFAULT 0,
	i_fringeTime TIMESTAMP NOT NULL DEFAULT 0,
	z_fringeTime TIMESTAMP NOT NULL DEFAULT 0,
	y_fringeTime TIMESTAMP NOT NULL DEFAULT 0,
	u_flatTime TIMESTAMP NOT NULL DEFAULT 0,
	g_FlatTime TIMESTAMP NOT NULL DEFAULT 0,
	r_flatTime TIMESTAMP NOT NULL DEFAULT 0,
	i_flatTime TIMESTAMP NOT NULL DEFAULT 0,
	z_flatTime TIMESTAMP NOT NULL DEFAULT 0,
	y_flatTime TIMESTAMP NOT NULL DEFAULT 0,
	cmBiasExposureId INTEGER NULL,
	cmDarkExposureId INTEGER NULL,
	u_cmFlatExposureId INTEGER NULL,
	g_cmFlatExposureId INTEGER NULL,
	r_cmFlatExposureId INTEGER NULL,
	i_cmFlatExposureId INTEGER NULL,
	z_cmFlatExposureId INTEGER NULL,
	y_cmFlatExposureId INTEGER NULL,
	u_cmFringeExposureId INTEGER NULL,
	g_cmFringeExposureId INTEGER NULL,
	r_cmFringeExposureId INTEGER NULL,
	i_cmFringeExposureId INTEGER NULL,
	z_cmFringeExposureId INTEGER NULL,
	y_cmFringeExposureId INTEGER NULL,
	PRIMARY KEY (cseGroupId),
	KEY (cmBiasExposureId),
	KEY (cmDarkExposureId),
	KEY (u_cmFlatExposureId)
) ;


CREATE TABLE ObjectType
(
	typeId SMALLINT NOT NULL,
	description VARCHAR(255) NULL,
	PRIMARY KEY (typeId)
) ;


CREATE TABLE Filter
(
	filterId INTEGER NOT NULL,
	filtURL VARCHAR(255) NULL,
	filtName VARCHAR(255) NOT NULL,
	photClam FLOAT(0) NOT NULL,
	photBW FLOAT(0) NOT NULL,
	PRIMARY KEY (filterId)
) ;


CREATE TABLE DIASourceIDTonight
(
	DIASourceId BIGINT NOT NULL
) ;


CREATE TABLE CCD_Detector
(
	ccdDetectorId INTEGER NOT NULL DEFAULT 1,
	biasSec VARCHAR(20) NOT NULL DEFAULT '[0:0,0:0]',
	trimSec VARCHAR(20) NOT NULL DEFAULT '[0:0,0:0]',
	gain FLOAT(0) NULL,
	rdNoise FLOAT(0) NULL,
	saturate FLOAT(0) NULL,
	PRIMARY KEY (ccdDetectorId)
) ;


CREATE TABLE mops_pred
(
	orbit_id BIGINT NOT NULL,
	ra_deg DOUBLE NOT NULL,
	dec_deg DOUBLE NOT NULL,
	mjd DOUBLE NOT NULL,
	smia DOUBLE NOT NULL,
	smaa DOUBLE NOT NULL,
	pa DOUBLE NOT NULL,
	mag DOUBLE NOT NULL,
	magErr FLOAT(0) NOT NULL
) TYPE=MyISAM;


CREATE TABLE mops_orbits
(
	orbit_id BIGINT NOT NULL AUTO_INCREMENT,
	q DOUBLE NOT NULL DEFAULT 0,
	e DOUBLE NOT NULL DEFAULT 0,
	i DOUBLE NOT NULL DEFAULT 0,
	node DOUBLE NOT NULL DEFAULT 0,
	arg_peri DOUBLE NOT NULL DEFAULT 0,
	time_peri DOUBLE NOT NULL DEFAULT 0,
	epoch DOUBLE NOT NULL DEFAULT 0,
	h_v DOUBLE NOT NULL DEFAULT 0,
	residual DOUBLE NOT NULL DEFAULT 0,
	chi_squared DOUBLE NULL,
	cov_01 DOUBLE NULL,
	cov_02 DOUBLE NULL,
	cov_03 DOUBLE NULL,
	cov_04 DOUBLE NULL,
	cov_05 DOUBLE NULL,
	cov_06 DOUBLE NULL,
	cov_07 DOUBLE NULL,
	cov_08 DOUBLE NULL,
	cov_09 DOUBLE NULL,
	cov_10 DOUBLE NULL,
	cov_11 DOUBLE NULL,
	cov_12 DOUBLE NULL,
	cov_13 DOUBLE NULL,
	cov_14 DOUBLE NULL,
	cov_15 DOUBLE NULL,
	cov_16 DOUBLE NULL,
	cov_17 DOUBLE NULL,
	cov_18 DOUBLE NULL,
	cov_19 DOUBLE NULL,
	cov_20 DOUBLE NULL,
	cov_21 DOUBLE NULL,
	conv_code VARCHAR(8) NULL,
	o_minus_c DOUBLE NULL,
	moid_1 DOUBLE NULL,
	moid_long_1 DOUBLE NULL,
	moid_2 DOUBLE NULL,
	moid_long_2 DOUBLE NULL,
	PRIMARY KEY (orbit_id),
	UNIQUE (orbit_id)
) TYPE=InnoDB;


CREATE TABLE mops_ephem
(
	orbit_id BIGINT NOT NULL,
	ra_deg DOUBLE NOT NULL,
	dec_deg DOUBLE NOT NULL,
	mjd DOUBLE NOT NULL,
	smia DOUBLE NULL,
	smaa DOUBLE NULL,
	pa DOUBLE NULL,
	mag DOUBLE NULL,
	INDEX orbit_id_index (orbit_id ASC)
) TYPE=MyISAM;





ALTER TABLE Science_CCD_Exposure ADD CONSTRAINT FK_Science_CCD_Exposure_Raw_CCD_Exposure 
	FOREIGN KEY (rawCCDExposureId) REFERENCES Raw_CCD_Exposure (rawCCDExposureId);

ALTER TABLE Science_CCD_Exposure ADD CONSTRAINT FK_Science_CCD_Exposure_Science_FPA_Exposure 
	FOREIGN KEY (scienceFPAExposureId) REFERENCES Science_FPA_Exposure (scienceFPAExposureId);

ALTER TABLE Visit ADD CONSTRAINT FK_Visit_Raw_FPA_Exposure 
	FOREIGN KEY (exposureId) REFERENCES Raw_FPA_Exposure (rawFPAExposureId);

ALTER TABLE Raw_CCD_Exposure ADD CONSTRAINT FK_Raw_CCD_Exposure_Raw_FPA_Exposure 
	FOREIGN KEY (rawFPAExposureId) REFERENCES Raw_FPA_Exposure (rawFPAExposureId);

ALTER TABLE _Science_FPA_Exposure2TemplateImage ADD CONSTRAINT FK__Science_FPA_Exposure2TemplateImage_Science_FPA_Exposure 
	FOREIGN KEY (scienceFPAExposureId) REFERENCES Science_FPA_Exposure (scienceFPAExposureId);

ALTER TABLE _Raw_FPA_Exposure2Visit ADD CONSTRAINT FK__Raw_FPA_Exposure2Visit_Raw_FPA_Exposure 
	FOREIGN KEY (exposureId) REFERENCES Raw_FPA_Exposure (rawFPAExposureId);

ALTER TABLE _Object2Type ADD CONSTRAINT FK_Object2Type_Object 
	FOREIGN KEY (objectId) REFERENCES Object (latestObsTime);

ALTER TABLE _Object2Type ADD CONSTRAINT FK_Object2Type_ObjectType 
	FOREIGN KEY (typeId) REFERENCES ObjectType (typeId);

ALTER TABLE _MovingObject2Type ADD CONSTRAINT FK_MovingObject2Type_MovingObject 
	FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE _MovingObject2Type ADD CONSTRAINT FK_MovingObject2Type_ObjectType 
	FOREIGN KEY (typeId) REFERENCES ObjectType (typeId);
