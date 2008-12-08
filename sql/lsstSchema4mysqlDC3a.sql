
-- LSST Database Schema
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu:8100/trac/wiki/Copyrights>
-- for copyright information.


CREATE TABLE AAA_Version_DC3a_3_0_0 (version CHAR);

CREATE TABLE mops_Event_OrbitIdentification
(
	eventId BIGINT NOT NULL,
	childObjectId BIGINT NOT NULL,
	PRIMARY KEY (eventId),
	INDEX idx_mopsEventOrbitIdentification2MovingObject_childObjectId (childObjectId ASC),
	KEY (eventId)
) ;


CREATE TABLE _mops_MoidQueue
(
	movingObjectId BIGINT NOT NULL,
	movingObjectVersion INT NOT NULL,
	eventId BIGINT NOT NULL,
	insertTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (movingObjectId, movingObjectVersion),
	KEY (movingObjectId),
	INDEX idx_mopsMoidQueue_eventId (eventId ASC)
) ;


CREATE TABLE _mops_EonQueue
(
	movingObjectId BIGINT NOT NULL,
	eventId BIGINT NOT NULL,
	insertTime TIMESTAMP NOT NULL,
	status CHAR(1) NULL DEFAULT 'I',
	PRIMARY KEY (movingObjectId),
	KEY (movingObjectId),
	INDEX idx__mopsEonQueue_eventId (eventId ASC)
) ;


CREATE TABLE mops_Tracklets2DIASource
(
	trackletId BIGINT NOT NULL,
	diaSourceId BIGINT NOT NULL,
	PRIMARY KEY (trackletId, diaSourceId),
	INDEX idx_mopsTracklets2DIASource_diaSourceId (diaSourceId ASC),
	KEY (trackletId)
) ;


CREATE TABLE mops_MovingObject2Tracklet
(
	movingObjectId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	INDEX idx_mopsMovingObject2Tracklets_movingObjectId (movingObjectId ASC),
	INDEX idx_mopsMovingObject2Tracklets_trackletId (trackletId ASC)
) ;


CREATE TABLE mops_Event_TrackletRemoval
(
	eventId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	PRIMARY KEY (eventId),
	INDEX idx_mopsEventTrackletRemoval_trackletId (trackletId ASC),
	KEY (eventId)
) ;


CREATE TABLE mops_Event_TrackletPrecovery
(
	eventId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	ephemerisDistance FLOAT(0) NOT NULL,
	ephemerisUncertainty FLOAT(0) NULL,
	PRIMARY KEY (eventId),
	INDEX idx_mopsEventTrackletPrecovery_trackletId (trackletId ASC),
	KEY (eventId)
) ;


CREATE TABLE mops_Event_TrackletAttribution
(
	eventId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	ephemerisDistance FLOAT(0) NOT NULL,
	ephemerisUncertainty FLOAT(0) NULL,
	PRIMARY KEY (eventId),
	INDEX idx_mopsEventTrackletAttribution_trackletId (trackletId ASC),
	KEY (eventId)
) ;


CREATE TABLE mops_Event_OrbitDerivation
(
	eventId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	PRIMARY KEY (eventId, trackletId),
	INDEX idx_mopsEventDerivation_trackletId (trackletId ASC),
	KEY (eventId)
) ;


CREATE TABLE mops_Event
(
	eventId BIGINT NOT NULL AUTO_INCREMENT,
	procHistoryId INT NOT NULL,
	eventType CHAR(1) NOT NULL,
	eventTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	movingObjectId BIGINT NULL,
	movingObjectVersion INT NULL,
	orbitCode CHAR(1) NULL,
	d3 FLOAT(0) NULL,
	d4 FLOAT(0) NULL,
	ccdExposureId BIGINT NULL,
	classification CHAR(1) NULL,
	ssmId BIGINT NULL,
	PRIMARY KEY (eventId),
	KEY (movingObjectId),
	INDEX idx_mopsEvent_ccdExposureId (ccdExposureId ASC),
	INDEX idx_mopsEvent_movingObjectId (movingObjectId ASC, movingObjectVersion ASC),
	INDEX idx_mopsEvent_procHistoryId (procHistoryId ASC),
	INDEX idx_mopsEvent_ssmId (ssmId ASC)
) ;


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


