
-- LSST Database Schema
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu/trac/wiki/Copyrights>
-- for copyright information.


CREATE TABLE AAA_Version_3_1_80 (version CHAR);

SET FOREIGN_KEY_CHECKS=0;



CREATE TABLE prv_cnf_PolicyKey
(
	policyKeyId INTEGER NOT NULL,
	value TEXT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (policyKeyId),
	KEY (policyKeyId)
) ;


CREATE TABLE prv_cnf_SoftwarePackage
(
	packageId INTEGER NOT NULL,
	version VARCHAR(255) NOT NULL,
	directory VARCHAR(255) NOT NULL,
	validityBegin DATETIME NULL,
	validityEnd DATETIME NULL,
	PRIMARY KEY (packageId),
	KEY (packageId)
) ;


CREATE TABLE prv_Filter
(
	filterId TINYINT NOT NULL,
	focalPlaneId TINYINT NOT NULL,
	name VARCHAR(80) NOT NULL,
	url VARCHAR(255) NULL,
	clam FLOAT(0) NOT NULL,
	bw FLOAT(0) NOT NULL,
	PRIMARY KEY (filterId),
	UNIQUE name(name),
	INDEX focalPlaneId (focalPlaneId ASC)
) TYPE=MyISAM;


CREATE TABLE prv_PolicyFile
(
	policyFileId INTEGER NOT NULL,
	pathName VARCHAR(255) NOT NULL,
	hashValue CHAR(32) NOT NULL,
	modifiedDate BIGINT NOT NULL,
	PRIMARY KEY (policyFileId)
) ;


CREATE TABLE prv_PolicyKey
(
	policyKeyId INTEGER NOT NULL,
	policyFileId INTEGER NOT NULL,
	keyName VARCHAR(255) NOT NULL,
	keyType VARCHAR(16) NOT NULL,
	PRIMARY KEY (policyKeyId),
	KEY (policyFileId)
) ;


CREATE TABLE prv_Run
(
	offset INTEGER NOT NULL AUTO_INCREMENT,
	runId VARCHAR(255) NOT NULL,
	hostName VARCHAR(64) NULL,
	processId INTEGER NULL,
	PRIMARY KEY (offset),
	UNIQUE UQ_prv_Run_runId(runId)
) ;


CREATE TABLE prv_SoftwarePackage
(
	packageId INTEGER NOT NULL,
	packageName VARCHAR(64) NOT NULL,
	PRIMARY KEY (packageId)
) ;


CREATE TABLE _MovingObjectToType
(
	movingObjectId BIGINT NOT NULL,
	typeId SMALLINT NOT NULL,
	probability TINYINT NULL DEFAULT 100,
	KEY (typeId),
	KEY (movingObjectId)
) ;


CREATE TABLE _ObjectToType
(
	objectId BIGINT NOT NULL,
	typeId SMALLINT NOT NULL,
	probability TINYINT NULL DEFAULT 100,
	KEY (typeId),
	KEY (objectId)
) ;


CREATE TABLE _qservChunkMap
(
	raMin DOUBLE NOT NULL,
	raMax DOUBLE NOT NULL,
	declMin DOUBLE NOT NULL,
	declMax DOUBLE NOT NULL,
	chunkId INTEGER NOT NULL,
	objCount INTEGER NOT NULL
) ;


CREATE TABLE _qservObjectIdMap
(
	objectId BIGINT NOT NULL,
	chunkId INTEGER NOT NULL,
	subChunkId INTEGER NOT NULL
) ;


CREATE TABLE _qservSubChunkMap
(
	raMin DOUBLE NOT NULL,
	raMax DOUBLE NOT NULL,
	declMin DOUBLE NOT NULL,
	declMax DOUBLE NOT NULL,
	chunkId INTEGER NOT NULL,
	subChunkId INTEGER NOT NULL,
	objCount INTEGER NOT NULL
) ;


CREATE TABLE _tmpl_Id
(
	id BIGINT NOT NULL
) ;


CREATE TABLE _tmpl_IdPair
(
	first BIGINT NOT NULL,
	second BIGINT NOT NULL
) ;


CREATE TABLE _tmpl_MatchPair
(
	first BIGINT NOT NULL,
	second BIGINT NOT NULL,
	distance DOUBLE NOT NULL
) ;


