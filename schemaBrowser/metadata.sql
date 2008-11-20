-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Reset database
DROP DATABASE IF EXISTS lsst_schema_browser;
CREATE DATABASE lsst_schema_browser;
USE lsst_schema_browser;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Create metadata tables

CREATE TABLE md_Table (
	id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE,
	engine VARCHAR(255),
	description VARCHAR(255)
);

CREATE TABLE md_Column (
	id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	tableId INTEGER NOT NULL REFERENCES md_Table (id),
	name VARCHAR(255) NOT NULL,
	description VARCHAR(255),
	type VARCHAR(255),
	notNull INTEGER DEFAULT 0,
	defaultValue VARCHAR(255),
	unit VARCHAR(255),
	ucd VARCHAR(255),
        displayOrder INTEGER NOT NULL,
	INDEX md_Column_idx (tableId, name)
);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 1, name = "Alert",
	engine = "MyISAM",
	description = "Every alert belongs to exactly one AmpExposure";

	INSERT INTO md_Column
	SET id = 1, tableId = 1, name = "alertId",
		type = "INTEGER",
		notNull = 1,
		defaultValue = "0",
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 2, tableId = 1, name = "ampExposureId",
		description = "Pointer to the Raw_Amp_Exposure table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 3, tableId = 1, name = "objectId",
		description = "Id of object associated with given alert.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 4, tableId = 1, name = "timeGenerated",
		description = "Date/time of the middle of the second exposure in a visit corresponding to given alert.",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 5, tableId = 1, name = "imagePStampURL",
		description = "Logical URL describing where the image postamp associated with the alert is located.",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 6, tableId = 1, name = "templatePStampURL",
		description = "Logical URL of the postagestamp of the template image related to given alert.",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 7, tableId = 1, name = "alertURL",
		description = "Logical URL to the actual alert sent.",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 7;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 2, name = "AlertType",
	engine = "MyISAM",
	description = "Table to store alert types";

	INSERT INTO md_Column
	SET id = 8, tableId = 2, name = "alertTypeId",
		description = "unique id of alert type",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 9, tableId = 2, name = "alertTypeDescr",
		description = "Description of the alert type.",
		type = "VARCHAR(50)",
		notNull = 0,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 3, name = "Bias_FPA_CMExposure",
	description = "Calibrated Master Bias Exposure: a bias exposure that is composed of multiple single bias exposures.";

	INSERT INTO md_Column
	SET id = 10, tableId = 3, name = "cmBiasExposureId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 4, name = "Bias_FPA_Exposure",
	description = "Table for keeping (individual) BiasExposures. Coadded BiasExposures are kept in CMBiasExposure table.";

	INSERT INTO md_Column
	SET id = 11, tableId = 4, name = "biasExposureId",
		description = "Corresponds to exposureId from Exposure table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 12, tableId = 4, name = "averPixelValue",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 13, tableId = 4, name = "stdevPixelValue",
		description = "standard deviation",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 5, name = "CalibType",
	description = "Table with definition of Calibration types: flat, bias, mask, etc...";

	INSERT INTO md_Column
	SET id = 14, tableId = 5, name = "calibTypeId",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 15, tableId = 5, name = "descr",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 6, name = "Calibration_Amp_Exposure";

	INSERT INTO md_Column
	SET id = 16, tableId = 6, name = "ccdExposureId",
		description = "Pointer to CCD_Exposure.",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 17, tableId = 6, name = "ampExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 7, name = "Calibration_CCD_Exposure",
	description = "Placeholder...";

	INSERT INTO md_Column
	SET id = 18, tableId = 7, name = "ccdExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 19, tableId = 7, name = "exposureId",
		description = "Pointer to exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 20, tableId = 7, name = "calibTypeId",
		description = "Pointer to CalibType table",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 21, tableId = 7, name = "filterId",
		description = "Pointer to filter information.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 22, tableId = 7, name = "equinox",
		description = "Equinox of World Coordinate System.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 23, tableId = 7, name = "ctype1",
		description = " Coordinate projection type, axis 1.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 24, tableId = 7, name = "ctype2",
		description = " Coordinate projection type, axis 2.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 25, tableId = 7, name = "crpix1",
		description = "Coordinate reference pixel, axis 1.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 26, tableId = 7, name = "crpix2",
		description = "Coordinate reference pixel, axis 2.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 27, tableId = 7, name = "crval1",
		description = "Coordinate value 1 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 28, tableId = 7, name = "crval2",
		description = "Coordinate value 2 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 29, tableId = 7, name = "cd1_1",
		description = "First derivative of coordinate 1 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 30, tableId = 7, name = "cd2_1",
		description = "First derivative of coordinate 2 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 31, tableId = 7, name = "cd1_2",
		description = "First derivative of coordinate 1 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 32, tableId = 7, name = "cd2_2",
		description = "First derivative of coordinate 2 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 33, tableId = 7, name = "dateObs",
		description = "Date/Time of observation start (UTC).",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 34, tableId = 7, name = "expTime",
		description = "Duration of exposure.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 35, tableId = 7, name = "nCombine",
		description = "Number of images co-added to create a deeper image",
		type = "INTEGER",
		notNull = 1,
		defaultValue = "1",
		displayOrder = 18;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 8, name = "Calibration_FPA_Exposure";

	INSERT INTO md_Column
	SET id = 36, tableId = 8, name = "exposureId",
		description = "Id of corresponding exposure in the FPA_Exposure table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 9, name = "DIASource",
	engine = "MyISAM",
	description = "Table to store all Difference Image Analysis (DIA) Sources.";

	INSERT INTO md_Column
	SET id = 37, tableId = 9, name = "diaSourceId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 38, tableId = 9, name = "ampExposureId",
		description = "Pointer to Raw_Amp_Exposure table - the amplifier where the difference source was measured.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 39, tableId = 9, name = "filterId",
		description = "Pointer to Filter table - filter used to take the Exposure where this source was measured.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 40, tableId = 9, name = "objectId",
		description = "Pointer to Object table. Might be NULL (each DIASource will point to either MovingObject or Object)",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 41, tableId = 9, name = "movingObjectId",
		description = "Pointer to MovingObject table. Might be NULL (each DIASource will point to either MovingObject or Object)",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 42, tableId = 9, name = "procHistoryId",
		description = "Pointer to ProcessingHistory table - an entry describing processing history of this source.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 43, tableId = 9, name = "scId",
		description = "Pointer to corresponding SourceClassification entry.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 44, tableId = 9, name = "ra",
		description = "RA-coordinate of the source centroid (degrees)&#xA;Need to support accuracy ~ 0.0001 arcsec.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 45, tableId = 9, name = "ssmId",
		description = "Pointer to mops_SSM table. Might be NULL. Yields the originating SSM object for synthetic detections injected by daytime MOPS.",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 46, tableId = 9, name = "decl",
		description = "Dec coordinate of the source centroid (degrees). Need to support accuracy ~0.0001 arcsec.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 47, tableId = 9, name = "raErr4detection",
		description = "Error in centroid RA coordinate (milliarcsec) coming from Detection Pipeline [FIXME, maybe use Stage name here?].",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 48, tableId = 9, name = "declErr4detection",
		description = "Error in centroid Decl coordinate (milliarcsec) coming from Detection Pipeline [FIXME, maybe use Stage name here?].",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 49, tableId = 9, name = "raErr4wcs",
		description = "Error in centroid RA coordinate (milliarcsec) coming from WCS Stage.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 50, tableId = 9, name = "declErr4wcs",
		description = "Error in centroid Decl coordinate (milliarcsec) coming from WCS Stage.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 51, tableId = 9, name = "xFlux",
		description = "The flux weighted position for x, calculated from the first moment of the pixel values within the footprint",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 52, tableId = 9, name = "xFluxErr",
		description = "Uncertainty of the xFlux.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 53, tableId = 9, name = "yFlux",
		description = "The flux weighted position for y, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 54, tableId = 9, name = "yFluxErr",
		description = "Uncertainty for yFlux.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 55, tableId = 9, name = "raFlux",
		description = "The flux weighted position for ra, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 56, tableId = 9, name = "raFluxErr",
		description = "Uncertainty for raFlux",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 57, tableId = 9, name = "declFlux",
		description = "The flux weighted position for decl, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET id = 58, tableId = 9, name = "declFluxErr",
		description = "Uncertainty for declFlux",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET id = 59, tableId = 9, name = "xPeak",
		description = "The position of the pixel (x) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET id = 60, tableId = 9, name = "yPeak",
		description = "The position of the pixel (y) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET id = 61, tableId = 9, name = "raPeak",
		description = "The position of the pixel (ra) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET id = 62, tableId = 9, name = "declPeak",
		description = "The position of the pixel (decl) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET id = 63, tableId = 9, name = "xAstrom",
		description = "The position (x) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET id = 64, tableId = 9, name = "xAstromErr",
		description = "Uncertainty for xAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET id = 65, tableId = 9, name = "yAstrom",
		description = "The position (y) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET id = 66, tableId = 9, name = "yAstromErr",
		description = "Uncertainty for yAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET id = 67, tableId = 9, name = "raAstrom",
		description = "The position (ra) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET id = 68, tableId = 9, name = "raAstromErr",
		description = "Uncertainty for raAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET id = 69, tableId = 9, name = "declAstrom",
		description = "The position (decl) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET id = 70, tableId = 9, name = "declAstromErr",
		description = "Uncertainty for declAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET id = 71, tableId = 9, name = "taiMidPoint",
		description = "If a DIASource corresponds to a single exposure, taiMidPoint represents TAI time of the middle of exposure. For multiple exposures, this is middle of beginning-of-first-exposure to end-of-last-exposure.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 35;

	INSERT INTO md_Column
	SET id = 72, tableId = 9, name = "taiRange",
		description = "If a DIASource corresponds to a single exposure, taiRange equals to exposure length. If DIASource corresponds to multiple exposures, it taiRange equals to end-of-last-exposure minus beginning-of-first-exposure.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 36;

	INSERT INTO md_Column
	SET id = 73, tableId = 9, name = "fwhmA",
		description = "Size of the object along major axis (pixels).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 37;

	INSERT INTO md_Column
	SET id = 74, tableId = 9, name = "fwhmB",
		description = "Size of the object along minor axis (pixels).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 38;

	INSERT INTO md_Column
	SET id = 75, tableId = 9, name = "fwhmTheta",
		description = "Position angle of the major axis w.r.t. X-axis (measured in degrees).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 39;

	INSERT INTO md_Column
	SET id = 76, tableId = 9, name = "lengthDeg",
		description = "Size of the object along major axis (degrees).",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 40;

	INSERT INTO md_Column
	SET id = 77, tableId = 9, name = "flux",
		description = "Measured DIA flux for the source (ADUs). Range is just a guesstimate, based on SM values [FIXME]",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 41;

	INSERT INTO md_Column
	SET id = 78, tableId = 9, name = "fluxErr",
		description = "Error of the measured flux (ADUs). Range is just a guesstimate, based on SM values [FIXME]",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 42;

	INSERT INTO md_Column
	SET id = 79, tableId = 9, name = "psfMag",
		description = "PSF magnitude of the object",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 43;

	INSERT INTO md_Column
	SET id = 80, tableId = 9, name = "psfMagErr",
		description = "Uncertainty of PSF magnitude",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 44;

	INSERT INTO md_Column
	SET id = 81, tableId = 9, name = "apMag",
		description = "Aperture magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 45;

	INSERT INTO md_Column
	SET id = 82, tableId = 9, name = "apMagErr",
		description = "Uncertainty of aperture magnitude",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 46;

	INSERT INTO md_Column
	SET id = 83, tableId = 9, name = "modelMag",
		description = "model magnitude (adaptive 2D gauss)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 47;

	INSERT INTO md_Column
	SET id = 84, tableId = 9, name = "modelMagErr",
		description = "Uncertainly of model magnitude.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 48;

	INSERT INTO md_Column
	SET id = 85, tableId = 9, name = "apDia",
		description = "Diameter of aperture (pixels)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET id = 86, tableId = 9, name = "refMag",
		description = "Reference magnitude before shape modulation applied (for synthetic detections)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET id = 87, tableId = 9, name = "Ixx",
		description = "Adaptive second moment",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 51;

	INSERT INTO md_Column
	SET id = 88, tableId = 9, name = "IxxErr",
		description = "Adaptive second moment uncertainty",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET id = 89, tableId = 9, name = "Iyy",
		description = "Adaptive second moment",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET id = 90, tableId = 9, name = "IyyErr",
		description = "Adaptive second moment uncertainty",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET id = 91, tableId = 9, name = "Ixy",
		description = "Adaptive second moment",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET id = 92, tableId = 9, name = "IxyErr",
		description = "Adaptive second moment uncertainty",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET id = 93, tableId = 9, name = "snr",
		description = "Signal-to-Noise ratio",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 57;

	INSERT INTO md_Column
	SET id = 94, tableId = 9, name = "chi2",
		description = "Chi-square value for the PSF fit",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 58;

	INSERT INTO md_Column
	SET id = 95, tableId = 9, name = "valx1",
		description = "The x1 value of the orthogonal polynomials at the position of the DIASource.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 59;

	INSERT INTO md_Column
	SET id = 96, tableId = 9, name = "valx2",
		description = "The x2 value of the orthogonal polynomials at the position of the DIASource.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 60;

	INSERT INTO md_Column
	SET id = 97, tableId = 9, name = "valy1",
		description = "The y1 value of the orthogonal polynomials at the position of the DIASource.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 61;

	INSERT INTO md_Column
	SET id = 98, tableId = 9, name = "valy2",
		description = "The y2 value of the orthogonal polynomials at the position of the DIASource.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 62;

	INSERT INTO md_Column
	SET id = 99, tableId = 9, name = "valxy",
		description = "The xy value of the orthogonal polynomials at the position of the DIASource.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 63;

	INSERT INTO md_Column
	SET id = 100, tableId = 9, name = "obsCode",
		description = "MPC observatory code",
		type = "CHAR(3)",
		notNull = 0,
		displayOrder = 64;

	INSERT INTO md_Column
	SET id = 101, tableId = 9, name = "isSynthetic",
		description = "efficiency marker; indicates detection is synthetic",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 65;

	INSERT INTO md_Column
	SET id = 102, tableId = 9, name = "mopsStatus",
		description = "efficiency marker; indicates detection was detected (not lost in chip gap, etc.)",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET id = 103, tableId = 9, name = "flag4association",
		description = "Problem/special conditions indicator (Kem noted that these flags could include delta_sky, delta_PSF, ...). FIXME: likely we should use a Stage name here",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET id = 104, tableId = 9, name = "flag4detection",
		description = "Problem/special conditions indicator (Kem noted that these flags could include delta_sky, delta_PSF, ...). ",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET id = 105, tableId = 9, name = "flag4wcs",
		description = "Problem/special conditions indicator (Kem noted that these flags could include delta_sky, delta_PSF, ...). ",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 69;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 10, name = "Dark_FPA_CMExposure",
	description = "Calibrated Master Dark Exposure: a bias exposure that is composed of multiple single dark exposures.";

	INSERT INTO md_Column
	SET id = 106, tableId = 10, name = "cmDarkExposureId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 11, name = "Dark_FPA_Exposure",
	description = "Table for keeping (individual) DarkExposures. Coadded DarkExposures are kept in CMDarkExposure table.";

	INSERT INTO md_Column
	SET id = 107, tableId = 11, name = "darkExposureId",
		description = "Corresponds to exposureId from Exposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 108, tableId = 11, name = "averPixelValue",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 109, tableId = 11, name = "stdevPixelValue",
		description = "standard deviation",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 12, name = "Flat_FPA_CMExposure",
	description = "Calibrated Master Flat Exposure: a bias exposure that is composed of multiple single flat exposures.";

	INSERT INTO md_Column
	SET id = 110, tableId = 12, name = "cmFlatExposureId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 13, name = "Flat_FPA_Exposure",
	description = "Table for keeping (individual) FlatExposures. Coadded FlatExposures are kept in CMFlatExposure table.";

	INSERT INTO md_Column
	SET id = 111, tableId = 13, name = "flatExposureId",
		description = "Corresponds to exposureId from Exposure table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 112, tableId = 13, name = "filterId",
		description = "Pointer to Filter table - filter used to take this exposure",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 113, tableId = 13, name = "averPixelValue",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 114, tableId = 13, name = "stdevPixelValue",
		description = "standard deviation",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 115, tableId = 13, name = "wavelength",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 116, tableId = 13, name = "type",
		description = "FIXME: convert type to ENUM: 'sky', 'dome'",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 14, name = "Fringe_FPA_CMExposure",
	description = "Calibrated Master FringeExposure: a bias exposure that is composed of multiple single fringe exposures.";

	INSERT INTO md_Column
	SET id = 117, tableId = 14, name = "cdFringeExposureId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 15, name = "MovingObject",
	description = "Table to store description of the Solar System (moving) Objects.&#xA;";

	INSERT INTO md_Column
	SET id = 118, tableId = 15, name = "movingObjectId",
		description = "Moving object unique identified.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 119, tableId = 15, name = "movingObjectVersion",
		description = "Version number for the moving object. Updates to orbital parameters will result in a new version (row) of the object, preserving the orbit refinement history",
		type = "INT",
		notNull = 1,
		defaultValue = "'1'",
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 120, tableId = 15, name = "procHistoryId",
		description = "Pointer to ProcessingHistory table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 121, tableId = 15, name = "taxonomicTypeId",
		description = "Pointer to ObjectType table for asteroid taxonomic type",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 122, tableId = 15, name = "ssmObjectName",
		description = "MOPS base-64 SSM object name, included for convenience. This name can be obtained from `mops_SSM` by joining on `ssmId`",
		type = "VARCHAR(32)",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 123, tableId = 15, name = "q",
		description = "semi-major axis of the orbit (AU)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 124, tableId = 15, name = "e",
		description = "eccentricity e (dimensionless)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 125, tableId = 15, name = "i",
		description = "inclination of the orbit (degrees)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 126, tableId = 15, name = "node",
		description = "longitude of ascending node (degrees)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 127, tableId = 15, name = "meanAnom",
		description = "Mean anomaly of the orbit",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 128, tableId = 15, name = "argPeri",
		description = "argument of perihelion (degrees)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 129, tableId = 15, name = "distPeri",
		description = "perihelion distance (AU)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 130, tableId = 15, name = "timePeri",
		description = "time of perihelion passage, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 131, tableId = 15, name = "epoch",
		description = "epoch of osculating elements, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 132, tableId = 15, name = "h_v",
		description = "Absolute magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 133, tableId = 15, name = "g",
		description = "Slope parameter g",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 134, tableId = 15, name = "rotationPeriod",
		description = "Rotation period, days",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 135, tableId = 15, name = "rotationEpoch",
		description = "Rotation time origin, MJD (UTC)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 136, tableId = 15, name = "albedo",
		description = "Albedo (dimensionless)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 137, tableId = 15, name = "poleLat",
		description = "Rotation pole latitude (degrees)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 138, tableId = 15, name = "poleLon",
		description = "Rotation pole longitude (degrees)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET id = 139, tableId = 15, name = "d3",
		description = "3-parameter D-criterion (dimensionless) WRT SSM object",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET id = 140, tableId = 15, name = "d4",
		description = "4-parameter D-criterion (dimensionless) WRT SSM object",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET id = 141, tableId = 15, name = "orbFitResidual",
		description = "orbit fit RMS residual (arcsec)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 24;

	INSERT INTO md_Column
	SET id = 142, tableId = 15, name = "orbFitChi2",
		description = "orbit fit chi-squared statistic",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET id = 143, tableId = 15, name = "classification",
		description = "MOPS efficiency classification ('C'/'M'/'B'/'N'/'X')",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET id = 144, tableId = 15, name = "ssmId",
		description = "Source SSM object for C classification",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET id = 145, tableId = 15, name = "mopsStatus",
		description = "NULL, or set to 'M' when DO is merged with parent",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET id = 146, tableId = 15, name = "stablePass",
		description = "NULL, or set to 'Y' when stable precovery pass completed",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET id = 147, tableId = 15, name = "timeCreated",
		description = "Timestamp for row creation (this is the time of moving object creation for the first version of that object)",
		type = "TIMESTAMP",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET id = 148, tableId = 15, name = "uMag",
		description = "u-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 31;

	INSERT INTO md_Column
	SET id = 149, tableId = 15, name = "uMagErr",
		description = "u-magnitude error",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 32;

	INSERT INTO md_Column
	SET id = 150, tableId = 15, name = "uAmplitude",
		description = "Characteristic magnitude scale of the flux variations for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET id = 151, tableId = 15, name = "uPeriod",
		description = "Period of flux variations (if regular) for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET id = 152, tableId = 15, name = "gMag",
		description = "g-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 35;

	INSERT INTO md_Column
	SET id = 153, tableId = 15, name = "gMagErr",
		description = "g-magnitude error",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 36;

	INSERT INTO md_Column
	SET id = 154, tableId = 15, name = "gAmplitude",
		description = "Characteristic magnitude scale of the flux variations for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET id = 155, tableId = 15, name = "gPeriod",
		description = "Period of flux variations (if regular) for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET id = 156, tableId = 15, name = "rMag",
		description = "r-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 39;

	INSERT INTO md_Column
	SET id = 157, tableId = 15, name = "rMagErr",
		description = "r-magnitude error",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 40;

	INSERT INTO md_Column
	SET id = 158, tableId = 15, name = "rAmplitude",
		description = "Characteristic magnitude scale of the flux variations for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET id = 159, tableId = 15, name = "rPeriod",
		description = "Period of flux variations (if regular) for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 42;

	INSERT INTO md_Column
	SET id = 160, tableId = 15, name = "iMag",
		description = "i-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 43;

	INSERT INTO md_Column
	SET id = 161, tableId = 15, name = "iMagErr",
		description = "i-magnitude error",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 44;

	INSERT INTO md_Column
	SET id = 162, tableId = 15, name = "iAmplitude",
		description = "Characteristic magnitude scale of the flux variations for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET id = 163, tableId = 15, name = "iPeriod",
		description = "Period of flux variations (if regular) for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET id = 164, tableId = 15, name = "zMag",
		description = "z-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 47;

	INSERT INTO md_Column
	SET id = 165, tableId = 15, name = "zMagErr",
		description = "z-magnitude error",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 48;

	INSERT INTO md_Column
	SET id = 166, tableId = 15, name = "zAmplitude",
		description = "Characteristic magnitude scale of the flux variations for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET id = 167, tableId = 15, name = "zPeriod",
		description = "Period of flux variations (if regular) for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET id = 168, tableId = 15, name = "yMag",
		description = "y-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 51;

	INSERT INTO md_Column
	SET id = 169, tableId = 15, name = "yMagErr",
		description = "y-magnitude error",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 52;

	INSERT INTO md_Column
	SET id = 170, tableId = 15, name = "yAmplitude",
		description = "Characteristic magnitude scale of the flux variations for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET id = 171, tableId = 15, name = "yPeriod",
		description = "Period of flux variations (if regular) for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET id = 172, tableId = 15, name = "flag",
		description = "Problem/special condition flag.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET id = 173, tableId = 15, name = "src01",
		description = "square root of covariance EC EC (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET id = 174, tableId = 15, name = "src02",
		description = "square root of covariance EC QR (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET id = 175, tableId = 15, name = "src03",
		description = "square root of covariance QR QR (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET id = 176, tableId = 15, name = "src04",
		description = "square root of covariance EC TP (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET id = 177, tableId = 15, name = "src05",
		description = "square root of covariance QR TP (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET id = 178, tableId = 15, name = "src06",
		description = "square root of covariance TP TP (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET id = 179, tableId = 15, name = "src07",
		description = "square root of covariance EC OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 62;

	INSERT INTO md_Column
	SET id = 180, tableId = 15, name = "src08",
		description = "square root of covariance QR OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 63;

	INSERT INTO md_Column
	SET id = 181, tableId = 15, name = "src09",
		description = "square root of covariance TP OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 64;

	INSERT INTO md_Column
	SET id = 182, tableId = 15, name = "src10",
		description = "square root of covariance OM OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 65;

	INSERT INTO md_Column
	SET id = 183, tableId = 15, name = "src11",
		description = "square root of covariance EC W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET id = 184, tableId = 15, name = "src12",
		description = "square root of covariance QR W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET id = 185, tableId = 15, name = "src13",
		description = "square root of covariance TP W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET id = 186, tableId = 15, name = "src14",
		description = "square root of covariance OM W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET id = 187, tableId = 15, name = "src15",
		description = "square root of covariance W  W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET id = 188, tableId = 15, name = "src16",
		description = "square root of covariance EC IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET id = 189, tableId = 15, name = "src17",
		description = "square root of covariance QR IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 72;

	INSERT INTO md_Column
	SET id = 190, tableId = 15, name = "src18",
		description = "square root of covariance TP IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 73;

	INSERT INTO md_Column
	SET id = 191, tableId = 15, name = "src19",
		description = "square root of covariance OM IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 74;

	INSERT INTO md_Column
	SET id = 192, tableId = 15, name = "src20",
		description = "square root of covariance W  IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 75;

	INSERT INTO md_Column
	SET id = 193, tableId = 15, name = "src21",
		description = "square root of covariance IN IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 76;

	INSERT INTO md_Column
	SET id = 194, tableId = 15, name = "convCode",
		description = "JPL convergence code",
		type = "VARCHAR(8)",
		notNull = 0,
		displayOrder = 77;

	INSERT INTO md_Column
	SET id = 195, tableId = 15, name = "o_minus_c",
		description = "Vestigial observed-computed position, essentially RMS residual",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 78;

	INSERT INTO md_Column
	SET id = 196, tableId = 15, name = "moid1",
		description = "Minimum orbital intersection distance (MOID) solution 1",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 79;

	INSERT INTO md_Column
	SET id = 197, tableId = 15, name = "moidLong1",
		description = "Longitude of MOID 1",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 80;

	INSERT INTO md_Column
	SET id = 198, tableId = 15, name = "moid2",
		description = "Minimum orbital intersection distance (MOID) solution 2",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 81;

	INSERT INTO md_Column
	SET id = 199, tableId = 15, name = "moidLong2",
		description = "Longitude of MOID 2",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 82;

	INSERT INTO md_Column
	SET id = 200, tableId = 15, name = "arcLengthDays",
		description = "Arc length of detections used to compute orbit",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 83;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 16, name = "Object",
	engine = "MyISAM",
	description = "Description of the multi-epoch static object. (Kem: do we link Object and DIAObject tables? Right now it's done through the source tables)";

	INSERT INTO md_Column
	SET id = 201, tableId = 16, name = "objectId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 202, tableId = 16, name = "procHistoryId",
		description = "Pointer to ProcessingHistory table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 203, tableId = 16, name = "ra",
		description = "RA-coordinate of the object (degrees). Weighted center of light across all filters. Need to support accuracy ~0.0001 arcsec.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 204, tableId = 16, name = "decl",
		description = "Dec-coordinate of the object (degrees). Weighted center of light across all filters. Need to support accuracy ~0.0001 arcsec",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 205, tableId = 16, name = "raErr",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 206, tableId = 16, name = "declErr",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 207, tableId = 16, name = "muRa",
		description = "derived proper motion, mu_alpha*cos(Dec) (measured in arcsec/yr)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 208, tableId = 16, name = "muDecl",
		description = "derived proper motion, mu_delta (measured in arcsec/yr)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 209, tableId = 16, name = "muRaErr",
		description = "Error in ra proper motion",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 210, tableId = 16, name = "muDeclErr",
		description = "Error in Decl proper motion",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 211, tableId = 16, name = "xFlux",
		description = "The flux weighted position for x, calculated from the first moment of the pixel values within the footprint",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 212, tableId = 16, name = "xFluxErr",
		description = "Uncertainty of the xFlux.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 213, tableId = 16, name = "yFlux",
		description = "The flux weighted position for y, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 214, tableId = 16, name = "yFluxErr",
		description = "Uncertainty for yFlux.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 215, tableId = 16, name = "raFlux",
		description = "The flux weighted position for ra, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 216, tableId = 16, name = "raFluxErr",
		description = "Uncertainty for raFlux",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 217, tableId = 16, name = "declFlux",
		description = "The flux weighted position for decl, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 218, tableId = 16, name = "declFluxErr",
		description = "Uncertainty for declFlux",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 219, tableId = 16, name = "xPeak",
		description = "The position of the pixel (x) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 220, tableId = 16, name = "yPeak",
		description = "The position of the pixel (y) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 221, tableId = 16, name = "raPeak",
		description = "The position of the pixel (ra) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET id = 222, tableId = 16, name = "declPeak",
		description = "The position of the pixel (decl) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET id = 223, tableId = 16, name = "xAstrom",
		description = "The position (x) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET id = 224, tableId = 16, name = "xAstromErr",
		description = "Uncertainty for xAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET id = 225, tableId = 16, name = "yAstrom",
		description = "The position (y) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET id = 226, tableId = 16, name = "yAstromErr",
		description = "Uncertainty for yAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET id = 227, tableId = 16, name = "raAstrom",
		description = "The position (ra) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET id = 228, tableId = 16, name = "raAstromErr",
		description = "Uncertainty for raAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET id = 229, tableId = 16, name = "declAstrom",
		description = "The position (decl) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET id = 230, tableId = 16, name = "declAstromErr",
		description = "Uncertainty for declAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET id = 231, tableId = 16, name = "parallax",
		description = "derived parallax for the object",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET id = 232, tableId = 16, name = "parallaxErr",
		description = "parallax error",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET id = 233, tableId = 16, name = "earliestObsTime",
		description = "first observation time",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET id = 234, tableId = 16, name = "latestObsTime",
		description = "last observation time",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET id = 235, tableId = 16, name = "primaryPeriod",
		description = "period that represent periods for all filters.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 35;

	INSERT INTO md_Column
	SET id = 236, tableId = 16, name = "primaryPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 36;

	INSERT INTO md_Column
	SET id = 237, tableId = 16, name = "ugColor",
		description = "Precalculated color (difference between u and g).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET id = 238, tableId = 16, name = "grColor",
		description = "Precalculated color (difference between g and r).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET id = 239, tableId = 16, name = "riColor",
		description = "Precalculated color (difference between r and i).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 39;

	INSERT INTO md_Column
	SET id = 240, tableId = 16, name = "izColor",
		description = "Precalculated color (difference between i and z).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 40;

	INSERT INTO md_Column
	SET id = 241, tableId = 16, name = "zyColor",
		description = "Precalculated color (difference between z and y).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET id = 242, tableId = 16, name = "cx",
		description = "x-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 42;

	INSERT INTO md_Column
	SET id = 243, tableId = 16, name = "cxErr",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 43;

	INSERT INTO md_Column
	SET id = 244, tableId = 16, name = "cy",
		description = "z-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 44;

	INSERT INTO md_Column
	SET id = 245, tableId = 16, name = "cyErr",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 45;

	INSERT INTO md_Column
	SET id = 246, tableId = 16, name = "cz",
		description = "z-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 46;

	INSERT INTO md_Column
	SET id = 247, tableId = 16, name = "czErr",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 47;

	INSERT INTO md_Column
	SET id = 248, tableId = 16, name = "flag4stage1",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 48;

	INSERT INTO md_Column
	SET id = 249, tableId = 16, name = "flag4stage2",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET id = 250, tableId = 16, name = "flag4stage3",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET id = 251, tableId = 16, name = "isProvisional",
		description = "If this is set to true it indicates that the object was created at the base camp. If set to false, it means it was created by Deep Detection.",
		type = "BOOL",
		notNull = 1,
		defaultValue = "FALSE",
		displayOrder = 51;

	INSERT INTO md_Column
	SET id = 252, tableId = 16, name = "zone",
		description = "zone is an index to speed up spatial queries.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET id = 253, tableId = 16, name = "uMag",
		description = "u-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET id = 254, tableId = 16, name = "uMagErr",
		description = "u-magnitude error",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET id = 255, tableId = 16, name = "uPetroMag",
		description = "Petrosian flux for u filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET id = 256, tableId = 16, name = "uPetroMagErr",
		description = "Petrosian flux error for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET id = 257, tableId = 16, name = "uApMag",
		description = "aperture magnitude for u filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET id = 258, tableId = 16, name = "uApMagErr",
		description = "aperture magnitude error for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET id = 259, tableId = 16, name = "uPosErrA",
		description = "Large dimension of the position error ellipse, assuming gaussian scatter (arcsec). For u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET id = 260, tableId = 16, name = "uPosErrB",
		description = "Small dimension of the position error ellipse, assuming gaussian scatter (arcsec).  For u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET id = 261, tableId = 16, name = "uPosErrTheta",
		description = "Orientation of the position error ellipse (degrees). For u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET id = 262, tableId = 16, name = "uNumObs",
		description = "Number of measurements in the lightcurve for u filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 62;

	INSERT INTO md_Column
	SET id = 263, tableId = 16, name = "uVarProb",
		description = "Probability of variability in % (100% = variable object) for u filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 63;

	INSERT INTO md_Column
	SET id = 264, tableId = 16, name = "uAmplitude",
		description = "Characteristic magnitude scale of the flux variations for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 64;

	INSERT INTO md_Column
	SET id = 265, tableId = 16, name = "uPeriod",
		description = "Period of flux variations (if regular) for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 65;

	INSERT INTO md_Column
	SET id = 266, tableId = 16, name = "uPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET id = 267, tableId = 16, name = "uIx",
		description = "Adaptive first moment for u filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET id = 268, tableId = 16, name = "uIxErr",
		description = "Adaptive first moment uncertainty for u filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET id = 269, tableId = 16, name = "uIy",
		description = "Adaptive first moment for u filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET id = 270, tableId = 16, name = "uIyErr",
		description = "Adaptive first moment uncertainty for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET id = 271, tableId = 16, name = "uIxx",
		description = "Adaptive second moment for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET id = 272, tableId = 16, name = "uIxxErr",
		description = "Adaptive second moment uncertainty for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 72;

	INSERT INTO md_Column
	SET id = 273, tableId = 16, name = "uIyy",
		description = "Adaptive second moment for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 73;

	INSERT INTO md_Column
	SET id = 274, tableId = 16, name = "uIyyErr",
		description = "Adaptive second moment uncertainty for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 74;

	INSERT INTO md_Column
	SET id = 275, tableId = 16, name = "uIxy",
		description = "Adaptive second moment for u fiter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 75;

	INSERT INTO md_Column
	SET id = 276, tableId = 16, name = "uIxyErr",
		description = "Adaptive second moment uncertainty for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 76;

	INSERT INTO md_Column
	SET id = 277, tableId = 16, name = "uTimescale",
		description = "Characteristic timescale of flux variations (measured in days). This is to complement period for variables without a well-defined period. LSST images have sampling frequency of ~0.1Hz. For u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 77;

	INSERT INTO md_Column
	SET id = 278, tableId = 16, name = "gMag",
		description = "g-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 78;

	INSERT INTO md_Column
	SET id = 279, tableId = 16, name = "gMagErr",
		description = "g-magnitude error",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 79;

	INSERT INTO md_Column
	SET id = 280, tableId = 16, name = "gPetroMag",
		description = "Petrosian flux for g filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 80;

	INSERT INTO md_Column
	SET id = 281, tableId = 16, name = "gPetroMagErr",
		description = "Petrosian flux error filter for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 81;

	INSERT INTO md_Column
	SET id = 282, tableId = 16, name = "gApMag",
		description = "aperture magnitude for g filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 82;

	INSERT INTO md_Column
	SET id = 283, tableId = 16, name = "gApMagErr",
		description = "aperture magnitude error for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 83;

	INSERT INTO md_Column
	SET id = 284, tableId = 16, name = "gPosErrA",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 84;

	INSERT INTO md_Column
	SET id = 285, tableId = 16, name = "gPosErrB",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 85;

	INSERT INTO md_Column
	SET id = 286, tableId = 16, name = "gPosErrTheta",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 86;

	INSERT INTO md_Column
	SET id = 287, tableId = 16, name = "gNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 87;

	INSERT INTO md_Column
	SET id = 288, tableId = 16, name = "gVarProb",
		description = "Probability of variability in % (100% = variable object) for g filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 88;

	INSERT INTO md_Column
	SET id = 289, tableId = 16, name = "gAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 89;

	INSERT INTO md_Column
	SET id = 290, tableId = 16, name = "gPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 90;

	INSERT INTO md_Column
	SET id = 291, tableId = 16, name = "gPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 91;

	INSERT INTO md_Column
	SET id = 292, tableId = 16, name = "gIx",
		description = "Adaptive first moment for g filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 92;

	INSERT INTO md_Column
	SET id = 293, tableId = 16, name = "gIxErr",
		description = "Adaptive first moment uncertainty for g filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 93;

	INSERT INTO md_Column
	SET id = 294, tableId = 16, name = "gIy",
		description = "Adaptive first moment for g filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 94;

	INSERT INTO md_Column
	SET id = 295, tableId = 16, name = "gIyErr",
		description = "Adaptive first moment uncertainty for g filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 95;

	INSERT INTO md_Column
	SET id = 296, tableId = 16, name = "gIxx",
		description = "Adaptive second moment for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 96;

	INSERT INTO md_Column
	SET id = 297, tableId = 16, name = "gIxxErr",
		description = "Adaptive second moment uncertainty for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 97;

	INSERT INTO md_Column
	SET id = 298, tableId = 16, name = "gIyy",
		description = "Adaptive second moment for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 98;

	INSERT INTO md_Column
	SET id = 299, tableId = 16, name = "gIyyErr",
		description = "Adaptive second moment uncertainty for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 99;

	INSERT INTO md_Column
	SET id = 300, tableId = 16, name = "gIxy",
		description = "Adaptive second moment for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 100;

	INSERT INTO md_Column
	SET id = 301, tableId = 16, name = "gIxyErr",
		description = "Adaptive second moment uncertainty for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 101;

	INSERT INTO md_Column
	SET id = 302, tableId = 16, name = "gTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 102;

	INSERT INTO md_Column
	SET id = 303, tableId = 16, name = "rMag",
		description = "r-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 103;

	INSERT INTO md_Column
	SET id = 304, tableId = 16, name = "rMagErr",
		description = "r-magnitude error",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 104;

	INSERT INTO md_Column
	SET id = 305, tableId = 16, name = "rPetroMag",
		description = "Petrosian flux for r filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 105;

	INSERT INTO md_Column
	SET id = 306, tableId = 16, name = "rPetroMagErr",
		description = "Petrosian flux error for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 106;

	INSERT INTO md_Column
	SET id = 307, tableId = 16, name = "rApMag",
		description = "aperture magnitude for r filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 107;

	INSERT INTO md_Column
	SET id = 308, tableId = 16, name = "rApMagErr",
		description = "aperture magnitude error for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 108;

	INSERT INTO md_Column
	SET id = 309, tableId = 16, name = "rPosErrA",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 109;

	INSERT INTO md_Column
	SET id = 310, tableId = 16, name = "rPosErrB",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 110;

	INSERT INTO md_Column
	SET id = 311, tableId = 16, name = "rPosErrTheta",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 111;

	INSERT INTO md_Column
	SET id = 312, tableId = 16, name = "rNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 112;

	INSERT INTO md_Column
	SET id = 313, tableId = 16, name = "rVarProb",
		description = "Probability of variability in % (100% = variable object) for r filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 113;

	INSERT INTO md_Column
	SET id = 314, tableId = 16, name = "rAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 114;

	INSERT INTO md_Column
	SET id = 315, tableId = 16, name = "rPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 115;

	INSERT INTO md_Column
	SET id = 316, tableId = 16, name = "rPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 116;

	INSERT INTO md_Column
	SET id = 317, tableId = 16, name = "rIx",
		description = "Adaptive first moment for r filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 117;

	INSERT INTO md_Column
	SET id = 318, tableId = 16, name = "rIxErr",
		description = "Adaptive first moment uncertainty for r filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 118;

	INSERT INTO md_Column
	SET id = 319, tableId = 16, name = "rIy",
		description = "Adaptive first moment for r filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 119;

	INSERT INTO md_Column
	SET id = 320, tableId = 16, name = "rIyErr",
		description = "Adaptive first moment uncertainty for r filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 120;

	INSERT INTO md_Column
	SET id = 321, tableId = 16, name = "rIxx",
		description = "Adaptive second moment for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 121;

	INSERT INTO md_Column
	SET id = 322, tableId = 16, name = "rIxxErr",
		description = "Adaptive second moment uncertainty for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 122;

	INSERT INTO md_Column
	SET id = 323, tableId = 16, name = "rIyy",
		description = "Adaptive second moment for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 123;

	INSERT INTO md_Column
	SET id = 324, tableId = 16, name = "rIyyErr",
		description = "Adaptive second moment uncertainty for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 124;

	INSERT INTO md_Column
	SET id = 325, tableId = 16, name = "rIxy",
		description = "Adaptive second moment for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 125;

	INSERT INTO md_Column
	SET id = 326, tableId = 16, name = "rIxyErr",
		description = "Adaptive second moment uncertainty for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 126;

	INSERT INTO md_Column
	SET id = 327, tableId = 16, name = "rTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 127;

	INSERT INTO md_Column
	SET id = 328, tableId = 16, name = "iMag",
		description = "i-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 128;

	INSERT INTO md_Column
	SET id = 329, tableId = 16, name = "iMagErr",
		description = "i-magnitude error",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 129;

	INSERT INTO md_Column
	SET id = 330, tableId = 16, name = "iPetroMag",
		description = "Petrosian flux for i filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 130;

	INSERT INTO md_Column
	SET id = 331, tableId = 16, name = "iPetroMagErr",
		description = "Petrosian flux error for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 131;

	INSERT INTO md_Column
	SET id = 332, tableId = 16, name = "iApMag",
		description = "aperture magnitude for i filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 132;

	INSERT INTO md_Column
	SET id = 333, tableId = 16, name = "iApMagErr",
		description = "aperture magnitude error for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 133;

	INSERT INTO md_Column
	SET id = 334, tableId = 16, name = "iPosErrA",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 134;

	INSERT INTO md_Column
	SET id = 335, tableId = 16, name = "iPosErrB",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 135;

	INSERT INTO md_Column
	SET id = 336, tableId = 16, name = "iPosErrTheta",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 136;

	INSERT INTO md_Column
	SET id = 337, tableId = 16, name = "iNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 137;

	INSERT INTO md_Column
	SET id = 338, tableId = 16, name = "iVarProb",
		description = "Probability of variability in % (100% = variable object) for i filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 138;

	INSERT INTO md_Column
	SET id = 339, tableId = 16, name = "iAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 139;

	INSERT INTO md_Column
	SET id = 340, tableId = 16, name = "iPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 140;

	INSERT INTO md_Column
	SET id = 341, tableId = 16, name = "iPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 141;

	INSERT INTO md_Column
	SET id = 342, tableId = 16, name = "iIx",
		description = "Adaptive first moment for i filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 142;

	INSERT INTO md_Column
	SET id = 343, tableId = 16, name = "iIxErr",
		description = "Adaptive first moment uncertainty for i filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 143;

	INSERT INTO md_Column
	SET id = 344, tableId = 16, name = "iIy",
		description = "Adaptive first moment for i filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 144;

	INSERT INTO md_Column
	SET id = 345, tableId = 16, name = "iIyErr",
		description = "Adaptive first moment uncertainty for i filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 145;

	INSERT INTO md_Column
	SET id = 346, tableId = 16, name = "iIxx",
		description = "Adaptive second moment for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 146;

	INSERT INTO md_Column
	SET id = 347, tableId = 16, name = "iIxxErr",
		description = "Adaptive second moment uncertainty for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 147;

	INSERT INTO md_Column
	SET id = 348, tableId = 16, name = "iIyy",
		description = "Adaptive second moment for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 148;

	INSERT INTO md_Column
	SET id = 349, tableId = 16, name = "iIyyErr",
		description = "Adaptive second moment uncertainty for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 149;

	INSERT INTO md_Column
	SET id = 350, tableId = 16, name = "iIxy",
		description = "Adaptive second moment for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 150;

	INSERT INTO md_Column
	SET id = 351, tableId = 16, name = "iIxyErr",
		description = "Adaptive second moment uncertainty for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 151;

	INSERT INTO md_Column
	SET id = 352, tableId = 16, name = "iTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 152;

	INSERT INTO md_Column
	SET id = 353, tableId = 16, name = "zMag",
		description = "z-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 153;

	INSERT INTO md_Column
	SET id = 354, tableId = 16, name = "zMagErr",
		description = "z-magnitude error",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 154;

	INSERT INTO md_Column
	SET id = 355, tableId = 16, name = "zPetroMag",
		description = "Petrosian flux for z filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 155;

	INSERT INTO md_Column
	SET id = 356, tableId = 16, name = "zPetroMagErr",
		description = "Petrosian flux error for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 156;

	INSERT INTO md_Column
	SET id = 357, tableId = 16, name = "zApMag",
		description = "aperture magnitude for z filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 157;

	INSERT INTO md_Column
	SET id = 358, tableId = 16, name = "zApMagErr",
		description = "aperture magnitude error for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 158;

	INSERT INTO md_Column
	SET id = 359, tableId = 16, name = "zPosErrA",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 159;

	INSERT INTO md_Column
	SET id = 360, tableId = 16, name = "zPosErrB",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 160;

	INSERT INTO md_Column
	SET id = 361, tableId = 16, name = "zPosErrTheta",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 161;

	INSERT INTO md_Column
	SET id = 362, tableId = 16, name = "zNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 162;

	INSERT INTO md_Column
	SET id = 363, tableId = 16, name = "zVarProb",
		description = "Probability of variability in % (100% = variable object) for z filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 163;

	INSERT INTO md_Column
	SET id = 364, tableId = 16, name = "zAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 164;

	INSERT INTO md_Column
	SET id = 365, tableId = 16, name = "zPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 165;

	INSERT INTO md_Column
	SET id = 366, tableId = 16, name = "zPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 166;

	INSERT INTO md_Column
	SET id = 367, tableId = 16, name = "zIx",
		description = "Adaptive first moment for z filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 167;

	INSERT INTO md_Column
	SET id = 368, tableId = 16, name = "zIxErr",
		description = "Adaptive first moment uncertainty for z filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 168;

	INSERT INTO md_Column
	SET id = 369, tableId = 16, name = "zIy",
		description = "Adaptive first moment for z filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 169;

	INSERT INTO md_Column
	SET id = 370, tableId = 16, name = "zIyErr",
		description = "Adaptive first moment uncertainty for z filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 170;

	INSERT INTO md_Column
	SET id = 371, tableId = 16, name = "zIxx",
		description = "Adaptive second moment for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 171;

	INSERT INTO md_Column
	SET id = 372, tableId = 16, name = "zIxxErr",
		description = "Adaptive second moment uncertainty for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 172;

	INSERT INTO md_Column
	SET id = 373, tableId = 16, name = "zIyy",
		description = "Adaptive second moment for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 173;

	INSERT INTO md_Column
	SET id = 374, tableId = 16, name = "zIyyErr",
		description = "Adaptive second moment uncertainty for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 174;

	INSERT INTO md_Column
	SET id = 375, tableId = 16, name = "zIxy",
		description = "Adaptive second moment for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 175;

	INSERT INTO md_Column
	SET id = 376, tableId = 16, name = "zIxyErr",
		description = "Adaptive second moment uncertainty for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 176;

	INSERT INTO md_Column
	SET id = 377, tableId = 16, name = "zTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 177;

	INSERT INTO md_Column
	SET id = 378, tableId = 16, name = "yMag",
		description = "y-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 178;

	INSERT INTO md_Column
	SET id = 379, tableId = 16, name = "yMagErr",
		description = "y-magnitude error",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 179;

	INSERT INTO md_Column
	SET id = 380, tableId = 16, name = "yPetroMag",
		description = "Petrosian flux for y filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 180;

	INSERT INTO md_Column
	SET id = 381, tableId = 16, name = "yPetroMagErr",
		description = "Petrosian flux error for y filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 181;

	INSERT INTO md_Column
	SET id = 382, tableId = 16, name = "yApMag",
		description = "aperture magnitude for y filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 182;

	INSERT INTO md_Column
	SET id = 383, tableId = 16, name = "yApMagErr",
		description = "aperture magnitude error for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 183;

	INSERT INTO md_Column
	SET id = 384, tableId = 16, name = "yPosErrA",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 184;

	INSERT INTO md_Column
	SET id = 385, tableId = 16, name = "yPosErrB",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 185;

	INSERT INTO md_Column
	SET id = 386, tableId = 16, name = "yPosErrTheta",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 186;

	INSERT INTO md_Column
	SET id = 387, tableId = 16, name = "yNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 187;

	INSERT INTO md_Column
	SET id = 388, tableId = 16, name = "yVarProb",
		description = "Probability of variability in % (100% = variable object) for y filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 188;

	INSERT INTO md_Column
	SET id = 389, tableId = 16, name = "yAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 189;

	INSERT INTO md_Column
	SET id = 390, tableId = 16, name = "yPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 190;

	INSERT INTO md_Column
	SET id = 391, tableId = 16, name = "yPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 191;

	INSERT INTO md_Column
	SET id = 392, tableId = 16, name = "yIx",
		description = "Adaptive first moment for y filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 192;

	INSERT INTO md_Column
	SET id = 393, tableId = 16, name = "yIxErr",
		description = "Adaptive first moment uncertainty for y filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 193;

	INSERT INTO md_Column
	SET id = 394, tableId = 16, name = "yIy",
		description = "Adaptive first moment for y filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 194;

	INSERT INTO md_Column
	SET id = 395, tableId = 16, name = "yIyErr",
		description = "Adaptive first moment uncertainty for y filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 195;

	INSERT INTO md_Column
	SET id = 396, tableId = 16, name = "yIxx",
		description = "Adaptive second moment for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 196;

	INSERT INTO md_Column
	SET id = 397, tableId = 16, name = "yIxxErr",
		description = "Adaptive second moment uncertainty for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 197;

	INSERT INTO md_Column
	SET id = 398, tableId = 16, name = "yIyy",
		description = "Adaptive second moment for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 198;

	INSERT INTO md_Column
	SET id = 399, tableId = 16, name = "yIyyErr",
		description = "Adaptive second moment uncertainty for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 199;

	INSERT INTO md_Column
	SET id = 400, tableId = 16, name = "yIxy",
		description = "Adaptive second moment for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 200;

	INSERT INTO md_Column
	SET id = 401, tableId = 16, name = "yIxyErr",
		description = "Adaptive second moment uncertainty for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 201;

	INSERT INTO md_Column
	SET id = 402, tableId = 16, name = "yTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 202;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 17, name = "ObjectType",
	description = "Table to store description of object types. It includes all object types: static, variables, Solar System objects, etc.";

	INSERT INTO md_Column
	SET id = 403, tableId = 17, name = "typeId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 404, tableId = 17, name = "description",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 18, name = "PostageStampJpegs";

	INSERT INTO md_Column
	SET id = 405, tableId = 18, name = "ra",
		description = "ra of upper left corner",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 406, tableId = 18, name = "decl",
		description = "decl or upper left corner",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 407, tableId = 18, name = "sizeRa",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 408, tableId = 18, name = "sizeDecl",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 409, tableId = 18, name = "url",
		description = "logical url of the jpeg image",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 19, name = "Raw_Amp_Exposure",
	description = "Table to store per-exposure information for every Amplifier.&#xA;&#xA;tai+texp also added to this table, because there might be difference in the way focal plane is illuminated (finite shutter speed) leading to differences in exposure time between CCDs.&#xA;&#xA;ISSUE: binX, binY, sizeX, sizeY can be dropped if we know for sure we never going to use pixel binning in LSST (confirm).";

	INSERT INTO md_Column
	SET id = 410, tableId = 19, name = "ampExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 411, tableId = 19, name = "amplifierId",
		description = "Pointer to Amplifier table - this identifies which amplifier this AmpExposure corresponds to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 412, tableId = 19, name = "ccdExposureId",
		description = "Pointer to CCDExposure that contains this AmpExposure",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 413, tableId = 19, name = "procHistoryId",
		description = "Pointer to an entry in ProcessingHistory table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 414, tableId = 19, name = "binX",
		description = "binning in X-coordinate",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 415, tableId = 19, name = "binY",
		description = "binning in Y-coordinate",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 416, tableId = 19, name = "sizeX",
		description = "Size of the image in X-direction (along rows; binned pixels). Ignores overscan but includes regions that may be considered outside of the data portion of the image.",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 417, tableId = 19, name = "sizeY",
		description = "Size of the image in Y-direction (along columns; binned pixels). Ignores overscan but includes regions that may be considered outside of the data portion of the image.",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 418, tableId = 19, name = "taiObs",
		description = "time of shutter open (international atomic time)",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 419, tableId = 19, name = "expTime",
		description = "Exposure time for this particular Amplifier. We are not certain yet that exposure times will be identical for all Amplifiers [FIXME] ",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 420, tableId = 19, name = "bias",
		description = "Bias level for the calibrated image (ADUs).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 421, tableId = 19, name = "gain",
		description = "Gain value for the amplifier (e/ADU).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 422, tableId = 19, name = "rdNoise",
		description = "Read noise value for this AmpExposure (measured in electrons).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 423, tableId = 19, name = "telAngle",
		description = "Orientation angle of the telescope w.r.t sky (degrees).  Note: This is different from camera orientation w.r.t sky (encapsulated in WCS), since telescope is on alt-az mount.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 424, tableId = 19, name = "az",
		description = "Azimuth of observation (deg), preferably at center of exposure at center of image and including refraction correction, but none of this is guaranteed",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 425, tableId = 19, name = "altitude",
		description = "Altitude of observation (deg), preferably at center of observation at center of image and including refraction correction, but none of this is guaranteed",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 426, tableId = 19, name = "flag",
		description = "Flags to indicate a problem/special condition with the AmpExposure (e.g. hardware, weather, etc)",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 427, tableId = 19, name = "zpt",
		description = "Photometric zero point magnitude.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 428, tableId = 19, name = "zptErr",
		description = "Error of zero point magnitude.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 429, tableId = 19, name = "sky",
		description = "The average sky level in the frame (ADU).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 430, tableId = 19, name = "skySig",
		description = "Sigma of distribution of sky values",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET id = 431, tableId = 19, name = "skyErr",
		description = "Error of the average sky value",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET id = 432, tableId = 19, name = "psf_nstar",
		description = "Number of stars used for PSF measurement",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET id = 433, tableId = 19, name = "psf_apcorr",
		description = "Photometric error due to imperfect PSF model (aperture correction)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET id = 434, tableId = 19, name = "psf_sigma1",
		description = "Inner Gaussian sigma for the composite fit (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET id = 435, tableId = 19, name = "psf_sigma2",
		description = "Outer Gaussian sigma for the composite fit (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET id = 436, tableId = 19, name = "psf_b",
		description = "Ratio of inner PSF to outer PSF (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET id = 437, tableId = 19, name = "psf_b_2G",
		description = "Ratio of Gaussian 2 to Gaussian 1 at origin (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET id = 438, tableId = 19, name = "psf_p0",
		description = "The value of the power law at the origin (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET id = 439, tableId = 19, name = "psf_beta",
		description = "The slope of the power law (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET id = 440, tableId = 19, name = "psf_sigmap",
		description = "Width parameter for the power law (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET id = 441, tableId = 19, name = "psf_nprof",
		description = "Number of profile bins (XXX?)",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET id = 442, tableId = 19, name = "psf_fwhm",
		description = "Effective PSF width.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 33;

	INSERT INTO md_Column
	SET id = 443, tableId = 19, name = "psf_sigma_x",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET id = 444, tableId = 19, name = "psf_sigma_y",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 35;

	INSERT INTO md_Column
	SET id = 445, tableId = 19, name = "psf_posAngle",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 36;

	INSERT INTO md_Column
	SET id = 446, tableId = 19, name = "psf_peak",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET id = 447, tableId = 19, name = "psf_x0",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET id = 448, tableId = 19, name = "psf_x1",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 39;

	INSERT INTO md_Column
	SET id = 449, tableId = 19, name = "radesys",
		description = "Type of WCS used. Obsolete in ICRS",
		type = "VARCHAR(5)",
		notNull = 0,
		displayOrder = 40;

	INSERT INTO md_Column
	SET id = 450, tableId = 19, name = "equinox",
		description = "Equinox of the WCS. Obsolete in ICRS",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 41;

	INSERT INTO md_Column
	SET id = 451, tableId = 19, name = "ctype1",
		description = "Coordinate type (axis 1). Obsolete in ICRS",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 42;

	INSERT INTO md_Column
	SET id = 452, tableId = 19, name = "ctype2",
		description = "Coordinate type (axis 2). Obsolete in ICRS",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 43;

	INSERT INTO md_Column
	SET id = 453, tableId = 19, name = "cunit1",
		description = "X axis units",
		type = "VARCHAR(10)",
		notNull = 0,
		displayOrder = 44;

	INSERT INTO md_Column
	SET id = 454, tableId = 19, name = "cunit2",
		description = "Y axis units",
		type = "VARCHAR(10)",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET id = 455, tableId = 19, name = "crpix1",
		description = "Pixel X-coordinate for reference pixel",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 46;

	INSERT INTO md_Column
	SET id = 456, tableId = 19, name = "crpix2",
		description = "Pixel Y-coordinate for reference pixel",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 47;

	INSERT INTO md_Column
	SET id = 457, tableId = 19, name = "crval1",
		description = "Sky coordinate (longitude) for reference pixel (degrees)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 48;

	INSERT INTO md_Column
	SET id = 458, tableId = 19, name = "crval2",
		description = "Sky coordinate (latitude) for reference pixel (degrees)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 49;

	INSERT INTO md_Column
	SET id = 459, tableId = 19, name = "cd11",
		description = "WCS transformation matrix element (_11)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 50;

	INSERT INTO md_Column
	SET id = 460, tableId = 19, name = "cd12",
		description = "WCS transformation matrix element (_12)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 51;

	INSERT INTO md_Column
	SET id = 461, tableId = 19, name = "cd21",
		description = "WCS transformation matrix element (_21)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 52;

	INSERT INTO md_Column
	SET id = 462, tableId = 19, name = "cd22",
		description = "WCS transformation matrix element (_22)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 53;

	INSERT INTO md_Column
	SET id = 463, tableId = 19, name = "cdelt1",
		description = "Obsolete by cd_xx terms?",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET id = 464, tableId = 19, name = "cdelt2",
		description = "Obsolete by cd_xx terms?",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 55;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 20, name = "Raw_CCD_Exposure";

	INSERT INTO md_Column
	SET id = 465, tableId = 20, name = "ccdExposureId",
		description = "Unique id",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 466, tableId = 20, name = "exposureId",
		description = "Pointer to the Exposure that this CCDExposure belongs to",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 467, tableId = 20, name = "procHistoryId",
		description = "Pointer to ProcessingHistory. Valid if all pieces processed with the same processing history (all AmpExposures). If different processing histories used, then NULL",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 468, tableId = 20, name = "refExposureId",
		description = "See the descripton of c0 below.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 469, tableId = 20, name = "filterId",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 470, tableId = 20, name = "visitId",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 471, tableId = 20, name = "ra",
		description = "Right Ascension of aperture center.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 472, tableId = 20, name = "decl",
		description = "Declination of aperture center.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 473, tableId = 20, name = "equinox",
		description = "Equinox of World Coordinate System.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 474, tableId = 20, name = "url",
		description = "Logical URL to the corresponding image file.",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 475, tableId = 20, name = "ctype1",
		description = "Coordinate projection type, axis 1.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 476, tableId = 20, name = "ctype2",
		description = "Coordinate projection type, axis 2.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 477, tableId = 20, name = "crpix1",
		description = "Coordinate reference pixel, axis 1.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 478, tableId = 20, name = "crpix2",
		description = "Coordinate reference pixel, axis 2.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 479, tableId = 20, name = "crval1",
		description = "Coordinate value 1 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 480, tableId = 20, name = "crval2",
		description = "Coordinate value 2 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 481, tableId = 20, name = "cd11",
		description = "First derivative of coordinate 1 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 482, tableId = 20, name = "cd21",
		description = "First derivative of coordinate 2 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 483, tableId = 20, name = "cd12",
		description = "First derivative of coordinate 1 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 484, tableId = 20, name = "cd22",
		description = "First derivative of coordinate 2 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 485, tableId = 20, name = "dateObs",
		description = "Date/Time of observation start (UTC).",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 21;

	INSERT INTO md_Column
	SET id = 486, tableId = 20, name = "taiObs",
		description = "TAI-OBS = UTC + offset. Offset = 32 s from  1/1/1999 to 1/1/2006, = 33 s after 1/1/2006.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET id = 487, tableId = 20, name = "mjdObs",
		description = "MJD of observation start.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET id = 488, tableId = 20, name = "expTime",
		description = "Duration of exposure.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 24;

	INSERT INTO md_Column
	SET id = 489, tableId = 20, name = "darkTime",
		description = "Total elapsed time from exposure start to end of read.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET id = 490, tableId = 20, name = "zd",
		description = "Zenith distance at observation mid-point.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 26;

	INSERT INTO md_Column
	SET id = 491, tableId = 20, name = "airmass",
		description = "Airmass value for the Amp reference pixel (preferably center, but not guaranteed).",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET id = 492, tableId = 20, name = "kNonGray",
		description = "The value of the non-gray extinction.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 28;

	INSERT INTO md_Column
	SET id = 493, tableId = 20, name = "c0",
		description = "One of the coefficients that specify a second order spatial polynomial surface defined over the pixels of an Exposure. The coefficients c0, cx1, ..., cxy multiply orthogonal polynomials of order 0, 1, and 2 in x and y, and order 1 in x*y. The orthogonality is defined over the set of x, y, and x*y for the set of DIASources in the Exposure that match through the Object table to a DIASource in the Exposure given by refExposureId ",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 29;

	INSERT INTO md_Column
	SET id = 494, tableId = 20, name = "c0Err",
		description = "Uncertainty of c0 coefficient.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 30;

	INSERT INTO md_Column
	SET id = 495, tableId = 20, name = "cx1",
		description = "See the descripton of c0.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 31;

	INSERT INTO md_Column
	SET id = 496, tableId = 20, name = "cx1Err",
		description = "Uncertainty of cx1 coefficient.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 32;

	INSERT INTO md_Column
	SET id = 497, tableId = 20, name = "cx2",
		description = "See the descripton of c0.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 33;

	INSERT INTO md_Column
	SET id = 498, tableId = 20, name = "cx2Err",
		description = "Uncertainty of cx2 coefficient.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 34;

	INSERT INTO md_Column
	SET id = 499, tableId = 20, name = "cy1",
		description = "See the descripton of c0.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 35;

	INSERT INTO md_Column
	SET id = 500, tableId = 20, name = "cy1Err",
		description = "Uncertainty of cy1 coefficient.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 36;

	INSERT INTO md_Column
	SET id = 501, tableId = 20, name = "cy2",
		description = "See the descripton of c0.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 37;

	INSERT INTO md_Column
	SET id = 502, tableId = 20, name = "cy2Err",
		description = "Uncertainty of cy2 coefficient.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 38;

	INSERT INTO md_Column
	SET id = 503, tableId = 20, name = "cxy",
		description = "See the descripton of c0.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 39;

	INSERT INTO md_Column
	SET id = 504, tableId = 20, name = "cxyErr",
		description = "Uncertainty of cxy coefficient.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 40;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 21, name = "Raw_FPA_Exposure",
	engine = "MyISAM",
	description = "Table to store information about raw image metadata for the entire Focal Plane Assembly. Contains information from FITS header.&#xA;&#xA;ISSUE: For such a large FOV, do we expect amp-to-amp differences in texp, because shutter moves with finite speed?  If yes, texp and potentially mjd, etc should be moved further down the image hierarchy.&#xA;&#xA;ISSUE: To take previous issue even further: do we expect differences in integration time source-to-source, depending on their focal plane position?";

	INSERT INTO md_Column
	SET id = 505, tableId = 21, name = "exposureId",
		description = "Unique id of an exposure. At most, there will be roughly 10^7 entries in this table: (3000 per night X 300 nights X 10 years).",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 506, tableId = 21, name = "filterId",
		description = "Pointer to Filter table - filter used when this exposure was taken.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 507, tableId = 21, name = "procHistoryId",
		description = "Pointer to ProcessingHistory. Valid if all pieces processed with the same processing history (all AmpExposures and all CCDExposures). If different processing histories used, then NULL",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 508, tableId = 21, name = "ra",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 509, tableId = 21, name = "decl",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 510, tableId = 21, name = "obsDate",
		description = "When image was taken (observation start). Note: datetime type does not have fractional seconds!",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 511, tableId = 21, name = "tai",
		description = "time of shutter open (observation start), international atomic time.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 512, tableId = 21, name = "taiDark",
		description = "time of shutter closed (during the exposure, if there was such an occasion; eg due to clowds. See Kem). International atomic time. There also could be a situation when the shutter was closed and reopened multiple times during the exposure. In this case, a more complicated data structure is needed?",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 513, tableId = 21, name = "azimuth",
		description = "[in degrees]",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 514, tableId = 21, name = "altitude",
		description = "[in degrees]",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 515, tableId = 21, name = "temperature",
		description = "[in Celsius]",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 516, tableId = 21, name = "texp",
		description = "Exposure time (total length of integration), sec.&#xA;",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 517, tableId = 21, name = "flag",
		description = "Flag to indicate a problem/special condition with the image (e.g. hardware, weather, etc).",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 518, tableId = 21, name = "ra_ll",
		description = "ra for the low-left corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 519, tableId = 21, name = "dec_ll",
		description = "del for the low-left corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 520, tableId = 21, name = "ra_lr",
		description = "ra for the low-right corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 521, tableId = 21, name = "dec_lr",
		description = "dec for the low-right corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 522, tableId = 21, name = "ra_ul",
		description = "ra for the upper-left corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 523, tableId = 21, name = "dec_ul",
		description = "dec for the upper-left corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 524, tableId = 21, name = "ra_ur",
		description = "ra for the upper-right corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 525, tableId = 21, name = "dec_ur",
		description = "dec for the upper-right corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 21;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 22, name = "Science_Amp_Exposure";

	INSERT INTO md_Column
	SET id = 526, tableId = 22, name = "ampExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 527, tableId = 22, name = "ccdExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 528, tableId = 22, name = "sdqa_imageStatusId",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 23, name = "Science_CCD_Exposure";

	INSERT INTO md_Column
	SET id = 529, tableId = 23, name = "ccdExposureId",
		description = "Pointer to raw exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 530, tableId = 23, name = "exposureId",
		description = "Pointer to Exposure table. This also identifies Calibration_FPA_Exposure used to calibrated this exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 531, tableId = 23, name = "sceId",
		description = "Pointer to science calibrated exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 532, tableId = 23, name = "filterId",
		description = "Pointer to filter.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 533, tableId = 23, name = "equinox",
		description = "Equinox of World Coordinate System.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 534, tableId = 23, name = "url",
		description = "Logical URL to the actual calibrated image.",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 535, tableId = 23, name = "ctype1",
		description = "Coordinate projection type, axis 1.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 536, tableId = 23, name = "ctype2",
		description = "Coordinate projection type, axis 2.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 537, tableId = 23, name = "crpix1",
		description = "Coordinate reference pixel, axis 1.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 538, tableId = 23, name = "crpix2",
		description = "Coordinate reference pixel, axis 2.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 539, tableId = 23, name = "crval1",
		description = "Coordinate value 1 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 540, tableId = 23, name = "crval2",
		description = "Coordinate value 2 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 541, tableId = 23, name = "cd1_1",
		description = "First derivative of coordinate 1 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 542, tableId = 23, name = "cd2_1",
		description = "First derivative of coordinate 2 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 543, tableId = 23, name = "cd1_2",
		description = "First derivative of coordinate 1 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 544, tableId = 23, name = "cd2_2",
		description = "First derivative of coordinate 2 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 545, tableId = 23, name = "dateObs",
		description = "Date/Time of observation start (UTC).",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 546, tableId = 23, name = "expTime",
		description = "Duration of exposure.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 547, tableId = 23, name = "photoFlam",
		description = "Inverse sensitivity.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 548, tableId = 23, name = "photoZP",
		description = "System photometric zero-point.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 549, tableId = 23, name = "nCombine",
		description = "Number of images co-added to create a deeper image",
		type = "INTEGER",
		notNull = 1,
		defaultValue = "1",
		displayOrder = 21;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 24, name = "Science_FPA_Exposure",
	description = "Image metadata for the science calibrated exposure";

	INSERT INTO md_Column
	SET id = 550, tableId = 24, name = "cseId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 551, tableId = 24, name = "exposureId",
		description = "Pointer to Exposure table. This also identifies Calibration_FPA_Exposure used to calibrated this exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 552, tableId = 24, name = "subtractedExposureId",
		description = "Pointer to an entry in the Exposure table - a subtracted exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 553, tableId = 24, name = "varianceExposureId",
		description = "Pointer to an entry in the Exposure table - a variance exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 554, tableId = 24, name = "cseGroupId",
		description = "Pointer to ScienceFPAExposure_Group table. There will be many ScienceFPAExposure entries with the same set of values, so it makes sense to normalize this and store as one entry in a separate table.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 25, name = "Source",
	engine = "MyISAM",
	description = "Table to store all sources from static (not DIA) photometry pipelines.";

	INSERT INTO md_Column
	SET id = 555, tableId = 25, name = "sourceId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 556, tableId = 25, name = "ampExposureId",
		description = "Pointer to Amplifier where source was measured.&#xA;If the Source belongs to multiple AmpExposures, then table Source2AmpExposure is used, and this pointer is NULL",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 557, tableId = 25, name = "filterId",
		description = "Pointer to an entry in Filter table: filter used to take Exposure where this Source (or these Sources) were measured.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 558, tableId = 25, name = "objectId",
		description = "Pointer to Object table. Might be NULL (each Source will point to either MovingObject or Object)",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 559, tableId = 25, name = "movingObjectId",
		description = "Pointer to MovingObject table. Might be NULL (each Source will point to either MovingObject or Object)",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 560, tableId = 25, name = "procHistoryId",
		description = "Pointer to an entry in ProcessingHistory table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 561, tableId = 25, name = "ra",
		description = "RA-coordinate of the source centroid (degrees). Need to support accuracy ~0.0001 arcsec",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 562, tableId = 25, name = "decl",
		description = "Dec coordinate of the source centroid (degrees). Need to support accuracy ~0.0001 arcsec",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 563, tableId = 25, name = "raErr4wcs",
		description = "Error in centroid RA coordinate (miliarcsec) coming from WCS Stage.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 564, tableId = 25, name = "decErr4wcs",
		description = "Error in centroid Dec coordinate (miliarcsec) coming from WCS Stage.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 565, tableId = 25, name = "raErr4detection",
		description = "Error in centroid RA coordinate (miliarcsec) coming from Detection Pipeline [FIXME, maybe use Stage name here?].",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 566, tableId = 25, name = "decErr4detection",
		description = "Error in centroid Dec coordinate (miliarcsec) coming from Detection Pipeline [FIXME, maybe use Stage name here?].",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 567, tableId = 25, name = "xFlux",
		description = "The flux weighted position for x, calculated from the first moment of the pixel values within the footprint",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 568, tableId = 25, name = "xFluxErr",
		description = "Uncertainty of the xFlux.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 569, tableId = 25, name = "yFlux",
		description = "The flux weighted position for y, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 570, tableId = 25, name = "yFluxErr",
		description = "Uncertainty for yFlux.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 571, tableId = 25, name = "raFlux",
		description = "The flux weighted position for ra, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 572, tableId = 25, name = "raFluxErr",
		description = "Uncertainty for raFlux",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 573, tableId = 25, name = "declFlux",
		description = "The flux weighted position for decl, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 574, tableId = 25, name = "declFluxErr",
		description = "Uncertainty for declFlux",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 575, tableId = 25, name = "xPeak",
		description = "The position of the pixel (x) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET id = 576, tableId = 25, name = "yPeak",
		description = "The position of the pixel (y) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET id = 577, tableId = 25, name = "raPeak",
		description = "The position of the pixel (ra) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET id = 578, tableId = 25, name = "declPeak",
		description = "The position of the pixel (decl) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET id = 579, tableId = 25, name = "xAstrom",
		description = "The position (x) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET id = 580, tableId = 25, name = "xAstromErr",
		description = "Uncertainty for xAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET id = 581, tableId = 25, name = "yAstrom",
		description = "The position (y) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET id = 582, tableId = 25, name = "yAstromErr",
		description = "Uncertainty for yAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET id = 583, tableId = 25, name = "raAstrom",
		description = "The position (ra) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET id = 584, tableId = 25, name = "raAstromErr",
		description = "Uncertainty for raAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET id = 585, tableId = 25, name = "declAstrom",
		description = "The position (decl) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET id = 586, tableId = 25, name = "declAstromErr",
		description = "Uncertainty for declAstrom",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET id = 587, tableId = 25, name = "taiMidPoint",
		description = "If a DIASource corresponds to a single exposure, taiMidPoint represents tai time of the middle of exposure. For multiple exposures, this is middle of beginning-of-first-exposure to end-of-last-exposure",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 33;

	INSERT INTO md_Column
	SET id = 588, tableId = 25, name = "taiRange",
		description = "If a DIASource corresponds to a single exposure, taiRange equals to exposure length. If DIASoure corresponds to multiple exposures, it taiRange equals to end-of-last-exposure minus beginning-of-first-exposure",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET id = 589, tableId = 25, name = "fwhmA",
		description = "Size of the object along major axis (pixels).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 35;

	INSERT INTO md_Column
	SET id = 590, tableId = 25, name = "fwhmB",
		description = "Size of the object along minor axis (pixels).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 36;

	INSERT INTO md_Column
	SET id = 591, tableId = 25, name = "fwhmTheta",
		description = "Position angle of the major axis w.r.t. X-axis (measured in degrees).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 37;

	INSERT INTO md_Column
	SET id = 592, tableId = 25, name = "psfMag",
		description = "PSF magnitude of the object",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 38;

	INSERT INTO md_Column
	SET id = 593, tableId = 25, name = "psfMagErr",
		description = "Uncertainty of PSF magnitude",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 39;

	INSERT INTO md_Column
	SET id = 594, tableId = 25, name = "apMag",
		description = "Aperture magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 40;

	INSERT INTO md_Column
	SET id = 595, tableId = 25, name = "apMagErr",
		description = "Uncertainty of aperture magnitude",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 41;

	INSERT INTO md_Column
	SET id = 596, tableId = 25, name = "modelMag",
		description = "model magnitude (adaptive 2D gauss)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 42;

	INSERT INTO md_Column
	SET id = 597, tableId = 25, name = "modelMagErr",
		description = "Uncertainly of model magnitude.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 43;

	INSERT INTO md_Column
	SET id = 598, tableId = 25, name = "petroMag",
		description = "Petrosian flux",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 44;

	INSERT INTO md_Column
	SET id = 599, tableId = 25, name = "petroMagErr",
		description = "Petrosian flux error",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET id = 600, tableId = 25, name = "apDia",
		description = "Diameter of aperture (pixels)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET id = 601, tableId = 25, name = "snr",
		description = "Signal-to-Noise Ratio for the PSF optimal filter.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 47;

	INSERT INTO md_Column
	SET id = 602, tableId = 25, name = "chi2",
		description = "Chi-square value for the PSF fit",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 48;

	INSERT INTO md_Column
	SET id = 603, tableId = 25, name = "sky",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET id = 604, tableId = 25, name = "skyErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET id = 605, tableId = 25, name = "flag4association",
		description = "FIXME: likely we should use a Stage name here",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 51;

	INSERT INTO md_Column
	SET id = 606, tableId = 25, name = "flag4detection",
		description = "FIXME: likely we should use a Stage name here",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET id = 607, tableId = 25, name = "flag4wcs",
		description = "Problem/special conditions indicator (Kem noted that these flags could include delta_sky, delta_PSF, ...).&#xA;FIXME: likely we should use a Stage name here",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 53;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 26, name = "SourceClassif",
	description = "Table keeping information about source classification.";

	INSERT INTO md_Column
	SET id = 608, tableId = 26, name = "scId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 27, name = "SourceClassifAttr",
	description = "Entries stored in this table are used to construct the Source Classification table (columns). Examples: &quot;Cosmin Ray&quot;, &quot;Negative Excursion&quot;, &quot;Positive Excursion&quot;, &quot;Fast Mover&quot;, &quot;Flash&quot;.";

	INSERT INTO md_Column
	SET id = 609, tableId = 27, name = "scAttrId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 610, tableId = 27, name = "scAttrDescr",
		description = "Attribute description.",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 28, name = "SourceClassifDescr",
	description = "Entries stored in this table are used to construct the Source Classification table (rows). Examples: &quot;present in both visits&quot;, &quot;shape differs in two visits&quot;, elliptical after PSF deconvolve&quot;,  &quot;positive flux excursion&quot;.";

	INSERT INTO md_Column
	SET id = 611, tableId = 28, name = "scDescrId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 612, tableId = 28, name = "scDescr",
		description = "description",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 29, name = "TemplateImage",
	description = "Table that defines which template images";

	INSERT INTO md_Column
	SET id = 613, tableId = 29, name = "templateImageId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 30, name = "Visit",
	description = "Defines a single Visit. 1 row per LSST visit.";

	INSERT INTO md_Column
	SET id = 614, tableId = 30, name = "visitId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 615, tableId = 30, name = "exposureId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 31, name = "_Alert2Type";

	INSERT INTO md_Column
	SET id = 616, tableId = 31, name = "alertTypeId",
		description = "Pointer to AlertType",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 617, tableId = 31, name = "alertId",
		description = "Pointer to Alert",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 32, name = "_DIASource2Alert",
	description = "Mapping: DIASource --&gt; alerts generated by the object";

	INSERT INTO md_Column
	SET id = 618, tableId = 32, name = "alertId",
		description = "Pointer to an entry in Alert table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 619, tableId = 32, name = "diaSourceId",
		description = "Pointer to an entry in DIASource table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 33, name = "_FPA_Bias2CMExposure",
	description = "Mapping table. Keeps information which BiasExposures are part of CalibratedMasterBiasExposure.";

	INSERT INTO md_Column
	SET id = 620, tableId = 33, name = "biasExposureId",
		description = "Pointer to BiasExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 621, tableId = 33, name = "cmBiasExposureId",
		description = "Pointer to CMBiasExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 34, name = "_FPA_Dark2CMExposure",
	description = "Mapping table. Keeps information which DarkExposures are part of CalibratedMasterDarkExposure, and which BiasExposures were used to generate the CalibratedMasterDarkExposures.";

	INSERT INTO md_Column
	SET id = 622, tableId = 34, name = "darkExposureId",
		description = "Pointer to DarkExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 623, tableId = 34, name = "biasExposureId",
		description = "Pointer to BiasExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 624, tableId = 34, name = "cmDarkExposureId",
		description = "Pointer to CMDarkExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 35, name = "_FPA_Flat2CMExposure",
	description = "Mapping table. Keeps information which FlatExposures are part of CalibratedMasterFlatExposure, and which BiasExposures &amp; Dark Exposures were used to generate the CalibratedMasterFlatExposures.";

	INSERT INTO md_Column
	SET id = 625, tableId = 35, name = "flatExposureId",
		description = "Pointer to FlatExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 626, tableId = 35, name = "biasExposureId",
		description = "Pointer to BiasExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 627, tableId = 35, name = "darkExposureId",
		description = "Pointer to DarkExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 628, tableId = 35, name = "cmFlatExposureId",
		description = "Pointer to CMFlatExposure table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 36, name = "_FPA_Fringe2CMExposure",
	description = "Mapping table. Keeps information which FlatExposures are part of CalibratedMasterFringeExposure, and which BiasExposures &amp; Dark Exposures were used to generate the CalibratedMasterFringeExposures.";

	INSERT INTO md_Column
	SET id = 629, tableId = 36, name = "biasExposureId",
		description = "Pointer to BiasExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 630, tableId = 36, name = "darkExposureId",
		description = "Pointer to DarkExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 631, tableId = 36, name = "flatExposureId",
		description = "Pointer to FlatExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 632, tableId = 36, name = "cmFringeExposureId",
		description = "Pointer to CMFringeExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 37, name = "_MovingObject2Type",
	description = "Mapping: moving object --&gt; types, with probabilities";

	INSERT INTO md_Column
	SET id = 633, tableId = 37, name = "movingObjectId",
		description = "Pointer to entry in MovingObject table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 634, tableId = 37, name = "typeId",
		description = "Pointer to entry in ObjectType table",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 635, tableId = 37, name = "probability",
		description = "Probability that given MovingObject is of given type. Range: 0-100 (in%)",
		type = "TINYINT",
		notNull = 0,
		defaultValue = "100",
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 38, name = "_Object2Type",
	description = "Mapping Object --&gt; types, with probabilities";

	INSERT INTO md_Column
	SET id = 636, tableId = 38, name = "objectId",
		description = "Pointer to an entry in Object table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 637, tableId = 38, name = "typeId",
		description = "Pointer to an entry in ObjectType table",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 638, tableId = 38, name = "probability",
		description = "Probability that given object is of given type. Range 0-100 %",
		type = "TINYINT",
		notNull = 0,
		defaultValue = "100",
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 39, name = "_Science_FPA_Exposure2TemplateImage",
	description = "Mapping table: exposures used to build given template image";

	INSERT INTO md_Column
	SET id = 639, tableId = 39, name = "exposureId",
		description = "Pointer to an entry in Exposure table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 640, tableId = 39, name = "templateImageId",
		description = "Pointer to an entry in TemplateImage table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 40, name = "_Science_FPA_Exposure_Group",
	description = "Foreign key constraint";

	INSERT INTO md_Column
	SET id = 641, tableId = 40, name = "cseGroupId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 642, tableId = 40, name = "darkTime",
		description = "Timestamp when corresponding CMDarkExposure was processed.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 643, tableId = 40, name = "biasTime",
		description = "Timestamp when corresponding CMBiasExposure was processed.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 644, tableId = 40, name = "u_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For u filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 645, tableId = 40, name = "g_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For g filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 646, tableId = 40, name = "r_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For r filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 647, tableId = 40, name = "i_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For i filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 648, tableId = 40, name = "z_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For z filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 649, tableId = 40, name = "y_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For y filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 650, tableId = 40, name = "u_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For u filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 651, tableId = 40, name = "g_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For g filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 652, tableId = 40, name = "r_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For r filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 653, tableId = 40, name = "i_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For i filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 654, tableId = 40, name = "z_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For z filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 655, tableId = 40, name = "y_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For y filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 656, tableId = 40, name = "cmBiasExposureId",
		description = "Pointer to CalibratedMasterBiasExposure.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 657, tableId = 40, name = "cmDarkExposureId",
		description = "Pointer to CalibratedMasterDarkExposure.&#xA;",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 658, tableId = 40, name = "u_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for u filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 659, tableId = 40, name = "g_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for g filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 660, tableId = 40, name = "r_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for r filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 661, tableId = 40, name = "i_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for i filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET id = 662, tableId = 40, name = "z_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for z filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET id = 663, tableId = 40, name = "y_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for y filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET id = 664, tableId = 40, name = "u_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for u filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET id = 665, tableId = 40, name = "g_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for g filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET id = 666, tableId = 40, name = "r_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for r filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET id = 667, tableId = 40, name = "i_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for i filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET id = 668, tableId = 40, name = "z_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for z filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET id = 669, tableId = 40, name = "y_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for y filter.&#xA;",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 29;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 41, name = "_Source2Amp_Exposure",
	description = "Source --&gt; AmpExposures";

	INSERT INTO md_Column
	SET id = 670, tableId = 41, name = "sourceId",
		description = "Pointer to entry in Source table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 671, tableId = 41, name = "ampExposureId",
		description = "Pointer to enty in AmpExposure table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 42, name = "_Source2Object",
	description = "Table used to store mapping Source --&gt; Object for sources that belong to more than one object (Objects that &quot;split&quot;). If a source corresponds to only one object, objectId is used. See http://lsstdev.ncsa.uiuc.edu:8100/trac/wiki/dbObjectSplits for further details.";

	INSERT INTO md_Column
	SET id = 672, tableId = 42, name = "objectId",
		description = "Id of the object - pointer to a row in the Object table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 673, tableId = 42, name = "sourceId",
		description = "Id of source - pointer to a row in the Source table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 674, tableId = 42, name = "splitPercentage",
		description = "percentage of the split (all for a given source must add up to 100%",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 43, name = "_SourceClassif2Descr",
	description = "Mapping table: SourceClassif --&gt; (SourceClassifAttr + SourceClassifDescr + value &quot;yes/no&quot;)";

	INSERT INTO md_Column
	SET id = 675, tableId = 43, name = "scId",
		description = "Pointer to an entry in SourceClassification table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 676, tableId = 43, name = "scAttrId",
		description = "Pointer to an entry in SourceClassifAttr table",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 677, tableId = 43, name = "scDescrId",
		description = "Pointer to an entry in SourceClassifDescr table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 678, tableId = 43, name = "status",
		description = "Status: 'yes' / 'no'. Default: 'yes'",
		type = "BIT",
		notNull = 0,
		defaultValue = "1",
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 44, name = "_aux_FPA_Bias2CMExposure";

	INSERT INTO md_Column
	SET id = 679, tableId = 44, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 45, name = "_aux_FPA_Dark2CMExposure";

	INSERT INTO md_Column
	SET id = 680, tableId = 45, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 46, name = "_aux_FPA_Flat2CMExposure";

	INSERT INTO md_Column
	SET id = 681, tableId = 46, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 47, name = "_aux_FPA_Fringe2CMExposure";

	INSERT INTO md_Column
	SET id = 682, tableId = 47, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 48, name = "_aux_Science_FPA_Exposure_Group";

	INSERT INTO md_Column
	SET id = 683, tableId = 48, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 49, name = "_aux_Science_FPA_SpectraExposure_Group";

	INSERT INTO md_Column
	SET id = 684, tableId = 49, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 50, name = "_mops_Config",
	description = "Internal table used to ship runtime configuration data to MOPS worker nodes.&#xA;&#xA;This will eventually be replaced by some other mechanism. Note however that this data must be captured by the LSST software provenance tables.";

	INSERT INTO md_Column
	SET id = 685, tableId = 50, name = "configId",
		description = "Referring derived object",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 686, tableId = 50, name = "configText",
		description = "Config contents",
		type = "TEXT",
		notNull = 0,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 51, name = "_mops_EonQueue",
	description = "Internal table which maintains a queue of objects to be passed to the MOPS precovery pipeline.&#xA;&#xA;Will eventually be replaced by a different queueing mechanism.";

	INSERT INTO md_Column
	SET id = 687, tableId = 51, name = "movingObjectId",
		description = "Referring derived object",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 688, tableId = 51, name = "eventId",
		description = "Referring history event causing insertion",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 689, tableId = 51, name = "insertTime",
		description = "Wall clock time object was queued",
		type = "TIMESTAMP",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 690, tableId = 51, name = "status",
		description = "Processing status N =&amp;gt; new, I =&amp;gt; ID1 done, P =&amp;gt; precov done, X =&amp;gt; finished",
		type = "CHAR(1)",
		notNull = 0,
		defaultValue = "'I'",
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 52, name = "_mops_MoidQueue",
	description = "Internal table which maintain a queue of objects to be passed to the MOPS precovery pipeline.&#xA;&#xA;Will eventually be replaced by a different queueing mechanism.";

	INSERT INTO md_Column
	SET id = 691, tableId = 52, name = "movingObjectId",
		description = "Referring derived object",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 692, tableId = 52, name = "movingObjectVersion",
		description = "version of referring derived object",
		type = "INT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 693, tableId = 52, name = "eventId",
		description = "Referring history event causing insertion",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 694, tableId = 52, name = "insertTime",
		description = "Wall clock time object was queued",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "CURRENT_TIMESTAMP",
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 53, name = "aux_Amp_Exposure";

	INSERT INTO md_Column
	SET id = 695, tableId = 53, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 54, name = "aux_Bias_FPA_CMExposure";

	INSERT INTO md_Column
	SET id = 696, tableId = 54, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 55, name = "aux_Bias_FPA_Exposure";

	INSERT INTO md_Column
	SET id = 697, tableId = 55, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 56, name = "aux_Calibration_FPA_Exposure";

	INSERT INTO md_Column
	SET id = 698, tableId = 56, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 57, name = "aux_CloudMap";

	INSERT INTO md_Column
	SET id = 699, tableId = 57, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 58, name = "aux_Dark_FPA_CMExposure";

	INSERT INTO md_Column
	SET id = 700, tableId = 58, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 59, name = "aux_Dark_FPA_Exposure";

	INSERT INTO md_Column
	SET id = 701, tableId = 59, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 60, name = "aux_FPA_Exposure";

	INSERT INTO md_Column
	SET id = 702, tableId = 60, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 61, name = "aux_Flat_FPA_CMExposure";

	INSERT INTO md_Column
	SET id = 703, tableId = 61, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 62, name = "aux_Flat_FPA_Exposure";

	INSERT INTO md_Column
	SET id = 704, tableId = 62, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 63, name = "aux_Fringe_FPA_CMExposure";

	INSERT INTO md_Column
	SET id = 705, tableId = 63, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 64, name = "aux_IR_FPA_Exposure",
	description = "Kem: &quot;we need an IRexposure table, and probably a CloudMap table (which connects IRexposures to 2-D maps of clouds in a particular exposure.  The IRexposure should link to each ScienceExposure.&quot;";

	INSERT INTO md_Column
	SET id = 706, tableId = 64, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 65, name = "aux_LIDARshot",
	description = "Kem: &quot;There should be a LIDARshot table which has a time, wavelength, altitude, azimuth and two URLs pointing to a 1-D file of delay-time versus intensity and a transparency vs wavelenght file.&quot;";

	INSERT INTO md_Column
	SET id = 707, tableId = 65, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 66, name = "aux_Object";

	INSERT INTO md_Column
	SET id = 708, tableId = 66, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 67, name = "aux_SED",
	description = "Spectral Energy Distribution. Kem: &quot;...SED tables having SEDstdID, altitude, azimuth and an URL to&#xA;transmission vs wavelength&quot;";

	INSERT INTO md_Column
	SET id = 709, tableId = 67, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 68, name = "aux_Science_FPA_Exposure";

	INSERT INTO md_Column
	SET id = 710, tableId = 68, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 69, name = "aux_Science_FPA_SpectraExposure";

	INSERT INTO md_Column
	SET id = 711, tableId = 69, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 70, name = "aux_Source";

	INSERT INTO md_Column
	SET id = 712, tableId = 70, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 71, name = "mops_Event";

	INSERT INTO md_Column
	SET id = 713, tableId = 71, name = "eventId",
		description = "Auto-generated internal event ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 714, tableId = 71, name = "procHistoryId",
		description = "Pointer to processing history (prv_ProcHistory)",
		type = "INT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 715, tableId = 71, name = "eventType",
		description = "Type of event (A)ttribution/(P)recovery/(D)erivation/(I)dentification/(R)emoval",
		type = "CHAR(1)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 716, tableId = 71, name = "eventTime",
		description = "Timestamp for event creation",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "CURRENT_TIMESTAMP",
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 717, tableId = 71, name = "movingObjectId",
		description = "Referring derived object ID",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 718, tableId = 71, name = "movingObjectVersion",
		description = "Pointer to resulting orbit",
		type = "INT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 719, tableId = 71, name = "orbitCode",
		description = "Information about computed orbit",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 720, tableId = 71, name = "d3",
		description = "Computed 3-parameter D-criterion",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 721, tableId = 71, name = "d4",
		description = "Computed 4-parameter D-criterion",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 722, tableId = 71, name = "ccdExposureId",
		description = "Referring to Science CCD exposure ID generating the event",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 723, tableId = 71, name = "classification",
		description = "MOPS efficiency classification for event",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 724, tableId = 71, name = "ssmId",
		description = "Matching SSM ID for clean classifications",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 12;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 72, name = "mops_Event_OrbitDerivation",
	description = "Table for associating tracklets with derivation events. There is a one to many relationship between events and tracklets (there will be multiple rows per event).";

	INSERT INTO md_Column
	SET id = 725, tableId = 72, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 726, tableId = 72, name = "trackletId",
		description = "Associated tracklet ID (multiple rows per event)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 73, name = "mops_Event_OrbitIdentification",
	description = "Table for associating moving objects with identification events (one object per event). The original orbit and tracklets for the child can be obtained from the MOPS_History table by looking up the child object.";

	INSERT INTO md_Column
	SET id = 727, tableId = 73, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 728, tableId = 73, name = "childObjectId",
		description = "Matching (child) derived object ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 74, name = "mops_Event_TrackletAttribution",
	description = "Table for associating tracklets with attribution events (one tracklet per event).";

	INSERT INTO md_Column
	SET id = 729, tableId = 74, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 730, tableId = 74, name = "trackletId",
		description = "Attributed tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 731, tableId = 74, name = "ephemerisDistance",
		description = "Predicted position minus actual, arcsecs",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 732, tableId = 74, name = "ephemerisUncertainty",
		description = "Predicted error ellipse semi-major axis, arcsecs",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 75, name = "mops_Event_TrackletPrecovery",
	description = "Table for associating tracklets with precovery events (one precovery per event).";

	INSERT INTO md_Column
	SET id = 733, tableId = 75, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 734, tableId = 75, name = "trackletId",
		description = "Precovered tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 735, tableId = 75, name = "ephemerisDistance",
		description = "Predicted position minus actual, arcsecs",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 736, tableId = 75, name = "ephemerisUncertainty",
		description = "Predicted error ellipse semi-major axis, arcsecs",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 76, name = "mops_Event_TrackletRemoval",
	description = "Table for associating tracklets with removal events (one removal per event).";

	INSERT INTO md_Column
	SET id = 737, tableId = 76, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 738, tableId = 76, name = "trackletId",
		description = "Removed tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 77, name = "mops_MovingObject2Tracklet",
	description = "Current membership of tracklets and moving objects.";

	INSERT INTO md_Column
	SET id = 739, tableId = 77, name = "movingObjectId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 740, tableId = 77, name = "trackletId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 78, name = "mops_SSM",
	description = "Table that contains synthetic solar system model (SSM) objects.";

	INSERT INTO md_Column
	SET id = 741, tableId = 78, name = "ssmId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 742, tableId = 78, name = "ssmDescId",
		description = "Pointer to SSM description",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 743, tableId = 78, name = "q",
		description = "semi-major axis, AU",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 744, tableId = 78, name = "e",
		description = "eccentricity e (dimensionless)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 745, tableId = 78, name = "i",
		description = "inclination, deg",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 746, tableId = 78, name = "node",
		description = "longitude of ascending node, deg",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 747, tableId = 78, name = "argPeri",
		description = "argument of perihelion, deg",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 748, tableId = 78, name = "timePeri",
		description = "time of perihelion, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 749, tableId = 78, name = "epoch",
		description = "epoch of osculating elements, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 750, tableId = 78, name = "h_v",
		description = "Absolute magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 751, tableId = 78, name = "h_ss",
		description = "??",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 752, tableId = 78, name = "g",
		description = "Slope parameter g, dimensionless",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 753, tableId = 78, name = "albedo",
		description = "Albedo, dimensionless",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 754, tableId = 78, name = "ssmObjectName",
		description = "MOPS synthetic object name",
		type = "VARCHAR(32)",
		notNull = 1,
		displayOrder = 14;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 79, name = "mops_SSMDesc",
	description = "Table containing object name prefixes and descriptions of synthetic solar system object types.";

	INSERT INTO md_Column
	SET id = 755, tableId = 79, name = "ssmDescId",
		description = "Auto-generated row ID",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 756, tableId = 79, name = "prefix",
		description = "MOPS prefix code S0/S1/etc.",
		type = "CHAR(4)",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 757, tableId = 79, name = "description",
		description = "Long description",
		type = "VARCHAR(100)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 80, name = "mops_Tracklet";

	INSERT INTO md_Column
	SET id = 758, tableId = 80, name = "trackletId",
		description = "Auto-generated internal MOPS tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 759, tableId = 80, name = "ccdExposureId",
		description = "Terminating field ID - pointer to Science_CCD_Exposure",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 760, tableId = 80, name = "procHistoryId",
		description = "Pointer to processing history (prv_ProcHistory)",
		type = "INT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 761, tableId = 80, name = "ssmId",
		description = "Matching SSM ID for clean classifications",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 762, tableId = 80, name = "velRa",
		description = "Average RA velocity deg/day, cos(dec) applied",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 763, tableId = 80, name = "velRaErr",
		description = "Uncertainty in RA velocity",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 764, tableId = 80, name = "velDecl",
		description = "Average Dec velocity, deg/day)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 765, tableId = 80, name = "velDeclErr",
		description = "Uncertainty in Dec velocity",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 766, tableId = 80, name = "velTot",
		description = "Average total velocity, deg/day",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 767, tableId = 80, name = "accRa",
		description = "Average RA Acceleration, deg/day^2",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 768, tableId = 80, name = "accRaErr",
		description = "Uncertainty in RA acceleration",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 769, tableId = 80, name = "accDecl",
		description = "Average Dec Acceleration, deg/day^2",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 770, tableId = 80, name = "accDeclErr",
		description = "Uncertainty in Dec acceleration",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 771, tableId = 80, name = "extEpoch",
		description = "Extrapolated (central) epoch, MJD (UTC)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 772, tableId = 80, name = "extRa",
		description = "Extrapolated (central) RA, deg",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 773, tableId = 80, name = "extRaErr",
		description = "Uncertainty in extrapolated RA, deg",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 774, tableId = 80, name = "extDecl",
		description = "Extrapolated (central) Dec, deg",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 775, tableId = 80, name = "extDeclErr",
		description = "Uncertainty in extrapolated Dec, deg",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 776, tableId = 80, name = "extMag",
		description = "Extrapolated (central) magnitude",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 777, tableId = 80, name = "extMagErr",
		description = "Uncertainty in extrapolated mag, deg",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 778, tableId = 80, name = "probability",
		description = "Likelihood tracklet is real (unused currently)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET id = 779, tableId = 80, name = "status",
		description = "processing status (unfound 'X', unattributed 'U', attributed 'A')",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET id = 780, tableId = 80, name = "classification",
		description = "MOPS efficiency classification",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 23;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 81, name = "mops_Tracklets2DIASource",
	description = "Table maintaining many-to-many relationship between tracklets and detections.";

	INSERT INTO md_Column
	SET id = 781, tableId = 81, name = "trackletId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 782, tableId = 81, name = "diaSourceId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 82, name = "placeholder_Alert";

	INSERT INTO md_Column
	SET id = 783, tableId = 82, name = "__voEventId",
		description = "FIXME. Some sort of pointer to voEvent. Placeholder. Also, not sure if type is correct.",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 83, name = "placeholder_Object";

	INSERT INTO md_Column
	SET id = 784, tableId = 83, name = "uScalegram01",
		description = "&quot;Scalegram&quot;: time series as the average of the squares of the wavelet coefficients at a given scale. See Scargel et al 1993 for more details.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 785, tableId = 83, name = "uScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 786, tableId = 83, name = "uScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 787, tableId = 83, name = "uScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 788, tableId = 83, name = "uScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 789, tableId = 83, name = "uScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 790, tableId = 83, name = "uScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 791, tableId = 83, name = "uScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 792, tableId = 83, name = "uScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 793, tableId = 83, name = "uScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 794, tableId = 83, name = "uScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 795, tableId = 83, name = "uScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 796, tableId = 83, name = "uScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 797, tableId = 83, name = "uScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 798, tableId = 83, name = "uScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 799, tableId = 83, name = "uScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 800, tableId = 83, name = "uScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 801, tableId = 83, name = "uScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 802, tableId = 83, name = "uScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 803, tableId = 83, name = "uScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 804, tableId = 83, name = "uScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET id = 805, tableId = 83, name = "uScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET id = 806, tableId = 83, name = "uScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET id = 807, tableId = 83, name = "uScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET id = 808, tableId = 83, name = "uScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET id = 809, tableId = 83, name = "gScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET id = 810, tableId = 83, name = "gScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET id = 811, tableId = 83, name = "gScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET id = 812, tableId = 83, name = "gScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET id = 813, tableId = 83, name = "gScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET id = 814, tableId = 83, name = "gScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET id = 815, tableId = 83, name = "gScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET id = 816, tableId = 83, name = "gScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET id = 817, tableId = 83, name = "gScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET id = 818, tableId = 83, name = "gScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 35;

	INSERT INTO md_Column
	SET id = 819, tableId = 83, name = "gScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 36;

	INSERT INTO md_Column
	SET id = 820, tableId = 83, name = "gScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET id = 821, tableId = 83, name = "gScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET id = 822, tableId = 83, name = "gScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 39;

	INSERT INTO md_Column
	SET id = 823, tableId = 83, name = "gScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 40;

	INSERT INTO md_Column
	SET id = 824, tableId = 83, name = "gScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET id = 825, tableId = 83, name = "gScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 42;

	INSERT INTO md_Column
	SET id = 826, tableId = 83, name = "gScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 43;

	INSERT INTO md_Column
	SET id = 827, tableId = 83, name = "gScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 44;

	INSERT INTO md_Column
	SET id = 828, tableId = 83, name = "gScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET id = 829, tableId = 83, name = "gScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET id = 830, tableId = 83, name = "gScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 47;

	INSERT INTO md_Column
	SET id = 831, tableId = 83, name = "gScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 48;

	INSERT INTO md_Column
	SET id = 832, tableId = 83, name = "gScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET id = 833, tableId = 83, name = "gScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET id = 834, tableId = 83, name = "rScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 51;

	INSERT INTO md_Column
	SET id = 835, tableId = 83, name = "rScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET id = 836, tableId = 83, name = "rScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET id = 837, tableId = 83, name = "rScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET id = 838, tableId = 83, name = "rScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET id = 839, tableId = 83, name = "rScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET id = 840, tableId = 83, name = "rScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET id = 841, tableId = 83, name = "rScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET id = 842, tableId = 83, name = "rScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET id = 843, tableId = 83, name = "rScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET id = 844, tableId = 83, name = "rScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET id = 845, tableId = 83, name = "rScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 62;

	INSERT INTO md_Column
	SET id = 846, tableId = 83, name = "rScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 63;

	INSERT INTO md_Column
	SET id = 847, tableId = 83, name = "rScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 64;

	INSERT INTO md_Column
	SET id = 848, tableId = 83, name = "rScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 65;

	INSERT INTO md_Column
	SET id = 849, tableId = 83, name = "rScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET id = 850, tableId = 83, name = "rScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET id = 851, tableId = 83, name = "rScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET id = 852, tableId = 83, name = "rScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET id = 853, tableId = 83, name = "rScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET id = 854, tableId = 83, name = "rScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET id = 855, tableId = 83, name = "rScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 72;

	INSERT INTO md_Column
	SET id = 856, tableId = 83, name = "rScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 73;

	INSERT INTO md_Column
	SET id = 857, tableId = 83, name = "rScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 74;

	INSERT INTO md_Column
	SET id = 858, tableId = 83, name = "rScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 75;

	INSERT INTO md_Column
	SET id = 859, tableId = 83, name = "iScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 76;

	INSERT INTO md_Column
	SET id = 860, tableId = 83, name = "iScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 77;

	INSERT INTO md_Column
	SET id = 861, tableId = 83, name = "iScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 78;

	INSERT INTO md_Column
	SET id = 862, tableId = 83, name = "iScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 79;

	INSERT INTO md_Column
	SET id = 863, tableId = 83, name = "iScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 80;

	INSERT INTO md_Column
	SET id = 864, tableId = 83, name = "iScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 81;

	INSERT INTO md_Column
	SET id = 865, tableId = 83, name = "iScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 82;

	INSERT INTO md_Column
	SET id = 866, tableId = 83, name = "iScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 83;

	INSERT INTO md_Column
	SET id = 867, tableId = 83, name = "iScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 84;

	INSERT INTO md_Column
	SET id = 868, tableId = 83, name = "iScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 85;

	INSERT INTO md_Column
	SET id = 869, tableId = 83, name = "iScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 86;

	INSERT INTO md_Column
	SET id = 870, tableId = 83, name = "iScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 87;

	INSERT INTO md_Column
	SET id = 871, tableId = 83, name = "iScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 88;

	INSERT INTO md_Column
	SET id = 872, tableId = 83, name = "iScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 89;

	INSERT INTO md_Column
	SET id = 873, tableId = 83, name = "iScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 90;

	INSERT INTO md_Column
	SET id = 874, tableId = 83, name = "iScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 91;

	INSERT INTO md_Column
	SET id = 875, tableId = 83, name = "iScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 92;

	INSERT INTO md_Column
	SET id = 876, tableId = 83, name = "iScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 93;

	INSERT INTO md_Column
	SET id = 877, tableId = 83, name = "iScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 94;

	INSERT INTO md_Column
	SET id = 878, tableId = 83, name = "iScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 95;

	INSERT INTO md_Column
	SET id = 879, tableId = 83, name = "iScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 96;

	INSERT INTO md_Column
	SET id = 880, tableId = 83, name = "iScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 97;

	INSERT INTO md_Column
	SET id = 881, tableId = 83, name = "iScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 98;

	INSERT INTO md_Column
	SET id = 882, tableId = 83, name = "iScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 99;

	INSERT INTO md_Column
	SET id = 883, tableId = 83, name = "iScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 100;

	INSERT INTO md_Column
	SET id = 884, tableId = 83, name = "zScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 101;

	INSERT INTO md_Column
	SET id = 885, tableId = 83, name = "zScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 102;

	INSERT INTO md_Column
	SET id = 886, tableId = 83, name = "zScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 103;

	INSERT INTO md_Column
	SET id = 887, tableId = 83, name = "zScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 104;

	INSERT INTO md_Column
	SET id = 888, tableId = 83, name = "zScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 105;

	INSERT INTO md_Column
	SET id = 889, tableId = 83, name = "zScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 106;

	INSERT INTO md_Column
	SET id = 890, tableId = 83, name = "zScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 107;

	INSERT INTO md_Column
	SET id = 891, tableId = 83, name = "zScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 108;

	INSERT INTO md_Column
	SET id = 892, tableId = 83, name = "zScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 109;

	INSERT INTO md_Column
	SET id = 893, tableId = 83, name = "zScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 110;

	INSERT INTO md_Column
	SET id = 894, tableId = 83, name = "zScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 111;

	INSERT INTO md_Column
	SET id = 895, tableId = 83, name = "zScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 112;

	INSERT INTO md_Column
	SET id = 896, tableId = 83, name = "zScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 113;

	INSERT INTO md_Column
	SET id = 897, tableId = 83, name = "zScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 114;

	INSERT INTO md_Column
	SET id = 898, tableId = 83, name = "zScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 115;

	INSERT INTO md_Column
	SET id = 899, tableId = 83, name = "zScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 116;

	INSERT INTO md_Column
	SET id = 900, tableId = 83, name = "zScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 117;

	INSERT INTO md_Column
	SET id = 901, tableId = 83, name = "zScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 118;

	INSERT INTO md_Column
	SET id = 902, tableId = 83, name = "zScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 119;

	INSERT INTO md_Column
	SET id = 903, tableId = 83, name = "zScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 120;

	INSERT INTO md_Column
	SET id = 904, tableId = 83, name = "zScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 121;

	INSERT INTO md_Column
	SET id = 905, tableId = 83, name = "zScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 122;

	INSERT INTO md_Column
	SET id = 906, tableId = 83, name = "zScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 123;

	INSERT INTO md_Column
	SET id = 907, tableId = 83, name = "zScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 124;

	INSERT INTO md_Column
	SET id = 908, tableId = 83, name = "zScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 125;

	INSERT INTO md_Column
	SET id = 909, tableId = 83, name = "yScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 126;

	INSERT INTO md_Column
	SET id = 910, tableId = 83, name = "yScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 127;

	INSERT INTO md_Column
	SET id = 911, tableId = 83, name = "yScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 128;

	INSERT INTO md_Column
	SET id = 912, tableId = 83, name = "yScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 129;

	INSERT INTO md_Column
	SET id = 913, tableId = 83, name = "yScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 130;

	INSERT INTO md_Column
	SET id = 914, tableId = 83, name = "yScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 131;

	INSERT INTO md_Column
	SET id = 915, tableId = 83, name = "yScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 132;

	INSERT INTO md_Column
	SET id = 916, tableId = 83, name = "yScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 133;

	INSERT INTO md_Column
	SET id = 917, tableId = 83, name = "yScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 134;

	INSERT INTO md_Column
	SET id = 918, tableId = 83, name = "yScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 135;

	INSERT INTO md_Column
	SET id = 919, tableId = 83, name = "yScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 136;

	INSERT INTO md_Column
	SET id = 920, tableId = 83, name = "yScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 137;

	INSERT INTO md_Column
	SET id = 921, tableId = 83, name = "yScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 138;

	INSERT INTO md_Column
	SET id = 922, tableId = 83, name = "yScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 139;

	INSERT INTO md_Column
	SET id = 923, tableId = 83, name = "yScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 140;

	INSERT INTO md_Column
	SET id = 924, tableId = 83, name = "yScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 141;

	INSERT INTO md_Column
	SET id = 925, tableId = 83, name = "yScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 142;

	INSERT INTO md_Column
	SET id = 926, tableId = 83, name = "yScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 143;

	INSERT INTO md_Column
	SET id = 927, tableId = 83, name = "yScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 144;

	INSERT INTO md_Column
	SET id = 928, tableId = 83, name = "yScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 145;

	INSERT INTO md_Column
	SET id = 929, tableId = 83, name = "yScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 146;

	INSERT INTO md_Column
	SET id = 930, tableId = 83, name = "yScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 147;

	INSERT INTO md_Column
	SET id = 931, tableId = 83, name = "yScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 148;

	INSERT INTO md_Column
	SET id = 932, tableId = 83, name = "yScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 149;

	INSERT INTO md_Column
	SET id = 933, tableId = 83, name = "yScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 150;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 84, name = "placeholder_ObjectPhotoZ",
	description = "Extension of the Object table for photo-z related information.";

	INSERT INTO md_Column
	SET id = 934, tableId = 84, name = "objectId",
		description = "This is of a corresponding object from the Object table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 935, tableId = 84, name = "redshift",
		description = "Photometric redshift.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 936, tableId = 84, name = "redshiftErr",
		description = "Photometric redshift uncertainty.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 937, tableId = 84, name = "probability",
		description = "Probability that given object has photo-z. 0-100. In %. Default 100%.",
		type = "TINYINT",
		notNull = 1,
		defaultValue = "100",
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 938, tableId = 84, name = "photoZ1",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 939, tableId = 84, name = "photoZ1Err",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 940, tableId = 84, name = "photoZ2",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 941, tableId = 84, name = "photoZ2Err",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 942, tableId = 84, name = "photoZ1Outlier",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 943, tableId = 84, name = "photoZ2Outlier",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 85, name = "placeholder_SQLLog",
	engine = "MyISAM",
	description = "Table to store DB usage statistics. Placeholder.";

	INSERT INTO md_Column
	SET id = 944, tableId = 85, name = "sqlLogId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 945, tableId = 85, name = "tstamp",
		description = "Timestamp when query was issued",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 946, tableId = 85, name = "elapsed",
		description = "Length of the query execution (sec?)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 947, tableId = 85, name = "userId",
		description = "Unique user identifier (among users logged on?)",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 948, tableId = 85, name = "domain",
		description = "Domain name",
		type = "VARCHAR(80)",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 949, tableId = 85, name = "ipaddr",
		description = "IP address where query originated",
		type = "VARCHAR(80)",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 950, tableId = 85, name = "query",
		description = "Query text string (SQL)",
		type = "TEXT",
		notNull = 1,
		displayOrder = 7;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 86, name = "placeholder_Source";

	INSERT INTO md_Column
	SET id = 951, tableId = 86, name = "moment0",
		description = "Sum of all flux of all pixels that belong to a source. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 952, tableId = 86, name = "moment1_x",
		description = "Center of light - x component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 953, tableId = 86, name = "moment1_y",
		description = "Center of light - y component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 954, tableId = 86, name = "moment2_xx",
		description = "Standard deviation about center of light - xx component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 955, tableId = 86, name = "moment2_xy",
		description = "Standard deviation about center of light - xy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 956, tableId = 86, name = "moment2_yy",
		description = "Standard deviation about center of light - yy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 957, tableId = 86, name = "moment3_xxx",
		description = "Skewness of the profile - xxx component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 958, tableId = 86, name = "moment3_xxy",
		description = "Skewness of the profile - xxy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 959, tableId = 86, name = "moment3_xyy",
		description = "Skewness of the profile - xyy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 960, tableId = 86, name = "moment3_yyy",
		description = "Skewness of the profile - yyy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 961, tableId = 86, name = "moment4_xxxx",
		description = "Kurtosis - xxxx component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 962, tableId = 86, name = "moment4_xxxy",
		description = "Kurtosis - xxxy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 963, tableId = 86, name = "moment4_xxyy",
		description = "Kurtosis - xxyy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 964, tableId = 86, name = "moment4_xyyy",
		description = "Kurtosis - xyyy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 965, tableId = 86, name = "moment4_yyyy",
		description = "Kurtosis - yyyy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 15;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 87, name = "placeholder_VarObject",
	description = "Table to store Variable Objects - this will keep a COPY of variable objects. All variable objects will be stored in the Object table. Main reasons to have this table is improving access speed to variable objects.";

	INSERT INTO md_Column
	SET id = 966, tableId = 87, name = "objectId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 967, tableId = 87, name = "ra",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 968, tableId = 87, name = "decl",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 969, tableId = 87, name = "raErr",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 970, tableId = 87, name = "declErr",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 971, tableId = 87, name = "flag4stage1",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 972, tableId = 87, name = "flag4stage2",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 973, tableId = 87, name = "flag4stage3",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 974, tableId = 87, name = "uAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 975, tableId = 87, name = "uPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 976, tableId = 87, name = "uTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 977, tableId = 87, name = "gAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET id = 978, tableId = 87, name = "gPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET id = 979, tableId = 87, name = "gTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET id = 980, tableId = 87, name = "rAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET id = 981, tableId = 87, name = "rPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET id = 982, tableId = 87, name = "rTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET id = 983, tableId = 87, name = "iAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET id = 984, tableId = 87, name = "iPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET id = 985, tableId = 87, name = "iTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET id = 986, tableId = 87, name = "zAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET id = 987, tableId = 87, name = "zPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET id = 988, tableId = 87, name = "zTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET id = 989, tableId = 87, name = "yAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET id = 990, tableId = 87, name = "yPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET id = 991, tableId = 87, name = "yTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET id = 992, tableId = 87, name = "uScalegram01",
		description = "&quot;Scalegram&quot;: time series as the average of the squares of the wavelet coefficients at a given scale. See Scargel et al 1993 for more details.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET id = 993, tableId = 87, name = "uScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET id = 994, tableId = 87, name = "uScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET id = 995, tableId = 87, name = "uScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET id = 996, tableId = 87, name = "uScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET id = 997, tableId = 87, name = "uScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET id = 998, tableId = 87, name = "uScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET id = 999, tableId = 87, name = "uScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET id = 1000, tableId = 87, name = "uScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 35;

	INSERT INTO md_Column
	SET id = 1001, tableId = 87, name = "uScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 36;

	INSERT INTO md_Column
	SET id = 1002, tableId = 87, name = "uScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET id = 1003, tableId = 87, name = "uScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET id = 1004, tableId = 87, name = "uScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 39;

	INSERT INTO md_Column
	SET id = 1005, tableId = 87, name = "uScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 40;

	INSERT INTO md_Column
	SET id = 1006, tableId = 87, name = "uScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET id = 1007, tableId = 87, name = "uScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 42;

	INSERT INTO md_Column
	SET id = 1008, tableId = 87, name = "uScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 43;

	INSERT INTO md_Column
	SET id = 1009, tableId = 87, name = "uScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 44;

	INSERT INTO md_Column
	SET id = 1010, tableId = 87, name = "uScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET id = 1011, tableId = 87, name = "uScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET id = 1012, tableId = 87, name = "uScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 47;

	INSERT INTO md_Column
	SET id = 1013, tableId = 87, name = "uScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 48;

	INSERT INTO md_Column
	SET id = 1014, tableId = 87, name = "uScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET id = 1015, tableId = 87, name = "uScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET id = 1016, tableId = 87, name = "uScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 51;

	INSERT INTO md_Column
	SET id = 1017, tableId = 87, name = "gScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET id = 1018, tableId = 87, name = "gScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET id = 1019, tableId = 87, name = "gScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET id = 1020, tableId = 87, name = "gScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET id = 1021, tableId = 87, name = "gScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET id = 1022, tableId = 87, name = "gScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET id = 1023, tableId = 87, name = "gScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET id = 1024, tableId = 87, name = "gScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET id = 1025, tableId = 87, name = "gScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET id = 1026, tableId = 87, name = "gScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET id = 1027, tableId = 87, name = "gScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 62;

	INSERT INTO md_Column
	SET id = 1028, tableId = 87, name = "gScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 63;

	INSERT INTO md_Column
	SET id = 1029, tableId = 87, name = "gScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 64;

	INSERT INTO md_Column
	SET id = 1030, tableId = 87, name = "gScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 65;

	INSERT INTO md_Column
	SET id = 1031, tableId = 87, name = "gScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET id = 1032, tableId = 87, name = "gScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET id = 1033, tableId = 87, name = "gScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET id = 1034, tableId = 87, name = "gScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET id = 1035, tableId = 87, name = "gScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET id = 1036, tableId = 87, name = "gScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET id = 1037, tableId = 87, name = "gScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 72;

	INSERT INTO md_Column
	SET id = 1038, tableId = 87, name = "gScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 73;

	INSERT INTO md_Column
	SET id = 1039, tableId = 87, name = "gScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 74;

	INSERT INTO md_Column
	SET id = 1040, tableId = 87, name = "gScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 75;

	INSERT INTO md_Column
	SET id = 1041, tableId = 87, name = "gScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 76;

	INSERT INTO md_Column
	SET id = 1042, tableId = 87, name = "rScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 77;

	INSERT INTO md_Column
	SET id = 1043, tableId = 87, name = "rScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 78;

	INSERT INTO md_Column
	SET id = 1044, tableId = 87, name = "rScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 79;

	INSERT INTO md_Column
	SET id = 1045, tableId = 87, name = "rScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 80;

	INSERT INTO md_Column
	SET id = 1046, tableId = 87, name = "rScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 81;

	INSERT INTO md_Column
	SET id = 1047, tableId = 87, name = "rScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 82;

	INSERT INTO md_Column
	SET id = 1048, tableId = 87, name = "rScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 83;

	INSERT INTO md_Column
	SET id = 1049, tableId = 87, name = "rScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 84;

	INSERT INTO md_Column
	SET id = 1050, tableId = 87, name = "rScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 85;

	INSERT INTO md_Column
	SET id = 1051, tableId = 87, name = "rScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 86;

	INSERT INTO md_Column
	SET id = 1052, tableId = 87, name = "rScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 87;

	INSERT INTO md_Column
	SET id = 1053, tableId = 87, name = "rScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 88;

	INSERT INTO md_Column
	SET id = 1054, tableId = 87, name = "rScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 89;

	INSERT INTO md_Column
	SET id = 1055, tableId = 87, name = "rScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 90;

	INSERT INTO md_Column
	SET id = 1056, tableId = 87, name = "rScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 91;

	INSERT INTO md_Column
	SET id = 1057, tableId = 87, name = "rScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 92;

	INSERT INTO md_Column
	SET id = 1058, tableId = 87, name = "rScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 93;

	INSERT INTO md_Column
	SET id = 1059, tableId = 87, name = "rScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 94;

	INSERT INTO md_Column
	SET id = 1060, tableId = 87, name = "rScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 95;

	INSERT INTO md_Column
	SET id = 1061, tableId = 87, name = "rScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 96;

	INSERT INTO md_Column
	SET id = 1062, tableId = 87, name = "rScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 97;

	INSERT INTO md_Column
	SET id = 1063, tableId = 87, name = "rScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 98;

	INSERT INTO md_Column
	SET id = 1064, tableId = 87, name = "rScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 99;

	INSERT INTO md_Column
	SET id = 1065, tableId = 87, name = "rScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 100;

	INSERT INTO md_Column
	SET id = 1066, tableId = 87, name = "rScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 101;

	INSERT INTO md_Column
	SET id = 1067, tableId = 87, name = "iScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 102;

	INSERT INTO md_Column
	SET id = 1068, tableId = 87, name = "iScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 103;

	INSERT INTO md_Column
	SET id = 1069, tableId = 87, name = "iScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 104;

	INSERT INTO md_Column
	SET id = 1070, tableId = 87, name = "iScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 105;

	INSERT INTO md_Column
	SET id = 1071, tableId = 87, name = "iScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 106;

	INSERT INTO md_Column
	SET id = 1072, tableId = 87, name = "iScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 107;

	INSERT INTO md_Column
	SET id = 1073, tableId = 87, name = "iScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 108;

	INSERT INTO md_Column
	SET id = 1074, tableId = 87, name = "iScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 109;

	INSERT INTO md_Column
	SET id = 1075, tableId = 87, name = "iScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 110;

	INSERT INTO md_Column
	SET id = 1076, tableId = 87, name = "iScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 111;

	INSERT INTO md_Column
	SET id = 1077, tableId = 87, name = "iScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 112;

	INSERT INTO md_Column
	SET id = 1078, tableId = 87, name = "iScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 113;

	INSERT INTO md_Column
	SET id = 1079, tableId = 87, name = "iScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 114;

	INSERT INTO md_Column
	SET id = 1080, tableId = 87, name = "iScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 115;

	INSERT INTO md_Column
	SET id = 1081, tableId = 87, name = "iScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 116;

	INSERT INTO md_Column
	SET id = 1082, tableId = 87, name = "iScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 117;

	INSERT INTO md_Column
	SET id = 1083, tableId = 87, name = "iScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 118;

	INSERT INTO md_Column
	SET id = 1084, tableId = 87, name = "iScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 119;

	INSERT INTO md_Column
	SET id = 1085, tableId = 87, name = "iScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 120;

	INSERT INTO md_Column
	SET id = 1086, tableId = 87, name = "iScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 121;

	INSERT INTO md_Column
	SET id = 1087, tableId = 87, name = "iScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 122;

	INSERT INTO md_Column
	SET id = 1088, tableId = 87, name = "iScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 123;

	INSERT INTO md_Column
	SET id = 1089, tableId = 87, name = "iScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 124;

	INSERT INTO md_Column
	SET id = 1090, tableId = 87, name = "iScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 125;

	INSERT INTO md_Column
	SET id = 1091, tableId = 87, name = "iScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 126;

	INSERT INTO md_Column
	SET id = 1092, tableId = 87, name = "zScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 127;

	INSERT INTO md_Column
	SET id = 1093, tableId = 87, name = "zScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 128;

	INSERT INTO md_Column
	SET id = 1094, tableId = 87, name = "zScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 129;

	INSERT INTO md_Column
	SET id = 1095, tableId = 87, name = "zScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 130;

	INSERT INTO md_Column
	SET id = 1096, tableId = 87, name = "zScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 131;

	INSERT INTO md_Column
	SET id = 1097, tableId = 87, name = "zScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 132;

	INSERT INTO md_Column
	SET id = 1098, tableId = 87, name = "zScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 133;

	INSERT INTO md_Column
	SET id = 1099, tableId = 87, name = "zScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 134;

	INSERT INTO md_Column
	SET id = 1100, tableId = 87, name = "zScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 135;

	INSERT INTO md_Column
	SET id = 1101, tableId = 87, name = "zScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 136;

	INSERT INTO md_Column
	SET id = 1102, tableId = 87, name = "zScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 137;

	INSERT INTO md_Column
	SET id = 1103, tableId = 87, name = "zScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 138;

	INSERT INTO md_Column
	SET id = 1104, tableId = 87, name = "zScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 139;

	INSERT INTO md_Column
	SET id = 1105, tableId = 87, name = "zScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 140;

	INSERT INTO md_Column
	SET id = 1106, tableId = 87, name = "zScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 141;

	INSERT INTO md_Column
	SET id = 1107, tableId = 87, name = "zScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 142;

	INSERT INTO md_Column
	SET id = 1108, tableId = 87, name = "zScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 143;

	INSERT INTO md_Column
	SET id = 1109, tableId = 87, name = "zScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 144;

	INSERT INTO md_Column
	SET id = 1110, tableId = 87, name = "zScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 145;

	INSERT INTO md_Column
	SET id = 1111, tableId = 87, name = "zScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 146;

	INSERT INTO md_Column
	SET id = 1112, tableId = 87, name = "zScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 147;

	INSERT INTO md_Column
	SET id = 1113, tableId = 87, name = "zScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 148;

	INSERT INTO md_Column
	SET id = 1114, tableId = 87, name = "zScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 149;

	INSERT INTO md_Column
	SET id = 1115, tableId = 87, name = "zScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 150;

	INSERT INTO md_Column
	SET id = 1116, tableId = 87, name = "zScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 151;

	INSERT INTO md_Column
	SET id = 1117, tableId = 87, name = "yScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 152;

	INSERT INTO md_Column
	SET id = 1118, tableId = 87, name = "yScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 153;

	INSERT INTO md_Column
	SET id = 1119, tableId = 87, name = "yScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 154;

	INSERT INTO md_Column
	SET id = 1120, tableId = 87, name = "yScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 155;

	INSERT INTO md_Column
	SET id = 1121, tableId = 87, name = "yScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 156;

	INSERT INTO md_Column
	SET id = 1122, tableId = 87, name = "yScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 157;

	INSERT INTO md_Column
	SET id = 1123, tableId = 87, name = "yScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 158;

	INSERT INTO md_Column
	SET id = 1124, tableId = 87, name = "yScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 159;

	INSERT INTO md_Column
	SET id = 1125, tableId = 87, name = "yScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 160;

	INSERT INTO md_Column
	SET id = 1126, tableId = 87, name = "yScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 161;

	INSERT INTO md_Column
	SET id = 1127, tableId = 87, name = "yScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 162;

	INSERT INTO md_Column
	SET id = 1128, tableId = 87, name = "yScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 163;

	INSERT INTO md_Column
	SET id = 1129, tableId = 87, name = "yScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 164;

	INSERT INTO md_Column
	SET id = 1130, tableId = 87, name = "yScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 165;

	INSERT INTO md_Column
	SET id = 1131, tableId = 87, name = "yScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 166;

	INSERT INTO md_Column
	SET id = 1132, tableId = 87, name = "yScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 167;

	INSERT INTO md_Column
	SET id = 1133, tableId = 87, name = "yScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 168;

	INSERT INTO md_Column
	SET id = 1134, tableId = 87, name = "yScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 169;

	INSERT INTO md_Column
	SET id = 1135, tableId = 87, name = "yScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 170;

	INSERT INTO md_Column
	SET id = 1136, tableId = 87, name = "yScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 171;

	INSERT INTO md_Column
	SET id = 1137, tableId = 87, name = "yScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 172;

	INSERT INTO md_Column
	SET id = 1138, tableId = 87, name = "yScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 173;

	INSERT INTO md_Column
	SET id = 1139, tableId = 87, name = "yScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 174;

	INSERT INTO md_Column
	SET id = 1140, tableId = 87, name = "yScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 175;

	INSERT INTO md_Column
	SET id = 1141, tableId = 87, name = "yScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 176;

	INSERT INTO md_Column
	SET id = 1142, tableId = 87, name = "primaryPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 177;

	INSERT INTO md_Column
	SET id = 1143, tableId = 87, name = "primaryPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 178;

	INSERT INTO md_Column
	SET id = 1144, tableId = 87, name = "uPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 179;

	INSERT INTO md_Column
	SET id = 1145, tableId = 87, name = "gPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 180;

	INSERT INTO md_Column
	SET id = 1146, tableId = 87, name = "rPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 181;

	INSERT INTO md_Column
	SET id = 1147, tableId = 87, name = "iPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 182;

	INSERT INTO md_Column
	SET id = 1148, tableId = 87, name = "zPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 183;

	INSERT INTO md_Column
	SET id = 1149, tableId = 87, name = "yPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 184;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 88, name = "prv_Amplifier",
	description = "One entry per amplifier &quot;slot&quot;";

	INSERT INTO md_Column
	SET id = 1150, tableId = 88, name = "amplifierId",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1151, tableId = 88, name = "ccdId",
		description = "Pointer to CCD this amplifier belongs to",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1152, tableId = 88, name = "amplifierDescr",
		type = "VARCHAR(80)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 89, name = "prv_CCD",
	description = "Table that keeps assignment of Amplifier slots to CCD. 1 row = assignment for one CCD";

	INSERT INTO md_Column
	SET id = 1153, tableId = 89, name = "ccdId",
		description = "Unique id",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1154, tableId = 89, name = "raftId",
		description = "Pointer to raft owning this ccd",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1155, tableId = 89, name = "amp01",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1156, tableId = 89, name = "amp02",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 1157, tableId = 89, name = "amp03",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 1158, tableId = 89, name = "amp04",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 1159, tableId = 89, name = "amp05",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 1160, tableId = 89, name = "amp06",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 1161, tableId = 89, name = "amp07",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 1162, tableId = 89, name = "amp08",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 1163, tableId = 89, name = "amp09",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET id = 1164, tableId = 89, name = "amp10",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 12;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 90, name = "prv_Filter",
	engine = "MyISAM",
	description = "One row per color - the table will have 6 rows";

	INSERT INTO md_Column
	SET id = 1165, tableId = 90, name = "filterId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1166, tableId = 90, name = "focalPlaneId",
		description = "Pointer to FocalPlane - focal plane this filter belongs to.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1167, tableId = 90, name = "name",
		description = "String description of the filter,e.g. 'VR SuperMacho c6027'.",
		type = "VARCHAR(80)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1168, tableId = 90, name = "url",
		description = "URL for filter transmission curve. (Added from archive specs for LSST precursor data).",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 1169, tableId = 90, name = "clam",
		description = "Filter centroid wavelength (Angstroms). (Added from archive specs for LSST precursor data).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 1170, tableId = 90, name = "bw",
		description = "Filter effective bandwidth (Angstroms). (Added from archive specs for LSST precursor data).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 91, name = "prv_FocalPlane",
	description = "Each row keeps assignment of Rafts to FocalPlane (there will be just one row I guess...)";

	INSERT INTO md_Column
	SET id = 1171, tableId = 91, name = "focalPlaneId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 92, name = "prv_Node";

	INSERT INTO md_Column
	SET id = 1172, tableId = 92, name = "nodeId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1173, tableId = 92, name = "policyId",
		description = "Pointer to Policy table: node-related policy.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 93, name = "prv_Pipeline",
	description = "Defines all LSST pipelines. 1 row = 1 pipeline. Actual configurations (which stages are part of given pipeline) are tracked through cnf_Stage2Pipeline";

	INSERT INTO md_Column
	SET id = 1174, tableId = 93, name = "pipelineId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1175, tableId = 93, name = "policyId",
		description = "Pointer to Policy table: pipeline-related table.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1176, tableId = 93, name = "pipelineName",
		description = "name of the pipeline",
		type = "VARCHAR(64)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 94, name = "prv_Pipeline2Run",
	description = "Mapping table. Keep tracks of mapping which Pipelines are part of a given Run, and during what time period given configuration was valid.";

	INSERT INTO md_Column
	SET id = 1177, tableId = 94, name = "pipeline2runId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1178, tableId = 94, name = "runId",
		description = "Pointer to Run table",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1179, tableId = 94, name = "pipelineId",
		description = "Pointer to Pipeline table.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 95, name = "prv_Policy";

	INSERT INTO md_Column
	SET id = 1180, tableId = 95, name = "policyId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1181, tableId = 95, name = "policyName",
		type = "VARCHAR(80)",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 96, name = "prv_ProcHistory",
	description = "Table keeps track of processing history. One row represents one batch of objects and/or sources and/or diasources and/or moving objects that were processed together. For each such group the table keeps track which Stage run, and time when the processing started. There is an assumption that configuration does not changes when during processing";

	INSERT INTO md_Column
	SET id = 1182, tableId = 96, name = "procHistoryId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 97, name = "prv_Raft",
	description = "Table that keeps assignment of CCDs to Rafts. 1 row: assignement for 1 raft";

	INSERT INTO md_Column
	SET id = 1183, tableId = 97, name = "raftId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1184, tableId = 97, name = "focalPlaneId",
		description = "Pointer to an entry in the focal plane.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1185, tableId = 97, name = "ccd01",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1186, tableId = 97, name = "ccd02",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 1187, tableId = 97, name = "ccd03",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 1188, tableId = 97, name = "ccd04",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET id = 1189, tableId = 97, name = "ccd05",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET id = 1190, tableId = 97, name = "ccd06",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET id = 1191, tableId = 97, name = "ccd07",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET id = 1192, tableId = 97, name = "ccd08",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET id = 1193, tableId = 97, name = "ccd09",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 11;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 98, name = "prv_Run",
	description = "Table to define LSST run. An example of a run &quot;nightly processing run&quot;";

	INSERT INTO md_Column
	SET id = 1194, tableId = 98, name = "runId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1195, tableId = 98, name = "policyId",
		description = "Pointer to Policy table: run-related policy.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 99, name = "prv_Slice";

	INSERT INTO md_Column
	SET id = 1196, tableId = 99, name = "sliceId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 100, name = "prv_Snapshot",
	description = "Table for saving significant snapshots (for example ProcessingHistory used to produce a data release)";

	INSERT INTO md_Column
	SET id = 1197, tableId = 100, name = "snapshotId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1198, tableId = 100, name = "procHistoryId",
		description = "Pointer to an entry in ProcessingHistory table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1199, tableId = 100, name = "snapshotDescr",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 101, name = "prv_Stage",
	description = "Table that defines all LSST stages. Actual Stage configurations are tracked through Config_Stage2Pipeline";

	INSERT INTO md_Column
	SET id = 1200, tableId = 101, name = "stageId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1201, tableId = 101, name = "policyId",
		description = "Pointer to Policy table: Stage-related policy.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1202, tableId = 101, name = "stageName",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 102, name = "prv_Stage2Pipeline",
	description = "Mapping table. Keep tracks of mapping which ProcessingSteps are part of a given Pipeline and during what time period given configuration was valid.";

	INSERT INTO md_Column
	SET id = 1203, tableId = 102, name = "stage2pipelineId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1204, tableId = 102, name = "pipelineId",
		description = "Pointer to an entry in Pipeline table.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1205, tableId = 102, name = "stageId",
		description = "Pointer to an entry in Stage table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 103, name = "prv_Stage2ProcHistory",
	description = "Table that keeps information which Stages belong to given processing history";

	INSERT INTO md_Column
	SET id = 1206, tableId = 103, name = "stageId",
		description = "Pointer to an entry in prv_Stage table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1207, tableId = 103, name = "procHistoryId",
		description = "Pointer to ProcessingHistory",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1208, tableId = 103, name = "stageStart",
		description = "Time when stage started.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1209, tableId = 103, name = "stageEnd",
		description = "Time when stage finished.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 104, name = "prv_Stage2Slice",
	description = "Mapping table. Keeps track of mapping between Stages and Slices.";

	INSERT INTO md_Column
	SET id = 1210, tableId = 104, name = "stage2SliceId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1211, tableId = 104, name = "stageId",
		description = "Pointer to an entry in Stage table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1212, tableId = 104, name = "sliceId",
		description = "Pointer to an entry in Slice table.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 105, name = "prv_Stage2UpdatableColumn",
	description = "Mapping table. Keeps track between Stage --&gt; set of columns that given Stage can update, and time period during which given mapping is valid.";

	INSERT INTO md_Column
	SET id = 1213, tableId = 105, name = "stageId",
		description = "Pointer to an entry in Stage table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1214, tableId = 105, name = "columnId",
		description = "Pointer to an entry in UpdatableColumn table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1215, tableId = 105, name = "cStage2UpdateColumnId",
		description = "Pointer to an entry in Config_Stage2UpdatableColumn table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 106, name = "prv_Telescope";

	INSERT INTO md_Column
	SET id = 1216, tableId = 106, name = "telescopeId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1217, tableId = 106, name = "focalPlaneId",
		description = "Pointer to an entry in FocalPlane table.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 107, name = "prv_UpdatableColumn",
	description = "Keep track of all columns that are updated by pipelines/stages";

	INSERT INTO md_Column
	SET id = 1218, tableId = 107, name = "columnId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1219, tableId = 107, name = "tableId",
		description = "Pointer to an entry in UpdatableTable, a table this column belongs to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1220, tableId = 107, name = "columnName",
		description = "Name, must be the same as in the database schema.",
		type = "VARCHAR(64)",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 108, name = "prv_UpdatableTable",
	description = "Keeps track of names of database tables that are (or can be) updated by stages.";

	INSERT INTO md_Column
	SET id = 1221, tableId = 108, name = "tableId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1222, tableId = 108, name = "tableName",
		description = "Name of table (must be the same as in schema, for example Object, DIASource...)",
		type = "VARCHAR(64)",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 109, name = "prv_cnf_Amplifier",
	engine = "MyISAM",
	description = "Table to store amplifier configuration. One row = hardware configuration of one amplifier";

	INSERT INTO md_Column
	SET id = 1223, tableId = 109, name = "cAmplifierId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1224, tableId = 109, name = "amplifierId",
		description = "Pointer to Amplifier table - amplifier that this config corresponds to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1225, tableId = 109, name = "serialNumber",
		description = "FIXME: Not sure what the type should be",
		type = "VARCHAR(40)",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1226, tableId = 109, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 1227, tableId = 109, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 110, name = "prv_cnf_CCD",
	description = "Table to store ccd configuration. One row = hardware configuration of one ccd";

	INSERT INTO md_Column
	SET id = 1228, tableId = 110, name = "cCCDId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1229, tableId = 110, name = "ccdId",
		description = "Pointer to CCD table - ccd that this configuration corresponds to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1230, tableId = 110, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1231, tableId = 110, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 111, name = "prv_cnf_Filter",
	description = "Table to store filter configuration. One row = one physical filter. If a filter is replaced, a new entry should be created here";

	INSERT INTO md_Column
	SET id = 1232, tableId = 111, name = "cFilterId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1233, tableId = 111, name = "filterId",
		description = "Pointer to Filter table - filter that this configuration corresponds to.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1234, tableId = 111, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1235, tableId = 111, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 112, name = "prv_cnf_FocalPlane",
	description = "Table to store focal plane configuration.";

	INSERT INTO md_Column
	SET id = 1236, tableId = 112, name = "cFocalPlaneId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1237, tableId = 112, name = "focalPlaneId",
		description = "Pointer to FocalPlane table - focal plane that this configuration corresponds to.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1238, tableId = 112, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1239, tableId = 112, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 113, name = "prv_cnf_MaskAmpImage";

	INSERT INTO md_Column
	SET id = 1240, tableId = 113, name = "cMaskAmpImageId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1241, tableId = 113, name = "amplifierId",
		description = "Pointer to Amplifier table - this determines which amplifier this config is used for.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1242, tableId = 113, name = "url",
		description = "Logical URL to the MaskIage file corresponding to a given amplifier.",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1243, tableId = 113, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 1244, tableId = 113, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 114, name = "prv_cnf_Node";

	INSERT INTO md_Column
	SET id = 1245, tableId = 114, name = "cNodeId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1246, tableId = 114, name = "nodeId",
		description = "Pointer to Node table - node that this configuration corresponds to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1247, tableId = 114, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1248, tableId = 114, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 115, name = "prv_cnf_Pipeline2Run";

	INSERT INTO md_Column
	SET id = 1249, tableId = 115, name = "cPipeline2RunId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1250, tableId = 115, name = "pipeline2runId",
		description = "Pointer to entry in Pipeline2Run table that this config corresponds to.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1251, tableId = 115, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1252, tableId = 115, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 116, name = "prv_cnf_Policy";

	INSERT INTO md_Column
	SET id = 1253, tableId = 116, name = "cPolicyId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1254, tableId = 116, name = "policyId",
		description = "Pointer to Policy table - policy that this config corresponds to.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1255, tableId = 116, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1256, tableId = 116, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 117, name = "prv_cnf_Raft",
	description = "Table to store raft configuration. One row = hardware configuration of one raft";

	INSERT INTO md_Column
	SET id = 1257, tableId = 117, name = "cRaftId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1258, tableId = 117, name = "raftId",
		description = "Pointer to Raft table - raft that this config corresponds to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1259, tableId = 117, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1260, tableId = 117, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 118, name = "prv_cnf_Slice";

	INSERT INTO md_Column
	SET id = 1261, tableId = 118, name = "nodeId",
		description = "Pointer to a node that this given slice runs on.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1262, tableId = 118, name = "sliceId",
		description = "Pointer to an entry in Slice table that this config corresponds to.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1263, tableId = 118, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1264, tableId = 118, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 119, name = "prv_cnf_Stage2Pipeline";

	INSERT INTO md_Column
	SET id = 1265, tableId = 119, name = "cStage2PipelineId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1266, tableId = 119, name = "stage2pipelineId",
		description = "Pointer to entry in Stage2Pipeline that this config corresponds to.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1267, tableId = 119, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1268, tableId = 119, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 120, name = "prv_cnf_Stage2Slice";

	INSERT INTO md_Column
	SET id = 1269, tableId = 120, name = "cStage2SliceId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1270, tableId = 120, name = "stage2sliceId",
		description = "Pointer to an entry in Stage2SliceId that this config corresponds to.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1271, tableId = 120, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1272, tableId = 120, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 121, name = "prv_cnf_Stage2UpdatableColumn";

	INSERT INTO md_Column
	SET id = 1273, tableId = 121, name = "c_stage2UpdatableColumn",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1274, tableId = 121, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1275, tableId = 121, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 122, name = "prv_cnf_Telescope";

	INSERT INTO md_Column
	SET id = 1276, tableId = 122, name = "cTelescopeId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1277, tableId = 122, name = "telescopeId",
		description = "Pointer to Telescope table - telescope that this configuration corresponds to.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1278, tableId = 122, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1279, tableId = 122, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 123, name = "sdqa_ImageStatus",
	description = "Unique set of status names and their definitions, e.g. &quot;passed&quot;, &quot;failed&quot;, etc. ";

	INSERT INTO md_Column
	SET id = 1280, tableId = 123, name = "sdqa_imageStatusId",
		description = "Primary key",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1281, tableId = 123, name = "statusName",
		description = "One-word, camel-case, descriptive name of a possible image status (e.g., passedAuto, marginallyPassedManual, etc.)",
		type = "VARCHAR(30)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1282, tableId = 123, name = "definition",
		description = "Detailed Definition of the image status",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 124, name = "sdqa_Metric",
	description = "Unique set of metric names and associated metadata (e.g., &quot;nDeadPix&quot;, &quot;median&quot;, etc.). There will be approximately 30 records total in this table.";

	INSERT INTO md_Column
	SET id = 1283, tableId = 124, name = "sdqa_metricId",
		description = "Primary key.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1284, tableId = 124, name = "metricName",
		description = "One-word, camel-case, descriptive name of a possible metric (e.g., mSatPix, median, etc).",
		type = "VARCHAR(30)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1285, tableId = 124, name = "physicalUnits",
		description = "Physical units of metric.",
		type = "VARCHAR(30)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1286, tableId = 124, name = "dataType",
		description = "Flag indicating whether data type of the metric value is integer (0) or float (1)",
		type = "CHAR(10)",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 1287, tableId = 124, name = "definition",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 125, name = "sdqa_Rating_4ScienceAmpExposure",
	description = "Various SDQA ratings for a given amplifier image. There will approximately 30 of these records per image record.";

	INSERT INTO md_Column
	SET id = 1288, tableId = 125, name = "sdqa_ratingId",
		description = "Primary key.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1289, tableId = 125, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1290, tableId = 125, name = "sdqa_thresholdId",
		description = "Pointer to sdqa_Threshold.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1291, tableId = 125, name = "ampExposureId",
		description = "Pointer to Science_Amp_Exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 1292, tableId = 125, name = "metricValue",
		description = "Value of this SDQA metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 1293, tableId = 125, name = "metricErr",
		description = "Uncertainty of the value of this metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 126, name = "sdqa_Rating_4ScienceCCDExposure",
	description = "Various SDQA ratings for a given CCD image.";

	INSERT INTO md_Column
	SET id = 1294, tableId = 126, name = "sdqa_ratingId",
		description = "Primary key.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1295, tableId = 126, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1296, tableId = 126, name = "sdqa_thresholdId",
		description = "Pointer to sdqa_Threshold.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1297, tableId = 126, name = "ccdExposureId",
		description = "Pointer to Science_CCD_Exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 1298, tableId = 126, name = "metricValue",
		description = "Value of this SDQA metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 1299, tableId = 126, name = "metricErr",
		description = "Uncertainty of the value of this metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 127, name = "sdqa_Rating_4ScienceFPAExposure",
	description = "Various SDQA ratings for a given FPA image.";

	INSERT INTO md_Column
	SET id = 1300, tableId = 127, name = "sdqa_ratingId",
		description = "Primary key.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1301, tableId = 127, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1302, tableId = 127, name = "sdqa_thresholdId",
		description = "Pointer to sdqa_Threshold.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1303, tableId = 127, name = "exposureId",
		description = "Pointer to Science_FPA_Exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 1304, tableId = 127, name = "metricValue",
		description = "Value of this SDQA metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET id = 1305, tableId = 127, name = "metricErr",
		description = "Uncertainty of the value of this metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET id = 128, name = "sdqa_Threshold",
	description = "Version-controlled metric thresholds. Total number of these records is approximately equal to 30 x the number of times the thresholds will be changed over the entire period of LSST operations (of ordre of 100), with most of the changes occuring in the first year of operations.";

	INSERT INTO md_Column
	SET id = 1306, tableId = 128, name = "sdqa_thresholdId",
		description = "Primary key.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET id = 1307, tableId = 128, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET id = 1308, tableId = 128, name = "upperThreshold",
		description = "Threshold for which a metric value is tested to be greater than.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET id = 1309, tableId = 128, name = "lowerThreshold",
		description = "Threshold for which a metric value is tested to be less than.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET id = 1310, tableId = 128, name = "createdDate",
		description = "Database timestamp when the record is inserted.",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "CURRENT_TIMESTAMP",
		displayOrder = 5;