CREATE TABLE mops_Tracklet
(
	trackletId BIGINT NOT NULL AUTO_INCREMENT,
	ccdExposureId BIGINT NOT NULL,
	procHistoryId INT NOT NULL,
	ssmId BIGINT NULL,
	velRa DOUBLE NULL,
	velRaErr DOUBLE NULL,
	velDecl DOUBLE NULL,
	velDeclErr DOUBLE NULL,
	velTot DOUBLE NULL,
	accRa DOUBLE NULL,
	accRaErr DOUBLE NULL,
	accDecl DOUBLE NULL,
	accDeclErr DOUBLE NULL,
	extEpoch DOUBLE NULL,
	extRa DOUBLE NULL,
	extRaErr DOUBLE NULL,
	extDecl DOUBLE NULL,
	extDeclErr DOUBLE NULL,
	extMag DOUBLE NULL,
	extMagErr DOUBLE NULL,
	probability DOUBLE NULL,
	status CHAR(1) NULL,
	classification CHAR(1) NULL,
	PRIMARY KEY (trackletId),
	INDEX idx_mopsTracklets_ccdExposureId (ccdExposureId ASC),
	INDEX idx_mopsTracklets_ssmId (ssmId ASC),
	INDEX idx_mopsTracklets_classification (classification ASC),
	INDEX idx_mopsTracklets_extEpoch (extEpoch ASC)
) ;


CREATE TABLE sdqa_Rating_4ScienceFPAExposure
(
	sdqa_ratingId BIGINT NOT NULL,
	sdqa_metricId SMALLINT NOT NULL,
	sdqa_thresholdId SMALLINT NOT NULL,
	exposureId INTEGER NOT NULL,
	metricValue DOUBLE NOT NULL,
	metricErr DOUBLE NOT NULL,
	PRIMARY KEY (sdqa_ratingId),
	KEY (exposureId),
	KEY (sdqa_metricId)
) ;


CREATE TABLE sdqa_Rating_4ScienceCCDExposure
(
	sdqa_ratingId BIGINT NOT NULL,
	sdqa_metricId SMALLINT NOT NULL,
	sdqa_thresholdId SMALLINT NOT NULL,
	ccdExposureId BIGINT NOT NULL,
	metricValue DOUBLE NOT NULL,
	metricErr DOUBLE NOT NULL,
	PRIMARY KEY (sdqa_ratingId),
	KEY (ccdExposureId),
	KEY (sdqa_metricId),
	KEY (sdqa_thresholdId)
) ;


CREATE TABLE sdqa_Rating_4ScienceAmpExposure
(
	sdqa_ratingId BIGINT NOT NULL,
	sdqa_metricId SMALLINT NOT NULL,
	sdqa_thresholdId SMALLINT NOT NULL,
	ampExposureId BIGINT NOT NULL,
	metricValue DOUBLE NOT NULL,
	metricErr DOUBLE NOT NULL,
	PRIMARY KEY (sdqa_ratingId),
	KEY (ampExposureId),
	KEY (sdqa_metricId),
	KEY (sdqa_thresholdId)
) ;