CREATE TABLE Ccd_Detector
(
	ccdDetectorId INTEGER NOT NULL DEFAULT 1,
	biasSec VARCHAR(20) NOT NULL DEFAULT '[0:0,0:0]',
	trimSec VARCHAR(20) NOT NULL DEFAULT '[0:0,0:0]',
	gain FLOAT(0) NULL,
	rdNoise FLOAT(0) NULL,
	saturate FLOAT(0) NULL,
	PRIMARY KEY (ccdDetectorId)
) ;


CREATE TABLE Filter
(
	filterId TINYINT NOT NULL,
	filterName CHAR(255) NOT NULL,
	photClam FLOAT(0) NOT NULL,
	photBW FLOAT(0) NOT NULL,
	PRIMARY KEY (filterId)
) ;


CREATE TABLE ObjectType
(
	typeId SMALLINT NOT NULL,
	description VARCHAR(255) NULL,
	PRIMARY KEY (typeId)
) ;


CREATE TABLE sdqa_ImageStatus
(
	sdqa_imageStatusId SMALLINT NOT NULL AUTO_INCREMENT,
	statusName VARCHAR(30) NOT NULL,
	definition VARCHAR(255) NOT NULL,
	PRIMARY KEY (sdqa_imageStatusId)
) ;


CREATE TABLE sdqa_Metric
(
	sdqa_metricId SMALLINT NOT NULL AUTO_INCREMENT,
	metricName VARCHAR(30) NOT NULL,
	physicalUnits VARCHAR(30) NOT NULL,
	dataType CHAR(1) NOT NULL,
	definition VARCHAR(255) NOT NULL,
	PRIMARY KEY (sdqa_metricId),
	UNIQUE UQ_sdqaMetric_metricName(metricName)
) ;


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
) ;


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
) ;


CREATE TABLE sdqa_Rating_ForScienceFpaExposure
(
	sdqa_ratingId BIGINT NOT NULL AUTO_INCREMENT,
	sdqa_metricId SMALLINT NOT NULL,
	sdqa_thresholdId SMALLINT NOT NULL,
	exposureId INTEGER NOT NULL,
	metricValue DOUBLE NOT NULL,
	metricSigma DOUBLE NOT NULL,
	PRIMARY KEY (sdqa_ratingId),
	UNIQUE UQ_sdqaRating_ForScienceFpaExposure_metricId_exposureId(sdqa_metricId, exposureId),
	KEY (exposureId),
	KEY (sdqa_metricId),
	KEY (sdqa_thresholdId)
) ;


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
) ;


