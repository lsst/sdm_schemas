
-- LSST Database Metadata
-- $Revision$
-- $Date$
--
-- See <http://dev.lsstcorp.org/trac/wiki/Copyrights>
-- for copyright information.


DROP DATABASE IF EXISTS lsst_schema_browser_DC3b;
CREATE DATABASE lsst_schema_browser_DC3b;
USE lsst_schema_browser_DC3b;


CREATE TABLE AAA_Version_DC3b_3_1_54 (version CHAR);


CREATE TABLE md_Table (
	tableId INTEGER NOT NULL UNIQUE PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE,
	engine VARCHAR(255),
	description VARCHAR(255)
);

CREATE TABLE md_Column (
	columnId INTEGER NOT NULL UNIQUE PRIMARY KEY,
	tableId INTEGER NOT NULL REFERENCES md_Table (tableId),
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
SET tableId = 1, name = "Alert",
	engine = "MyISAM",
	description = "Every alert belongs to exactly one AmpExposure";

	INSERT INTO md_Column
	SET columnId = 1, tableId = 1, name = "alertId",
		type = "INTEGER",
		notNull = 1,
		defaultValue = "0",
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 2, tableId = 1, name = "ampExposureId",
		description = "Pointer to the Raw_Amp_Exposure table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 3, tableId = 1, name = "objectId",
		description = "Id of object associated with given alert.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 4, tableId = 1, name = "timeGenerated",
		description = "Date/time of the middle of the second exposure in a visit corresponding to given alert.",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 5, tableId = 1, name = "imagePStampURL",
		description = "Logical URL describing where the image postamp associated with the alert is located.",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 6, tableId = 1, name = "templatePStampURL",
		description = "Logical URL of the postagestamp of the template image related to given alert.",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 7, tableId = 1, name = "alertURL",
		description = "Logical URL to the actual alert sent.",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 7;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 2, name = "AlertType",
	engine = "MyISAM",
	description = "Table to store alert types";

	INSERT INTO md_Column
	SET columnId = 8, tableId = 2, name = "alertTypeId",
		description = "unique id of alert type",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 9, tableId = 2, name = "alertTypeDescr",
		description = "Description of the alert type.",
		type = "VARCHAR(50)",
		notNull = 0,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 3, name = "Bias_FPA_CMExposure",
	description = "Calibrated Master Bias Exposure: a bias exposure that is composed of multiple single bias exposures.";

	INSERT INTO md_Column
	SET columnId = 10, tableId = 3, name = "cmBiasExposureId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 4, name = "Bias_FPA_Exposure",
	description = "Table for keeping (individual) BiasExposures. Coadded BiasExposures are kept in CMBiasExposure table.";

	INSERT INTO md_Column
	SET columnId = 11, tableId = 4, name = "biasExposureId",
		description = "Corresponds to exposureId from Exposure table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 12, tableId = 4, name = "averPixelValue",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 13, tableId = 4, name = "stdevPixelValue",
		description = "standard deviation",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 5, name = "CalibType",
	description = "Table with definition of Calibration types: flat, bias, mask, etc...";

	INSERT INTO md_Column
	SET columnId = 14, tableId = 5, name = "calibTypeId",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 15, tableId = 5, name = "descr",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 6, name = "Calibration_Amp_Exposure";

	INSERT INTO md_Column
	SET columnId = 16, tableId = 6, name = "ampExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 17, tableId = 6, name = "ccdExposureId",
		description = "Pointer to CCD_Exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 18, tableId = 6, name = "fpaExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 7, name = "Calibration_CCD_Exposure",
	description = "Placeholder...";

	INSERT INTO md_Column
	SET columnId = 19, tableId = 7, name = "ccdExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 20, tableId = 7, name = "exposureId",
		description = "Pointer to exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 21, tableId = 7, name = "calibTypeId",
		description = "Pointer to CalibType table",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 22, tableId = 7, name = "filterId",
		description = "Pointer to filter information.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 23, tableId = 7, name = "equinox",
		description = "Equinox of World Coordinate System.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 24, tableId = 7, name = "ctype1",
		description = " Coordinate projection type, axis 1.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 25, tableId = 7, name = "ctype2",
		description = " Coordinate projection type, axis 2.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 26, tableId = 7, name = "crpix1",
		description = "Coordinate reference pixel, axis 1.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 27, tableId = 7, name = "crpix2",
		description = "Coordinate reference pixel, axis 2.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 28, tableId = 7, name = "crval1",
		description = "Coordinate value 1 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 29, tableId = 7, name = "crval2",
		description = "Coordinate value 2 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 30, tableId = 7, name = "cd1_1",
		description = "First derivative of coordinate 1 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 31, tableId = 7, name = "cd2_1",
		description = "First derivative of coordinate 2 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 32, tableId = 7, name = "cd1_2",
		description = "First derivative of coordinate 1 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 33, tableId = 7, name = "cd2_2",
		description = "First derivative of coordinate 2 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 34, tableId = 7, name = "dateObs",
		description = "Date/Time of observation start (UTC).",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 35, tableId = 7, name = "expTime",
		description = "Duration of exposure.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 36, tableId = 7, name = "nCombine",
		description = "Number of images co-added to create a deeper image",
		type = "INTEGER",
		notNull = 1,
		defaultValue = "1",
		displayOrder = 18;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 8, name = "Calibration_FPA_Exposure";

	INSERT INTO md_Column
	SET columnId = 37, tableId = 8, name = "calibrationFPAExposureId",
		description = "Unique id of this calibration FPA Exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 9, name = "DIASource",
	engine = "MyISAM",
	description = "An entry in the DIASource Table is made as a result of a high SNR measurement of an Object in a difference Exposure.";

	INSERT INTO md_Column
	SET columnId = 38, tableId = 9, name = "diaSourceId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 39, tableId = 9, name = "ampExposureId",
		description = "Pointer to Raw_Amp_Exposure table - the amplifier where the difference source was measured.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 40, tableId = 9, name = "diaSourceToId",
		description = "Id of the corresponding diaSourceId measured in the other exposure from the same visit.",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 41, tableId = 9, name = "filterId",
		description = "Pointer to Filter table - filter used to take the Exposure where this source was measured.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 42, tableId = 9, name = "objectId",
		description = "Pointer to Object table. Might be NULL (each DIASource will point to either MovingObject or Object)",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 43, tableId = 9, name = "movingObjectId",
		description = "Pointer to MovingObject table. Might be NULL (each DIASource will point to either MovingObject or Object)",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 44, tableId = 9, name = "procHistoryId",
		description = "Pointer to ProcessingHistory table - an entry describing processing history of this source.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 45, tableId = 9, name = "scId",
		description = "Pointer to corresponding SourceClassification entry.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 46, tableId = 9, name = "ssmId",
		description = "Pointer to mops_SSM table. Might be NULL. Yields the originating SSM object for synthetic detections injected by daytime MOPS.",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 47, tableId = 9, name = "ra",
		description = "RA-coordinate of the difference source centroid.",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 48, tableId = 9, name = "raErrForDetection",
		description = "Uncertainty of ra coming from Detection Pipeline.",
		type = "FLOAT",
		notNull = 1,
		unit = "degree",
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 49, tableId = 9, name = "raErrForWcs",
		description = "Uncertainty of ra coming from WCS Stage.",
		type = "FLOAT",
		notNull = 0,
		unit = "degree",
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 50, tableId = 9, name = "decl",
		description = "Declination coordinate of the difference source centroid.",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 51, tableId = 9, name = "declErrForDetection",
		description = "Uncertainty of decl coming from Detection Pipeline.",
		type = "FLOAT",
		notNull = 1,
		unit = "degree",
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 52, tableId = 9, name = "declErrForWcs",
		description = "Uncertainty of decl coming from WCS Stage.",
		type = "FLOAT",
		notNull = 0,
		unit = "degree",
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 53, tableId = 9, name = "xFlux",
		description = "The flux weighted position for x, calculated from the first moment of the pixel values within the footprint",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 54, tableId = 9, name = "xFluxErr",
		description = "Uncertainty of the xFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 55, tableId = 9, name = "yFlux",
		description = "The flux weighted position for y, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 56, tableId = 9, name = "yFluxErr",
		description = "Uncertainty for yFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 57, tableId = 9, name = "raFlux",
		description = "The flux weighted position for ra, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 58, tableId = 9, name = "raFluxErr",
		description = "Uncertainty for raFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 59, tableId = 9, name = "declFlux",
		description = "The flux weighted position for decl, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 60, tableId = 9, name = "declFluxErr",
		description = "Uncertainty for declFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 61, tableId = 9, name = "xPeak",
		description = "The position of the pixel (x) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 62, tableId = 9, name = "yPeak",
		description = "The position of the pixel (y) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 63, tableId = 9, name = "raPeak",
		description = "The position of the pixel (ra) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 64, tableId = 9, name = "declPeak",
		description = "The position of the pixel (decl) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 65, tableId = 9, name = "xAstrom",
		description = "The position (x) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 66, tableId = 9, name = "xAstromErr",
		description = "Uncertainty for xAstrom.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 67, tableId = 9, name = "yAstrom",
		description = "The position (y) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 68, tableId = 9, name = "yAstromErr",
		description = "Uncertainty for yAstrom.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 69, tableId = 9, name = "raAstrom",
		description = "The position (ra) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 70, tableId = 9, name = "raAstromErr",
		description = "Uncertainty for raAstrom.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 71, tableId = 9, name = "declAstrom",
		description = "The position (decl) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 72, tableId = 9, name = "declAstromErr",
		description = "Uncertainty for declAstrom.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 73, tableId = 9, name = "taiMidPoint",
		description = "If a DIASource corresponds to a single exposure, taiMidPoint represents TAI time of the middle of exposure. For multiple exposures, this is middle of beginning-of-first-exposure to end-of-last-exposure.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 74, tableId = 9, name = "taiRange",
		description = "If a DIASource corresponds to a single exposure, taiRange equals to exposure length. If DIASource corresponds to multiple exposures, it taiRange equals to end-of-last-exposure minus beginning-of-first-exposure.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 75, tableId = 9, name = "lengthDeg",
		description = "Size of the object along major axis.",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 76, tableId = 9, name = "psfFlux",
		description = "PSF flux.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 39;

	INSERT INTO md_Column
	SET columnId = 77, tableId = 9, name = "psfFluxErr",
		description = "Uncertainty of PSF flux.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 40;

	INSERT INTO md_Column
	SET columnId = 78, tableId = 9, name = "apFlux",
		description = "Aperture flux.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 41;

	INSERT INTO md_Column
	SET columnId = 79, tableId = 9, name = "apFluxErr",
		description = "Uncertainty of apFlux.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 42;

	INSERT INTO md_Column
	SET columnId = 80, tableId = 9, name = "modelFlux",
		description = "Adaptive 2D gauss model flux.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 43;

	INSERT INTO md_Column
	SET columnId = 81, tableId = 9, name = "modelFluxErr",
		description = "Uncertainly of the model flux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 44;

	INSERT INTO md_Column
	SET columnId = 82, tableId = 9, name = "instFlux",
		description = "Instrumental flux.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 45;

	INSERT INTO md_Column
	SET columnId = 83, tableId = 9, name = "instFluxErr",
		description = "Uncertainty of instFlux.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 46;

	INSERT INTO md_Column
	SET columnId = 84, tableId = 9, name = "nonGrayCorrFlux",
		description = "Instrumental flux corrected for non-gray extinction.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 47;

	INSERT INTO md_Column
	SET columnId = 85, tableId = 9, name = "nonGrayCorrFluxErr",
		description = "Uncertainty of nonGrayCorrFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 48;

	INSERT INTO md_Column
	SET columnId = 86, tableId = 9, name = "atmCorrFlux",
		description = "Instrumental flux corrected for both gray and non-gray extinction.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET columnId = 87, tableId = 9, name = "atmCorrFluxErr",
		description = "Uncertainty of atmCorrFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET columnId = 88, tableId = 9, name = "apDia",
		description = "Diameter of aperture (pixels)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 51;

	INSERT INTO md_Column
	SET columnId = 89, tableId = 9, name = "refMag",
		description = "Reference magnitude before shape modulation applied (for synthetic detections)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET columnId = 90, tableId = 9, name = "Ixx",
		description = "Adaptive second moment",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET columnId = 91, tableId = 9, name = "IxxErr",
		description = "Uncertainty of Ixx: sqrt(covariance(x, x))",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET columnId = 92, tableId = 9, name = "Iyy",
		description = "Adaptive second moment",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET columnId = 93, tableId = 9, name = "IyyErr",
		description = "Uncertainty of Iyy: sqrt(covariance(y, y))",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET columnId = 94, tableId = 9, name = "Ixy",
		description = "Adaptive second moment",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET columnId = 95, tableId = 9, name = "IxyErr",
		description = "Uncertainty of Ixy: sign(covariance(x, y))*sqrt(|covariance(x, y)|)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET columnId = 96, tableId = 9, name = "snr",
		description = "Signal-to-Noise ratio",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 59;

	INSERT INTO md_Column
	SET columnId = 97, tableId = 9, name = "chi2",
		description = "Chi-square value for the PSF fit",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 60;

	INSERT INTO md_Column
	SET columnId = 98, tableId = 9, name = "valx1",
		description = "The x1 value of the orthogonal polynomials at the position of the DIASource.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 61;

	INSERT INTO md_Column
	SET columnId = 99, tableId = 9, name = "valx2",
		description = "The x2 value of the orthogonal polynomials at the position of the DIASource.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 62;

	INSERT INTO md_Column
	SET columnId = 100, tableId = 9, name = "valy1",
		description = "The y1 value of the orthogonal polynomials at the position of the DIASource.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 63;

	INSERT INTO md_Column
	SET columnId = 101, tableId = 9, name = "valy2",
		description = "The y2 value of the orthogonal polynomials at the position of the DIASource.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 64;

	INSERT INTO md_Column
	SET columnId = 102, tableId = 9, name = "valxy",
		description = "The xy value of the orthogonal polynomials at the position of the DIASource.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 65;

	INSERT INTO md_Column
	SET columnId = 103, tableId = 9, name = "obsCode",
		description = "MPC observatory code",
		type = "CHAR(3)",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET columnId = 104, tableId = 9, name = "isSynthetic",
		description = "efficiency marker; indicates detection is synthetic",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET columnId = 105, tableId = 9, name = "mopsStatus",
		description = "efficiency marker; indicates detection was detected (not lost in chip gap, etc.)",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET columnId = 106, tableId = 9, name = "flagForAssociation",
		description = "Problem/special conditions indicator (Kem noted that these flags could include delta_sky, delta_PSF, ...). FIXME: likely we should use a Stage name here",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET columnId = 107, tableId = 9, name = "flagForDetection",
		description = "Problem/special conditions indicator (Kem noted that these flags could include delta_sky, delta_PSF, ...). ",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET columnId = 108, tableId = 9, name = "flagForWcs",
		description = "Problem/special conditions indicator (Kem noted that these flags could include delta_sky, delta_PSF, ...). ",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET columnId = 109, tableId = 9, name = "flagClassification",
		description = "A flag capturing information about this DIASource classification.",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 72;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 10, name = "DIASourceIDTonight",
	description = "Table for storing IDs of DIASources generated during given night. For basecamp only.";

	INSERT INTO md_Column
	SET columnId = 110, tableId = 10, name = "DIASourceId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 11, name = "Dark_FPA_CMExposure",
	description = "Calibrated Master Dark Exposure: a bias exposure that is composed of multiple single dark exposures.";

	INSERT INTO md_Column
	SET columnId = 111, tableId = 11, name = "cmDarkExposureId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 12, name = "Dark_FPA_Exposure",
	description = "Table for keeping (individual) DarkExposures. Coadded DarkExposures are kept in CMDarkExposure table.";

	INSERT INTO md_Column
	SET columnId = 112, tableId = 12, name = "darkExposureId",
		description = "Corresponds to exposureId from Exposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 113, tableId = 12, name = "averPixelValue",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 114, tableId = 12, name = "stdevPixelValue",
		description = "standard deviation",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 13, name = "Flat_FPA_CMExposure",
	description = "Calibrated Master Flat Exposure: a bias exposure that is composed of multiple single flat exposures.";

	INSERT INTO md_Column
	SET columnId = 115, tableId = 13, name = "cmFlatExposureId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 14, name = "Flat_FPA_Exposure",
	description = "Table for keeping (individual) FlatExposures. Coadded FlatExposures are kept in CMFlatExposure table.";

	INSERT INTO md_Column
	SET columnId = 116, tableId = 14, name = "flatExposureId",
		description = "Corresponds to exposureId from Exposure table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 117, tableId = 14, name = "filterId",
		description = "Pointer to Filter table - filter used to take this exposure",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 118, tableId = 14, name = "averPixelValue",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 119, tableId = 14, name = "stdevPixelValue",
		description = "standard deviation",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 120, tableId = 14, name = "wavelength",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 121, tableId = 14, name = "type",
		description = "FIXME: convert type to ENUM: 'sky', 'dome'",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 15, name = "Fringe_FPA_CMExposure",
	description = "Calibrated Master FringeExposure: a bias exposure that is composed of multiple single fringe exposures.";

	INSERT INTO md_Column
	SET columnId = 122, tableId = 15, name = "cdFringeExposureId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 16, name = "MovingObject",
	description = "Table to store description of the Solar System (moving) Objects.";

	INSERT INTO md_Column
	SET columnId = 123, tableId = 16, name = "movingObjectId",
		description = "Moving object unique identified.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 124, tableId = 16, name = "movingObjectVersion",
		description = "Version number for the moving object. Updates to orbital parameters will result in a new version (row) of the object, preserving the orbit refinement history",
		type = "INT",
		notNull = 1,
		defaultValue = "'1'",
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 125, tableId = 16, name = "procHistoryId",
		description = "Pointer to ProcessingHistory table.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 126, tableId = 16, name = "taxonomicTypeId",
		description = "Pointer to ObjectType table for asteroid taxonomic type",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 127, tableId = 16, name = "ssmObjectName",
		description = "MOPS base-64 SSM object name, included for convenience. This name can be obtained from `mops_SSM` by joining on `ssmId`",
		type = "VARCHAR(32)",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 128, tableId = 16, name = "q",
		description = "semi-major axis of the orbit (AU)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 129, tableId = 16, name = "e",
		description = "eccentricity e (dimensionless)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 130, tableId = 16, name = "i",
		description = "Inclination of the orbit.",
		type = "DOUBLE",
		notNull = 1,
		unit = "deg",
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 131, tableId = 16, name = "node",
		description = "Longitude of ascending node.",
		type = "DOUBLE",
		notNull = 1,
		unit = "deg",
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 132, tableId = 16, name = "meanAnom",
		description = "Mean anomaly of the orbit",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 133, tableId = 16, name = "argPeri",
		description = "Argument of perihelion.",
		type = "DOUBLE",
		notNull = 1,
		unit = "deg",
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 134, tableId = 16, name = "distPeri",
		description = "perihelion distance (AU)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 135, tableId = 16, name = "timePeri",
		description = "time of perihelion passage, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 136, tableId = 16, name = "epoch",
		description = "epoch of osculating elements, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 137, tableId = 16, name = "h_v",
		description = "Absolute magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 138, tableId = 16, name = "g",
		description = "Slope parameter g",
		type = "DOUBLE",
		notNull = 0,
		defaultValue = "0.15",
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 139, tableId = 16, name = "rotationPeriod",
		description = "Rotation period, days",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 140, tableId = 16, name = "rotationEpoch",
		description = "Rotation time origin, MJD (UTC)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 141, tableId = 16, name = "albedo",
		description = "Albedo (dimensionless)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 142, tableId = 16, name = "poleLat",
		description = "Rotation pole latitude (degrees)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 143, tableId = 16, name = "poleLon",
		description = "Rotation pole longitude (degrees)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 144, tableId = 16, name = "d3",
		description = "3-parameter D-criterion (dimensionless) WRT SSM object",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 145, tableId = 16, name = "d4",
		description = "4-parameter D-criterion (dimensionless) WRT SSM object",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 146, tableId = 16, name = "orbFitResidual",
		description = "Orbit fit RMS residual.",
		type = "DOUBLE",
		notNull = 1,
		unit = "argsec",
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 147, tableId = 16, name = "orbFitChi2",
		description = "orbit fit chi-squared statistic",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 148, tableId = 16, name = "classification",
		description = "MOPS efficiency classification ('C'/'M'/'B'/'N'/'X')",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 149, tableId = 16, name = "ssmId",
		description = "Source SSM object for C classification",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 150, tableId = 16, name = "mopsStatus",
		description = "NULL, or set to 'M' when DO is merged with parent",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 151, tableId = 16, name = "stablePass",
		description = "NULL, or set to 'Y' when stable precovery pass completed",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 152, tableId = 16, name = "timeCreated",
		description = "Timestamp for row creation (this is the time of moving object creation for the first version of that object)",
		type = "TIMESTAMP",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 153, tableId = 16, name = "uMag",
		description = "Weighted average apparent magnitude in u filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 154, tableId = 16, name = "uMagErr",
		description = "Uncertainty of uMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 155, tableId = 16, name = "uAmplitude",
		description = "Characteristic magnitude scale of the flux variations for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 156, tableId = 16, name = "uPeriod",
		description = "Period of flux variations (if regular) for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 157, tableId = 16, name = "gMag",
		description = "Weighted average apparent magnitude in g filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 158, tableId = 16, name = "gMagErr",
		description = "Uncertainty of gMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 159, tableId = 16, name = "gAmplitude",
		description = "Characteristic magnitude scale of the flux variations for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 160, tableId = 16, name = "gPeriod",
		description = "Period of flux variations (if regular) for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 161, tableId = 16, name = "rMag",
		description = "Weighted average apparent magnitude in r filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 39;

	INSERT INTO md_Column
	SET columnId = 162, tableId = 16, name = "rMagErr",
		description = "Uncertainty of rMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 40;

	INSERT INTO md_Column
	SET columnId = 163, tableId = 16, name = "rAmplitude",
		description = "Characteristic magnitude scale of the flux variations for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET columnId = 164, tableId = 16, name = "rPeriod",
		description = "Period of flux variations (if regular) for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 42;

	INSERT INTO md_Column
	SET columnId = 165, tableId = 16, name = "iMag",
		description = "Weighted average apparent magnitude in i filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 43;

	INSERT INTO md_Column
	SET columnId = 166, tableId = 16, name = "iMagErr",
		description = "Uncertainty of iMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 44;

	INSERT INTO md_Column
	SET columnId = 167, tableId = 16, name = "iAmplitude",
		description = "Characteristic magnitude scale of the flux variations for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET columnId = 168, tableId = 16, name = "iPeriod",
		description = "Period of flux variations (if regular) for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET columnId = 169, tableId = 16, name = "zMag",
		description = "Weighted average apparent magnitude in z filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 47;

	INSERT INTO md_Column
	SET columnId = 170, tableId = 16, name = "zMagErr",
		description = "Uncertainty of zMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 48;

	INSERT INTO md_Column
	SET columnId = 171, tableId = 16, name = "zAmplitude",
		description = "Characteristic magnitude scale of the flux variations for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET columnId = 172, tableId = 16, name = "zPeriod",
		description = "Period of flux variations (if regular) for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET columnId = 173, tableId = 16, name = "yMag",
		description = "Weighted average apparent magnitude in y filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 51;

	INSERT INTO md_Column
	SET columnId = 174, tableId = 16, name = "yMagErr",
		description = "Uncertainty of yMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET columnId = 175, tableId = 16, name = "yAmplitude",
		description = "Characteristic magnitude scale of the flux variations for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET columnId = 176, tableId = 16, name = "yPeriod",
		description = "Period of flux variations (if regular) for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET columnId = 177, tableId = 16, name = "flag",
		description = "Problem/special condition flag.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET columnId = 178, tableId = 16, name = "src01",
		description = "square root of covariance EC EC (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET columnId = 179, tableId = 16, name = "src02",
		description = "square root of covariance EC QR (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET columnId = 180, tableId = 16, name = "src03",
		description = "square root of covariance QR QR (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET columnId = 181, tableId = 16, name = "src04",
		description = "square root of covariance EC TP (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET columnId = 182, tableId = 16, name = "src05",
		description = "square root of covariance QR TP (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET columnId = 183, tableId = 16, name = "src06",
		description = "square root of covariance TP TP (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET columnId = 184, tableId = 16, name = "src07",
		description = "square root of covariance EC OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 62;

	INSERT INTO md_Column
	SET columnId = 185, tableId = 16, name = "src08",
		description = "square root of covariance QR OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 63;

	INSERT INTO md_Column
	SET columnId = 186, tableId = 16, name = "src09",
		description = "square root of covariance TP OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 64;

	INSERT INTO md_Column
	SET columnId = 187, tableId = 16, name = "src10",
		description = "square root of covariance OM OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 65;

	INSERT INTO md_Column
	SET columnId = 188, tableId = 16, name = "src11",
		description = "square root of covariance EC W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET columnId = 189, tableId = 16, name = "src12",
		description = "square root of covariance QR W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET columnId = 190, tableId = 16, name = "src13",
		description = "square root of covariance TP W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET columnId = 191, tableId = 16, name = "src14",
		description = "square root of covariance OM W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET columnId = 192, tableId = 16, name = "src15",
		description = "square root of covariance W  W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET columnId = 193, tableId = 16, name = "src16",
		description = "square root of covariance EC IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET columnId = 194, tableId = 16, name = "src17",
		description = "square root of covariance QR IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 72;

	INSERT INTO md_Column
	SET columnId = 195, tableId = 16, name = "src18",
		description = "square root of covariance TP IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 73;

	INSERT INTO md_Column
	SET columnId = 196, tableId = 16, name = "src19",
		description = "square root of covariance OM IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 74;

	INSERT INTO md_Column
	SET columnId = 197, tableId = 16, name = "src20",
		description = "square root of covariance W  IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 75;

	INSERT INTO md_Column
	SET columnId = 198, tableId = 16, name = "src21",
		description = "square root of covariance IN IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 76;

	INSERT INTO md_Column
	SET columnId = 199, tableId = 16, name = "convCode",
		description = "JPL convergence code",
		type = "VARCHAR(8)",
		notNull = 0,
		displayOrder = 77;

	INSERT INTO md_Column
	SET columnId = 200, tableId = 16, name = "o_minus_c",
		description = "Vestigial observed-computed position, essentially RMS residual",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 78;

	INSERT INTO md_Column
	SET columnId = 201, tableId = 16, name = "moid1",
		description = "Minimum orbital intersection distance (MOID) solution 1",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 79;

	INSERT INTO md_Column
	SET columnId = 202, tableId = 16, name = "moidLong1",
		description = "Longitude of MOID 1",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 80;

	INSERT INTO md_Column
	SET columnId = 203, tableId = 16, name = "moid2",
		description = "Minimum orbital intersection distance (MOID) solution 2",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 81;

	INSERT INTO md_Column
	SET columnId = 204, tableId = 16, name = "moidLong2",
		description = "Longitude of MOID 2",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 82;

	INSERT INTO md_Column
	SET columnId = 205, tableId = 16, name = "arcLengthDays",
		description = "Arc length of detections used to compute orbit",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 83;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 17, name = "Object",
	engine = "MyISAM",
	description = "Table to store all non-Solar-System astrophysical objects found in the LSST images.";

	INSERT INTO md_Column
	SET columnId = 206, tableId = 17, name = "objectId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 207, tableId = 17, name = "procHistoryId",
		description = "Pointer to ProcessingHistory table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 208, tableId = 17, name = "ra",
		description = "RA-coordinate of the object. Weighted center of light across all filters.",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 209, tableId = 17, name = "raErr",
		description = "Uncertainty of ra.",
		type = "FLOAT",
		notNull = 1,
		unit = "degree",
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 210, tableId = 17, name = "decl",
		description = "Declination-coordinate of the object. Weighted center of light across all filters.",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 211, tableId = 17, name = "declErr",
		description = "Uncertainty of decl.",
		type = "FLOAT",
		notNull = 1,
		unit = "degree",
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 212, tableId = 17, name = "muRa",
		description = "Derived proper motion (right ascension).",
		type = "DOUBLE",
		notNull = 0,
		unit = "miliarcsec/year",
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 213, tableId = 17, name = "muRaErr",
		description = "Uncertainty of muRa.",
		type = "FLOAT",
		notNull = 0,
		unit = "miliarcsec/year",
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 214, tableId = 17, name = "muDecl",
		description = "Derived proper motion (declination).",
		type = "DOUBLE",
		notNull = 0,
		unit = "miliarcsec/year",
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 215, tableId = 17, name = "muDeclErr",
		description = "Uncertainty of muDecl.",
		type = "FLOAT",
		notNull = 0,
		unit = "miliarcsec/year",
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 216, tableId = 17, name = "xFlux",
		description = "The flux weighted position for x, calculated from the first moment of the pixel values within the footprint",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 217, tableId = 17, name = "xFluxErr",
		description = "Uncertainty of the xFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 218, tableId = 17, name = "yFlux",
		description = "The flux weighted position for y, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 219, tableId = 17, name = "yFluxErr",
		description = "Uncertainty for yFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 220, tableId = 17, name = "raFlux",
		description = "The flux weighted position for ra, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 221, tableId = 17, name = "raFluxErr",
		description = "Uncertainty for raFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 222, tableId = 17, name = "declFlux",
		description = "The flux weighted position for decl, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 223, tableId = 17, name = "declFluxErr",
		description = "Uncertainty for declFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 224, tableId = 17, name = "xPeak",
		description = "The position of the pixel (x) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 225, tableId = 17, name = "yPeak",
		description = "The position of the pixel (y) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 226, tableId = 17, name = "raPeak",
		description = "The position of the pixel (ra) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 227, tableId = 17, name = "declPeak",
		description = "The position of the pixel (decl) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 228, tableId = 17, name = "xAstrom",
		description = "The position (x) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 229, tableId = 17, name = "xAstromErr",
		description = "Uncertainty for xAstrom",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 230, tableId = 17, name = "yAstrom",
		description = "The position (y) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 231, tableId = 17, name = "yAstromErr",
		description = "Uncertainty for yAstrom",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 232, tableId = 17, name = "raAstrom",
		description = "The position (ra) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 233, tableId = 17, name = "raAstromErr",
		description = "Uncertainty for raAstrom",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 234, tableId = 17, name = "declAstrom",
		description = "The position (decl) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 235, tableId = 17, name = "declAstromErr",
		description = "Uncertainty for declAstrom.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 236, tableId = 17, name = "refrRaAstrom",
		description = "Astrometric refraction in RA.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 237, tableId = 17, name = "refrRaAstromErr",
		description = "Uncertainty of refrRaAstrom.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 238, tableId = 17, name = "refrDeclAstrom",
		description = "Astrometric refraction in Declination.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 239, tableId = 17, name = "refrDeclAstromErr",
		description = "Uncertanty of refrDeclAstrom.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 240, tableId = 17, name = "parallax",
		description = "derived parallax for the object",
		type = "FLOAT",
		notNull = 0,
		unit = "miliarcsec",
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 241, tableId = 17, name = "parallaxErr",
		description = "parallax error",
		type = "FLOAT",
		notNull = 0,
		unit = "miliarcsec",
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 242, tableId = 17, name = "earliestObsTime",
		description = "first observation time",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 243, tableId = 17, name = "latestObsTime",
		description = "last observation time",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 244, tableId = 17, name = "primaryPeriod",
		description = "period that represent periods for all filters.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 39;

	INSERT INTO md_Column
	SET columnId = 245, tableId = 17, name = "primaryPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 40;

	INSERT INTO md_Column
	SET columnId = 246, tableId = 17, name = "ugColor",
		description = "Precalculated color (difference between u and g).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET columnId = 247, tableId = 17, name = "grColor",
		description = "Precalculated color (difference between g and r).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 42;

	INSERT INTO md_Column
	SET columnId = 248, tableId = 17, name = "riColor",
		description = "Precalculated color (difference between r and i).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 43;

	INSERT INTO md_Column
	SET columnId = 249, tableId = 17, name = "izColor",
		description = "Precalculated color (difference between i and z).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 44;

	INSERT INTO md_Column
	SET columnId = 250, tableId = 17, name = "zyColor",
		description = "Precalculated color (difference between z and y).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET columnId = 251, tableId = 17, name = "cx",
		description = "x-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 46;

	INSERT INTO md_Column
	SET columnId = 252, tableId = 17, name = "cxErr",
		description = "Uncertainty of cx.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 47;

	INSERT INTO md_Column
	SET columnId = 253, tableId = 17, name = "cy",
		description = "z-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 48;

	INSERT INTO md_Column
	SET columnId = 254, tableId = 17, name = "cyErr",
		description = "Uncertainty of cy.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 49;

	INSERT INTO md_Column
	SET columnId = 255, tableId = 17, name = "cz",
		description = "z-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 50;

	INSERT INTO md_Column
	SET columnId = 256, tableId = 17, name = "czErr",
		description = "Uncertainty of cz.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 51;

	INSERT INTO md_Column
	SET columnId = 257, tableId = 17, name = "flagForStage1",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET columnId = 258, tableId = 17, name = "flagForStage2",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET columnId = 259, tableId = 17, name = "flagForStage3",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET columnId = 260, tableId = 17, name = "isProvisional",
		description = "If this is set to true it indicates that the object was created at the base camp. If set to false, it means it was created by Deep Detection.",
		type = "BOOL",
		notNull = 1,
		defaultValue = "FALSE",
		displayOrder = 55;

	INSERT INTO md_Column
	SET columnId = 261, tableId = 17, name = "zone",
		description = "zone is an index to speed up spatial queries.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET columnId = 262, tableId = 17, name = "uMag",
		description = "Weighted average apparent magnitude in u filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET columnId = 263, tableId = 17, name = "uMagErr",
		description = "Uncertainty of uMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET columnId = 264, tableId = 17, name = "uPetroMag",
		description = "Petrosian flux for u filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET columnId = 265, tableId = 17, name = "uPetroMagErr",
		description = "Petrosian flux error for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET columnId = 266, tableId = 17, name = "uApMag",
		description = "aperture magnitude for u filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET columnId = 267, tableId = 17, name = "uApMagErr",
		description = "aperture magnitude error for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 62;

	INSERT INTO md_Column
	SET columnId = 268, tableId = 17, name = "uPosErrA",
		description = "Large dimension of the position error ellipse, assuming gaussian scatter. For u filter.",
		type = "FLOAT",
		notNull = 0,
		unit = "arcsec",
		displayOrder = 63;

	INSERT INTO md_Column
	SET columnId = 269, tableId = 17, name = "uPosErrB",
		description = "Small dimension of the position error ellipse, assuming gaussian scatter.  For u filter.",
		type = "FLOAT",
		notNull = 0,
		unit = "arcsec",
		displayOrder = 64;

	INSERT INTO md_Column
	SET columnId = 270, tableId = 17, name = "uPosErrTheta",
		description = "Orientation of the position error ellipse. For u filter",
		type = "FLOAT",
		notNull = 0,
		unit = "degree",
		displayOrder = 65;

	INSERT INTO md_Column
	SET columnId = 271, tableId = 17, name = "uNumObs",
		description = "Number of measurements in the lightcurve for u filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET columnId = 272, tableId = 17, name = "uVarProb",
		description = "Probability of variability in % (100% = variable object) for u filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		unit = "%",
		displayOrder = 67;

	INSERT INTO md_Column
	SET columnId = 273, tableId = 17, name = "uAmplitude",
		description = "Characteristic magnitude scale of the flux variations for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET columnId = 274, tableId = 17, name = "uPeriod",
		description = "Period of flux variations (if regular) for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET columnId = 275, tableId = 17, name = "uPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET columnId = 276, tableId = 17, name = "uIx",
		description = "Adaptive first moment for u filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET columnId = 277, tableId = 17, name = "uIxErr",
		description = "Adaptive first moment uncertainty for u filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 72;

	INSERT INTO md_Column
	SET columnId = 278, tableId = 17, name = "uIy",
		description = "Adaptive first moment for u filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 73;

	INSERT INTO md_Column
	SET columnId = 279, tableId = 17, name = "uIyErr",
		description = "Adaptive first moment uncertainty for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 74;

	INSERT INTO md_Column
	SET columnId = 280, tableId = 17, name = "uIxx",
		description = "Adaptive second moment for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 75;

	INSERT INTO md_Column
	SET columnId = 281, tableId = 17, name = "uIxxErr",
		description = "Adaptive second moment uncertainty for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 76;

	INSERT INTO md_Column
	SET columnId = 282, tableId = 17, name = "uIyy",
		description = "Adaptive second moment for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 77;

	INSERT INTO md_Column
	SET columnId = 283, tableId = 17, name = "uIyyErr",
		description = "Adaptive second moment uncertainty for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 78;

	INSERT INTO md_Column
	SET columnId = 284, tableId = 17, name = "uIxy",
		description = "Adaptive second moment for u fiter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 79;

	INSERT INTO md_Column
	SET columnId = 285, tableId = 17, name = "uIxyErr",
		description = "Adaptive second moment uncertainty for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 80;

	INSERT INTO md_Column
	SET columnId = 286, tableId = 17, name = "uTimescale",
		description = "Characteristic timescale of flux variations (measured in days). This is to complement period for variables without a well-defined period. LSST images have sampling frequency of ~0.1Hz. For u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 81;

	INSERT INTO md_Column
	SET columnId = 287, tableId = 17, name = "gMag",
		description = "Weighted average apparent magnitude in g filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 82;

	INSERT INTO md_Column
	SET columnId = 288, tableId = 17, name = "gMagErr",
		description = "Uncertainty of gMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 83;

	INSERT INTO md_Column
	SET columnId = 289, tableId = 17, name = "gPetroMag",
		description = "Petrosian flux for g filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 84;

	INSERT INTO md_Column
	SET columnId = 290, tableId = 17, name = "gPetroMagErr",
		description = "Petrosian flux error filter for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 85;

	INSERT INTO md_Column
	SET columnId = 291, tableId = 17, name = "gApMag",
		description = "aperture magnitude for g filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 86;

	INSERT INTO md_Column
	SET columnId = 292, tableId = 17, name = "gApMagErr",
		description = "aperture magnitude error for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 87;

	INSERT INTO md_Column
	SET columnId = 293, tableId = 17, name = "gPosErrA",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 88;

	INSERT INTO md_Column
	SET columnId = 294, tableId = 17, name = "gPosErrB",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 89;

	INSERT INTO md_Column
	SET columnId = 295, tableId = 17, name = "gPosErrTheta",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 90;

	INSERT INTO md_Column
	SET columnId = 296, tableId = 17, name = "gNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 91;

	INSERT INTO md_Column
	SET columnId = 297, tableId = 17, name = "gVarProb",
		description = "Probability of variability in % (100% = variable object) for g filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 92;

	INSERT INTO md_Column
	SET columnId = 298, tableId = 17, name = "gAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 93;

	INSERT INTO md_Column
	SET columnId = 299, tableId = 17, name = "gPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 94;

	INSERT INTO md_Column
	SET columnId = 300, tableId = 17, name = "gPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 95;

	INSERT INTO md_Column
	SET columnId = 301, tableId = 17, name = "gIx",
		description = "Adaptive first moment for g filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 96;

	INSERT INTO md_Column
	SET columnId = 302, tableId = 17, name = "gIxErr",
		description = "Adaptive first moment uncertainty for g filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 97;

	INSERT INTO md_Column
	SET columnId = 303, tableId = 17, name = "gIy",
		description = "Adaptive first moment for g filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 98;

	INSERT INTO md_Column
	SET columnId = 304, tableId = 17, name = "gIyErr",
		description = "Adaptive first moment uncertainty for g filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 99;

	INSERT INTO md_Column
	SET columnId = 305, tableId = 17, name = "gIxx",
		description = "Adaptive second moment for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 100;

	INSERT INTO md_Column
	SET columnId = 306, tableId = 17, name = "gIxxErr",
		description = "Adaptive second moment uncertainty for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 101;

	INSERT INTO md_Column
	SET columnId = 307, tableId = 17, name = "gIyy",
		description = "Adaptive second moment for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 102;

	INSERT INTO md_Column
	SET columnId = 308, tableId = 17, name = "gIyyErr",
		description = "Adaptive second moment uncertainty for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 103;

	INSERT INTO md_Column
	SET columnId = 309, tableId = 17, name = "gIxy",
		description = "Adaptive second moment for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 104;

	INSERT INTO md_Column
	SET columnId = 310, tableId = 17, name = "gIxyErr",
		description = "Adaptive second moment uncertainty for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 105;

	INSERT INTO md_Column
	SET columnId = 311, tableId = 17, name = "gTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 106;

	INSERT INTO md_Column
	SET columnId = 312, tableId = 17, name = "rMag",
		description = "Weighted average apparent magnitude in r filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 107;

	INSERT INTO md_Column
	SET columnId = 313, tableId = 17, name = "rMagErr",
		description = "Uncertainty of rMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 108;

	INSERT INTO md_Column
	SET columnId = 314, tableId = 17, name = "rPetroMag",
		description = "Petrosian flux for r filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 109;

	INSERT INTO md_Column
	SET columnId = 315, tableId = 17, name = "rPetroMagErr",
		description = "Petrosian flux error for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 110;

	INSERT INTO md_Column
	SET columnId = 316, tableId = 17, name = "rApMag",
		description = "aperture magnitude for r filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 111;

	INSERT INTO md_Column
	SET columnId = 317, tableId = 17, name = "rApMagErr",
		description = "aperture magnitude error for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 112;

	INSERT INTO md_Column
	SET columnId = 318, tableId = 17, name = "rPosErrA",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 113;

	INSERT INTO md_Column
	SET columnId = 319, tableId = 17, name = "rPosErrB",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 114;

	INSERT INTO md_Column
	SET columnId = 320, tableId = 17, name = "rPosErrTheta",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 115;

	INSERT INTO md_Column
	SET columnId = 321, tableId = 17, name = "rNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 116;

	INSERT INTO md_Column
	SET columnId = 322, tableId = 17, name = "rVarProb",
		description = "Probability of variability in % (100% = variable object) for r filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 117;

	INSERT INTO md_Column
	SET columnId = 323, tableId = 17, name = "rAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 118;

	INSERT INTO md_Column
	SET columnId = 324, tableId = 17, name = "rPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 119;

	INSERT INTO md_Column
	SET columnId = 325, tableId = 17, name = "rPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 120;

	INSERT INTO md_Column
	SET columnId = 326, tableId = 17, name = "rIx",
		description = "Adaptive first moment for r filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 121;

	INSERT INTO md_Column
	SET columnId = 327, tableId = 17, name = "rIxErr",
		description = "Adaptive first moment uncertainty for r filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 122;

	INSERT INTO md_Column
	SET columnId = 328, tableId = 17, name = "rIy",
		description = "Adaptive first moment for r filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 123;

	INSERT INTO md_Column
	SET columnId = 329, tableId = 17, name = "rIyErr",
		description = "Adaptive first moment uncertainty for r filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 124;

	INSERT INTO md_Column
	SET columnId = 330, tableId = 17, name = "rIxx",
		description = "Adaptive second moment for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 125;

	INSERT INTO md_Column
	SET columnId = 331, tableId = 17, name = "rIxxErr",
		description = "Adaptive second moment uncertainty for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 126;

	INSERT INTO md_Column
	SET columnId = 332, tableId = 17, name = "rIyy",
		description = "Adaptive second moment for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 127;

	INSERT INTO md_Column
	SET columnId = 333, tableId = 17, name = "rIyyErr",
		description = "Adaptive second moment uncertainty for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 128;

	INSERT INTO md_Column
	SET columnId = 334, tableId = 17, name = "rIxy",
		description = "Adaptive second moment for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 129;

	INSERT INTO md_Column
	SET columnId = 335, tableId = 17, name = "rIxyErr",
		description = "Adaptive second moment uncertainty for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 130;

	INSERT INTO md_Column
	SET columnId = 336, tableId = 17, name = "rTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 131;

	INSERT INTO md_Column
	SET columnId = 337, tableId = 17, name = "iMag",
		description = "Weighted average apparent magnitude in i filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 132;

	INSERT INTO md_Column
	SET columnId = 338, tableId = 17, name = "iMagErr",
		description = "Uncertainty of iMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 133;

	INSERT INTO md_Column
	SET columnId = 339, tableId = 17, name = "iPetroMag",
		description = "Petrosian flux for i filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 134;

	INSERT INTO md_Column
	SET columnId = 340, tableId = 17, name = "iPetroMagErr",
		description = "Petrosian flux error for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 135;

	INSERT INTO md_Column
	SET columnId = 341, tableId = 17, name = "iApMag",
		description = "aperture magnitude for i filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 136;

	INSERT INTO md_Column
	SET columnId = 342, tableId = 17, name = "iApMagErr",
		description = "aperture magnitude error for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 137;

	INSERT INTO md_Column
	SET columnId = 343, tableId = 17, name = "iPosErrA",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 138;

	INSERT INTO md_Column
	SET columnId = 344, tableId = 17, name = "iPosErrB",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 139;

	INSERT INTO md_Column
	SET columnId = 345, tableId = 17, name = "iPosErrTheta",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 140;

	INSERT INTO md_Column
	SET columnId = 346, tableId = 17, name = "iNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 141;

	INSERT INTO md_Column
	SET columnId = 347, tableId = 17, name = "iVarProb",
		description = "Probability of variability in % (100% = variable object) for i filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 142;

	INSERT INTO md_Column
	SET columnId = 348, tableId = 17, name = "iAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 143;

	INSERT INTO md_Column
	SET columnId = 349, tableId = 17, name = "iPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 144;

	INSERT INTO md_Column
	SET columnId = 350, tableId = 17, name = "iPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 145;

	INSERT INTO md_Column
	SET columnId = 351, tableId = 17, name = "iIx",
		description = "Adaptive first moment for i filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 146;

	INSERT INTO md_Column
	SET columnId = 352, tableId = 17, name = "iIxErr",
		description = "Adaptive first moment uncertainty for i filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 147;

	INSERT INTO md_Column
	SET columnId = 353, tableId = 17, name = "iIy",
		description = "Adaptive first moment for i filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 148;

	INSERT INTO md_Column
	SET columnId = 354, tableId = 17, name = "iIyErr",
		description = "Adaptive first moment uncertainty for i filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 149;

	INSERT INTO md_Column
	SET columnId = 355, tableId = 17, name = "iIxx",
		description = "Adaptive second moment for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 150;

	INSERT INTO md_Column
	SET columnId = 356, tableId = 17, name = "iIxxErr",
		description = "Adaptive second moment uncertainty for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 151;

	INSERT INTO md_Column
	SET columnId = 357, tableId = 17, name = "iIyy",
		description = "Adaptive second moment for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 152;

	INSERT INTO md_Column
	SET columnId = 358, tableId = 17, name = "iIyyErr",
		description = "Adaptive second moment uncertainty for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 153;

	INSERT INTO md_Column
	SET columnId = 359, tableId = 17, name = "iIxy",
		description = "Adaptive second moment for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 154;

	INSERT INTO md_Column
	SET columnId = 360, tableId = 17, name = "iIxyErr",
		description = "Adaptive second moment uncertainty for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 155;

	INSERT INTO md_Column
	SET columnId = 361, tableId = 17, name = "iTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 156;

	INSERT INTO md_Column
	SET columnId = 362, tableId = 17, name = "zMag",
		description = "Weighted average apparent magnitude in z filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 157;

	INSERT INTO md_Column
	SET columnId = 363, tableId = 17, name = "zMagErr",
		description = "Uncertainty of zMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 158;

	INSERT INTO md_Column
	SET columnId = 364, tableId = 17, name = "zPetroMag",
		description = "Petrosian flux for z filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 159;

	INSERT INTO md_Column
	SET columnId = 365, tableId = 17, name = "zPetroMagErr",
		description = "Petrosian flux error for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 160;

	INSERT INTO md_Column
	SET columnId = 366, tableId = 17, name = "zApMag",
		description = "aperture magnitude for z filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 161;

	INSERT INTO md_Column
	SET columnId = 367, tableId = 17, name = "zApMagErr",
		description = "aperture magnitude error for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 162;

	INSERT INTO md_Column
	SET columnId = 368, tableId = 17, name = "zPosErrA",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 163;

	INSERT INTO md_Column
	SET columnId = 369, tableId = 17, name = "zPosErrB",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 164;

	INSERT INTO md_Column
	SET columnId = 370, tableId = 17, name = "zPosErrTheta",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 165;

	INSERT INTO md_Column
	SET columnId = 371, tableId = 17, name = "zNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 166;

	INSERT INTO md_Column
	SET columnId = 372, tableId = 17, name = "zVarProb",
		description = "Probability of variability in % (100% = variable object) for z filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 167;

	INSERT INTO md_Column
	SET columnId = 373, tableId = 17, name = "zAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 168;

	INSERT INTO md_Column
	SET columnId = 374, tableId = 17, name = "zPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 169;

	INSERT INTO md_Column
	SET columnId = 375, tableId = 17, name = "zPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 170;

	INSERT INTO md_Column
	SET columnId = 376, tableId = 17, name = "zIx",
		description = "Adaptive first moment for z filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 171;

	INSERT INTO md_Column
	SET columnId = 377, tableId = 17, name = "zIxErr",
		description = "Adaptive first moment uncertainty for z filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 172;

	INSERT INTO md_Column
	SET columnId = 378, tableId = 17, name = "zIy",
		description = "Adaptive first moment for z filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 173;

	INSERT INTO md_Column
	SET columnId = 379, tableId = 17, name = "zIyErr",
		description = "Adaptive first moment uncertainty for z filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 174;

	INSERT INTO md_Column
	SET columnId = 380, tableId = 17, name = "zIxx",
		description = "Adaptive second moment for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 175;

	INSERT INTO md_Column
	SET columnId = 381, tableId = 17, name = "zIxxErr",
		description = "Adaptive second moment uncertainty for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 176;

	INSERT INTO md_Column
	SET columnId = 382, tableId = 17, name = "zIyy",
		description = "Adaptive second moment for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 177;

	INSERT INTO md_Column
	SET columnId = 383, tableId = 17, name = "zIyyErr",
		description = "Adaptive second moment uncertainty for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 178;

	INSERT INTO md_Column
	SET columnId = 384, tableId = 17, name = "zIxy",
		description = "Adaptive second moment for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 179;

	INSERT INTO md_Column
	SET columnId = 385, tableId = 17, name = "zIxyErr",
		description = "Adaptive second moment uncertainty for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 180;

	INSERT INTO md_Column
	SET columnId = 386, tableId = 17, name = "zTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 181;

	INSERT INTO md_Column
	SET columnId = 387, tableId = 17, name = "yMag",
		description = "Weighted average apparent magnitude in y filter.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 182;

	INSERT INTO md_Column
	SET columnId = 388, tableId = 17, name = "yMagErr",
		description = "Uncertainty of yMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 183;

	INSERT INTO md_Column
	SET columnId = 389, tableId = 17, name = "yPetroMag",
		description = "Petrosian flux for y filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 184;

	INSERT INTO md_Column
	SET columnId = 390, tableId = 17, name = "yPetroMagErr",
		description = "Uncertainty of yPetroMag.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 185;

	INSERT INTO md_Column
	SET columnId = 391, tableId = 17, name = "yApMag",
		description = "aperture magnitude for y filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 186;

	INSERT INTO md_Column
	SET columnId = 392, tableId = 17, name = "yApMagErr",
		description = "aperture magnitude error for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 187;

	INSERT INTO md_Column
	SET columnId = 393, tableId = 17, name = "yPosErrA",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 188;

	INSERT INTO md_Column
	SET columnId = 394, tableId = 17, name = "yPosErrB",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 189;

	INSERT INTO md_Column
	SET columnId = 395, tableId = 17, name = "yPosErrTheta",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 190;

	INSERT INTO md_Column
	SET columnId = 396, tableId = 17, name = "yNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 191;

	INSERT INTO md_Column
	SET columnId = 397, tableId = 17, name = "yVarProb",
		description = "Probability of variability in % (100% = variable object) for y filter. Note: large photometric errors do not necessarily mean variability.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 192;

	INSERT INTO md_Column
	SET columnId = 398, tableId = 17, name = "yAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 193;

	INSERT INTO md_Column
	SET columnId = 399, tableId = 17, name = "yPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 194;

	INSERT INTO md_Column
	SET columnId = 400, tableId = 17, name = "yPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 195;

	INSERT INTO md_Column
	SET columnId = 401, tableId = 17, name = "yIx",
		description = "Adaptive first moment for y filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 196;

	INSERT INTO md_Column
	SET columnId = 402, tableId = 17, name = "yIxErr",
		description = "Adaptive first moment uncertainty for y filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 197;

	INSERT INTO md_Column
	SET columnId = 403, tableId = 17, name = "yIy",
		description = "Adaptive first moment for y filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 198;

	INSERT INTO md_Column
	SET columnId = 404, tableId = 17, name = "yIyErr",
		description = "Adaptive first moment uncertainty for y filter.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 199;

	INSERT INTO md_Column
	SET columnId = 405, tableId = 17, name = "yIxx",
		description = "Adaptive second moment for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 200;

	INSERT INTO md_Column
	SET columnId = 406, tableId = 17, name = "yIxxErr",
		description = "Adaptive second moment uncertainty for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 201;

	INSERT INTO md_Column
	SET columnId = 407, tableId = 17, name = "yIyy",
		description = "Adaptive second moment for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 202;

	INSERT INTO md_Column
	SET columnId = 408, tableId = 17, name = "yIyyErr",
		description = "Adaptive second moment uncertainty for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 203;

	INSERT INTO md_Column
	SET columnId = 409, tableId = 17, name = "yIxy",
		description = "Adaptive second moment for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 204;

	INSERT INTO md_Column
	SET columnId = 410, tableId = 17, name = "yIxyErr",
		description = "Adaptive second moment uncertainty for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 205;

	INSERT INTO md_Column
	SET columnId = 411, tableId = 17, name = "yTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 206;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 18, name = "ObjectType",
	description = "Table to store description of object types. It includes all object types: static, variables, Solar System objects, etc.";

	INSERT INTO md_Column
	SET columnId = 412, tableId = 18, name = "typeId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 413, tableId = 18, name = "description",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 19, name = "PostageStampJpegs";

	INSERT INTO md_Column
	SET columnId = 414, tableId = 19, name = "ra",
		description = "ra of upper left corner",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 415, tableId = 19, name = "decl",
		description = "decl or upper left corner",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 416, tableId = 19, name = "sizeRa",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 417, tableId = 19, name = "sizeDecl",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 418, tableId = 19, name = "url",
		description = "logical url of the jpeg image",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 20, name = "Raw_Amp_Exposure",
	description = "Table to store per-exposure information for every Amplifier.&#xA;&#xA;tai+texp also added to this table, because there might be difference in the way focal plane is illuminated (finite shutter speed) leading to differences in exposure time between CCDs.&#xA;&#xA;ISSUE: binX, binY, sizeX, sizeY can be dropped if we know for sure we never going to use pixel binning in LSST (confirm).";

	INSERT INTO md_Column
	SET columnId = 419, tableId = 20, name = "rawAmpExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 420, tableId = 20, name = "rawCCDExposureId",
		description = "Pointer to Raw_CCD_Exposure that contains this AmpExposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 421, tableId = 20, name = "rawFPAExposureId",
		description = "Pointer to Raw_FPA_Exposure that contains this AmpExposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 422, tableId = 20, name = "amplifierId",
		description = "Pointer to Amplifier table - this identifies which amplifier this AmpExposure corresponds to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 423, tableId = 20, name = "procHistoryId",
		description = "Pointer to an entry in ProcessingHistory table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 424, tableId = 20, name = "binX",
		description = "binning in X-coordinate",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 425, tableId = 20, name = "binY",
		description = "binning in Y-coordinate",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 426, tableId = 20, name = "sizeX",
		description = "Size of the image in X-direction (along rows; binned pixels). Ignores overscan but includes regions that may be considered outside of the data portion of the image.",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 427, tableId = 20, name = "sizeY",
		description = "Size of the image in Y-direction (along columns; binned pixels). Ignores overscan but includes regions that may be considered outside of the data portion of the image.",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 428, tableId = 20, name = "taiObs",
		description = "time of shutter open (international atomic time)",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 429, tableId = 20, name = "expTime",
		description = "Exposure time for this particular Amplifier. We are not certain yet that exposure times will be identical for all Amplifiers [FIXME] ",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 430, tableId = 20, name = "bias",
		description = "Bias level for the calibrated image (ADUs).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 431, tableId = 20, name = "gain",
		description = "Gain value for the amplifier (e/ADU).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 432, tableId = 20, name = "rdNoise",
		description = "Read noise value for this AmpExposure (measured in electrons).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 433, tableId = 20, name = "telAngle",
		description = "Orientation angle of the telescope with regards to sky.  Note: This is different from camera orientation w.r.t sky (encapsulated in WCS), since telescope is on alt-az mount.",
		type = "FLOAT",
		notNull = 1,
		unit = "deg",
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 434, tableId = 20, name = "az",
		description = "Azimuth of observation, preferably at center of exposure at center of image and including refraction correction, but none of this is guaranteed",
		type = "FLOAT",
		notNull = 0,
		unit = "deg",
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 435, tableId = 20, name = "altitude",
		description = "Altitude of observation, preferably at center of observation at center of image and including refraction correction, but none of this is guaranteed",
		type = "FLOAT",
		notNull = 0,
		unit = "deg",
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 436, tableId = 20, name = "flag",
		description = "Flags to indicate a problem/special condition with the AmpExposure (e.g. hardware, weather, etc)",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 437, tableId = 20, name = "zpt",
		description = "Photometric zero point magnitude.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 438, tableId = 20, name = "zptErr",
		description = "Error of zero point magnitude.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 439, tableId = 20, name = "sky",
		description = "The average sky level in the frame (ADU).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 440, tableId = 20, name = "skySig",
		description = "Sigma of distribution of sky values",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 441, tableId = 20, name = "skyErr",
		description = "Error of the average sky value",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 442, tableId = 20, name = "psf_nstar",
		description = "Number of stars used for PSF measurement",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 443, tableId = 20, name = "psf_apcorr",
		description = "Photometric error due to imperfect PSF model (aperture correction)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 444, tableId = 20, name = "psf_sigma1",
		description = "Inner Gaussian sigma for the composite fit (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 445, tableId = 20, name = "psf_sigma2",
		description = "Outer Gaussian sigma for the composite fit (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 446, tableId = 20, name = "psf_b",
		description = "Ratio of inner PSF to outer PSF (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 447, tableId = 20, name = "psf_b_2G",
		description = "Ratio of Gaussian 2 to Gaussian 1 at origin (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 448, tableId = 20, name = "psf_p0",
		description = "The value of the power law at the origin (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 449, tableId = 20, name = "psf_beta",
		description = "The slope of the power law (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 450, tableId = 20, name = "psf_sigmap",
		description = "Width parameter for the power law (XXX)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 451, tableId = 20, name = "psf_nprof",
		description = "Number of profile bins (XXX?)",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 452, tableId = 20, name = "psf_fwhm",
		description = "Effective PSF width.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 453, tableId = 20, name = "psf_sigma_x",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 454, tableId = 20, name = "psf_sigma_y",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 455, tableId = 20, name = "psf_posAngle",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 456, tableId = 20, name = "psf_peak",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 457, tableId = 20, name = "psf_x0",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 39;

	INSERT INTO md_Column
	SET columnId = 458, tableId = 20, name = "psf_x1",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 40;

	INSERT INTO md_Column
	SET columnId = 459, tableId = 20, name = "radesys",
		description = "Type of WCS used. Obsolete in ICRS",
		type = "VARCHAR(5)",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET columnId = 460, tableId = 20, name = "equinox",
		description = "Equinox of the WCS. Obsolete in ICRS",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 42;

	INSERT INTO md_Column
	SET columnId = 461, tableId = 20, name = "ctype1",
		description = "Coordinate type (axis 1). Obsolete in ICRS",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 43;

	INSERT INTO md_Column
	SET columnId = 462, tableId = 20, name = "ctype2",
		description = "Coordinate type (axis 2). Obsolete in ICRS",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 44;

	INSERT INTO md_Column
	SET columnId = 463, tableId = 20, name = "cunit1",
		description = "X axis units",
		type = "VARCHAR(10)",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET columnId = 464, tableId = 20, name = "cunit2",
		description = "Y axis units",
		type = "VARCHAR(10)",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET columnId = 465, tableId = 20, name = "crpix1",
		description = "Pixel X-coordinate for reference pixel",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 47;

	INSERT INTO md_Column
	SET columnId = 466, tableId = 20, name = "crpix2",
		description = "Pixel Y-coordinate for reference pixel",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 48;

	INSERT INTO md_Column
	SET columnId = 467, tableId = 20, name = "crval1",
		description = "Sky coordinate (longitude) for reference pixel.",
		type = "FLOAT",
		notNull = 1,
		unit = "deg",
		displayOrder = 49;

	INSERT INTO md_Column
	SET columnId = 468, tableId = 20, name = "crval2",
		description = "Sky coordinate (latitude) for reference pixel.",
		type = "FLOAT",
		notNull = 1,
		unit = "deg",
		displayOrder = 50;

	INSERT INTO md_Column
	SET columnId = 469, tableId = 20, name = "cd11",
		description = "WCS transformation matrix element (_11)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 51;

	INSERT INTO md_Column
	SET columnId = 470, tableId = 20, name = "cd12",
		description = "WCS transformation matrix element (_12)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 52;

	INSERT INTO md_Column
	SET columnId = 471, tableId = 20, name = "cd21",
		description = "WCS transformation matrix element (_21)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 53;

	INSERT INTO md_Column
	SET columnId = 472, tableId = 20, name = "cd22",
		description = "WCS transformation matrix element (_22)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 54;

	INSERT INTO md_Column
	SET columnId = 473, tableId = 20, name = "cdelt1",
		description = "Obsolete by cd_xx terms?",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET columnId = 474, tableId = 20, name = "cdelt2",
		description = "Obsolete by cd_xx terms?",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 56;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 21, name = "Raw_CCD_Exposure";

	INSERT INTO md_Column
	SET columnId = 475, tableId = 21, name = "rawCCDExposureId",
		description = "Unique id",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 476, tableId = 21, name = "rawFPAExposureId",
		description = "Pointer to the Raw FPA Exposure that this CCD Exposure belongs to.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 477, tableId = 21, name = "procHistoryId",
		description = "Pointer to ProcessingHistory. Valid if all pieces processed with the same processing history (all AmpExposures). If different processing histories used, then NULL",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 478, tableId = 21, name = "referenceRawFPAExposureId",
		description = "See the descripton of c0 below.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 479, tableId = 21, name = "filterId",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 480, tableId = 21, name = "ra",
		description = "Right Ascension of aperture center.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 481, tableId = 21, name = "decl",
		description = "Declination of aperture center.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 482, tableId = 21, name = "equinox",
		description = "Equinox of World Coordinate System.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 483, tableId = 21, name = "url",
		description = "Logical URL to the corresponding image file.",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 484, tableId = 21, name = "ctype1",
		description = "Coordinate projection type, axis 1.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 485, tableId = 21, name = "ctype2",
		description = "Coordinate projection type, axis 2.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 486, tableId = 21, name = "crpix1",
		description = "Coordinate reference pixel, axis 1.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 487, tableId = 21, name = "crpix2",
		description = "Coordinate reference pixel, axis 2.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 488, tableId = 21, name = "crval1",
		description = "Coordinate value 1 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 489, tableId = 21, name = "crval2",
		description = "Coordinate value 2 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 490, tableId = 21, name = "cd11",
		description = "First derivative of coordinate 1 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 491, tableId = 21, name = "cd21",
		description = "First derivative of coordinate 2 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 492, tableId = 21, name = "cd12",
		description = "First derivative of coordinate 1 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 493, tableId = 21, name = "cd22",
		description = "First derivative of coordinate 2 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 494, tableId = 21, name = "dateObs",
		description = "Date/Time of observation start (UTC).",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 495, tableId = 21, name = "taiObs",
		description = "TAI-OBS = UTC + offset. Offset = 32 s from  1/1/1999 to 1/1/2006, = 33 s after 1/1/2006.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 496, tableId = 21, name = "mjdObs",
		description = "MJD of observation start.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 497, tableId = 21, name = "expTime",
		description = "Duration of exposure.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 498, tableId = 21, name = "darkTime",
		description = "Total elapsed time from exposure start to end of read.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 499, tableId = 21, name = "zd",
		description = "Zenith distance at observation mid-point.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 500, tableId = 21, name = "airmass",
		description = "Airmass value for the Amp reference pixel (preferably center, but not guaranteed).",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 501, tableId = 21, name = "kNonGray",
		description = "The value of the non-gray extinction.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 502, tableId = 21, name = "c0",
		description = "One of the coefficients that specify a second order spatial polynomial surface defined over the pixels of an Exposure. The coefficients c0, cx1, ..., cxy multiply orthogonal polynomials of order 0, 1, and 2 in x and y, and order 1 in x*y. The orthogonality is defined over the set of x, y, and x*y for the set of DIASources in the Exposure that match through the Object table to a DIASource in the Exposure given by referenceRawFPAExposureId ",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 503, tableId = 21, name = "c0Err",
		description = "Uncertainty of c0 coefficient.",
		type = "FLOAT",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 504, tableId = 21, name = "cx1",
		description = "See the descripton of c0.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 505, tableId = 21, name = "cx1Err",
		description = "Uncertainty of cx1 coefficient.",
		type = "FLOAT",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 506, tableId = 21, name = "cx2",
		description = "See the descripton of c0.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 507, tableId = 21, name = "cx2Err",
		description = "Uncertainty of cx2 coefficient.",
		type = "FLOAT",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 508, tableId = 21, name = "cy1",
		description = "See the descripton of c0.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 509, tableId = 21, name = "cy1Err",
		description = "Uncertainty of cy1 coefficient.",
		type = "FLOAT",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 510, tableId = 21, name = "cy2",
		description = "See the descripton of c0.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 511, tableId = 21, name = "cy2Err",
		description = "Uncertainty of cy2 coefficient.",
		type = "FLOAT",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 512, tableId = 21, name = "cxy",
		description = "See the descripton of c0.",
		type = "DOUBLE",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 513, tableId = 21, name = "cxyErr",
		description = "Uncertainty of cxy coefficient.",
		type = "FLOAT",
		notNull = 1,
		unit = "magnitude",
		displayOrder = 39;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 22, name = "Raw_FPA_Exposure",
	engine = "MyISAM",
	description = "Table to store information about raw image metadata for the entire Focal Plane Assembly. Contains information from FITS header.&#xA;&#xA;ISSUE: For such a large FOV, do we expect amp-to-amp differences in texp, because shutter moves with finite speed?  If yes, texp and potentially mjd, etc should be moved further down the image hierarchy.&#xA;&#xA;ISSUE: To take previous issue even further: do we expect differences in integration time source-to-source, depending on their focal plane position?";

	INSERT INTO md_Column
	SET columnId = 514, tableId = 22, name = "rawFPAExposureId",
		description = "Unique id of an exposure. At most, there will be roughly 10^7 entries in this table: (3000 per night X 300 nights X 10 years).",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 515, tableId = 22, name = "filterId",
		description = "Pointer to Filter table - filter used when this exposure was taken.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 516, tableId = 22, name = "procHistoryId",
		description = "Pointer to ProcessingHistory. Valid if all pieces processed with the same processing history (all AmpExposures and all CCDExposures). If different processing histories used, then NULL",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 517, tableId = 22, name = "visitId",
		description = "Pointer to the visit this exposure belongs to.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 518, tableId = 22, name = "ra",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 519, tableId = 22, name = "decl",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 520, tableId = 22, name = "obsDate",
		description = "When image was taken (observation start). Note: datetime type does not have fractional seconds!",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 521, tableId = 22, name = "tai",
		description = "time of shutter open (observation start), international atomic time.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 522, tableId = 22, name = "taiDark",
		description = "time of shutter closed (during the exposure, if there was such an occasion; eg due to clowds. See Kem). International atomic time. There also could be a situation when the shutter was closed and reopened multiple times during the exposure. In this case, a more complicated data structure is needed?",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 523, tableId = 22, name = "azimuth",
		type = "FLOAT",
		notNull = 0,
		unit = "degree",
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 524, tableId = 22, name = "altitude",
		type = "FLOAT",
		notNull = 0,
		unit = "degree",
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 525, tableId = 22, name = "temperature",
		type = "FLOAT",
		notNull = 0,
		unit = "Celsius",
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 526, tableId = 22, name = "texp",
		description = "Exposure time (total length of integration), sec.&#xA;",
		type = "FLOAT",
		notNull = 1,
		unit = "second",
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 527, tableId = 22, name = "flag",
		description = "Flag to indicate a problem/special condition with the image (e.g. hardware, weather, etc).",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 528, tableId = 22, name = "ra_ll",
		description = "ra for the low-left corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 529, tableId = 22, name = "dec_ll",
		description = "del for the low-left corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 530, tableId = 22, name = "ra_lr",
		description = "ra for the low-right corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 531, tableId = 22, name = "dec_lr",
		description = "dec for the low-right corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 532, tableId = 22, name = "ra_ul",
		description = "ra for the upper-left corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 533, tableId = 22, name = "dec_ul",
		description = "dec for the upper-left corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 534, tableId = 22, name = "ra_ur",
		description = "ra for the upper-right corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 535, tableId = 22, name = "dec_ur",
		description = "dec for the upper-right corner. We will probably do something more fancy than that in the real system...",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 22;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 23, name = "Science_Amp_Exposure";

	INSERT INTO md_Column
	SET columnId = 536, tableId = 23, name = "scienceAmpExposureId",
		description = "Unique id of this science Amp exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 537, tableId = 23, name = "scienceCCDExposureId",
		description = "Pointer to Science_CCD_Exposure that contains this AmpExposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 538, tableId = 23, name = "scienceFPAExposureId",
		description = "Pointer to Science_FPA_Exposure that contains this AmpExposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 539, tableId = 23, name = "sdqa_imageStatusId",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 24, name = "Science_CCD_Exposure";

	INSERT INTO md_Column
	SET columnId = 540, tableId = 24, name = "scienceCCDExposureId",
		description = "Unique Science CCD Exposure id. Note that this id is the same as the id of the corresponding raw CCD Exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 541, tableId = 24, name = "scienceFPAExposureId",
		description = "Pointer to the Science FPA Exposure this CCD exposure belongs to. This also identifies Calibration_FPA_Exposure used to calibrated this exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 542, tableId = 24, name = "filterId",
		description = "Pointer to filter.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 543, tableId = 24, name = "equinox",
		description = "Equinox of World Coordinate System.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 544, tableId = 24, name = "url",
		description = "Logical URL to the actual calibrated image.",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 545, tableId = 24, name = "ctype1",
		description = "Coordinate projection type, axis 1.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 546, tableId = 24, name = "ctype2",
		description = "Coordinate projection type, axis 2.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 547, tableId = 24, name = "crpix1",
		description = "Coordinate reference pixel, axis 1.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 548, tableId = 24, name = "crpix2",
		description = "Coordinate reference pixel, axis 2.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 549, tableId = 24, name = "crval1",
		description = "Coordinate value 1 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 550, tableId = 24, name = "crval2",
		description = "Coordinate value 2 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 551, tableId = 24, name = "cd1_1",
		description = "First derivative of coordinate 1 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 552, tableId = 24, name = "cd2_1",
		description = "First derivative of coordinate 2 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 553, tableId = 24, name = "cd1_2",
		description = "First derivative of coordinate 1 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 554, tableId = 24, name = "cd2_2",
		description = "First derivative of coordinate 2 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 555, tableId = 24, name = "dateObs",
		description = "Date/Time of observation start (UTC).",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 556, tableId = 24, name = "expTime",
		description = "Duration of exposure.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 557, tableId = 24, name = "photoFlam",
		description = "Inverse sensitivity.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 558, tableId = 24, name = "photoZP",
		description = "System photometric zero-point.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 559, tableId = 24, name = "nCombine",
		description = "Number of images co-added to create a deeper image",
		type = "INTEGER",
		notNull = 1,
		defaultValue = "1",
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 560, tableId = 24, name = "taiMjd",
		description = "Date of the start of the exposure",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 561, tableId = 24, name = "binX",
		description = "Binning of the ccd in x.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 562, tableId = 24, name = "binY",
		description = "Binning of the ccd in y.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 563, tableId = 24, name = "saturationLimit",
		description = "Saturation limit for the CCD (average of the amplifiers).",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 564, tableId = 24, name = "dataSection",
		description = "Data section for the ccd in the form of [####:####,####:####]",
		type = "VARCHAR(24)",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 565, tableId = 24, name = "ccdSize",
		description = "Size of the entire detector.",
		type = "VARCHAR(50)",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 566, tableId = 24, name = "gain",
		description = "Gain of the CCD.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 567, tableId = 24, name = "readNoise",
		description = "Read noise of the CCD.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 28;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 25, name = "Science_FPA_Exposure",
	description = "Image metadata for the science calibrated exposure";

	INSERT INTO md_Column
	SET columnId = 568, tableId = 25, name = "scienceFPAExposureId",
		description = "Unique id of this Science FPA Exposure",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 569, tableId = 25, name = "rawFPAExposureId",
		description = "Pointer to corresponding Raw FPA Exposure. This also identifies Calibration_FPA_Exposure used to calibrate this exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 570, tableId = 25, name = "subtractedRawFPAExposureId",
		description = "Pointer to the corresponding subtracted raw fpa exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 571, tableId = 25, name = "varianceRawFPAExposureId",
		description = "Pointer to the corresponding variance RAW FPA exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 572, tableId = 25, name = "cseGroupId",
		description = "Pointer to ScienceFPAExposure_Group table. There will be many ScienceFPAExposure entries with the same set of values, so it makes sense to normalize this and store as one entry in a separate table.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 26, name = "Source",
	engine = "MyISAM",
	description = "Table to store high signal-to-noise &quot;sources&quot;. A source is a measurement of  Object's properties from a single image that contains its footprint on the sky.";

	INSERT INTO md_Column
	SET columnId = 573, tableId = 26, name = "sourceId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 574, tableId = 26, name = "ampExposureId",
		description = "Pointer to Amplifier where source was measured.&#xA;If the Source belongs to multiple AmpExposures, then table Source2AmpExposure is used, and this pointer is NULL",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 575, tableId = 26, name = "filterId",
		description = "Pointer to an entry in Filter table: filter used to take Exposure where this Source (or these Sources) were measured.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 576, tableId = 26, name = "objectId",
		description = "Pointer to Object table. Might be NULL (each Source will point to either MovingObject or Object)",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 577, tableId = 26, name = "movingObjectId",
		description = "Pointer to MovingObject table. Might be NULL (each Source will point to either MovingObject or Object)",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 578, tableId = 26, name = "procHistoryId",
		description = "Pointer to an entry in ProcessingHistory table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 579, tableId = 26, name = "ra",
		description = "RA-coordinate of the source centroid.",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 580, tableId = 26, name = "raErrForDetection",
		description = "Uncertainty of ra coming from Detection Pipeline.",
		type = "FLOAT",
		notNull = 0,
		unit = "degree",
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 581, tableId = 26, name = "raErrForWcs",
		description = "Uncertainty of ra coming from WCS Stage.",
		type = "FLOAT",
		notNull = 1,
		unit = "degree",
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 582, tableId = 26, name = "decl",
		description = "Declination coordinate of the source centroid.",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 583, tableId = 26, name = "declErrForDetection",
		description = "Uncertainty of decl coming from Detection Pipeline.",
		type = "FLOAT",
		notNull = 0,
		unit = "degree",
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 584, tableId = 26, name = "declErrForWcs",
		description = "Uncertainty of decl coming from WCS Stage.",
		type = "FLOAT",
		notNull = 1,
		unit = "degree",
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 585, tableId = 26, name = "xFlux",
		description = "The flux weighted position for x, calculated from the first moment of the pixel values within the footprint",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 586, tableId = 26, name = "xFluxErr",
		description = "Uncertainty of the xFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 587, tableId = 26, name = "yFlux",
		description = "The flux weighted position for y, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 588, tableId = 26, name = "yFluxErr",
		description = "Uncertainty for yFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 589, tableId = 26, name = "raFlux",
		description = "The flux weighted position for ra, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 590, tableId = 26, name = "raFluxErr",
		description = "Uncertainty for raFlux",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 591, tableId = 26, name = "declFlux",
		description = "The flux weighted position for decl, calculated from the first moment of the pixel values within the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 592, tableId = 26, name = "declFluxErr",
		description = "Uncertainty for declFlux",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 593, tableId = 26, name = "xPeak",
		description = "The position of the pixel (x) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 594, tableId = 26, name = "yPeak",
		description = "The position of the pixel (y) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 595, tableId = 26, name = "raPeak",
		description = "The position of the pixel (ra) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 596, tableId = 26, name = "declPeak",
		description = "The position of the pixel (decl) with the peak value in the footprint.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 597, tableId = 26, name = "xAstrom",
		description = "The position (x) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 598, tableId = 26, name = "xAstromErr",
		description = "Uncertainty for xAstrom",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 599, tableId = 26, name = "yAstrom",
		description = "The position (y) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 600, tableId = 26, name = "yAstromErr",
		description = "Uncertainty for yAstrom",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 601, tableId = 26, name = "raAstrom",
		description = "The position (ra) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 602, tableId = 26, name = "raAstromErr",
		description = "Uncertainty for raAstrom",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 603, tableId = 26, name = "declAstrom",
		description = "The position (decl) measured for purposes of astrometry.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 604, tableId = 26, name = "declAstromErr",
		description = "Uncertainty for declAstrom",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 605, tableId = 26, name = "taiMidPoint",
		description = "If a DIASource corresponds to a single exposure, taiMidPoint represents tai time of the middle of exposure. For multiple exposures, this is middle of beginning-of-first-exposure to end-of-last-exposure",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 606, tableId = 26, name = "taiRange",
		description = "If a DIASource corresponds to a single exposure, taiRange equals to exposure length. If DIASoure corresponds to multiple exposures, it taiRange equals to end-of-last-exposure minus beginning-of-first-exposure",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 607, tableId = 26, name = "psfFlux",
		description = "PSF flux of the object.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 608, tableId = 26, name = "psfFluxErr",
		description = "Uncertainty of psfFlux.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 609, tableId = 26, name = "apFlux",
		description = "Aperture flux.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 610, tableId = 26, name = "apFluxErr",
		description = "Uncertainty of apFlux.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 611, tableId = 26, name = "modelFlux",
		description = "Adaptive 2D gauss model flux.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 39;

	INSERT INTO md_Column
	SET columnId = 612, tableId = 26, name = "modelFluxErr",
		description = "Uncertainly of modelFlux.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 40;

	INSERT INTO md_Column
	SET columnId = 613, tableId = 26, name = "petroFlux",
		description = "Petrosian flux.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET columnId = 614, tableId = 26, name = "petroFluxErr",
		description = "Uncertainty of petroFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 42;

	INSERT INTO md_Column
	SET columnId = 615, tableId = 26, name = "instFlux",
		description = "Instrumental flux.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 43;

	INSERT INTO md_Column
	SET columnId = 616, tableId = 26, name = "instFluxErr",
		description = "Uncertainty of instFlux.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 44;

	INSERT INTO md_Column
	SET columnId = 617, tableId = 26, name = "nonGrayCorrFlux",
		description = "Instrumental flux corrected for non-gray extinction.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET columnId = 618, tableId = 26, name = "nonGrayCorrFluxErr",
		description = "Uncertainty of nonGrayCorrFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET columnId = 619, tableId = 26, name = "atmCorrFlux",
		description = "Instrumental flux corrected for both gray and non-gray extinction.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 47;

	INSERT INTO md_Column
	SET columnId = 620, tableId = 26, name = "atmCorrFluxErr",
		description = "Uncertainty of atmCorrFlux.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 48;

	INSERT INTO md_Column
	SET columnId = 621, tableId = 26, name = "apDia",
		description = "Diameter of aperture (pixels)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET columnId = 622, tableId = 26, name = "Ixx",
		description = "Adaptive second moment.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET columnId = 623, tableId = 26, name = "IxxErr",
		description = "Uncertainty of Ixx: sign(covariance(x, x))*sqrt(|covariance(x, x)|)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 51;

	INSERT INTO md_Column
	SET columnId = 624, tableId = 26, name = "Iyy",
		description = "Adaptive second moment.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET columnId = 625, tableId = 26, name = "IyyErr",
		description = "Uncertainty of Iyy: sqrt(covariance(y, y))",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET columnId = 626, tableId = 26, name = "Ixy",
		description = "Adaptive second moment.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET columnId = 627, tableId = 26, name = "IxyErr",
		description = "Uncertainty of Ixy: sign(covariance(x, y))*sqrt(|covariance(x, y)|)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET columnId = 628, tableId = 26, name = "snr",
		description = "Signal-to-Noise Ratio for the PSF optimal filter.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 56;

	INSERT INTO md_Column
	SET columnId = 629, tableId = 26, name = "chi2",
		description = "Chi-square value for the PSF fit",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 57;

	INSERT INTO md_Column
	SET columnId = 630, tableId = 26, name = "sky",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET columnId = 631, tableId = 26, name = "skyErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET columnId = 632, tableId = 26, name = "flagForAssociation",
		description = "FIXME: likely we should use a Stage name here",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET columnId = 633, tableId = 26, name = "flagForDetection",
		description = "FIXME: likely we should use a Stage name here",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET columnId = 634, tableId = 26, name = "flagForWcs",
		description = "Problem/special conditions indicator (Kem noted that these flags could include delta_sky, delta_PSF, ...).&#xA;FIXME: likely we should use a Stage name here",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 62;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 27, name = "SourceClassif",
	description = "Table keeping information about source classification.";

	INSERT INTO md_Column
	SET columnId = 635, tableId = 27, name = "scId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 28, name = "SourceClassifAttr",
	description = "Entries stored in this table are used to construct the Source Classification table (columns). Examples: &quot;Cosmin Ray&quot;, &quot;Negative Excursion&quot;, &quot;Positive Excursion&quot;, &quot;Fast Mover&quot;, &quot;Flash&quot;.";

	INSERT INTO md_Column
	SET columnId = 636, tableId = 28, name = "scAttrId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 637, tableId = 28, name = "scAttrDescr",
		description = "Attribute description.",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 29, name = "SourceClassifDescr",
	description = "Entries stored in this table are used to construct the Source Classification table (rows). Examples: &quot;present in both visits&quot;, &quot;shape differs in two visits&quot;, elliptical after PSF deconvolve&quot;,  &quot;positive flux excursion&quot;.";

	INSERT INTO md_Column
	SET columnId = 638, tableId = 29, name = "scDescrId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 639, tableId = 29, name = "scDescr",
		description = "description",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 30, name = "TemplateImage",
	description = "Table that defines which template images";

	INSERT INTO md_Column
	SET columnId = 640, tableId = 30, name = "templateImageId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 31, name = "Visit",
	description = "Defines a single Visit. 1 row per LSST visit.";

	INSERT INTO md_Column
	SET columnId = 641, tableId = 31, name = "visitId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 642, tableId = 31, name = "rawFPAExposureId",
		description = "Pointer to Raw_FPA_Exposure: the two exposures that are part of this visit.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 32, name = "_AlertToType";

	INSERT INTO md_Column
	SET columnId = 643, tableId = 32, name = "alertTypeId",
		description = "Pointer to AlertType",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 644, tableId = 32, name = "alertId",
		description = "Pointer to Alert",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 33, name = "_DIASourceToAlert",
	description = "Mapping: DIASource --&amp;gt; alerts generated by the object";

	INSERT INTO md_Column
	SET columnId = 645, tableId = 33, name = "alertId",
		description = "Pointer to an entry in Alert table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 646, tableId = 33, name = "diaSourceId",
		description = "Pointer to an entry in DIASource table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 34, name = "_FPA_BiasToCMExposure",
	description = "Mapping table. Keeps information which BiasExposures are part of CalibratedMasterBiasExposure.";

	INSERT INTO md_Column
	SET columnId = 647, tableId = 34, name = "biasExposureId",
		description = "Pointer to BiasExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 648, tableId = 34, name = "cmBiasExposureId",
		description = "Pointer to CMBiasExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 35, name = "_FPA_DarkToCMExposure",
	description = "Mapping table. Keeps information which DarkExposures are part of CalibratedMasterDarkExposure, and which BiasExposures were used to generate the CalibratedMasterDarkExposures.";

	INSERT INTO md_Column
	SET columnId = 649, tableId = 35, name = "darkExposureId",
		description = "Pointer to DarkExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 650, tableId = 35, name = "biasExposureId",
		description = "Pointer to BiasExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 651, tableId = 35, name = "cmDarkExposureId",
		description = "Pointer to CMDarkExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 36, name = "_FPA_FlatToCMExposure",
	description = "Mapping table. Keeps information which FlatExposures are part of CalibratedMasterFlatExposure, and which BiasExposures &amp;amp; Dark Exposures were used to generate the CalibratedMasterFlatExposures.";

	INSERT INTO md_Column
	SET columnId = 652, tableId = 36, name = "flatExposureId",
		description = "Pointer to FlatExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 653, tableId = 36, name = "biasExposureId",
		description = "Pointer to BiasExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 654, tableId = 36, name = "darkExposureId",
		description = "Pointer to DarkExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 655, tableId = 36, name = "cmFlatExposureId",
		description = "Pointer to CMFlatExposure table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 37, name = "_FPA_FringeToCMExposure",
	description = "Mapping table. Keeps information which FlatExposures are part of CalibratedMasterFringeExposure, and which BiasExposures &amp;amp; Dark Exposures were used to generate the CalibratedMasterFringeExposures.";

	INSERT INTO md_Column
	SET columnId = 656, tableId = 37, name = "biasExposureId",
		description = "Pointer to BiasExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 657, tableId = 37, name = "darkExposureId",
		description = "Pointer to DarkExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 658, tableId = 37, name = "flatExposureId",
		description = "Pointer to FlatExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 659, tableId = 37, name = "cmFringeExposureId",
		description = "Pointer to CMFringeExposure table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 38, name = "_MovingObjectToType",
	description = "Mapping: moving object --&amp;gt; types, with probabilities";

	INSERT INTO md_Column
	SET columnId = 660, tableId = 38, name = "movingObjectId",
		description = "Pointer to entry in MovingObject table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 661, tableId = 38, name = "typeId",
		description = "Pointer to entry in ObjectType table",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 662, tableId = 38, name = "probability",
		description = "Probability that given MovingObject is of given type. Range: 0-100 (in%)",
		type = "TINYINT",
		notNull = 0,
		defaultValue = "100",
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 39, name = "_ObjectToType",
	description = "Mapping Object --&amp;gt; types, with probabilities";

	INSERT INTO md_Column
	SET columnId = 663, tableId = 39, name = "objectId",
		description = "Pointer to an entry in Object table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 664, tableId = 39, name = "typeId",
		description = "Pointer to an entry in ObjectType table",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 665, tableId = 39, name = "probability",
		description = "Probability that given object is of given type. Range 0-100 %",
		type = "TINYINT",
		notNull = 0,
		defaultValue = "100",
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 40, name = "_Science_FPA_ExposureToTemplateImage",
	description = "Mapping table: exposures used to build given template image";

	INSERT INTO md_Column
	SET columnId = 666, tableId = 40, name = "scienceFPAExposureId",
		description = "Pointer to an entry in Science FPA Exposure table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 667, tableId = 40, name = "templateImageId",
		description = "Pointer to an entry in TemplateImage table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 41, name = "_Science_FPA_Exposure_Group",
	description = "Foreign key constraint";

	INSERT INTO md_Column
	SET columnId = 668, tableId = 41, name = "cseGroupId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 669, tableId = 41, name = "darkTime",
		description = "Timestamp when corresponding CMDarkExposure was processed.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 670, tableId = 41, name = "biasTime",
		description = "Timestamp when corresponding CMBiasExposure was processed.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 671, tableId = 41, name = "u_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For u filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 672, tableId = 41, name = "g_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For g filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 673, tableId = 41, name = "r_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For r filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 674, tableId = 41, name = "i_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For i filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 675, tableId = 41, name = "z_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For z filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 676, tableId = 41, name = "y_fringeTime",
		description = "Timestamp when corresponding CMFringeExposure was processed. For y filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 677, tableId = 41, name = "u_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For u filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 678, tableId = 41, name = "g_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For g filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 679, tableId = 41, name = "r_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For r filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 680, tableId = 41, name = "i_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For i filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 681, tableId = 41, name = "z_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For z filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 682, tableId = 41, name = "y_flatTime",
		description = "Timestamp when corresponding CMFlatExposure was processed. For y filter.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 683, tableId = 41, name = "cmBiasExposureId",
		description = "Pointer to CalibratedMasterBiasExposure.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 684, tableId = 41, name = "cmDarkExposureId",
		description = "Pointer to CalibratedMasterDarkExposure.&#xA;",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 685, tableId = 41, name = "u_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for u filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 686, tableId = 41, name = "g_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for g filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 687, tableId = 41, name = "r_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for r filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 688, tableId = 41, name = "i_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for i filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 689, tableId = 41, name = "z_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for z filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 690, tableId = 41, name = "y_cmFlatExposureId",
		description = "Pointer to CalibratedMasterFlatExposure for y filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 691, tableId = 41, name = "u_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for u filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 692, tableId = 41, name = "g_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for g filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 693, tableId = 41, name = "r_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for r filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 694, tableId = 41, name = "i_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for i filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 695, tableId = 41, name = "z_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for z filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 696, tableId = 41, name = "y_cmFringeExposureId",
		description = "Pointer to CalibratedMasterFringeExposure for y filter.&#xA;",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 29;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 42, name = "_SourceClassifToDescr",
	description = "Mapping table: SourceClassif --&amp;gt; (SourceClassifAttr + SourceClassifDescr + value &quot;yes/no&quot;)";

	INSERT INTO md_Column
	SET columnId = 697, tableId = 42, name = "scId",
		description = "Pointer to an entry in SourceClassification table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 698, tableId = 42, name = "scAttrId",
		description = "Pointer to an entry in SourceClassifAttr table",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 699, tableId = 42, name = "scDescrId",
		description = "Pointer to an entry in SourceClassifDescr table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 700, tableId = 42, name = "status",
		description = "Status: 'yes' / 'no'. Default: 'yes'",
		type = "BIT",
		notNull = 0,
		defaultValue = "1",
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 43, name = "_SourceToAmp_Exposure",
	description = "Source --&amp;gt; AmpExposures";

	INSERT INTO md_Column
	SET columnId = 701, tableId = 43, name = "sourceId",
		description = "Pointer to entry in Source table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 702, tableId = 43, name = "ampExposureId",
		description = "Pointer to enty in AmpExposure table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 44, name = "_SourceToObject",
	description = "Table used to store mapping Source --&amp;gt; Object for sources that belong to more than one object (Objects that &quot;split&quot;). If a source corresponds to only one object, objectId is used. See http://lsstdev.ncsa.uiuc.edu:8100/trac/wiki/dbObjectSplits for further details.";

	INSERT INTO md_Column
	SET columnId = 703, tableId = 44, name = "objectId",
		description = "Id of the object - pointer to a row in the Object table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 704, tableId = 44, name = "sourceId",
		description = "Id of source - pointer to a row in the Source table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 705, tableId = 44, name = "splitPercentage",
		description = "percentage of the split (all for a given source must add up to 100%",
		type = "TINYINT",
		notNull = 1,
		unit = "%",
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 45, name = "_aux_FPA_Bias2CMExposure";

	INSERT INTO md_Column
	SET columnId = 706, tableId = 45, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 46, name = "_aux_FPA_Dark2CMExposure";

	INSERT INTO md_Column
	SET columnId = 707, tableId = 46, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 47, name = "_aux_FPA_Flat2CMExposure";

	INSERT INTO md_Column
	SET columnId = 708, tableId = 47, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 48, name = "_aux_FPA_Fringe2CMExposure";

	INSERT INTO md_Column
	SET columnId = 709, tableId = 48, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 49, name = "_aux_Science_FPA_Exposure_Group";

	INSERT INTO md_Column
	SET columnId = 710, tableId = 49, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 50, name = "_aux_Science_FPA_SpectraExposure_Group";

	INSERT INTO md_Column
	SET columnId = 711, tableId = 50, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 51, name = "_mops_Config",
	description = "Internal table used to ship runtime configuration data to MOPS worker nodes.&#xA;&#xA;This will eventually be replaced by some other mechanism. Note however that this data must be captured by the LSST software provenance tables.";

	INSERT INTO md_Column
	SET columnId = 712, tableId = 51, name = "configId",
		description = "Referring derived object",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 713, tableId = 51, name = "configText",
		description = "Config contents",
		type = "TEXT",
		notNull = 0,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 52, name = "_mops_EonQueue",
	description = "Internal table which maintains a queue of objects to be passed to the MOPS precovery pipeline.&#xA;&#xA;Will eventually be replaced by a different queueing mechanism.";

	INSERT INTO md_Column
	SET columnId = 714, tableId = 52, name = "movingObjectId",
		description = "Referring derived object",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 715, tableId = 52, name = "eventId",
		description = "Referring history event causing insertion",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 716, tableId = 52, name = "insertTime",
		description = "Wall clock time object was queued",
		type = "TIMESTAMP",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 717, tableId = 52, name = "status",
		description = "Processing status N =&amp;gt; new, I =&amp;gt; ID1 done, P =&amp;gt; precov done, X =&amp;gt; finished",
		type = "CHAR(1)",
		notNull = 0,
		defaultValue = "'I'",
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 53, name = "_mops_MoidQueue",
	description = "Internal table which maintain a queue of objects to be passed to the MOPS precovery pipeline.&#xA;&#xA;Will eventually be replaced by a different queueing mechanism.";

	INSERT INTO md_Column
	SET columnId = 718, tableId = 53, name = "movingObjectId",
		description = "Referring derived object",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 719, tableId = 53, name = "movingObjectVersion",
		description = "version of referring derived object",
		type = "INT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 720, tableId = 53, name = "eventId",
		description = "Referring history event causing insertion",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 721, tableId = 53, name = "insertTime",
		description = "Wall clock time object was queued",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "CURRENT_TIMESTAMP",
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 54, name = "_tmpl_Id",
	description = "Template table. Schema for lists of ids (e.g. for Objects to delete)";

	INSERT INTO md_Column
	SET columnId = 722, tableId = 54, name = "id",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 55, name = "_tmpl_IdPair",
	description = "Template table. Schema for list of id pairs.";

	INSERT INTO md_Column
	SET columnId = 723, tableId = 55, name = "first",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 724, tableId = 55, name = "second",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 56, name = "_tmpl_MatchPair",
	description = "Template table. Schema for per-visit match result tables.";

	INSERT INTO md_Column
	SET columnId = 725, tableId = 56, name = "first",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 726, tableId = 56, name = "second",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 727, tableId = 56, name = "distance",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 57, name = "_tmpl_mops_Ephemeris",
	engine = "MyISAM";

	INSERT INTO md_Column
	SET columnId = 728, tableId = 57, name = "movingObjectId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 729, tableId = 57, name = "movingObjectVersion",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 730, tableId = 57, name = "ra",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 731, tableId = 57, name = "decl",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 732, tableId = 57, name = "mjd",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 733, tableId = 57, name = "smia",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 734, tableId = 57, name = "smaa",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 735, tableId = 57, name = "pa",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 736, tableId = 57, name = "mag",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 9;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 58, name = "_tmpl_mops_Prediction",
	engine = "MyISAM";

	INSERT INTO md_Column
	SET columnId = 737, tableId = 58, name = "movingObjectId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 738, tableId = 58, name = "movingObjectVersion",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 739, tableId = 58, name = "ra",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 740, tableId = 58, name = "decl",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 741, tableId = 58, name = "mjd",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 742, tableId = 58, name = "smia",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 743, tableId = 58, name = "smaa",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 744, tableId = 58, name = "pa",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 745, tableId = 58, name = "mag",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 746, tableId = 58, name = "magErr",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 10;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 59, name = "aux_Amp_Exposure";

	INSERT INTO md_Column
	SET columnId = 747, tableId = 59, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 60, name = "aux_Bias_FPA_CMExposure";

	INSERT INTO md_Column
	SET columnId = 748, tableId = 60, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 61, name = "aux_Bias_FPA_Exposure";

	INSERT INTO md_Column
	SET columnId = 749, tableId = 61, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 62, name = "aux_Calibration_FPA_Exposure";

	INSERT INTO md_Column
	SET columnId = 750, tableId = 62, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 63, name = "aux_CloudMap";

	INSERT INTO md_Column
	SET columnId = 751, tableId = 63, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 64, name = "aux_Dark_FPA_CMExposure";

	INSERT INTO md_Column
	SET columnId = 752, tableId = 64, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 65, name = "aux_Dark_FPA_Exposure";

	INSERT INTO md_Column
	SET columnId = 753, tableId = 65, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 66, name = "aux_FPA_Exposure";

	INSERT INTO md_Column
	SET columnId = 754, tableId = 66, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 67, name = "aux_Flat_FPA_CMExposure";

	INSERT INTO md_Column
	SET columnId = 755, tableId = 67, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 68, name = "aux_Flat_FPA_Exposure";

	INSERT INTO md_Column
	SET columnId = 756, tableId = 68, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 69, name = "aux_Fringe_FPA_CMExposure";

	INSERT INTO md_Column
	SET columnId = 757, tableId = 69, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 70, name = "aux_IR_FPA_Exposure",
	description = "Kem: &quot;we need an IRexposure table, and probably a CloudMap table (which connects IRexposures to 2-D maps of clouds in a particular exposure.  The IRexposure should link to each ScienceExposure.&quot;";

	INSERT INTO md_Column
	SET columnId = 758, tableId = 70, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 71, name = "aux_LIDARshot",
	description = "Kem: &quot;There should be a LIDARshot table which has a time, wavelength, altitude, azimuth and two URLs pointing to a 1-D file of delay-time versus intensity and a transparency vs wavelenght file.&quot;";

	INSERT INTO md_Column
	SET columnId = 759, tableId = 71, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 72, name = "aux_Object";

	INSERT INTO md_Column
	SET columnId = 760, tableId = 72, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 73, name = "aux_SED",
	description = "Spectral Energy Distribution. Kem: &quot;...SED tables having SEDstdID, altitude, azimuth and an URL to&#xA;transmission vs wavelength&quot;";

	INSERT INTO md_Column
	SET columnId = 761, tableId = 73, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 74, name = "aux_Science_FPA_Exposure";

	INSERT INTO md_Column
	SET columnId = 762, tableId = 74, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 75, name = "aux_Science_FPA_SpectraExposure";

	INSERT INTO md_Column
	SET columnId = 763, tableId = 75, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 76, name = "aux_Source";

	INSERT INTO md_Column
	SET columnId = 764, tableId = 76, name = "dummy",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 77, name = "mops_Event";

	INSERT INTO md_Column
	SET columnId = 765, tableId = 77, name = "eventId",
		description = "Auto-generated internal event ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 766, tableId = 77, name = "procHistoryId",
		description = "Pointer to processing history (prv_ProcHistory)",
		type = "INT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 767, tableId = 77, name = "eventType",
		description = "Type of event (A)ttribution/(P)recovery/(D)erivation/(I)dentification/(R)emoval",
		type = "CHAR(1)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 768, tableId = 77, name = "eventTime",
		description = "Timestamp for event creation",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "CURRENT_TIMESTAMP",
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 769, tableId = 77, name = "movingObjectId",
		description = "Referring derived object ID",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 770, tableId = 77, name = "movingObjectVersion",
		description = "Pointer to resulting orbit",
		type = "INT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 771, tableId = 77, name = "orbitCode",
		description = "Information about computed orbit",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 772, tableId = 77, name = "d3",
		description = "Computed 3-parameter D-criterion",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 773, tableId = 77, name = "d4",
		description = "Computed 4-parameter D-criterion",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 774, tableId = 77, name = "ccdExposureId",
		description = "Referring to Science CCD exposure ID generating the event",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 775, tableId = 77, name = "classification",
		description = "MOPS efficiency classification for event",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 776, tableId = 77, name = "ssmId",
		description = "Matching SSM ID for clean classifications",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 12;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 78, name = "mops_Event_OrbitDerivation",
	description = "Table for associating tracklets with derivation events. There is a one to many relationship between events and tracklets (there will be multiple rows per event).";

	INSERT INTO md_Column
	SET columnId = 777, tableId = 78, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 778, tableId = 78, name = "trackletId",
		description = "Associated tracklet ID (multiple rows per event)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 79, name = "mops_Event_OrbitIdentification",
	description = "Table for associating moving objects with identification events (one object per event). The original orbit and tracklets for the child can be obtained from the MOPS_History table by looking up the child object.";

	INSERT INTO md_Column
	SET columnId = 779, tableId = 79, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 780, tableId = 79, name = "childObjectId",
		description = "Matching (child) derived object ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 80, name = "mops_Event_TrackletAttribution",
	description = "Table for associating tracklets with attribution events (one tracklet per event).";

	INSERT INTO md_Column
	SET columnId = 781, tableId = 80, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 782, tableId = 80, name = "trackletId",
		description = "Attributed tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 783, tableId = 80, name = "ephemerisDistance",
		description = "Predicted position minus actual, arcsecs",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 784, tableId = 80, name = "ephemerisUncertainty",
		description = "Predicted error ellipse semi-major axis, arcsecs",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 81, name = "mops_Event_TrackletPrecovery",
	description = "Table for associating tracklets with precovery events (one precovery per event).";

	INSERT INTO md_Column
	SET columnId = 785, tableId = 81, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 786, tableId = 81, name = "trackletId",
		description = "Precovered tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 787, tableId = 81, name = "ephemerisDistance",
		description = "Predicted position minus actual, arcsecs",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 788, tableId = 81, name = "ephemerisUncertainty",
		description = "Predicted error ellipse semi-major axis, arcsecs",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 82, name = "mops_Event_TrackletRemoval",
	description = "Table for associating tracklets with removal events (one removal per event).";

	INSERT INTO md_Column
	SET columnId = 789, tableId = 82, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 790, tableId = 82, name = "trackletId",
		description = "Removed tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 83, name = "mops_MovingObjectToTracklet",
	description = "Current membership of tracklets and moving objects.";

	INSERT INTO md_Column
	SET columnId = 791, tableId = 83, name = "movingObjectId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 792, tableId = 83, name = "trackletId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 84, name = "mops_SSM",
	description = "Table that contains synthetic solar system model (SSM) objects.";

	INSERT INTO md_Column
	SET columnId = 793, tableId = 84, name = "ssmId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 794, tableId = 84, name = "ssmDescId",
		description = "Pointer to SSM description",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 795, tableId = 84, name = "q",
		description = "semi-major axis, AU",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 796, tableId = 84, name = "e",
		description = "eccentricity e (dimensionless)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 797, tableId = 84, name = "i",
		description = "inclination, deg",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 798, tableId = 84, name = "node",
		description = "longitude of ascending node, deg",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 799, tableId = 84, name = "argPeri",
		description = "argument of perihelion, deg",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 800, tableId = 84, name = "timePeri",
		description = "time of perihelion, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 801, tableId = 84, name = "epoch",
		description = "epoch of osculating elements, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 802, tableId = 84, name = "h_v",
		description = "Absolute magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 803, tableId = 84, name = "h_ss",
		description = "??",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 804, tableId = 84, name = "g",
		description = "Slope parameter g, dimensionless",
		type = "DOUBLE",
		notNull = 0,
		unit = "-",
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 805, tableId = 84, name = "albedo",
		description = "Albedo, dimensionless",
		type = "DOUBLE",
		notNull = 0,
		unit = "-",
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 806, tableId = 84, name = "ssmObjectName",
		description = "MOPS synthetic object name",
		type = "VARCHAR(32)",
		notNull = 1,
		displayOrder = 14;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 85, name = "mops_SSMDesc",
	description = "Table containing object name prefixes and descriptions of synthetic solar system object types.";

	INSERT INTO md_Column
	SET columnId = 807, tableId = 85, name = "ssmDescId",
		description = "Auto-generated row ID",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 808, tableId = 85, name = "prefix",
		description = "MOPS prefix code S0/S1/etc.",
		type = "CHAR(4)",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 809, tableId = 85, name = "description",
		description = "Long description",
		type = "VARCHAR(100)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 86, name = "mops_Tracklet";

	INSERT INTO md_Column
	SET columnId = 810, tableId = 86, name = "trackletId",
		description = "Auto-generated internal MOPS tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 811, tableId = 86, name = "ccdExposureId",
		description = "Terminating field ID - pointer to Science_CCD_Exposure",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 812, tableId = 86, name = "procHistoryId",
		description = "Pointer to processing history (prv_ProcHistory)",
		type = "INT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 813, tableId = 86, name = "ssmId",
		description = "Matching SSM ID for clean classifications",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 814, tableId = 86, name = "velRa",
		description = "Average RA velocity deg/day, cos(dec) applied",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day",
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 815, tableId = 86, name = "velRaErr",
		description = "Uncertainty in RA velocity",
		type = "FLOAT",
		notNull = 0,
		unit = "degree/day",
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 816, tableId = 86, name = "velDecl",
		description = "Average Dec velocity, deg/day)",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day",
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 817, tableId = 86, name = "velDeclErr",
		description = "Uncertainty in Dec velocity",
		type = "FLOAT",
		notNull = 0,
		unit = "degree/day",
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 818, tableId = 86, name = "velTot",
		description = "Average total velocity, deg/day",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day",
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 819, tableId = 86, name = "accRa",
		description = "Average RA Acceleration, deg/day^2",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day^2",
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 820, tableId = 86, name = "accRaErr",
		description = "Uncertainty in RA acceleration",
		type = "FLOAT",
		notNull = 0,
		unit = "degree/day^2",
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 821, tableId = 86, name = "accDecl",
		description = "Average Dec Acceleration, deg/day^2",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day^2",
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 822, tableId = 86, name = "accDeclErr",
		description = "Uncertainty in Dec acceleration",
		type = "FLOAT",
		notNull = 0,
		unit = "degree/day^2",
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 823, tableId = 86, name = "extEpoch",
		description = "Extrapolated (central) epoch, MJD (UTC)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 824, tableId = 86, name = "extRa",
		description = "Extrapolated (central) RA, deg",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree",
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 825, tableId = 86, name = "extRaErr",
		description = "Uncertainty in extrapolated RA, deg",
		type = "FLOAT",
		notNull = 0,
		unit = "degree",
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 826, tableId = 86, name = "extDecl",
		description = "Extrapolated (central) Dec, deg",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree",
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 827, tableId = 86, name = "extDeclErr",
		description = "Uncertainty in extrapolated Dec, deg",
		type = "FLOAT",
		notNull = 0,
		unit = "degree",
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 828, tableId = 86, name = "extMag",
		description = "Extrapolated (central) magnitude",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 829, tableId = 86, name = "extMagErr",
		description = "Uncertainty in extrapolated mag, deg",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 830, tableId = 86, name = "probability",
		description = "Likelihood tracklet is real (unused currently)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 831, tableId = 86, name = "status",
		description = "processing status (unfound 'X', unattributed 'U', attributed 'A')",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 832, tableId = 86, name = "classification",
		description = "MOPS efficiency classification",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 23;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 87, name = "mops_TrackletsToDIASource",
	description = "Table maintaining many-to-many relationship between tracklets and detections.";

	INSERT INTO md_Column
	SET columnId = 833, tableId = 87, name = "trackletId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 834, tableId = 87, name = "diaSourceId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 88, name = "placeholder_Alert";

	INSERT INTO md_Column
	SET columnId = 835, tableId = 88, name = "__voEventId",
		description = "FIXME. Some sort of pointer to voEvent. Placeholder. Also, not sure if type is correct.",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 89, name = "placeholder_Object";

	INSERT INTO md_Column
	SET columnId = 836, tableId = 89, name = "uScalegram01",
		description = "&quot;Scalegram&quot;: time series as the average of the squares of the wavelet coefficients at a given scale. See Scargel et al 1993 for more details.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 837, tableId = 89, name = "uScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 838, tableId = 89, name = "uScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 839, tableId = 89, name = "uScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 840, tableId = 89, name = "uScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 841, tableId = 89, name = "uScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 842, tableId = 89, name = "uScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 843, tableId = 89, name = "uScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 844, tableId = 89, name = "uScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 845, tableId = 89, name = "uScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 846, tableId = 89, name = "uScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 847, tableId = 89, name = "uScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 848, tableId = 89, name = "uScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 849, tableId = 89, name = "uScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 850, tableId = 89, name = "uScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 851, tableId = 89, name = "uScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 852, tableId = 89, name = "uScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 853, tableId = 89, name = "uScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 854, tableId = 89, name = "uScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 855, tableId = 89, name = "uScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 856, tableId = 89, name = "uScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 857, tableId = 89, name = "uScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 858, tableId = 89, name = "uScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 859, tableId = 89, name = "uScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 860, tableId = 89, name = "uScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 861, tableId = 89, name = "gScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 862, tableId = 89, name = "gScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 863, tableId = 89, name = "gScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 864, tableId = 89, name = "gScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 865, tableId = 89, name = "gScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 866, tableId = 89, name = "gScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 867, tableId = 89, name = "gScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 868, tableId = 89, name = "gScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 869, tableId = 89, name = "gScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 870, tableId = 89, name = "gScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 871, tableId = 89, name = "gScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 872, tableId = 89, name = "gScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 873, tableId = 89, name = "gScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 874, tableId = 89, name = "gScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 39;

	INSERT INTO md_Column
	SET columnId = 875, tableId = 89, name = "gScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 40;

	INSERT INTO md_Column
	SET columnId = 876, tableId = 89, name = "gScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET columnId = 877, tableId = 89, name = "gScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 42;

	INSERT INTO md_Column
	SET columnId = 878, tableId = 89, name = "gScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 43;

	INSERT INTO md_Column
	SET columnId = 879, tableId = 89, name = "gScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 44;

	INSERT INTO md_Column
	SET columnId = 880, tableId = 89, name = "gScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET columnId = 881, tableId = 89, name = "gScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET columnId = 882, tableId = 89, name = "gScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 47;

	INSERT INTO md_Column
	SET columnId = 883, tableId = 89, name = "gScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 48;

	INSERT INTO md_Column
	SET columnId = 884, tableId = 89, name = "gScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET columnId = 885, tableId = 89, name = "gScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET columnId = 886, tableId = 89, name = "rScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 51;

	INSERT INTO md_Column
	SET columnId = 887, tableId = 89, name = "rScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET columnId = 888, tableId = 89, name = "rScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET columnId = 889, tableId = 89, name = "rScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET columnId = 890, tableId = 89, name = "rScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET columnId = 891, tableId = 89, name = "rScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET columnId = 892, tableId = 89, name = "rScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET columnId = 893, tableId = 89, name = "rScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET columnId = 894, tableId = 89, name = "rScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET columnId = 895, tableId = 89, name = "rScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET columnId = 896, tableId = 89, name = "rScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET columnId = 897, tableId = 89, name = "rScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 62;

	INSERT INTO md_Column
	SET columnId = 898, tableId = 89, name = "rScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 63;

	INSERT INTO md_Column
	SET columnId = 899, tableId = 89, name = "rScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 64;

	INSERT INTO md_Column
	SET columnId = 900, tableId = 89, name = "rScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 65;

	INSERT INTO md_Column
	SET columnId = 901, tableId = 89, name = "rScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET columnId = 902, tableId = 89, name = "rScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET columnId = 903, tableId = 89, name = "rScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET columnId = 904, tableId = 89, name = "rScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET columnId = 905, tableId = 89, name = "rScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET columnId = 906, tableId = 89, name = "rScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET columnId = 907, tableId = 89, name = "rScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 72;

	INSERT INTO md_Column
	SET columnId = 908, tableId = 89, name = "rScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 73;

	INSERT INTO md_Column
	SET columnId = 909, tableId = 89, name = "rScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 74;

	INSERT INTO md_Column
	SET columnId = 910, tableId = 89, name = "rScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 75;

	INSERT INTO md_Column
	SET columnId = 911, tableId = 89, name = "iScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 76;

	INSERT INTO md_Column
	SET columnId = 912, tableId = 89, name = "iScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 77;

	INSERT INTO md_Column
	SET columnId = 913, tableId = 89, name = "iScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 78;

	INSERT INTO md_Column
	SET columnId = 914, tableId = 89, name = "iScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 79;

	INSERT INTO md_Column
	SET columnId = 915, tableId = 89, name = "iScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 80;

	INSERT INTO md_Column
	SET columnId = 916, tableId = 89, name = "iScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 81;

	INSERT INTO md_Column
	SET columnId = 917, tableId = 89, name = "iScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 82;

	INSERT INTO md_Column
	SET columnId = 918, tableId = 89, name = "iScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 83;

	INSERT INTO md_Column
	SET columnId = 919, tableId = 89, name = "iScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 84;

	INSERT INTO md_Column
	SET columnId = 920, tableId = 89, name = "iScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 85;

	INSERT INTO md_Column
	SET columnId = 921, tableId = 89, name = "iScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 86;

	INSERT INTO md_Column
	SET columnId = 922, tableId = 89, name = "iScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 87;

	INSERT INTO md_Column
	SET columnId = 923, tableId = 89, name = "iScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 88;

	INSERT INTO md_Column
	SET columnId = 924, tableId = 89, name = "iScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 89;

	INSERT INTO md_Column
	SET columnId = 925, tableId = 89, name = "iScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 90;

	INSERT INTO md_Column
	SET columnId = 926, tableId = 89, name = "iScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 91;

	INSERT INTO md_Column
	SET columnId = 927, tableId = 89, name = "iScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 92;

	INSERT INTO md_Column
	SET columnId = 928, tableId = 89, name = "iScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 93;

	INSERT INTO md_Column
	SET columnId = 929, tableId = 89, name = "iScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 94;

	INSERT INTO md_Column
	SET columnId = 930, tableId = 89, name = "iScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 95;

	INSERT INTO md_Column
	SET columnId = 931, tableId = 89, name = "iScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 96;

	INSERT INTO md_Column
	SET columnId = 932, tableId = 89, name = "iScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 97;

	INSERT INTO md_Column
	SET columnId = 933, tableId = 89, name = "iScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 98;

	INSERT INTO md_Column
	SET columnId = 934, tableId = 89, name = "iScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 99;

	INSERT INTO md_Column
	SET columnId = 935, tableId = 89, name = "iScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 100;

	INSERT INTO md_Column
	SET columnId = 936, tableId = 89, name = "zScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 101;

	INSERT INTO md_Column
	SET columnId = 937, tableId = 89, name = "zScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 102;

	INSERT INTO md_Column
	SET columnId = 938, tableId = 89, name = "zScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 103;

	INSERT INTO md_Column
	SET columnId = 939, tableId = 89, name = "zScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 104;

	INSERT INTO md_Column
	SET columnId = 940, tableId = 89, name = "zScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 105;

	INSERT INTO md_Column
	SET columnId = 941, tableId = 89, name = "zScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 106;

	INSERT INTO md_Column
	SET columnId = 942, tableId = 89, name = "zScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 107;

	INSERT INTO md_Column
	SET columnId = 943, tableId = 89, name = "zScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 108;

	INSERT INTO md_Column
	SET columnId = 944, tableId = 89, name = "zScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 109;

	INSERT INTO md_Column
	SET columnId = 945, tableId = 89, name = "zScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 110;

	INSERT INTO md_Column
	SET columnId = 946, tableId = 89, name = "zScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 111;

	INSERT INTO md_Column
	SET columnId = 947, tableId = 89, name = "zScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 112;

	INSERT INTO md_Column
	SET columnId = 948, tableId = 89, name = "zScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 113;

	INSERT INTO md_Column
	SET columnId = 949, tableId = 89, name = "zScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 114;

	INSERT INTO md_Column
	SET columnId = 950, tableId = 89, name = "zScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 115;

	INSERT INTO md_Column
	SET columnId = 951, tableId = 89, name = "zScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 116;

	INSERT INTO md_Column
	SET columnId = 952, tableId = 89, name = "zScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 117;

	INSERT INTO md_Column
	SET columnId = 953, tableId = 89, name = "zScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 118;

	INSERT INTO md_Column
	SET columnId = 954, tableId = 89, name = "zScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 119;

	INSERT INTO md_Column
	SET columnId = 955, tableId = 89, name = "zScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 120;

	INSERT INTO md_Column
	SET columnId = 956, tableId = 89, name = "zScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 121;

	INSERT INTO md_Column
	SET columnId = 957, tableId = 89, name = "zScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 122;

	INSERT INTO md_Column
	SET columnId = 958, tableId = 89, name = "zScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 123;

	INSERT INTO md_Column
	SET columnId = 959, tableId = 89, name = "zScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 124;

	INSERT INTO md_Column
	SET columnId = 960, tableId = 89, name = "zScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 125;

	INSERT INTO md_Column
	SET columnId = 961, tableId = 89, name = "yScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 126;

	INSERT INTO md_Column
	SET columnId = 962, tableId = 89, name = "yScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 127;

	INSERT INTO md_Column
	SET columnId = 963, tableId = 89, name = "yScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 128;

	INSERT INTO md_Column
	SET columnId = 964, tableId = 89, name = "yScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 129;

	INSERT INTO md_Column
	SET columnId = 965, tableId = 89, name = "yScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 130;

	INSERT INTO md_Column
	SET columnId = 966, tableId = 89, name = "yScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 131;

	INSERT INTO md_Column
	SET columnId = 967, tableId = 89, name = "yScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 132;

	INSERT INTO md_Column
	SET columnId = 968, tableId = 89, name = "yScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 133;

	INSERT INTO md_Column
	SET columnId = 969, tableId = 89, name = "yScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 134;

	INSERT INTO md_Column
	SET columnId = 970, tableId = 89, name = "yScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 135;

	INSERT INTO md_Column
	SET columnId = 971, tableId = 89, name = "yScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 136;

	INSERT INTO md_Column
	SET columnId = 972, tableId = 89, name = "yScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 137;

	INSERT INTO md_Column
	SET columnId = 973, tableId = 89, name = "yScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 138;

	INSERT INTO md_Column
	SET columnId = 974, tableId = 89, name = "yScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 139;

	INSERT INTO md_Column
	SET columnId = 975, tableId = 89, name = "yScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 140;

	INSERT INTO md_Column
	SET columnId = 976, tableId = 89, name = "yScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 141;

	INSERT INTO md_Column
	SET columnId = 977, tableId = 89, name = "yScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 142;

	INSERT INTO md_Column
	SET columnId = 978, tableId = 89, name = "yScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 143;

	INSERT INTO md_Column
	SET columnId = 979, tableId = 89, name = "yScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 144;

	INSERT INTO md_Column
	SET columnId = 980, tableId = 89, name = "yScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 145;

	INSERT INTO md_Column
	SET columnId = 981, tableId = 89, name = "yScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 146;

	INSERT INTO md_Column
	SET columnId = 982, tableId = 89, name = "yScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 147;

	INSERT INTO md_Column
	SET columnId = 983, tableId = 89, name = "yScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 148;

	INSERT INTO md_Column
	SET columnId = 984, tableId = 89, name = "yScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 149;

	INSERT INTO md_Column
	SET columnId = 985, tableId = 89, name = "yScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 150;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 90, name = "placeholder_ObjectPhotoZ",
	description = "Extension of the Object table for photo-z related information.";

	INSERT INTO md_Column
	SET columnId = 986, tableId = 90, name = "objectId",
		description = "This is of a corresponding object from the Object table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 987, tableId = 90, name = "redshift",
		description = "Photometric redshift.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 988, tableId = 90, name = "redshiftErr",
		description = "Photometric redshift uncertainty.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 989, tableId = 90, name = "probability",
		description = "Probability that given object has photo-z. 0-100. In %. Default 100%.",
		type = "TINYINT",
		notNull = 1,
		defaultValue = "100",
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 990, tableId = 90, name = "photoZ1",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 991, tableId = 90, name = "photoZ1Err",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 992, tableId = 90, name = "photoZ2",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 993, tableId = 90, name = "photoZ2Err",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 994, tableId = 90, name = "photoZ1Outlier",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 995, tableId = 90, name = "photoZ2Outlier",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 91, name = "placeholder_SQLLog",
	engine = "MyISAM",
	description = "Table to store DB usage statistics. Placeholder.";

	INSERT INTO md_Column
	SET columnId = 996, tableId = 91, name = "sqlLogId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 997, tableId = 91, name = "tstamp",
		description = "Timestamp when query was issued",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 998, tableId = 91, name = "elapsed",
		description = "Length of the query execution (sec?)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 999, tableId = 91, name = "userId",
		description = "Unique user identifier (among users logged on?)",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1000, tableId = 91, name = "domain",
		description = "Domain name",
		type = "VARCHAR(80)",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 1001, tableId = 91, name = "ipaddr",
		description = "IP address where query originated",
		type = "VARCHAR(80)",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 1002, tableId = 91, name = "query",
		description = "Query text string (SQL)",
		type = "TEXT",
		notNull = 1,
		displayOrder = 7;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 92, name = "placeholder_Source";

	INSERT INTO md_Column
	SET columnId = 1003, tableId = 92, name = "moment0",
		description = "Sum of all flux of all pixels that belong to a source. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1004, tableId = 92, name = "moment1_x",
		description = "Center of light - x component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1005, tableId = 92, name = "moment1_y",
		description = "Center of light - y component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1006, tableId = 92, name = "moment2_xx",
		description = "Standard deviation about center of light - xx component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1007, tableId = 92, name = "moment2_xy",
		description = "Standard deviation about center of light - xy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 1008, tableId = 92, name = "moment2_yy",
		description = "Standard deviation about center of light - yy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 1009, tableId = 92, name = "moment3_xxx",
		description = "Skewness of the profile - xxx component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 1010, tableId = 92, name = "moment3_xxy",
		description = "Skewness of the profile - xxy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 1011, tableId = 92, name = "moment3_xyy",
		description = "Skewness of the profile - xyy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 1012, tableId = 92, name = "moment3_yyy",
		description = "Skewness of the profile - yyy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 1013, tableId = 92, name = "moment4_xxxx",
		description = "Kurtosis - xxxx component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 1014, tableId = 92, name = "moment4_xxxy",
		description = "Kurtosis - xxxy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 1015, tableId = 92, name = "moment4_xxyy",
		description = "Kurtosis - xxyy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 1016, tableId = 92, name = "moment4_xyyy",
		description = "Kurtosis - xyyy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 1017, tableId = 92, name = "moment4_yyyy",
		description = "Kurtosis - yyyy component. PLACEHOLDER",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 15;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 93, name = "placeholder_VarObject",
	description = "Table to store Variable Objects - this will keep a COPY of variable objects. All variable objects will be stored in the Object table. Main reasons to have this table is improving access speed to variable objects.";

	INSERT INTO md_Column
	SET columnId = 1018, tableId = 93, name = "objectId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1019, tableId = 93, name = "ra",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1020, tableId = 93, name = "decl",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1021, tableId = 93, name = "raErr",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1022, tableId = 93, name = "declErr",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 1023, tableId = 93, name = "flagForStage1",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 1024, tableId = 93, name = "flagForStage2",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 1025, tableId = 93, name = "flagForStage3",
		description = "Problem/special condition flag reported by one stage. FIXME: replace with real Stage name",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 1026, tableId = 93, name = "uAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 1027, tableId = 93, name = "uPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 1028, tableId = 93, name = "uTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 1029, tableId = 93, name = "gAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 1030, tableId = 93, name = "gPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 1031, tableId = 93, name = "gTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 1032, tableId = 93, name = "rAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 1033, tableId = 93, name = "rPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 1034, tableId = 93, name = "rTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 1035, tableId = 93, name = "iAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 1036, tableId = 93, name = "iPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 1037, tableId = 93, name = "iTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 1038, tableId = 93, name = "zAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 1039, tableId = 93, name = "zPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 1040, tableId = 93, name = "zTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 1041, tableId = 93, name = "yAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 1042, tableId = 93, name = "yPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 1043, tableId = 93, name = "yTimescale",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 1044, tableId = 93, name = "uScalegram01",
		description = "&quot;Scalegram&quot;: time series as the average of the squares of the wavelet coefficients at a given scale. See Scargel et al 1993 for more details.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 1045, tableId = 93, name = "uScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 1046, tableId = 93, name = "uScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 1047, tableId = 93, name = "uScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 1048, tableId = 93, name = "uScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 1049, tableId = 93, name = "uScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 1050, tableId = 93, name = "uScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 1051, tableId = 93, name = "uScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 1052, tableId = 93, name = "uScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 1053, tableId = 93, name = "uScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 1054, tableId = 93, name = "uScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 1055, tableId = 93, name = "uScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 1056, tableId = 93, name = "uScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 39;

	INSERT INTO md_Column
	SET columnId = 1057, tableId = 93, name = "uScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 40;

	INSERT INTO md_Column
	SET columnId = 1058, tableId = 93, name = "uScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET columnId = 1059, tableId = 93, name = "uScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 42;

	INSERT INTO md_Column
	SET columnId = 1060, tableId = 93, name = "uScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 43;

	INSERT INTO md_Column
	SET columnId = 1061, tableId = 93, name = "uScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 44;

	INSERT INTO md_Column
	SET columnId = 1062, tableId = 93, name = "uScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET columnId = 1063, tableId = 93, name = "uScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET columnId = 1064, tableId = 93, name = "uScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 47;

	INSERT INTO md_Column
	SET columnId = 1065, tableId = 93, name = "uScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 48;

	INSERT INTO md_Column
	SET columnId = 1066, tableId = 93, name = "uScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET columnId = 1067, tableId = 93, name = "uScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET columnId = 1068, tableId = 93, name = "uScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 51;

	INSERT INTO md_Column
	SET columnId = 1069, tableId = 93, name = "gScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET columnId = 1070, tableId = 93, name = "gScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET columnId = 1071, tableId = 93, name = "gScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET columnId = 1072, tableId = 93, name = "gScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET columnId = 1073, tableId = 93, name = "gScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET columnId = 1074, tableId = 93, name = "gScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET columnId = 1075, tableId = 93, name = "gScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET columnId = 1076, tableId = 93, name = "gScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET columnId = 1077, tableId = 93, name = "gScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET columnId = 1078, tableId = 93, name = "gScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET columnId = 1079, tableId = 93, name = "gScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 62;

	INSERT INTO md_Column
	SET columnId = 1080, tableId = 93, name = "gScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 63;

	INSERT INTO md_Column
	SET columnId = 1081, tableId = 93, name = "gScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 64;

	INSERT INTO md_Column
	SET columnId = 1082, tableId = 93, name = "gScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 65;

	INSERT INTO md_Column
	SET columnId = 1083, tableId = 93, name = "gScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET columnId = 1084, tableId = 93, name = "gScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET columnId = 1085, tableId = 93, name = "gScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET columnId = 1086, tableId = 93, name = "gScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET columnId = 1087, tableId = 93, name = "gScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET columnId = 1088, tableId = 93, name = "gScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET columnId = 1089, tableId = 93, name = "gScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 72;

	INSERT INTO md_Column
	SET columnId = 1090, tableId = 93, name = "gScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 73;

	INSERT INTO md_Column
	SET columnId = 1091, tableId = 93, name = "gScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 74;

	INSERT INTO md_Column
	SET columnId = 1092, tableId = 93, name = "gScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 75;

	INSERT INTO md_Column
	SET columnId = 1093, tableId = 93, name = "gScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 76;

	INSERT INTO md_Column
	SET columnId = 1094, tableId = 93, name = "rScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 77;

	INSERT INTO md_Column
	SET columnId = 1095, tableId = 93, name = "rScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 78;

	INSERT INTO md_Column
	SET columnId = 1096, tableId = 93, name = "rScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 79;

	INSERT INTO md_Column
	SET columnId = 1097, tableId = 93, name = "rScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 80;

	INSERT INTO md_Column
	SET columnId = 1098, tableId = 93, name = "rScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 81;

	INSERT INTO md_Column
	SET columnId = 1099, tableId = 93, name = "rScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 82;

	INSERT INTO md_Column
	SET columnId = 1100, tableId = 93, name = "rScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 83;

	INSERT INTO md_Column
	SET columnId = 1101, tableId = 93, name = "rScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 84;

	INSERT INTO md_Column
	SET columnId = 1102, tableId = 93, name = "rScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 85;

	INSERT INTO md_Column
	SET columnId = 1103, tableId = 93, name = "rScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 86;

	INSERT INTO md_Column
	SET columnId = 1104, tableId = 93, name = "rScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 87;

	INSERT INTO md_Column
	SET columnId = 1105, tableId = 93, name = "rScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 88;

	INSERT INTO md_Column
	SET columnId = 1106, tableId = 93, name = "rScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 89;

	INSERT INTO md_Column
	SET columnId = 1107, tableId = 93, name = "rScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 90;

	INSERT INTO md_Column
	SET columnId = 1108, tableId = 93, name = "rScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 91;

	INSERT INTO md_Column
	SET columnId = 1109, tableId = 93, name = "rScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 92;

	INSERT INTO md_Column
	SET columnId = 1110, tableId = 93, name = "rScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 93;

	INSERT INTO md_Column
	SET columnId = 1111, tableId = 93, name = "rScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 94;

	INSERT INTO md_Column
	SET columnId = 1112, tableId = 93, name = "rScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 95;

	INSERT INTO md_Column
	SET columnId = 1113, tableId = 93, name = "rScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 96;

	INSERT INTO md_Column
	SET columnId = 1114, tableId = 93, name = "rScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 97;

	INSERT INTO md_Column
	SET columnId = 1115, tableId = 93, name = "rScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 98;

	INSERT INTO md_Column
	SET columnId = 1116, tableId = 93, name = "rScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 99;

	INSERT INTO md_Column
	SET columnId = 1117, tableId = 93, name = "rScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 100;

	INSERT INTO md_Column
	SET columnId = 1118, tableId = 93, name = "rScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 101;

	INSERT INTO md_Column
	SET columnId = 1119, tableId = 93, name = "iScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 102;

	INSERT INTO md_Column
	SET columnId = 1120, tableId = 93, name = "iScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 103;

	INSERT INTO md_Column
	SET columnId = 1121, tableId = 93, name = "iScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 104;

	INSERT INTO md_Column
	SET columnId = 1122, tableId = 93, name = "iScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 105;

	INSERT INTO md_Column
	SET columnId = 1123, tableId = 93, name = "iScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 106;

	INSERT INTO md_Column
	SET columnId = 1124, tableId = 93, name = "iScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 107;

	INSERT INTO md_Column
	SET columnId = 1125, tableId = 93, name = "iScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 108;

	INSERT INTO md_Column
	SET columnId = 1126, tableId = 93, name = "iScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 109;

	INSERT INTO md_Column
	SET columnId = 1127, tableId = 93, name = "iScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 110;

	INSERT INTO md_Column
	SET columnId = 1128, tableId = 93, name = "iScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 111;

	INSERT INTO md_Column
	SET columnId = 1129, tableId = 93, name = "iScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 112;

	INSERT INTO md_Column
	SET columnId = 1130, tableId = 93, name = "iScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 113;

	INSERT INTO md_Column
	SET columnId = 1131, tableId = 93, name = "iScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 114;

	INSERT INTO md_Column
	SET columnId = 1132, tableId = 93, name = "iScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 115;

	INSERT INTO md_Column
	SET columnId = 1133, tableId = 93, name = "iScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 116;

	INSERT INTO md_Column
	SET columnId = 1134, tableId = 93, name = "iScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 117;

	INSERT INTO md_Column
	SET columnId = 1135, tableId = 93, name = "iScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 118;

	INSERT INTO md_Column
	SET columnId = 1136, tableId = 93, name = "iScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 119;

	INSERT INTO md_Column
	SET columnId = 1137, tableId = 93, name = "iScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 120;

	INSERT INTO md_Column
	SET columnId = 1138, tableId = 93, name = "iScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 121;

	INSERT INTO md_Column
	SET columnId = 1139, tableId = 93, name = "iScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 122;

	INSERT INTO md_Column
	SET columnId = 1140, tableId = 93, name = "iScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 123;

	INSERT INTO md_Column
	SET columnId = 1141, tableId = 93, name = "iScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 124;

	INSERT INTO md_Column
	SET columnId = 1142, tableId = 93, name = "iScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 125;

	INSERT INTO md_Column
	SET columnId = 1143, tableId = 93, name = "iScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 126;

	INSERT INTO md_Column
	SET columnId = 1144, tableId = 93, name = "zScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 127;

	INSERT INTO md_Column
	SET columnId = 1145, tableId = 93, name = "zScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 128;

	INSERT INTO md_Column
	SET columnId = 1146, tableId = 93, name = "zScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 129;

	INSERT INTO md_Column
	SET columnId = 1147, tableId = 93, name = "zScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 130;

	INSERT INTO md_Column
	SET columnId = 1148, tableId = 93, name = "zScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 131;

	INSERT INTO md_Column
	SET columnId = 1149, tableId = 93, name = "zScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 132;

	INSERT INTO md_Column
	SET columnId = 1150, tableId = 93, name = "zScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 133;

	INSERT INTO md_Column
	SET columnId = 1151, tableId = 93, name = "zScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 134;

	INSERT INTO md_Column
	SET columnId = 1152, tableId = 93, name = "zScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 135;

	INSERT INTO md_Column
	SET columnId = 1153, tableId = 93, name = "zScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 136;

	INSERT INTO md_Column
	SET columnId = 1154, tableId = 93, name = "zScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 137;

	INSERT INTO md_Column
	SET columnId = 1155, tableId = 93, name = "zScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 138;

	INSERT INTO md_Column
	SET columnId = 1156, tableId = 93, name = "zScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 139;

	INSERT INTO md_Column
	SET columnId = 1157, tableId = 93, name = "zScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 140;

	INSERT INTO md_Column
	SET columnId = 1158, tableId = 93, name = "zScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 141;

	INSERT INTO md_Column
	SET columnId = 1159, tableId = 93, name = "zScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 142;

	INSERT INTO md_Column
	SET columnId = 1160, tableId = 93, name = "zScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 143;

	INSERT INTO md_Column
	SET columnId = 1161, tableId = 93, name = "zScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 144;

	INSERT INTO md_Column
	SET columnId = 1162, tableId = 93, name = "zScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 145;

	INSERT INTO md_Column
	SET columnId = 1163, tableId = 93, name = "zScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 146;

	INSERT INTO md_Column
	SET columnId = 1164, tableId = 93, name = "zScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 147;

	INSERT INTO md_Column
	SET columnId = 1165, tableId = 93, name = "zScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 148;

	INSERT INTO md_Column
	SET columnId = 1166, tableId = 93, name = "zScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 149;

	INSERT INTO md_Column
	SET columnId = 1167, tableId = 93, name = "zScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 150;

	INSERT INTO md_Column
	SET columnId = 1168, tableId = 93, name = "zScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 151;

	INSERT INTO md_Column
	SET columnId = 1169, tableId = 93, name = "yScalegram01",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 152;

	INSERT INTO md_Column
	SET columnId = 1170, tableId = 93, name = "yScalegram02",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 153;

	INSERT INTO md_Column
	SET columnId = 1171, tableId = 93, name = "yScalegram03",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 154;

	INSERT INTO md_Column
	SET columnId = 1172, tableId = 93, name = "yScalegram04",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 155;

	INSERT INTO md_Column
	SET columnId = 1173, tableId = 93, name = "yScalegram05",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 156;

	INSERT INTO md_Column
	SET columnId = 1174, tableId = 93, name = "yScalegram06",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 157;

	INSERT INTO md_Column
	SET columnId = 1175, tableId = 93, name = "yScalegram07",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 158;

	INSERT INTO md_Column
	SET columnId = 1176, tableId = 93, name = "yScalegram08",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 159;

	INSERT INTO md_Column
	SET columnId = 1177, tableId = 93, name = "yScalegram09",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 160;

	INSERT INTO md_Column
	SET columnId = 1178, tableId = 93, name = "yScalegram10",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 161;

	INSERT INTO md_Column
	SET columnId = 1179, tableId = 93, name = "yScalegram11",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 162;

	INSERT INTO md_Column
	SET columnId = 1180, tableId = 93, name = "yScalegram12",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 163;

	INSERT INTO md_Column
	SET columnId = 1181, tableId = 93, name = "yScalegram13",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 164;

	INSERT INTO md_Column
	SET columnId = 1182, tableId = 93, name = "yScalegram14",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 165;

	INSERT INTO md_Column
	SET columnId = 1183, tableId = 93, name = "yScalegram15",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 166;

	INSERT INTO md_Column
	SET columnId = 1184, tableId = 93, name = "yScalegram16",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 167;

	INSERT INTO md_Column
	SET columnId = 1185, tableId = 93, name = "yScalegram17",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 168;

	INSERT INTO md_Column
	SET columnId = 1186, tableId = 93, name = "yScalegram18",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 169;

	INSERT INTO md_Column
	SET columnId = 1187, tableId = 93, name = "yScalegram19",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 170;

	INSERT INTO md_Column
	SET columnId = 1188, tableId = 93, name = "yScalegram20",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 171;

	INSERT INTO md_Column
	SET columnId = 1189, tableId = 93, name = "yScalegram21",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 172;

	INSERT INTO md_Column
	SET columnId = 1190, tableId = 93, name = "yScalegram22",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 173;

	INSERT INTO md_Column
	SET columnId = 1191, tableId = 93, name = "yScalegram23",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 174;

	INSERT INTO md_Column
	SET columnId = 1192, tableId = 93, name = "yScalegram24",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 175;

	INSERT INTO md_Column
	SET columnId = 1193, tableId = 93, name = "yScalegram25",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 176;

	INSERT INTO md_Column
	SET columnId = 1194, tableId = 93, name = "primaryPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 177;

	INSERT INTO md_Column
	SET columnId = 1195, tableId = 93, name = "primaryPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 178;

	INSERT INTO md_Column
	SET columnId = 1196, tableId = 93, name = "uPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 179;

	INSERT INTO md_Column
	SET columnId = 1197, tableId = 93, name = "gPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 180;

	INSERT INTO md_Column
	SET columnId = 1198, tableId = 93, name = "rPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 181;

	INSERT INTO md_Column
	SET columnId = 1199, tableId = 93, name = "iPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 182;

	INSERT INTO md_Column
	SET columnId = 1200, tableId = 93, name = "zPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 183;

	INSERT INTO md_Column
	SET columnId = 1201, tableId = 93, name = "yPeriodErr",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 184;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 94, name = "prv_Amplifier",
	description = "One entry per amplifier &quot;slot&quot;";

	INSERT INTO md_Column
	SET columnId = 1202, tableId = 94, name = "amplifierId",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1203, tableId = 94, name = "ccdId",
		description = "Pointer to CCD this amplifier belongs to",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1204, tableId = 94, name = "amplifierDescr",
		type = "VARCHAR(80)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 95, name = "prv_CCD",
	description = "Table that keeps assignment of Amplifier slots to CCD. 1 row = assignment for one CCD";

	INSERT INTO md_Column
	SET columnId = 1205, tableId = 95, name = "ccdId",
		description = "Unique id",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1206, tableId = 95, name = "raftId",
		description = "Pointer to raft owning this ccd",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1207, tableId = 95, name = "amp01",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1208, tableId = 95, name = "amp02",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1209, tableId = 95, name = "amp03",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 1210, tableId = 95, name = "amp04",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 1211, tableId = 95, name = "amp05",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 1212, tableId = 95, name = "amp06",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 1213, tableId = 95, name = "amp07",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 1214, tableId = 95, name = "amp08",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 1215, tableId = 95, name = "amp09",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 1216, tableId = 95, name = "amp10",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 12;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 96, name = "prv_Filter",
	engine = "MyISAM",
	description = "One row per color - the table will have 6 rows";

	INSERT INTO md_Column
	SET columnId = 1217, tableId = 96, name = "filterId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1218, tableId = 96, name = "focalPlaneId",
		description = "Pointer to FocalPlane - focal plane this filter belongs to.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1219, tableId = 96, name = "name",
		description = "String description of the filter,e.g. 'VR SuperMacho c6027'.",
		type = "VARCHAR(80)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1220, tableId = 96, name = "url",
		description = "URL for filter transmission curve. (Added from archive specs for LSST precursor data).",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1221, tableId = 96, name = "clam",
		description = "Filter centroid wavelength (Angstroms). (Added from archive specs for LSST precursor data).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 1222, tableId = 96, name = "bw",
		description = "Filter effective bandwidth (Angstroms). (Added from archive specs for LSST precursor data).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 97, name = "prv_FocalPlane",
	description = "Each row keeps assignment of Rafts to FocalPlane (there will be just one row I guess...)";

	INSERT INTO md_Column
	SET columnId = 1223, tableId = 97, name = "focalPlaneId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 98, name = "prv_Node";

	INSERT INTO md_Column
	SET columnId = 1224, tableId = 98, name = "nodeId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1225, tableId = 98, name = "policyId",
		description = "Pointer to Policy table: node-related policy.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 99, name = "prv_Pipeline",
	description = "Defines all LSST pipelines. 1 row = 1 pipeline. Actual configurations (which stages are part of given pipeline) are tracked through cnf_Stage2Pipeline";

	INSERT INTO md_Column
	SET columnId = 1226, tableId = 99, name = "pipelineId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1227, tableId = 99, name = "policyId",
		description = "Pointer to Policy table: pipeline-related table.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1228, tableId = 99, name = "pipelineName",
		description = "name of the pipeline",
		type = "VARCHAR(64)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 100, name = "prv_PipelineToRun",
	description = "Mapping table. Keep tracks of mapping which Pipelines are part of a given Run, and during what time period given configuration was valid.";

	INSERT INTO md_Column
	SET columnId = 1229, tableId = 100, name = "pipelineToRunId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1230, tableId = 100, name = "runId",
		description = "Pointer to Run table",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1231, tableId = 100, name = "pipelineId",
		description = "Pointer to Pipeline table.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 101, name = "prv_Policy";

	INSERT INTO md_Column
	SET columnId = 1232, tableId = 101, name = "policyId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1233, tableId = 101, name = "policyName",
		type = "VARCHAR(80)",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 102, name = "prv_PolicyFile";

	INSERT INTO md_Column
	SET columnId = 1234, tableId = 102, name = "policyFileId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1235, tableId = 102, name = "pathName",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1236, tableId = 102, name = "hashValue",
		type = "CHAR(32)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1237, tableId = 102, name = "modifiedDate",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 103, name = "prv_PolicyKey";

	INSERT INTO md_Column
	SET columnId = 1238, tableId = 103, name = "policyKeyId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1239, tableId = 103, name = "policyFileId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1240, tableId = 103, name = "keyName",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1241, tableId = 103, name = "keyType",
		type = "VARCHAR(16)",
		notNull = 1,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 104, name = "prv_ProcHistory",
	description = "Table keeps track of processing history. One row represents one batch of objects and/or sources and/or diasources and/or moving objects that were processed together. For each such group the table keeps track which Stage run, and time when the processing started. There is an assumption that configuration does not changes when during processing";

	INSERT INTO md_Column
	SET columnId = 1242, tableId = 104, name = "procHistoryId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 105, name = "prv_Raft",
	description = "Table that keeps assignment of CCDs to Rafts. 1 row: assignement for 1 raft";

	INSERT INTO md_Column
	SET columnId = 1243, tableId = 105, name = "raftId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1244, tableId = 105, name = "focalPlaneId",
		description = "Pointer to an entry in the focal plane.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1245, tableId = 105, name = "ccd01",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1246, tableId = 105, name = "ccd02",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1247, tableId = 105, name = "ccd03",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 1248, tableId = 105, name = "ccd04",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 1249, tableId = 105, name = "ccd05",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 1250, tableId = 105, name = "ccd06",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 1251, tableId = 105, name = "ccd07",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 1252, tableId = 105, name = "ccd08",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 1253, tableId = 105, name = "ccd09",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 11;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 106, name = "prv_Run",
	description = "Table to define LSST run. An example of a run &quot;nightly processing run&quot;";

	INSERT INTO md_Column
	SET columnId = 1254, tableId = 106, name = "runId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1255, tableId = 106, name = "policyId",
		description = "Pointer to Policy table: run-related policy.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 107, name = "prv_Slice";

	INSERT INTO md_Column
	SET columnId = 1256, tableId = 107, name = "sliceId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 108, name = "prv_Snapshot",
	description = "Table for saving significant snapshots (for example ProcessingHistory used to produce a data release)";

	INSERT INTO md_Column
	SET columnId = 1257, tableId = 108, name = "snapshotId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1258, tableId = 108, name = "procHistoryId",
		description = "Pointer to an entry in ProcessingHistory table",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1259, tableId = 108, name = "snapshotDescr",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 109, name = "prv_SoftwarePackage";

	INSERT INTO md_Column
	SET columnId = 1260, tableId = 109, name = "packageId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1261, tableId = 109, name = "packageName",
		type = "VARCHAR(64)",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 110, name = "prv_Stage",
	description = "Table that defines all LSST stages. Actual Stage configurations are tracked through Config_Stage2Pipeline";

	INSERT INTO md_Column
	SET columnId = 1262, tableId = 110, name = "stageId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1263, tableId = 110, name = "policyId",
		description = "Pointer to Policy table: Stage-related policy.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1264, tableId = 110, name = "stageName",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 111, name = "prv_StageToPipeline",
	description = "Mapping table. Keep tracks of mapping which ProcessingSteps are part of a given Pipeline and during what time period given configuration was valid.";

	INSERT INTO md_Column
	SET columnId = 1265, tableId = 111, name = "stageToPipelineId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1266, tableId = 111, name = "pipelineId",
		description = "Pointer to an entry in Pipeline table.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1267, tableId = 111, name = "stageId",
		description = "Pointer to an entry in Stage table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 112, name = "prv_StageToProcHistory",
	description = "Table that keeps information which Stages belong to given processing history";

	INSERT INTO md_Column
	SET columnId = 1268, tableId = 112, name = "stageId",
		description = "Pointer to an entry in prv_Stage table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1269, tableId = 112, name = "procHistoryId",
		description = "Pointer to ProcessingHistory",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1270, tableId = 112, name = "stageStart",
		description = "Time when stage started.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1271, tableId = 112, name = "stageEnd",
		description = "Time when stage finished.",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 113, name = "prv_StageToSlice",
	description = "Mapping table. Keeps track of mapping between Stages and Slices.";

	INSERT INTO md_Column
	SET columnId = 1272, tableId = 113, name = "stageToSliceId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1273, tableId = 113, name = "stageId",
		description = "Pointer to an entry in Stage table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1274, tableId = 113, name = "sliceId",
		description = "Pointer to an entry in Slice table.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 114, name = "prv_StageToUpdatableColumn",
	description = "Mapping table. Keeps track between Stage --&amp;gt; set of columns that given Stage can update, and time period during which given mapping is valid.";

	INSERT INTO md_Column
	SET columnId = 1275, tableId = 114, name = "stageId",
		description = "Pointer to an entry in Stage table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1276, tableId = 114, name = "columnId",
		description = "Pointer to an entry in UpdatableColumn table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1277, tableId = 114, name = "cStageToUpdateColumnId",
		description = "Pointer to an entry in Config_Stage2UpdatableColumn table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 115, name = "prv_Telescope";

	INSERT INTO md_Column
	SET columnId = 1278, tableId = 115, name = "telescopeId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1279, tableId = 115, name = "focalPlaneId",
		description = "Pointer to an entry in FocalPlane table.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 116, name = "prv_UpdatableColumn",
	description = "Keep track of all columns that are updated by pipelines/stages";

	INSERT INTO md_Column
	SET columnId = 1280, tableId = 116, name = "columnId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1281, tableId = 116, name = "tableId",
		description = "Pointer to an entry in UpdatableTable, a table this column belongs to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1282, tableId = 116, name = "columnName",
		description = "Name, must be the same as in the database schema.",
		type = "VARCHAR(64)",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 117, name = "prv_UpdatableTable",
	description = "Keeps track of names of database tables that are (or can be) updated by stages.";

	INSERT INTO md_Column
	SET columnId = 1283, tableId = 117, name = "tableId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1284, tableId = 117, name = "tableName",
		description = "Name of table (must be the same as in schema, for example Object, DIASource...)",
		type = "VARCHAR(64)",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 118, name = "prv_cnf_Amplifier",
	engine = "MyISAM",
	description = "Table to store amplifier configuration. One row = hardware configuration of one amplifier";

	INSERT INTO md_Column
	SET columnId = 1285, tableId = 118, name = "cAmplifierId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1286, tableId = 118, name = "amplifierId",
		description = "Pointer to Amplifier table - amplifier that this config corresponds to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1287, tableId = 118, name = "serialNumber",
		description = "FIXME: Not sure what the type should be",
		type = "VARCHAR(40)",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1288, tableId = 118, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1289, tableId = 118, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 119, name = "prv_cnf_CCD",
	description = "Table to store ccd configuration. One row = hardware configuration of one ccd";

	INSERT INTO md_Column
	SET columnId = 1290, tableId = 119, name = "cCCDId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1291, tableId = 119, name = "ccdId",
		description = "Pointer to CCD table - ccd that this configuration corresponds to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1292, tableId = 119, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1293, tableId = 119, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 120, name = "prv_cnf_Filter",
	description = "Table to store filter configuration. One row = one physical filter. If a filter is replaced, a new entry should be created here";

	INSERT INTO md_Column
	SET columnId = 1294, tableId = 120, name = "cFilterId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1295, tableId = 120, name = "filterId",
		description = "Pointer to Filter table - filter that this configuration corresponds to.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1296, tableId = 120, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1297, tableId = 120, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 121, name = "prv_cnf_FocalPlane",
	description = "Table to store focal plane configuration.";

	INSERT INTO md_Column
	SET columnId = 1298, tableId = 121, name = "cFocalPlaneId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1299, tableId = 121, name = "focalPlaneId",
		description = "Pointer to FocalPlane table - focal plane that this configuration corresponds to.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1300, tableId = 121, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1301, tableId = 121, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 122, name = "prv_cnf_MaskAmpImage";

	INSERT INTO md_Column
	SET columnId = 1302, tableId = 122, name = "cMaskAmpImageId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1303, tableId = 122, name = "amplifierId",
		description = "Pointer to Amplifier table - this determines which amplifier this config is used for.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1304, tableId = 122, name = "url",
		description = "Logical URL to the MaskIage file corresponding to a given amplifier.",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1305, tableId = 122, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1306, tableId = 122, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 123, name = "prv_cnf_Node";

	INSERT INTO md_Column
	SET columnId = 1307, tableId = 123, name = "cNodeId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1308, tableId = 123, name = "nodeId",
		description = "Pointer to Node table - node that this configuration corresponds to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1309, tableId = 123, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1310, tableId = 123, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 124, name = "prv_cnf_PipelineToRun";

	INSERT INTO md_Column
	SET columnId = 1311, tableId = 124, name = "cPipelineToRunId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1312, tableId = 124, name = "pipelineToRunId",
		description = "Pointer to entry in Pipeline2Run table that this config corresponds to.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1313, tableId = 124, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1314, tableId = 124, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 125, name = "prv_cnf_Policy";

	INSERT INTO md_Column
	SET columnId = 1315, tableId = 125, name = "cPolicyId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1316, tableId = 125, name = "policyId",
		description = "Pointer to Policy table - policy that this config corresponds to.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1317, tableId = 125, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1318, tableId = 125, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 126, name = "prv_cnf_PolicyKey";

	INSERT INTO md_Column
	SET columnId = 1319, tableId = 126, name = "policyKeyId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1320, tableId = 126, name = "value",
		type = "TEXT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1321, tableId = 126, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1322, tableId = 126, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 127, name = "prv_cnf_Raft",
	description = "Table to store raft configuration. One row = hardware configuration of one raft";

	INSERT INTO md_Column
	SET columnId = 1323, tableId = 127, name = "cRaftId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1324, tableId = 127, name = "raftId",
		description = "Pointer to Raft table - raft that this config corresponds to.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1325, tableId = 127, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1326, tableId = 127, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 128, name = "prv_cnf_Slice";

	INSERT INTO md_Column
	SET columnId = 1327, tableId = 128, name = "nodeId",
		description = "Pointer to a node that this given slice runs on.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1328, tableId = 128, name = "sliceId",
		description = "Pointer to an entry in Slice table that this config corresponds to.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1329, tableId = 128, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1330, tableId = 128, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 129, name = "prv_cnf_SoftwarePackage";

	INSERT INTO md_Column
	SET columnId = 1331, tableId = 129, name = "packageId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1332, tableId = 129, name = "version",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1333, tableId = 129, name = "directory",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1334, tableId = 129, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1335, tableId = 129, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 130, name = "prv_cnf_StageToPipeline";

	INSERT INTO md_Column
	SET columnId = 1336, tableId = 130, name = "cStageToPipelineId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1337, tableId = 130, name = "stageToPipelineId",
		description = "Pointer to entry in Stage2Pipeline that this config corresponds to.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1338, tableId = 130, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1339, tableId = 130, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 131, name = "prv_cnf_StageToSlice";

	INSERT INTO md_Column
	SET columnId = 1340, tableId = 131, name = "cStageToSliceId",
		description = "Unique id.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1341, tableId = 131, name = "stageToSliceId",
		description = "Pointer to an entry in Stage2SliceId that this config corresponds to.",
		type = "MEDIUMINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1342, tableId = 131, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1343, tableId = 131, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 132, name = "prv_cnf_StageToUpdatableColumn";

	INSERT INTO md_Column
	SET columnId = 1344, tableId = 132, name = "c_stageToUpdatableColumn",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1345, tableId = 132, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1346, tableId = 132, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 133, name = "prv_cnf_Telescope";

	INSERT INTO md_Column
	SET columnId = 1347, tableId = 133, name = "cTelescopeId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1348, tableId = 133, name = "telescopeId",
		description = "Pointer to Telescope table - telescope that this configuration corresponds to.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1349, tableId = 133, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1350, tableId = 133, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 134, name = "sdqa_ImageStatus",
	description = "Unique set of status names and their definitions, e.g. &quot;passed&quot;, &quot;failed&quot;, etc. ";

	INSERT INTO md_Column
	SET columnId = 1351, tableId = 134, name = "sdqa_imageStatusId",
		description = "Primary key",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1352, tableId = 134, name = "statusName",
		description = "One-word, camel-case, descriptive name of a possible image status (e.g., passedAuto, marginallyPassedManual, etc.)",
		type = "VARCHAR(30)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1353, tableId = 134, name = "definition",
		description = "Detailed Definition of the image status",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 135, name = "sdqa_Metric",
	description = "Unique set of metric names and associated metadata (e.g., &quot;nDeadPix&quot;, &quot;median&quot;, etc.). There will be approximately 30 records total in this table.";

	INSERT INTO md_Column
	SET columnId = 1354, tableId = 135, name = "sdqa_metricId",
		description = "Primary key.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1355, tableId = 135, name = "metricName",
		description = "One-word, camel-case, descriptive name of a possible metric (e.g., mSatPix, median, etc).",
		type = "VARCHAR(30)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1356, tableId = 135, name = "physicalUnits",
		description = "Physical units of metric.",
		type = "VARCHAR(30)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1357, tableId = 135, name = "dataType",
		description = "Flag indicating whether data type of the metric value is integer (0) or float (1)",
		type = "CHAR(1)",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1358, tableId = 135, name = "definition",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 136, name = "sdqa_Rating_ForScienceAmpExposure",
	description = "Various SDQA ratings for a given amplifier image. There will approximately 30 of these records per image record.";

	INSERT INTO md_Column
	SET columnId = 1359, tableId = 136, name = "sdqa_ratingId",
		description = "Primary key. Auto-increment is used, we define a composite unique key, so potential duplicates will be captured.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1360, tableId = 136, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1361, tableId = 136, name = "sdqa_thresholdId",
		description = "Pointer to sdqa_Threshold.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1362, tableId = 136, name = "ampExposureId",
		description = "Pointer to Science_Amp_Exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1363, tableId = 136, name = "metricValue",
		description = "Value of this SDQA metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 1364, tableId = 136, name = "metricErr",
		description = "Uncertainty of the value of this metric.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 137, name = "sdqa_Rating_ForScienceCCDExposure",
	description = "Various SDQA ratings for a given CCD image.";

	INSERT INTO md_Column
	SET columnId = 1365, tableId = 137, name = "sdqa_ratingId",
		description = "Primary key. Auto-increment is used, we define a composite unique key, so potential duplicates will be captured.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1366, tableId = 137, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1367, tableId = 137, name = "sdqa_thresholdId",
		description = "Pointer to sdqa_Threshold.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1368, tableId = 137, name = "ccdExposureId",
		description = "Pointer to Science_CCD_Exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1369, tableId = 137, name = "metricValue",
		description = "Value of this SDQA metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 1370, tableId = 137, name = "metricErr",
		description = "Uncertainty of the value of this metric.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 138, name = "sdqa_Rating_ForScienceFPAExposure",
	description = "Various SDQA ratings for a given FPA image.";

	INSERT INTO md_Column
	SET columnId = 1371, tableId = 138, name = "sdqa_ratingId",
		description = "Primary key. Auto-increment is used, we define a composite unique key, so potential duplicates will be captured.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1372, tableId = 138, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1373, tableId = 138, name = "sdqa_thresholdId",
		description = "Pointer to sdqa_Threshold.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1374, tableId = 138, name = "exposureId",
		description = "Pointer to Science_FPA_Exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1375, tableId = 138, name = "metricValue",
		description = "Value of this SDQA metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 1376, tableId = 138, name = "metricErr",
		description = "Uncertainty of the value of this metric.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 139, name = "sdqa_Threshold",
	description = "Version-controlled metric thresholds. Total number of these records is approximately equal to 30 x the number of times the thresholds will be changed over the entire period of LSST operations (of ordre of 100), with most of the changes occuring in the first year of operations.";

	INSERT INTO md_Column
	SET columnId = 1377, tableId = 139, name = "sdqa_thresholdId",
		description = "Primary key.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 1378, tableId = 139, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 1379, tableId = 139, name = "upperThreshold",
		description = "Threshold for which a metric value is tested to be greater than.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 1380, tableId = 139, name = "lowerThreshold",
		description = "Threshold for which a metric value is tested to be less than.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 1381, tableId = 139, name = "createdDate",
		description = "Database timestamp when the record is inserted.",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "CURRENT_TIMESTAMP",
		displayOrder = 5;