CREATE TABLE DIASource
(
	diaSourceId BIGINT NOT NULL,
	ccdExposureId BIGINT NOT NULL,
	diaSource2Id BIGINT NULL,
	filterId TINYINT NOT NULL,
	objectId BIGINT NULL,
	movingObjectId BIGINT NULL,
	colc DOUBLE NOT NULL,
	colcErr FLOAT(0) NOT NULL,
	rowc DOUBLE NOT NULL,
	rowcErr FLOAT(0) NOT NULL,
	dcol DOUBLE NOT NULL,
	drow DOUBLE NOT NULL,
	ra DOUBLE NOT NULL,
	raErr4detection DOUBLE NOT NULL,
	decErr4detection DOUBLE NOT NULL,
	raErr4wcs DOUBLE NULL,
	decl DOUBLE NOT NULL,
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
	flagClassification BIGINT NULL,
	_dataSource TINYINT NOT NULL,
	snr FLOAT(0) NOT NULL,
	chi2 FLOAT(0) NOT NULL,
	PRIMARY KEY (diaSourceId),
	KEY (movingObjectId),
	KEY (ccdExposureId),
	KEY (filterId),
	KEY (movingObjectId),
	KEY (objectId)
) TYPE=MyISAM;


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


CREATE TABLE mops_SSM
(
	ssmId BIGINT NOT NULL AUTO_INCREMENT,
	ssmDescId SMALLINT NULL,
	q DOUBLE NOT NULL,
	e DOUBLE NOT NULL,
	i DOUBLE NOT NULL,
	node DOUBLE NOT NULL,
	argPeri DOUBLE NOT NULL,
	timePeri DOUBLE NOT NULL,
	epoch DOUBLE NOT NULL,
	h_v DOUBLE NOT NULL,
	h_ss DOUBLE NULL,
	g DOUBLE NULL,
	albedo DOUBLE NULL,
	ssmObjectName VARCHAR(32) NOT NULL,
	PRIMARY KEY (ssmId),
	UNIQUE UQ_mopsSSM_ssmObjectName(ssmObjectName),
	INDEX idx_mopsSSM_ssmDescId (ssmDescId ASC),
	INDEX idx_mopsSSM_epoch (epoch ASC)
) ;


CREATE TABLE sdqa_Threshold
(
	sdqa_thresholdId SMALLINT NOT NULL,
	sdqa_metricId SMALLINT NOT NULL,
	upperThreshold DOUBLE NULL,
	lowerThreshold DOUBLE NULL,
	createdDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (sdqa_thresholdId),
	KEY (sdqa_metricId)
) ;


CREATE TABLE prv_SoftwarePackage
(
	packageId INTEGER NOT NULL,
	packageName VARCHAR(64) NOT NULL,
	PRIMARY KEY (packageId)
) ;


CREATE TABLE prv_PolicyKey
(
	policyKeyId INTEGER NOT NULL,
	policyFileId INTEGER NOT NULL,
	keyName VARCHAR(255) NOT NULL,
	PRIMARY KEY (policyKeyId)
) ;


CREATE TABLE prv_PolicyFile
(
	policyFileId INTEGER NOT NULL,
	pathName VARCHAR(255) NOT NULL,
	hashValue CHAR(32) NOT NULL,
	modifiedDate DATETIME NOT NULL,
	PRIMARY KEY (policyFileId)
) ;


CREATE TABLE prv_cnf_SoftwarePackage
(
	packageId INTEGER NOT NULL,
	version VARCHAR(32) NOT NULL,
	directory VARCHAR(255) NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (packageId)
) ;


CREATE TABLE prv_cnf_PolicyKey
(
	policyKeyId INTEGER NOT NULL,
	value VARCHAR(255) NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (policyKeyId)
) ;


CREATE TABLE Object
(
	objectId BIGINT NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	muRA DOUBLE NULL,
	muRAErr DOUBLE NULL,
	muDecl DOUBLE NULL,
	muDeclErr DOUBLE NULL,
	parallax FLOAT(0) NULL,
	parallaxErr FLOAT(0) NULL,
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
	yTimescale DOUBLE NULL,
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
	INDEX idx_Object_zyColor (zyColor ASC)
) TYPE=MyISAM;