CREATE TABLE _mops_Config
(
	configId BIGINT NOT NULL AUTO_INCREMENT,
	configText TEXT NULL,
	PRIMARY KEY (configId)
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


CREATE TABLE mops_Event_OrbitDerivation
(
	eventId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	PRIMARY KEY (eventId, trackletId),
	INDEX idx_mopsEventDerivation_trackletId (trackletId ASC),
	KEY (eventId)
) ;


CREATE TABLE mops_Event_OrbitIdentification
(
	eventId BIGINT NOT NULL,
	childObjectId BIGINT NOT NULL,
	PRIMARY KEY (eventId),
	INDEX idx_mopsEventOrbitIdentification2MovingObject_childObjectId (childObjectId ASC),
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


CREATE TABLE mops_Event_TrackletRemoval
(
	eventId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	PRIMARY KEY (eventId),
	INDEX idx_mopsEventTrackletRemoval_trackletId (trackletId ASC),
	KEY (eventId)
) ;


CREATE TABLE mops_MovingObjectToTracklet
(
	movingObjectId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	INDEX idx_mopsMovingObjectToTracklets_movingObjectId (movingObjectId ASC),
	INDEX idx_mopsMovingObjectToTracklets_trackletId (trackletId ASC)
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


CREATE TABLE mops_SSMDesc
(
	ssmDescId SMALLINT NOT NULL AUTO_INCREMENT,
	prefix CHAR(4) NULL,
	description VARCHAR(100) NULL,
	PRIMARY KEY (ssmDescId)
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


CREATE TABLE mops_TrackletToDiaSource
(
	trackletId BIGINT NOT NULL,
	diaSourceId BIGINT NOT NULL,
	PRIMARY KEY (trackletId, diaSourceId),
	INDEX idx_mopsTrackletsToDIASource_diaSourceId (diaSourceId ASC),
	KEY (trackletId)
) ;


CREATE TABLE mops_TrackToTracklet
(
	trackId BIGINT NOT NULL,
	trackletId BIGINT NOT NULL,
	PRIMARY KEY (trackId, trackletId),
	INDEX IDX_mopsTrackToTracklet_trackletId (trackletId ASC)
) ;


CREATE TABLE _Raw_Ccd_ExposureToVisit
(
	visitId INTEGER NOT NULL,
	ccdExposureId BIGINT NOT NULL,
	KEY (ccdExposureId),
	KEY (visitId)
) ;


CREATE TABLE Raw_Amp_Exposure
(
	rawAmpExposureId BIGINT NOT NULL,
	rawCcdExposureId BIGINT NOT NULL,
	ampId INTEGER NOT NULL,
	PRIMARY KEY (rawAmpExposureId),
	KEY (rawCcdExposureId)
) ;


CREATE TABLE Raw_Amp_Exposure_Metadata
(
	rawAmpExposureId BIGINT NOT NULL,
	exposureType TINYINT NULL,
	metadataKey VARCHAR(255) NOT NULL,
	metadataValue VARCHAR(255) NULL,
	PRIMARY KEY (rawAmpExposureId)
) ;


CREATE TABLE Raw_Ccd_Exposure
(
	rawCcdExposureId BIGINT NOT NULL,
	ra DOUBLE NOT NULL,
	decl DOUBLE NOT NULL,
	filterId INTEGER NOT NULL,
	equinox FLOAT(0) NOT NULL,
	radecSys VARCHAR(20) NULL,
	dateObs TIMESTAMP NOT NULL DEFAULT 0,
	url VARCHAR(255) NOT NULL,
	ctype1 VARCHAR(20) NOT NULL,
	ctype2 VARCHAR(20) NOT NULL,
	mjdObs DOUBLE NULL,
	airmass FLOAT(0) NULL,
	crpix1 FLOAT(0) NOT NULL,
	crpix2 FLOAT(0) NOT NULL,
	crval1 DOUBLE NOT NULL,
	crval2 DOUBLE NOT NULL,
	cd11 DOUBLE NOT NULL,
	cd21 DOUBLE NOT NULL,
	darkTime FLOAT(0) NULL,
	cd12 DOUBLE NOT NULL,
	zd FLOAT(0) NULL,
	cd22 DOUBLE NOT NULL,
	taiObs TIMESTAMP NOT NULL DEFAULT 0,
	expTime FLOAT(0) NOT NULL,
	PRIMARY KEY (rawCcdExposureId)
) ;



SET FOREIGN_KEY_CHECKS=1;


ALTER TABLE prv_cnf_PolicyKey ADD CONSTRAINT FK_prv_cnf_PolicyKey_prv_PolicyKey 
	FOREIGN KEY (policyKeyId) REFERENCES prv_PolicyKey (policyKeyId);

ALTER TABLE prv_cnf_SoftwarePackage ADD CONSTRAINT FK_prv_cnf_SoftwarePackage_prv_SoftwarePackage 
	FOREIGN KEY (packageId) REFERENCES prv_SoftwarePackage (packageId);

ALTER TABLE prv_PolicyKey ADD CONSTRAINT FK_prv_PolicyKey_prv_PolicyFile 
	FOREIGN KEY (policyFileId) REFERENCES prv_PolicyFile (policyFileId);

ALTER TABLE _mops_EonQueue ADD CONSTRAINT FK__mopsEonQueue_MovingObject 
	FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE _mops_MoidQueue ADD CONSTRAINT FK__mops_MoidQueue_MovingObject 
	FOREIGN KEY (movingObjectId) REFERENCES MovingObject (movingObjectId);

ALTER TABLE mops_SSM ADD CONSTRAINT FK_mopsSSM_mopsSSMDesc 
	FOREIGN KEY (ssmDescId) REFERENCES mops_SSMDesc (ssmDescId);

ALTER TABLE mops_Tracklet ADD CONSTRAINT FK_mopsTracklets_mopsSSM 
	FOREIGN KEY (ssmId) REFERENCES mops_SSM (ssmId);