CREATE TABLE MovingObject
(
	movingObjectId BIGINT NOT NULL,
	movingObjectVersion INT NOT NULL DEFAULT '1',
	procHistoryId INTEGER NOT NULL,
	taxonomicTypeId SMALLINT NULL,
	ssmObjectName VARCHAR(32) NULL,
	q DOUBLE NOT NULL,
	e DOUBLE NOT NULL,
	i DOUBLE NOT NULL,
	node DOUBLE NOT NULL,
	meanAnom DOUBLE NOT NULL,
	argPeri DOUBLE NOT NULL,
	distPeri DOUBLE NOT NULL,
	timePeri DOUBLE NOT NULL,
	epoch DOUBLE NOT NULL,
	h_v DOUBLE NOT NULL,
	g DOUBLE NULL,
	rotationPeriod DOUBLE NULL,
	rotationEpoch DOUBLE NULL,
	albedo DOUBLE NULL,
	poleLat DOUBLE NULL,
	poleLon DOUBLE NULL,
	d3 DOUBLE NULL,
	d4 DOUBLE NULL,
	orbFitResidual DOUBLE NOT NULL,
	orbFitChi2 DOUBLE NULL,
	classification CHAR(1) NULL,
	ssmId BIGINT NULL,
	mopsStatus CHAR(1) NULL,
	stablePass CHAR(1) NULL,
	timeCreated TIMESTAMP NULL,
	uMag DOUBLE NOT NULL,
	uMagErr FLOAT(0) NOT NULL,
	uAmplitude FLOAT(0) NULL,
	uPeriod FLOAT(0) NULL,
	gMag DOUBLE NOT NULL,
	gMagErr FLOAT(0) NOT NULL,
	gAmplitude FLOAT(0) NULL,
	gPeriod FLOAT(0) NULL,
	rMag DOUBLE NOT NULL,
	rMagErr FLOAT(0) NOT NULL,
	rAmplitude FLOAT(0) NULL,
	rPeriod FLOAT(0) NULL,
	iMag DOUBLE NOT NULL,
	iMagErr FLOAT(0) NOT NULL,
	iAmplitude FLOAT(0) NULL,
	iPeriod FLOAT(0) NULL,
	zMag DOUBLE NOT NULL,
	zMagErr FLOAT(0) NOT NULL,
	zAmplitude FLOAT(0) NULL,
	zPeriod FLOAT(0) NULL,
	yMag DOUBLE NOT NULL,
	yMagErr FLOAT(0) NOT NULL,
	yAmplitude FLOAT(0) NULL,
	yPeriod FLOAT(0) NULL,
	flag INTEGER NULL,
	src01 DOUBLE NULL,
	src02 DOUBLE NULL,
	src03 DOUBLE NULL,
	src04 DOUBLE NULL,
	src05 DOUBLE NULL,
	src06 DOUBLE NULL,
	src07 DOUBLE NULL,
	src08 DOUBLE NULL,
	src09 DOUBLE NULL,
	src10 DOUBLE NULL,
	src11 DOUBLE NULL,
	src12 DOUBLE NULL,
	src13 DOUBLE NULL,
	src14 DOUBLE NULL,
	src15 DOUBLE NULL,
	src16 DOUBLE NULL,
	src17 DOUBLE NULL,
	src18 DOUBLE NULL,
	src19 DOUBLE NULL,
	src20 DOUBLE NULL,
	src21 DOUBLE NULL,
	convCode VARCHAR(8) NULL,
	o_minus_c DOUBLE NULL,
	moid1 DOUBLE NULL,
	moidLong1 DOUBLE NULL,
	moid2 DOUBLE NULL,
	moidLong2 DOUBLE NULL,
	arcLengthDays DOUBLE NULL,
	PRIMARY KEY (movingObjectId, movingObjectVersion),
	KEY (procHistoryId),
	INDEX idx_MovingObject_taxonomicTypeId (taxonomicTypeId ASC),
	INDEX idx_MovingObject_ssmId (ssmId ASC),
	INDEX idx_MovingObject_ssmObjectName (ssmObjectName ASC),
	INDEX idx_MovingObject_status (mopsStatus ASC)
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


CREATE TABLE _tmpl_MatchPair
(
	first BIGINT NOT NULL,
	second BIGINT NOT NULL,
	distance DOUBLE NOT NULL
) ;


CREATE TABLE _tmpl_IdPair
(
	first BIGINT NOT NULL,
	second BIGINT NOT NULL
) ;


CREATE TABLE _tmpl_Id
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


CREATE TABLE mops_SSMDesc
(
	ssmDescId SMALLINT NOT NULL AUTO_INCREMENT,
	prefix CHAR(4) NULL,
	description VARCHAR(100) NULL,
	PRIMARY KEY (ssmDescId)
) ;


CREATE TABLE _tmpl_mops_Prediction
(
	movingObjectId BIGINT NOT NULL,
	movingObjectVersion INTEGER NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	mjd DOUBLE NOT NULL,
	smia DOUBLE NOT NULL,
	smaa DOUBLE NOT NULL,
	pa DOUBLE NOT NULL,
	mag DOUBLE NOT NULL,
	magErr FLOAT(0) NOT NULL
) TYPE=MyISAM;


CREATE TABLE _tmpl_mops_Ephemeris
(
	movingObjectId BIGINT NOT NULL,
	movingObjectVersion INTEGER NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	mjd DOUBLE NOT NULL,
	smia DOUBLE NULL,
	smaa DOUBLE NULL,
	pa DOUBLE NULL,
	mag DOUBLE NULL,
	INDEX idx_mopsEphemeris_movingObjectId (movingObjectId ASC)
) TYPE=MyISAM;


CREATE TABLE _mops_Config
(
	configId BIGINT NOT NULL AUTO_INCREMENT,
	configText TEXT NULL,
	PRIMARY KEY (configId)
) ;


CREATE TABLE sdqa_Metric
(
	sdqa_metricId SMALLINT NOT NULL,
	metricName VARCHAR(30) NOT NULL,
	physicalUnits VARCHAR(30) NOT NULL,
	dataType CHAR(10) NOT NULL,
	definition VARCHAR(255) NOT NULL,
	PRIMARY KEY (sdqa_metricId)
) ;


CREATE TABLE sdqa_ImageStatus
(
	sdqa_imageStatusId SMALLINT NOT NULL,
	statusName VARCHAR(30) NOT NULL,
	definition VARCHAR(255) NOT NULL,
	PRIMARY KEY (sdqa_imageStatusId)
) ;





ALTER TABLE _mops_MoidQueue ADD CONSTRAINT FK__mops_MoidQueue_MovingObject 
	FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE _mops_EonQueue ADD CONSTRAINT FK__mopsEonQueue_MovingObject 
	FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE mops_Tracklets2DIASource ADD CONSTRAINT FK_mopsTracklets2DIASource_mopsTracklets 
	FOREIGN KEY (trackletId) REFERENCES mops_Tracklet (trackletId);

ALTER TABLE mops_MovingObject2Tracklet ADD CONSTRAINT FK_mopsMovingObject2Tracklets_mopsTracklets 
	FOREIGN KEY (trackletId) REFERENCES mops_Tracklet (trackletId);

ALTER TABLE mops_MovingObject2Tracklet ADD CONSTRAINT FK_mopsMovingObject2Tracklets_MovingObject_movingObjectId 
	FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE mops_Event ADD CONSTRAINT FK_mops_Event_Science_CCD_Exposure 
	FOREIGN KEY (ccdExposureId) REFERENCES Science_CCD_Exposure (scienceCCDExposureId);

ALTER TABLE Science_CCD_Exposure ADD CONSTRAINT FK_Science_CCD_Exposure_Raw_CCD_Exposure 
	FOREIGN KEY (rawCCDExposureId) REFERENCES Raw_CCD_Exposure (rawCCDExposureId);

ALTER TABLE Science_CCD_Exposure ADD CONSTRAINT FK_Science_CCD_Exposure_Science_FPA_Exposure 
	FOREIGN KEY (scienceFPAExposureId) REFERENCES Science_FPA_Exposure (scienceFPAExposureId);

ALTER TABLE mops_Tracklet ADD CONSTRAINT FK_mops_Tracklet_Science_CCD_Exposure 
	FOREIGN KEY (ccdExposureId) REFERENCES Science_CCD_Exposure (scienceCCDExposureId);

ALTER TABLE mops_Tracklet ADD CONSTRAINT FK_mopsTracklets_mopsSSM 
	FOREIGN KEY (ssmId) REFERENCES mops_SSM (ssmId);

ALTER TABLE sdqa_Rating_4ScienceFPAExposure ADD CONSTRAINT FK_sdqa_Rating_4ScienceFPAExposure_sdqa_Metric 
	FOREIGN KEY (sdqa_metricId) REFERENCES sdqa_Metric (sdqa_metricId);

ALTER TABLE sdqa_Rating_4ScienceCCDExposure ADD CONSTRAINT FK_sdqa_Rating_4ScienceCCDExposure_sdqa_Metric 
	FOREIGN KEY (sdqa_metricId) REFERENCES sdqa_Metric (sdqa_metricId);

ALTER TABLE sdqa_Rating_4ScienceCCDExposure ADD CONSTRAINT FK_sdqa_Rating_4ScienceCCDExposure_sdqa_Threshold 
	FOREIGN KEY (sdqa_thresholdId) REFERENCES sdqa_Threshold (sdqa_thresholdId);

ALTER TABLE sdqa_Rating_4ScienceAmpExposure ADD CONSTRAINT FK_sdqa_Rating_4ScienceAmpExposure_sdqa_Metric 
	FOREIGN KEY (sdqa_metricId) REFERENCES sdqa_Metric (sdqa_metricId);

ALTER TABLE sdqa_Rating_4ScienceAmpExposure ADD CONSTRAINT FK_sdqa_Rating_4ScienceAmpExposure_sdqa_Threshold 
	FOREIGN KEY (sdqa_thresholdId) REFERENCES sdqa_Threshold (sdqa_thresholdId);

ALTER TABLE DIASource ADD CONSTRAINT FK_DIASource_MovingObject 
	FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE _Object2Type ADD CONSTRAINT FK_Object2Type_ObjectType 
	FOREIGN KEY (typeId) REFERENCES ObjectType (typeId);

ALTER TABLE _MovingObject2Type ADD CONSTRAINT FK_MovingObject2Type_ObjectType 
	FOREIGN KEY (typeId) REFERENCES ObjectType (typeId);

ALTER TABLE Visit ADD CONSTRAINT FK_Visit_Raw_FPA_Exposure 
	FOREIGN KEY (exposureId) REFERENCES Raw_FPA_Exposure (rawFPAExposureId);

ALTER TABLE Raw_CCD_Exposure ADD CONSTRAINT FK_Raw_CCD_Exposure_Raw_FPA_Exposure 
	FOREIGN KEY (rawFPAExposureId) REFERENCES Raw_FPA_Exposure (rawFPAExposureId);

ALTER TABLE _Science_FPA_Exposure2TemplateImage ADD CONSTRAINT FK__Science_FPA_Exposure2TemplateImage_Science_FPA_Exposure 
	FOREIGN KEY (scienceFPAExposureId) REFERENCES Science_FPA_Exposure (scienceFPAExposureId);

ALTER TABLE _Raw_FPA_Exposure2Visit ADD CONSTRAINT FK__Raw_FPA_Exposure2Visit_Raw_FPA_Exposure 
	FOREIGN KEY (exposureId) REFERENCES Raw_FPA_Exposure (rawFPAExposureId);

ALTER TABLE mops_SSM ADD CONSTRAINT FK_mopsSSM_mopsSSMDesc 
	FOREIGN KEY (ssmDescId) REFERENCES mops_SSMDesc (ssmDescId);

ALTER TABLE sdqa_Threshold ADD CONSTRAINT FK_sdqa_Threshold_sdqa_Metric 
	FOREIGN KEY (sdqa_metricId) REFERENCES sdqa_Metric (sdqa_metricId);
