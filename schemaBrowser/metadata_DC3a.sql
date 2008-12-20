
-- LSST Database Metadata
-- $Revision$
-- $Date$
--
-- See <http://dev.lsstcorp.org/trac/wiki/Copyrights>
-- for copyright information.


DROP DATABASE IF EXISTS lsst_schema_browser_DC3a;
CREATE DATABASE lsst_schema_browser_DC3a;
USE lsst_schema_browser_DC3a;


CREATE TABLE AAA_Version_DC3a_3_0_8 (version CHAR);


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
SET tableId = 1, name = "CCD_Detector";

	INSERT INTO md_Column
	SET columnId = 1, tableId = 1, name = "ccdDetectorId",
		description = "from file name (required for raw science images)",
		type = "INTEGER",
		notNull = 1,
		defaultValue = "1",
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 2, tableId = 1, name = "biasSec",
		description = "Bias section (ex: '[2045:2108,1:4096]')",
		type = "VARCHAR(20)",
		notNull = 1,
		defaultValue = "'[0:0,0:0]'",
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 3, tableId = 1, name = "trimSec",
		description = "Trim section (ex: '[1:2044,1:4096]')",
		type = "VARCHAR(20)",
		notNull = 1,
		defaultValue = "'[0:0,0:0]'",
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 4, tableId = 1, name = "gain",
		description = "Detector/amplifier gain",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 5, tableId = 1, name = "rdNoise",
		description = "Read noise for detector/amplifier",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 6, tableId = 1, name = "saturate",
		description = "Maximum data value for A/D converter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 2, name = "DIASource",
	engine = "MyISAM",
	description = "Table to store all Difference Image Analysis (DIA) Sources.";

	INSERT INTO md_Column
	SET columnId = 7, tableId = 2, name = "diaSourceId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 8, tableId = 2, name = "ccdExposureId",
		description = "Pointer to Raw_CCD_Exposure table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 9, tableId = 2, name = "diaSource2Id",
		description = "Id of the corresponding diaSourceId measured in the other exposure from the same visit.",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 10, tableId = 2, name = "filterId",
		description = "Pointer to Filter table - filter used to take the Exposure where this source was measured.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 11, tableId = 2, name = "objectId",
		description = "Pointer to Object table. Might be NULL (each DIASource will point to either MovingObject or Object)",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 12, tableId = 2, name = "movingObjectId",
		description = "Pointer to MovingObject table. Might be NULL (each DIASource will point to either MovingObject or Object)",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 13, tableId = 2, name = "colc",
		description = "corresponds to &quot;double _colc&quot;",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 14, tableId = 2, name = "colcErr",
		description = "Error in pixel X-coordinate.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 15, tableId = 2, name = "rowc",
		description = "corresponds to &quot;double _rowc&quot;",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 16, tableId = 2, name = "rowcErr",
		description = "Error in pixel Y-coordinate.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 17, tableId = 2, name = "dcol",
		description = "extent in row",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 18, tableId = 2, name = "drow",
		description = "extent in row",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 19, tableId = 2, name = "ra",
		description = "RA-coordinate of the source centroid (degrees)&#xA;Need to support accuracy ~ 0.0001 arcsec.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 20, tableId = 2, name = "raErr4detection",
		description = "Error in centroid RA coordinate (miliarcsec) coming from Detection Pipeline [FIXME, maybe use Stage name here?].",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 21, tableId = 2, name = "decErr4detection",
		description = "Error in centroid Dec coordinate (miliarcsec) coming from Detection Pipeline [FIXME, maybe use Stage name here?].",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 22, tableId = 2, name = "raErr4wcs",
		description = "Error in centroid RA coordinate (miliarcsec) coming from WCS Stage.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 23, tableId = 2, name = "decl",
		description = "Dec coordinate of the source centroid (degrees). Need to support accuracy ~0.0001 arcsec.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 24, tableId = 2, name = "decErr4wcs",
		description = "Error in centroid Dec coordinate (miliarcsec) coming from WCS Stage.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 25, tableId = 2, name = "cx",
		description = "x-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 26, tableId = 2, name = "cy",
		description = "y-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 27, tableId = 2, name = "cz",
		description = "z-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 28, tableId = 2, name = "taiMidPoint",
		description = "If a DIASource corresponds to a single exposure, taiMidPoint represents tai time of the middle of exposure. For multiple exposures, this is middle of beginning-of-first-exposure to end-of-last-exposure.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 29, tableId = 2, name = "taiRange",
		description = "If a DIASource corresponds to a single exposure, taiRange equals to exposure length. If DIASoure corresponds to multiple exposures, it taiRange equals to end-of-last-exposure minus beginning-of-first-exposure.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 30, tableId = 2, name = "fwhmA",
		description = "Size of the object along major axis (pixels)",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 31, tableId = 2, name = "fwhmB",
		description = "Size of the object along minor axis (pixels).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 32, tableId = 2, name = "fwhmTheta",
		description = "Position angle of the major axis w.r.t. X-axis (measured in degrees).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 33, tableId = 2, name = "flux",
		description = "Measured DIA flux for the source (ADUs). Range is just a guesstimate, based on SM values [FIXME]",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 34, tableId = 2, name = "fluxErr",
		description = "Error of the measured flux (ADUs). Range is just a guesstimate, based on SM values [FIXME]",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 35, tableId = 2, name = "psfMag",
		description = "PSF magnitude of the object",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 36, tableId = 2, name = "psfMagErr",
		description = "Uncertainty of PSF magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 37, tableId = 2, name = "apMag",
		description = "Aperture magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 38, tableId = 2, name = "apMagErr",
		description = "Uncertainty of aperture magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 39, tableId = 2, name = "modelMag",
		description = "model magnitude (adaptive 2D gauss)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 40, tableId = 2, name = "modelMagErr",
		description = "Uncertainly of model magnitude.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 41, tableId = 2, name = "instMag",
		description = "Instrumental magnitude.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 42, tableId = 2, name = "instMagErr",
		description = "Uncertainty of instMag.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 43, tableId = 2, name = "apDia",
		description = "Diameter of aperture (pixels)",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 44, tableId = 2, name = "flagClassification",
		description = "A flag capturing information about this DIASource classification.",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 45, tableId = 2, name = "_dataSource",
		description = "This column is for DC2 only - it indicates which data source given DIASource is coming from.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 39;

	INSERT INTO md_Column
	SET columnId = 46, tableId = 2, name = "snr",
		description = "Signal-to-Noise ratio",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 40;

	INSERT INTO md_Column
	SET columnId = 47, tableId = 2, name = "chi2",
		description = "Chi-square value for the PSF fit",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 41;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 3, name = "Filter";

	INSERT INTO md_Column
	SET columnId = 48, tableId = 3, name = "filterId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 49, tableId = 3, name = "filtURL",
		description = "URL for filter transmission curve",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 50, tableId = 3, name = "filtName",
		description = "Filter name",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 51, tableId = 3, name = "photClam",
		description = "Filter centroid wavelength",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 52, tableId = 3, name = "photBW",
		description = "System effective bandwidth",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 4, name = "MovingObject",
	description = "Table to store description of the Solar System (moving) Objects.&#xA;";

	INSERT INTO md_Column
	SET columnId = 53, tableId = 4, name = "movingObjectId",
		description = "Moving object unique identified.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 54, tableId = 4, name = "movingObjectVersion",
		description = "Version number for the moving object. Updates to orbital parameters will result in a new version (row) of the object, preserving the orbit refinement history",
		type = "INT",
		notNull = 1,
		defaultValue = "'1'",
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 55, tableId = 4, name = "procHistoryId",
		description = "Pointer to ProcessingHistory table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 56, tableId = 4, name = "taxonomicTypeId",
		description = "Pointer to ObjectType table for asteroid taxonomic type",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 57, tableId = 4, name = "ssmObjectName",
		description = "MOPS base-64 SSM object name, included for convenience. This name can be obtained from `mops_SSM` by joining on `ssmId`",
		type = "VARCHAR(32)",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 58, tableId = 4, name = "q",
		description = "semi-major axis of the orbit (AU)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 59, tableId = 4, name = "e",
		description = "eccentricity e (dimensionless)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 60, tableId = 4, name = "i",
		description = "Inclination of the orbit.",
		type = "DOUBLE",
		notNull = 1,
		unit = "deg",
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 61, tableId = 4, name = "node",
		description = "Longitude of ascending node.",
		type = "DOUBLE",
		notNull = 1,
		unit = "deg",
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 62, tableId = 4, name = "meanAnom",
		description = "Mean anomaly of the orbit",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 63, tableId = 4, name = "argPeri",
		description = "Argument of perihelion.",
		type = "DOUBLE",
		notNull = 1,
		unit = "deg",
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 64, tableId = 4, name = "distPeri",
		description = "perihelion distance (AU)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 65, tableId = 4, name = "timePeri",
		description = "time of perihelion passage, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 66, tableId = 4, name = "epoch",
		description = "epoch of osculating elements, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 67, tableId = 4, name = "h_v",
		description = "Absolute magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 68, tableId = 4, name = "g",
		description = "Slope parameter g",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 69, tableId = 4, name = "rotationPeriod",
		description = "Rotation period, days",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 70, tableId = 4, name = "rotationEpoch",
		description = "Rotation time origin, MJD (UTC)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 71, tableId = 4, name = "albedo",
		description = "Albedo (dimensionless)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 72, tableId = 4, name = "poleLat",
		description = "Rotation pole latitude (degrees)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 73, tableId = 4, name = "poleLon",
		description = "Rotation pole longitude (degrees)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 74, tableId = 4, name = "d3",
		description = "3-parameter D-criterion (dimensionless) WRT SSM object",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 75, tableId = 4, name = "d4",
		description = "4-parameter D-criterion (dimensionless) WRT SSM object",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 76, tableId = 4, name = "orbFitResidual",
		description = "Orbit fit RMS residual.",
		type = "DOUBLE",
		notNull = 1,
		unit = "argsec",
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 77, tableId = 4, name = "orbFitChi2",
		description = "orbit fit chi-squared statistic",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 78, tableId = 4, name = "classification",
		description = "MOPS efficiency classification ('C'/'M'/'B'/'N'/'X')",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 79, tableId = 4, name = "ssmId",
		description = "Source SSM object for C classification",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 80, tableId = 4, name = "mopsStatus",
		description = "NULL, or set to 'M' when DO is merged with parent",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 81, tableId = 4, name = "stablePass",
		description = "NULL, or set to 'Y' when stable precovery pass completed",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 82, tableId = 4, name = "timeCreated",
		description = "Timestamp for row creation (this is the time of moving object creation for the first version of that object)",
		type = "TIMESTAMP",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 83, tableId = 4, name = "uMag",
		description = "Weighted average apparent magnitude in u filter.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 84, tableId = 4, name = "uMagErr",
		description = "Uncertainty of uMag.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 85, tableId = 4, name = "uAmplitude",
		description = "Characteristic magnitude scale of the flux variations for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 86, tableId = 4, name = "uPeriod",
		description = "Period of flux variations (if regular) for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 87, tableId = 4, name = "gMag",
		description = "Weighted average apparent magnitude in g filter.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 88, tableId = 4, name = "gMagErr",
		description = "Uncertainty of gMag.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 89, tableId = 4, name = "gAmplitude",
		description = "Characteristic magnitude scale of the flux variations for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 90, tableId = 4, name = "gPeriod",
		description = "Period of flux variations (if regular) for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 91, tableId = 4, name = "rMag",
		description = "Weighted average apparent magnitude in r filter.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 39;

	INSERT INTO md_Column
	SET columnId = 92, tableId = 4, name = "rMagErr",
		description = "Uncertainty of rMag.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 40;

	INSERT INTO md_Column
	SET columnId = 93, tableId = 4, name = "rAmplitude",
		description = "Characteristic magnitude scale of the flux variations for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET columnId = 94, tableId = 4, name = "rPeriod",
		description = "Period of flux variations (if regular) for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 42;

	INSERT INTO md_Column
	SET columnId = 95, tableId = 4, name = "iMag",
		description = "Weighted average apparent magnitude in i filter.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 43;

	INSERT INTO md_Column
	SET columnId = 96, tableId = 4, name = "iMagErr",
		description = "Uncertainty of iMag.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 44;

	INSERT INTO md_Column
	SET columnId = 97, tableId = 4, name = "iAmplitude",
		description = "Characteristic magnitude scale of the flux variations for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET columnId = 98, tableId = 4, name = "iPeriod",
		description = "Period of flux variations (if regular) for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET columnId = 99, tableId = 4, name = "zMag",
		description = "Weighted average apparent magnitude in z filter.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 47;

	INSERT INTO md_Column
	SET columnId = 100, tableId = 4, name = "zMagErr",
		description = "Uncertainty of zMag.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 48;

	INSERT INTO md_Column
	SET columnId = 101, tableId = 4, name = "zAmplitude",
		description = "Characteristic magnitude scale of the flux variations for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET columnId = 102, tableId = 4, name = "zPeriod",
		description = "Period of flux variations (if regular) for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET columnId = 103, tableId = 4, name = "yMag",
		description = "Weighted average apparent magnitude in y filter.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 51;

	INSERT INTO md_Column
	SET columnId = 104, tableId = 4, name = "yMagErr",
		description = "Uncertainty of yMag.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 52;

	INSERT INTO md_Column
	SET columnId = 105, tableId = 4, name = "yAmplitude",
		description = "Characteristic magnitude scale of the flux variations for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET columnId = 106, tableId = 4, name = "yPeriod",
		description = "Period of flux variations (if regular) for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET columnId = 107, tableId = 4, name = "flag",
		description = "Problem/special condition flag.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET columnId = 108, tableId = 4, name = "src01",
		description = "square root of covariance EC EC (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET columnId = 109, tableId = 4, name = "src02",
		description = "square root of covariance EC QR (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET columnId = 110, tableId = 4, name = "src03",
		description = "square root of covariance QR QR (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET columnId = 111, tableId = 4, name = "src04",
		description = "square root of covariance EC TP (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET columnId = 112, tableId = 4, name = "src05",
		description = "square root of covariance QR TP (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET columnId = 113, tableId = 4, name = "src06",
		description = "square root of covariance TP TP (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET columnId = 114, tableId = 4, name = "src07",
		description = "square root of covariance EC OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 62;

	INSERT INTO md_Column
	SET columnId = 115, tableId = 4, name = "src08",
		description = "square root of covariance QR OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 63;

	INSERT INTO md_Column
	SET columnId = 116, tableId = 4, name = "src09",
		description = "square root of covariance TP OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 64;

	INSERT INTO md_Column
	SET columnId = 117, tableId = 4, name = "src10",
		description = "square root of covariance OM OM (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 65;

	INSERT INTO md_Column
	SET columnId = 118, tableId = 4, name = "src11",
		description = "square root of covariance EC W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET columnId = 119, tableId = 4, name = "src12",
		description = "square root of covariance QR W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET columnId = 120, tableId = 4, name = "src13",
		description = "square root of covariance TP W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET columnId = 121, tableId = 4, name = "src14",
		description = "square root of covariance OM W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET columnId = 122, tableId = 4, name = "src15",
		description = "square root of covariance W  W  (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET columnId = 123, tableId = 4, name = "src16",
		description = "square root of covariance EC IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET columnId = 124, tableId = 4, name = "src17",
		description = "square root of covariance QR IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 72;

	INSERT INTO md_Column
	SET columnId = 125, tableId = 4, name = "src18",
		description = "square root of covariance TP IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 73;

	INSERT INTO md_Column
	SET columnId = 126, tableId = 4, name = "src19",
		description = "square root of covariance OM IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 74;

	INSERT INTO md_Column
	SET columnId = 127, tableId = 4, name = "src20",
		description = "square root of covariance W  IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 75;

	INSERT INTO md_Column
	SET columnId = 128, tableId = 4, name = "src21",
		description = "square root of covariance IN IN (see SQL documentation)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 76;

	INSERT INTO md_Column
	SET columnId = 129, tableId = 4, name = "convCode",
		description = "JPL convergence code",
		type = "VARCHAR(8)",
		notNull = 0,
		displayOrder = 77;

	INSERT INTO md_Column
	SET columnId = 130, tableId = 4, name = "o_minus_c",
		description = "Vestigial observed-computed position, essentially RMS residual",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 78;

	INSERT INTO md_Column
	SET columnId = 131, tableId = 4, name = "moid1",
		description = "Minimum orbital intersection distance (MOID) solution 1",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 79;

	INSERT INTO md_Column
	SET columnId = 132, tableId = 4, name = "moidLong1",
		description = "Longitude of MOID 1",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 80;

	INSERT INTO md_Column
	SET columnId = 133, tableId = 4, name = "moid2",
		description = "Minimum orbital intersection distance (MOID) solution 2",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 81;

	INSERT INTO md_Column
	SET columnId = 134, tableId = 4, name = "moidLong2",
		description = "Longitude of MOID 2",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 82;

	INSERT INTO md_Column
	SET columnId = 135, tableId = 4, name = "arcLengthDays",
		description = "Arc length of detections used to compute orbit",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 83;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 5, name = "Object",
	engine = "MyISAM",
	description = "Description of the multi-epoch static object. (Kem: do we link Object and DIAObject tables? Right now it's done through the source tables)";

	INSERT INTO md_Column
	SET columnId = 136, tableId = 5, name = "objectId",
		description = "Unique id.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 137, tableId = 5, name = "ra",
		description = "RA-coordinate of the object (degrees). Need to support accuracy ~0.0001 arcsec.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 138, tableId = 5, name = "decl",
		description = "Dec-coordinate of the object (degrees). Need to support accuracy ~0.0001 arcsec",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 139, tableId = 5, name = "muRA",
		description = "Derived proper motion (right ascension).",
		type = "DOUBLE",
		notNull = 0,
		unit = "miliarcsec/year",
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 140, tableId = 5, name = "muRAErr",
		description = "Uncertainty of the muRA.",
		type = "DOUBLE",
		notNull = 0,
		unit = "miliarcsec/year",
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 141, tableId = 5, name = "muDecl",
		description = "Derived proper motion (declination).",
		type = "DOUBLE",
		notNull = 0,
		unit = "miliarcsec/year",
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 142, tableId = 5, name = "muDeclErr",
		description = "Uncertainty of the muDecl.",
		type = "DOUBLE",
		notNull = 0,
		unit = "miliarcsec/year",
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 143, tableId = 5, name = "parallax",
		description = "Derived parallax.",
		type = "FLOAT",
		notNull = 0,
		unit = "miliarcsec",
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 144, tableId = 5, name = "parallaxErr",
		description = "Parallax uncertainty.",
		type = "FLOAT",
		notNull = 0,
		unit = "miliarcsec",
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 145, tableId = 5, name = "ugColor",
		description = "Precalculated color (difference between u and g).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 146, tableId = 5, name = "grColor",
		description = "Precalculated color (difference between g and r).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 147, tableId = 5, name = "riColor",
		description = "Precalculated color (difference between r and i).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 148, tableId = 5, name = "izColor",
		description = "Precalculated color (difference between i and z).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 149, tableId = 5, name = "zyColor",
		description = "Precalculated color (difference between z and y).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 150, tableId = 5, name = "cx",
		description = "x-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 151, tableId = 5, name = "cxErr",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 152, tableId = 5, name = "cy",
		description = "z-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 153, tableId = 5, name = "cyErr",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 154, tableId = 5, name = "cz",
		description = "z-component of the (RA,Dec) unit vector",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 155, tableId = 5, name = "czErr",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 156, tableId = 5, name = "isProvisional",
		description = "If this is set to true it indicates that the object was created at the base camp. If set to false, it means it was created by Deep Detection.",
		type = "BOOL",
		notNull = 0,
		defaultValue = "FALSE",
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 157, tableId = 5, name = "uMag",
		description = "u-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 158, tableId = 5, name = "uMagErr",
		description = "u-magnitude error",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 159, tableId = 5, name = "uErrA",
		description = "Large dimension of the position error ellipse, assuming gaussian scatter (arcsec).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 160, tableId = 5, name = "uErrB",
		description = "Small dimension of the position error ellipse, assuming gaussian scatter (arcsec).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 161, tableId = 5, name = "uErrTheta",
		description = "Orientation of the position error ellipse (degrees).",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 162, tableId = 5, name = "uNumObs",
		description = "Number of measurements in the lightcurve for u filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 163, tableId = 5, name = "uVarProb",
		description = "Probability of variability in % (100% = variable object) for u filter. Note: large photometric errors do not necessarily mean variability.",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 164, tableId = 5, name = "uAmplitude",
		description = "Characteristic magnitude scale of the flux variations for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 165, tableId = 5, name = "uPeriod",
		description = "Period of flux variations (if regular) for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 30;

	INSERT INTO md_Column
	SET columnId = 166, tableId = 5, name = "uPetroMag",
		description = "Petrosian flux for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 31;

	INSERT INTO md_Column
	SET columnId = 167, tableId = 5, name = "uPetroMagErr",
		description = "Petrosian flux error for u filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 32;

	INSERT INTO md_Column
	SET columnId = 168, tableId = 5, name = "uTimescale",
		description = "Characteristic timescale of flux variations (measured in days). This is to complement period for variables without a well-defined period. Range covered: 0.01 sec - 274 years. LSST images have sampling frequency of ~0.1Hz. For u filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 33;

	INSERT INTO md_Column
	SET columnId = 169, tableId = 5, name = "gMag",
		description = "g-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 34;

	INSERT INTO md_Column
	SET columnId = 170, tableId = 5, name = "gMagErr",
		description = "g-magnitude error",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 35;

	INSERT INTO md_Column
	SET columnId = 171, tableId = 5, name = "gErrA",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 36;

	INSERT INTO md_Column
	SET columnId = 172, tableId = 5, name = "gErrB",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 37;

	INSERT INTO md_Column
	SET columnId = 173, tableId = 5, name = "gErrTheta",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 38;

	INSERT INTO md_Column
	SET columnId = 174, tableId = 5, name = "gNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 39;

	INSERT INTO md_Column
	SET columnId = 175, tableId = 5, name = "gVarProb",
		description = "Probability of variability in % (100% = variable object) for g filter. Note: large photometric errors do not necessarily mean variability.",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 40;

	INSERT INTO md_Column
	SET columnId = 176, tableId = 5, name = "gAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 41;

	INSERT INTO md_Column
	SET columnId = 177, tableId = 5, name = "gPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 42;

	INSERT INTO md_Column
	SET columnId = 178, tableId = 5, name = "gPetroMag",
		description = "Petrosian flux for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 43;

	INSERT INTO md_Column
	SET columnId = 179, tableId = 5, name = "gPetroMagErr",
		description = "Petrosian flux error filter for g filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 44;

	INSERT INTO md_Column
	SET columnId = 180, tableId = 5, name = "gTimescale",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 45;

	INSERT INTO md_Column
	SET columnId = 181, tableId = 5, name = "rMag",
		description = "r-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 46;

	INSERT INTO md_Column
	SET columnId = 182, tableId = 5, name = "rMagErr",
		description = "r-magnitude error",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 47;

	INSERT INTO md_Column
	SET columnId = 183, tableId = 5, name = "rErrA",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 48;

	INSERT INTO md_Column
	SET columnId = 184, tableId = 5, name = "rErrB",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 49;

	INSERT INTO md_Column
	SET columnId = 185, tableId = 5, name = "rErrTheta",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 50;

	INSERT INTO md_Column
	SET columnId = 186, tableId = 5, name = "rNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 51;

	INSERT INTO md_Column
	SET columnId = 187, tableId = 5, name = "rVarProb",
		description = "Probability of variability in % (100% = variable object) for r filter. Note: large photometric errors do not necessarily mean variability.",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 52;

	INSERT INTO md_Column
	SET columnId = 188, tableId = 5, name = "rAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 53;

	INSERT INTO md_Column
	SET columnId = 189, tableId = 5, name = "rPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 54;

	INSERT INTO md_Column
	SET columnId = 190, tableId = 5, name = "rPetroMag",
		description = "Petrosian flux for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 55;

	INSERT INTO md_Column
	SET columnId = 191, tableId = 5, name = "rPetroMagErr",
		description = "Petrosian flux error for r filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 56;

	INSERT INTO md_Column
	SET columnId = 192, tableId = 5, name = "rTimescale",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 57;

	INSERT INTO md_Column
	SET columnId = 193, tableId = 5, name = "iMag",
		description = "i-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 58;

	INSERT INTO md_Column
	SET columnId = 194, tableId = 5, name = "iMagErr",
		description = "i-magnitude error",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 59;

	INSERT INTO md_Column
	SET columnId = 195, tableId = 5, name = "iErrA",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 60;

	INSERT INTO md_Column
	SET columnId = 196, tableId = 5, name = "iErrB",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 61;

	INSERT INTO md_Column
	SET columnId = 197, tableId = 5, name = "iErrTheta",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 62;

	INSERT INTO md_Column
	SET columnId = 198, tableId = 5, name = "iNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 63;

	INSERT INTO md_Column
	SET columnId = 199, tableId = 5, name = "iVarProb",
		description = "Probability of variability in % (100% = variable object) for i filter. Note: large photometric errors do not necessarily mean variability.",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 64;

	INSERT INTO md_Column
	SET columnId = 200, tableId = 5, name = "iAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 65;

	INSERT INTO md_Column
	SET columnId = 201, tableId = 5, name = "iPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 66;

	INSERT INTO md_Column
	SET columnId = 202, tableId = 5, name = "iPetroMag",
		description = "Petrosian flux for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 67;

	INSERT INTO md_Column
	SET columnId = 203, tableId = 5, name = "iPetroMagErr",
		description = "Petrosian flux error for i filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 68;

	INSERT INTO md_Column
	SET columnId = 204, tableId = 5, name = "iTimescale",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 69;

	INSERT INTO md_Column
	SET columnId = 205, tableId = 5, name = "zMag",
		description = "z-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 70;

	INSERT INTO md_Column
	SET columnId = 206, tableId = 5, name = "zMagErr",
		description = "z-magnitude error",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 71;

	INSERT INTO md_Column
	SET columnId = 207, tableId = 5, name = "zErrA",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 72;

	INSERT INTO md_Column
	SET columnId = 208, tableId = 5, name = "zErrB",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 73;

	INSERT INTO md_Column
	SET columnId = 209, tableId = 5, name = "zErrTheta",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 74;

	INSERT INTO md_Column
	SET columnId = 210, tableId = 5, name = "zNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 75;

	INSERT INTO md_Column
	SET columnId = 211, tableId = 5, name = "zVarProb",
		description = "Probability of variability in % (100% = variable object) for z filter. Note: large photometric errors do not necessarily mean variability.",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 76;

	INSERT INTO md_Column
	SET columnId = 212, tableId = 5, name = "zAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 77;

	INSERT INTO md_Column
	SET columnId = 213, tableId = 5, name = "zPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 78;

	INSERT INTO md_Column
	SET columnId = 214, tableId = 5, name = "zPetroMag",
		description = "Petrosian flux for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 79;

	INSERT INTO md_Column
	SET columnId = 215, tableId = 5, name = "zPetroMagErr",
		description = "Petrosian flux error for z filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 80;

	INSERT INTO md_Column
	SET columnId = 216, tableId = 5, name = "zTimescale",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 81;

	INSERT INTO md_Column
	SET columnId = 217, tableId = 5, name = "yMag",
		description = "y-magnitude (weighted average)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 82;

	INSERT INTO md_Column
	SET columnId = 218, tableId = 5, name = "yMagErr",
		description = "y-magnitude error",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 83;

	INSERT INTO md_Column
	SET columnId = 219, tableId = 5, name = "yErrA",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 84;

	INSERT INTO md_Column
	SET columnId = 220, tableId = 5, name = "yErrB",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 85;

	INSERT INTO md_Column
	SET columnId = 221, tableId = 5, name = "yErrTheta",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 86;

	INSERT INTO md_Column
	SET columnId = 222, tableId = 5, name = "yNumObs",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 87;

	INSERT INTO md_Column
	SET columnId = 223, tableId = 5, name = "yVarProb",
		description = "Probability of variability in % (100% = variable object) for y filter. Note: large photometric errors do not necessarily mean variability.",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 88;

	INSERT INTO md_Column
	SET columnId = 224, tableId = 5, name = "yAmplitude",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 89;

	INSERT INTO md_Column
	SET columnId = 225, tableId = 5, name = "yPeriod",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 90;

	INSERT INTO md_Column
	SET columnId = 226, tableId = 5, name = "yPetroMag",
		description = "Petrosian flux for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 91;

	INSERT INTO md_Column
	SET columnId = 227, tableId = 5, name = "yPetroMagErr",
		description = "Petrosian flux error for y filter",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 92;

	INSERT INTO md_Column
	SET columnId = 228, tableId = 5, name = "yTimescale",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 93;

	INSERT INTO md_Column
	SET columnId = 229, tableId = 5, name = "redshift",
		description = "Photometric redshift.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 94;

	INSERT INTO md_Column
	SET columnId = 230, tableId = 5, name = "redshiftErr",
		description = "Photometric redshift uncertainty.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 95;

	INSERT INTO md_Column
	SET columnId = 231, tableId = 5, name = "probability",
		description = "Probability that given object has photo-z. 0-100. In %. Default 100%.",
		type = "TINYINT",
		notNull = 0,
		displayOrder = 96;

	INSERT INTO md_Column
	SET columnId = 232, tableId = 5, name = "photoZ1",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 97;

	INSERT INTO md_Column
	SET columnId = 233, tableId = 5, name = "photoZ1Err",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 98;

	INSERT INTO md_Column
	SET columnId = 234, tableId = 5, name = "photoZ2",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 99;

	INSERT INTO md_Column
	SET columnId = 235, tableId = 5, name = "photoZ2Err",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 100;

	INSERT INTO md_Column
	SET columnId = 236, tableId = 5, name = "photoZ1Outlier",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 101;

	INSERT INTO md_Column
	SET columnId = 237, tableId = 5, name = "photoZ2Outlier",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 102;

	INSERT INTO md_Column
	SET columnId = 238, tableId = 5, name = "uApMag",
		description = "Fixed aperture magnitude vector for u filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 103;

	INSERT INTO md_Column
	SET columnId = 239, tableId = 5, name = "uApMagErr",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 104;

	INSERT INTO md_Column
	SET columnId = 240, tableId = 5, name = "uIsoAreaImage",
		description = "Isophotal area above Analysis threshold &gt; [pixel**2]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 105;

	INSERT INTO md_Column
	SET columnId = 241, tableId = 5, name = "uMuMax",
		description = "Peak surface brightness above background &gt; [mag * arcsec**(-2)]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 106;

	INSERT INTO md_Column
	SET columnId = 242, tableId = 5, name = "uFluxRadius",
		description = "raction-of-light radii [pixel]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 107;

	INSERT INTO md_Column
	SET columnId = 243, tableId = 5, name = "gApMag",
		description = "Fixed aperture magnitude vector for g filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 108;

	INSERT INTO md_Column
	SET columnId = 244, tableId = 5, name = "gApMagErr",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 109;

	INSERT INTO md_Column
	SET columnId = 245, tableId = 5, name = "gIsoAreaImage",
		description = "Isophotal area above Analysis threshold &gt; [pixel**2]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 110;

	INSERT INTO md_Column
	SET columnId = 246, tableId = 5, name = "gMuMax",
		description = "Peak surface brightness above background &gt; [mag * arcsec**(-2)]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 111;

	INSERT INTO md_Column
	SET columnId = 247, tableId = 5, name = "gFluxRadius",
		description = "raction-of-light radii [pixel]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 112;

	INSERT INTO md_Column
	SET columnId = 248, tableId = 5, name = "rApMag",
		description = "Fixed aperture magnitude vector for r filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 113;

	INSERT INTO md_Column
	SET columnId = 249, tableId = 5, name = "rApMagErr",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 114;

	INSERT INTO md_Column
	SET columnId = 250, tableId = 5, name = "rIsoAreaImage",
		description = "Isophotal area above Analysis threshold &gt; [pixel**2]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 115;

	INSERT INTO md_Column
	SET columnId = 251, tableId = 5, name = "rMuMax",
		description = "Peak surface brightness above background &gt; [mag * arcsec**(-2)]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 116;

	INSERT INTO md_Column
	SET columnId = 252, tableId = 5, name = "rFluxRadius",
		description = "raction-of-light radii [pixel]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 117;

	INSERT INTO md_Column
	SET columnId = 253, tableId = 5, name = "iApMag",
		description = "Fixed aperture magnitude vector for i filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 118;

	INSERT INTO md_Column
	SET columnId = 254, tableId = 5, name = "iApMagErr",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 119;

	INSERT INTO md_Column
	SET columnId = 255, tableId = 5, name = "iIsoAreaImage",
		description = "Isophotal area above Analysis threshold &gt; [pixel**2]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 120;

	INSERT INTO md_Column
	SET columnId = 256, tableId = 5, name = "iMuMax",
		description = "Peak surface brightness above background &gt; [mag * arcsec**(-2)]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 121;

	INSERT INTO md_Column
	SET columnId = 257, tableId = 5, name = "iFluxRadius",
		description = "raction-of-light radii [pixel]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 122;

	INSERT INTO md_Column
	SET columnId = 258, tableId = 5, name = "zApMag",
		description = "Fixed aperture magnitude vector for z filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 123;

	INSERT INTO md_Column
	SET columnId = 259, tableId = 5, name = "zApMagErr",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 124;

	INSERT INTO md_Column
	SET columnId = 260, tableId = 5, name = "zIsoAreaImage",
		description = "Isophotal area above Analysis threshold &gt; [pixel**2]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 125;

	INSERT INTO md_Column
	SET columnId = 261, tableId = 5, name = "zMuMax",
		description = "Peak surface brightness above background &gt; [mag * arcsec**(-2)]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 126;

	INSERT INTO md_Column
	SET columnId = 262, tableId = 5, name = "zFluxRadius",
		description = "raction-of-light radii [pixel]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 127;

	INSERT INTO md_Column
	SET columnId = 263, tableId = 5, name = "yApMag",
		description = "Fixed aperture magnitude vector for y filter",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 128;

	INSERT INTO md_Column
	SET columnId = 264, tableId = 5, name = "yApMagErr",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 129;

	INSERT INTO md_Column
	SET columnId = 265, tableId = 5, name = "yIsoAreaImage",
		description = "Isophotal area above Analysis threshold &gt; [pixel**2]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 130;

	INSERT INTO md_Column
	SET columnId = 266, tableId = 5, name = "yMuMax",
		description = "Peak surface brightness above background &gt; [mag * arcsec**(-2)]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 131;

	INSERT INTO md_Column
	SET columnId = 267, tableId = 5, name = "yFluxRadius",
		description = "raction-of-light radii [pixel]",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 132;

	INSERT INTO md_Column
	SET columnId = 268, tableId = 5, name = "uFlags",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 133;

	INSERT INTO md_Column
	SET columnId = 269, tableId = 5, name = "gFlags",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 134;

	INSERT INTO md_Column
	SET columnId = 270, tableId = 5, name = "rFlags",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 135;

	INSERT INTO md_Column
	SET columnId = 271, tableId = 5, name = "iFlags",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 136;

	INSERT INTO md_Column
	SET columnId = 272, tableId = 5, name = "zFlags",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 137;

	INSERT INTO md_Column
	SET columnId = 273, tableId = 5, name = "yFlags",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 138;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 6, name = "ObjectType",
	description = "Table to store description of object types. It includes all object types: static, variables, Solar System objects, etc.";

	INSERT INTO md_Column
	SET columnId = 274, tableId = 6, name = "typeId",
		description = "Unique id.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 275, tableId = 6, name = "description",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 7, name = "Raw_CCD_Exposure";

	INSERT INTO md_Column
	SET columnId = 276, tableId = 7, name = "rawCCDExposureId",
		description = "ccd raw exposure id (science raw image)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 277, tableId = 7, name = "ccdDetectorId",
		description = "Pointer to the Exposure that this CCDExposure belongs to",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 278, tableId = 7, name = "rawFPAExposureId",
		description = "pointer to Raw_FPA_Exposure",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 279, tableId = 7, name = "radecSys",
		description = "Coordinate system type. (Allowed systems: FK5, ICRS)",
		type = "VARCHAR(20)",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 280, tableId = 7, name = "url",
		description = "Logical URL to the actual raw image.",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 281, tableId = 7, name = "ctype1",
		description = "Coordinate projection type, axis 1.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 282, tableId = 7, name = "ctype2",
		description = "Coordinate projection type, axis 2.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 283, tableId = 7, name = "crpix1",
		description = "Coordinate reference pixel, axis 1.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 284, tableId = 7, name = "crpix2",
		description = "Coordinate reference pixel, axis 2.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 285, tableId = 7, name = "crval1",
		description = "Coordinate value 1 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 286, tableId = 7, name = "crval2",
		description = "Coordinate value 2 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 287, tableId = 7, name = "cd11",
		description = "First derivative of coordinate 1 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 288, tableId = 7, name = "cd21",
		description = "First derivative of coordinate 2 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 289, tableId = 7, name = "cd12",
		description = "First derivative of coordinate 1 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 290, tableId = 7, name = "cd22",
		description = "First derivative of coordinate 2 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 291, tableId = 7, name = "taiObs",
		description = "TAI-OBS = UTC + offset, offset = 32 s from  1/1/1999 to 1/1/2006",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "0",
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 292, tableId = 7, name = "darkTime",
		description = "Total elapsed time from exposure start to end of read.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 293, tableId = 7, name = "zd",
		description = "Zenith distance at observation mid-point.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 18;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 8, name = "Raw_FPA_Exposure";

	INSERT INTO md_Column
	SET columnId = 294, tableId = 8, name = "rawFPAExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 295, tableId = 8, name = "ra",
		description = "Right Ascension of aperture center.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 296, tableId = 8, name = "decl",
		description = "Declination of aperture center.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 297, tableId = 8, name = "filterId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 298, tableId = 8, name = "equinox",
		description = "Equinox of World Coordinate System.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 299, tableId = 8, name = "dateObs",
		description = "Date/Time of observation start (UTC).",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "0",
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 300, tableId = 8, name = "mjdObs",
		description = "MJD of observation start.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 301, tableId = 8, name = "expTime",
		description = "Duration of exposure.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 302, tableId = 8, name = "airmass",
		description = "Airmass value for the Amp reference pixel (preferably center, but not guaranteed). Range: [-99.999, 99.999] is enough to accomodate ZD in [0, 89.433].",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 9, name = "Science_CCD_Exposure";

	INSERT INTO md_Column
	SET columnId = 303, tableId = 9, name = "scienceCCDExposureId",
		description = "Id of te Science CCD Exposure",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 304, tableId = 9, name = "scienceFPAExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 305, tableId = 9, name = "rawCCDExposureId",
		description = "Pointer to raw exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 306, tableId = 9, name = "ccdDetectorId",
		description = "Pointer to the CCD_Detector corresponding to this CCDExposure (this is DC3 specific).",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 307, tableId = 9, name = "filterId",
		description = "Pointer to filter.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 308, tableId = 9, name = "equinox",
		description = "Equinox of World Coordinate System.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 309, tableId = 9, name = "url",
		description = "Logical URL to the actual calibrated image.",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 310, tableId = 9, name = "ctype1",
		description = "Coordinate projection type, axis 1.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 311, tableId = 9, name = "ctype2",
		description = "Coordinate projection type, axis 2.",
		type = "VARCHAR(20)",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 312, tableId = 9, name = "crpix1",
		description = "Coordinate reference pixel, axis 1.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 313, tableId = 9, name = "crpix2",
		description = "Coordinate reference pixel, axis 2.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 314, tableId = 9, name = "crval1",
		description = "Coordinate value 1 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 315, tableId = 9, name = "crval2",
		description = "Coordinate value 2 @reference pixel.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 316, tableId = 9, name = "cd1_1",
		description = "First derivative of coordinate 1 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 317, tableId = 9, name = "cd2_1",
		description = "First derivative of coordinate 2 w.r.t. axis 1.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 318, tableId = 9, name = "cd1_2",
		description = "First derivative of coordinate 1 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 319, tableId = 9, name = "cd2_2",
		description = "First derivative of coordinate 2 w.r.t. axis 2.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 320, tableId = 9, name = "dateObs",
		description = "Date/Time of observation start (UTC).",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "0",
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 321, tableId = 9, name = "expTime",
		description = "Duration of exposure.",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 322, tableId = 9, name = "ccdSize",
		description = "Size of the entire detector.",
		type = "VARCHAR(50)",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 323, tableId = 9, name = "photoFlam",
		description = "Inverse sensitivity.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 324, tableId = 9, name = "photoZP",
		description = "System photometric zero-point.",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 325, tableId = 9, name = "nCombine",
		description = "Number of images co-added to create a deeper image",
		type = "INTEGER",
		notNull = 1,
		defaultValue = "1",
		displayOrder = 23;

	INSERT INTO md_Column
	SET columnId = 326, tableId = 9, name = "taiMjd",
		description = "Date of the start of the exposure",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 24;

	INSERT INTO md_Column
	SET columnId = 327, tableId = 9, name = "bixX",
		description = "Binning of the ccd in x.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 25;

	INSERT INTO md_Column
	SET columnId = 328, tableId = 9, name = "binY",
		description = "Binning of the ccd in y.",
		type = "INTEGER",
		notNull = 0,
		displayOrder = 26;

	INSERT INTO md_Column
	SET columnId = 329, tableId = 9, name = "readNoise",
		description = "Read noise of the CCD.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 27;

	INSERT INTO md_Column
	SET columnId = 330, tableId = 9, name = "saturationLimit",
		description = "Saturation limit for the CCD (average of the amplifiers).",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 28;

	INSERT INTO md_Column
	SET columnId = 331, tableId = 9, name = "dataSection",
		description = "Data section for the ccd in the form of [####:####,####:####]",
		type = "VARCHAR(24)",
		notNull = 0,
		displayOrder = 29;

	INSERT INTO md_Column
	SET columnId = 332, tableId = 9, name = "gain",
		description = "Gain of the CCD.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 30;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 10, name = "Science_FPA_Exposure";

	INSERT INTO md_Column
	SET columnId = 333, tableId = 10, name = "scienceFPAExposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 11, name = "Visit",
	description = "Defines a single Visit. 1 row per LSST visit.";

	INSERT INTO md_Column
	SET columnId = 334, tableId = 11, name = "visitId",
		description = "Unique id.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 335, tableId = 11, name = "exposureId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 12, name = "_MovingObject2Type",
	description = "Mapping: moving object --&gt; types, with probabilities";

	INSERT INTO md_Column
	SET columnId = 336, tableId = 12, name = "movingObjectId",
		description = "Pointer to entry in MovingObject table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 337, tableId = 12, name = "typeId",
		description = "Pointer to entry in ObjectType table",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 338, tableId = 12, name = "probability",
		description = "Probability that given MovingObject is of given type. Range: 0-100 (in%)",
		type = "TINYINT",
		notNull = 0,
		defaultValue = "100",
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 13, name = "_Object2Type",
	description = "Mapping Object --&gt; types, with probabilities";

	INSERT INTO md_Column
	SET columnId = 339, tableId = 13, name = "objectId",
		description = "Pointer to an entry in Object table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 340, tableId = 13, name = "typeId",
		description = "Pointer to an entry in ObjectType table",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 341, tableId = 13, name = "probability",
		description = "Probability that given object is of given type. Range 0-100 %",
		type = "TINYINT",
		notNull = 0,
		defaultValue = "100",
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 14, name = "_Raw_FPA_Exposure2Visit",
	description = "Mapping table: exposures --&gt; visit";

	INSERT INTO md_Column
	SET columnId = 342, tableId = 14, name = "visitId",
		description = "Pointer to entry in Visit table - visit that given Exposure belongs to.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 343, tableId = 14, name = "exposureId",
		description = "Pointer to entry in Raw_FPA_Exposure table",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 15, name = "_Science_FPA_Exposure2TemplateImage",
	description = "Mapping table: exposures used to build given template image";

	INSERT INTO md_Column
	SET columnId = 344, tableId = 15, name = "scienceFPAExposureId",
		description = "Pointer to an entry in Science_FPA_Exposure table.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 345, tableId = 15, name = "templateImageId",
		description = "Pointer to an entry in TemplateImage table.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 16, name = "_mops_Config",
	description = "Internal table used to ship runtime configuration data to MOPS worker nodes.&#xA;&#xA;This will eventually be replaced by some other mechanism. Note however that this data must be captured by the LSST software provenance tables.";

	INSERT INTO md_Column
	SET columnId = 346, tableId = 16, name = "configId",
		description = "Referring derived object",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 347, tableId = 16, name = "configText",
		description = "Config contents",
		type = "TEXT",
		notNull = 0,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 17, name = "_mops_EonQueue",
	description = "Internal table which maintains a queue of objects to be passed to the MOPS precovery pipeline.&#xA;&#xA;Will eventually be replaced by a different queueing mechanism.";

	INSERT INTO md_Column
	SET columnId = 348, tableId = 17, name = "movingObjectId",
		description = "Referring derived object",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 349, tableId = 17, name = "eventId",
		description = "Referring history event causing insertion",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 350, tableId = 17, name = "insertTime",
		description = "Wall clock time object was queued",
		type = "TIMESTAMP",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 351, tableId = 17, name = "status",
		description = "Processing status N =&amp;gt; new, I =&amp;gt; ID1 done, P =&amp;gt; precov done, X =&amp;gt; finished",
		type = "CHAR(1)",
		notNull = 0,
		defaultValue = "'I'",
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 18, name = "_mops_MoidQueue",
	description = "Internal table which maintain a queue of objects to be passed to the MOPS precovery pipeline.&#xA;&#xA;Will eventually be replaced by a different queueing mechanism.";

	INSERT INTO md_Column
	SET columnId = 352, tableId = 18, name = "movingObjectId",
		description = "Referring derived object",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 353, tableId = 18, name = "movingObjectVersion",
		description = "version of referring derived object",
		type = "INT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 354, tableId = 18, name = "eventId",
		description = "Referring history event causing insertion",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 355, tableId = 18, name = "insertTime",
		description = "Wall clock time object was queued",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "CURRENT_TIMESTAMP",
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 19, name = "_tmpl_Id",
	description = "Template table. Schema for lists of ids (e.g. for Objects to delete)";

	INSERT INTO md_Column
	SET columnId = 356, tableId = 19, name = "id",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 20, name = "_tmpl_IdPair",
	description = "Template table. Schema for list of id pairs.";

	INSERT INTO md_Column
	SET columnId = 357, tableId = 20, name = "first",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 358, tableId = 20, name = "second",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 21, name = "_tmpl_MatchPair",
	description = "Template table. Schema for per-visit match result tables.";

	INSERT INTO md_Column
	SET columnId = 359, tableId = 21, name = "first",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 360, tableId = 21, name = "second",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 361, tableId = 21, name = "distance",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 22, name = "_tmpl_mops_Ephemeris",
	engine = "MyISAM";

	INSERT INTO md_Column
	SET columnId = 362, tableId = 22, name = "movingObjectId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 363, tableId = 22, name = "movingObjectVersion",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 364, tableId = 22, name = "ra",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 365, tableId = 22, name = "decl",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 366, tableId = 22, name = "mjd",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 367, tableId = 22, name = "smia",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 368, tableId = 22, name = "smaa",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 369, tableId = 22, name = "pa",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 370, tableId = 22, name = "mag",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 9;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 23, name = "_tmpl_mops_Prediction",
	engine = "MyISAM";

	INSERT INTO md_Column
	SET columnId = 371, tableId = 23, name = "movingObjectId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 372, tableId = 23, name = "movingObjectVersion",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 373, tableId = 23, name = "ra",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 374, tableId = 23, name = "decl",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 375, tableId = 23, name = "mjd",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 376, tableId = 23, name = "smia",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 377, tableId = 23, name = "smaa",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 378, tableId = 23, name = "pa",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 379, tableId = 23, name = "mag",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 380, tableId = 23, name = "magErr",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 10;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 24, name = "mops_Event";

	INSERT INTO md_Column
	SET columnId = 381, tableId = 24, name = "eventId",
		description = "Auto-generated internal event ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 382, tableId = 24, name = "procHistoryId",
		description = "Pointer to processing history (prv_ProcHistory)",
		type = "INT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 383, tableId = 24, name = "eventType",
		description = "Type of event (A)ttribution/(P)recovery/(D)erivation/(I)dentification/(R)emoval",
		type = "CHAR(1)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 384, tableId = 24, name = "eventTime",
		description = "Timestamp for event creation",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "CURRENT_TIMESTAMP",
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 385, tableId = 24, name = "movingObjectId",
		description = "Referring derived object ID",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 386, tableId = 24, name = "movingObjectVersion",
		description = "Pointer to resulting orbit",
		type = "INT",
		notNull = 0,
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 387, tableId = 24, name = "orbitCode",
		description = "Information about computed orbit",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 388, tableId = 24, name = "d3",
		description = "Computed 3-parameter D-criterion",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 389, tableId = 24, name = "d4",
		description = "Computed 4-parameter D-criterion",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 390, tableId = 24, name = "ccdExposureId",
		description = "Referring to Science CCD exposure ID generating the event",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 391, tableId = 24, name = "classification",
		description = "MOPS efficiency classification for event",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 392, tableId = 24, name = "ssmId",
		description = "Matching SSM ID for clean classifications",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 12;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 25, name = "mops_Event_OrbitDerivation",
	description = "Table for associating tracklets with derivation events. There is a one to many relationship between events and tracklets (there will be multiple rows per event).";

	INSERT INTO md_Column
	SET columnId = 393, tableId = 25, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 394, tableId = 25, name = "trackletId",
		description = "Associated tracklet ID (multiple rows per event)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 26, name = "mops_Event_OrbitIdentification",
	description = "Table for associating moving objects with identification events (one object per event). The original orbit and tracklets for the child can be obtained from the MOPS_History table by looking up the child object.";

	INSERT INTO md_Column
	SET columnId = 395, tableId = 26, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 396, tableId = 26, name = "childObjectId",
		description = "Matching (child) derived object ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 27, name = "mops_Event_TrackletAttribution",
	description = "Table for associating tracklets with attribution events (one tracklet per event).";

	INSERT INTO md_Column
	SET columnId = 397, tableId = 27, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 398, tableId = 27, name = "trackletId",
		description = "Attributed tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 399, tableId = 27, name = "ephemerisDistance",
		description = "Predicted position minus actual, arcsecs",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 400, tableId = 27, name = "ephemerisUncertainty",
		description = "Predicted error ellipse semi-major axis, arcsecs",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 28, name = "mops_Event_TrackletPrecovery",
	description = "Table for associating tracklets with precovery events (one precovery per event).";

	INSERT INTO md_Column
	SET columnId = 401, tableId = 28, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 402, tableId = 28, name = "trackletId",
		description = "Precovered tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 403, tableId = 28, name = "ephemerisDistance",
		description = "Predicted position minus actual, arcsecs",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 404, tableId = 28, name = "ephemerisUncertainty",
		description = "Predicted error ellipse semi-major axis, arcsecs",
		type = "FLOAT",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 29, name = "mops_Event_TrackletRemoval",
	description = "Table for associating tracklets with removal events (one removal per event).";

	INSERT INTO md_Column
	SET columnId = 405, tableId = 29, name = "eventId",
		description = "Parent event ID (from mops_History table)",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 406, tableId = 29, name = "trackletId",
		description = "Removed tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 30, name = "mops_MovingObject2Tracklet",
	description = "Current membership of tracklets and moving objects.";

	INSERT INTO md_Column
	SET columnId = 407, tableId = 30, name = "movingObjectId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 408, tableId = 30, name = "trackletId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 31, name = "mops_SSM",
	description = "Table that contains synthetic solar system model (SSM) objects.";

	INSERT INTO md_Column
	SET columnId = 409, tableId = 31, name = "ssmId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 410, tableId = 31, name = "ssmDescId",
		description = "Pointer to SSM description",
		type = "SMALLINT",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 411, tableId = 31, name = "q",
		description = "semi-major axis, AU",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 412, tableId = 31, name = "e",
		description = "eccentricity e (dimensionless)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 413, tableId = 31, name = "i",
		description = "inclination, deg",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 414, tableId = 31, name = "node",
		description = "longitude of ascending node, deg",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 415, tableId = 31, name = "argPeri",
		description = "argument of perihelion, deg",
		type = "DOUBLE",
		notNull = 1,
		unit = "degree",
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 416, tableId = 31, name = "timePeri",
		description = "time of perihelion, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 417, tableId = 31, name = "epoch",
		description = "epoch of osculating elements, MJD (UTC)",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 418, tableId = 31, name = "h_v",
		description = "Absolute magnitude",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 419, tableId = 31, name = "h_ss",
		description = "??",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 420, tableId = 31, name = "g",
		description = "Slope parameter g, dimensionless",
		type = "DOUBLE",
		notNull = 0,
		unit = "-",
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 421, tableId = 31, name = "albedo",
		description = "Albedo, dimensionless",
		type = "DOUBLE",
		notNull = 0,
		unit = "-",
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 422, tableId = 31, name = "ssmObjectName",
		description = "MOPS synthetic object name",
		type = "VARCHAR(32)",
		notNull = 1,
		displayOrder = 14;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 32, name = "mops_SSMDesc",
	description = "Table containing object name prefixes and descriptions of synthetic solar system object types.";

	INSERT INTO md_Column
	SET columnId = 423, tableId = 32, name = "ssmDescId",
		description = "Auto-generated row ID",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 424, tableId = 32, name = "prefix",
		description = "MOPS prefix code S0/S1/etc.",
		type = "CHAR(4)",
		notNull = 0,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 425, tableId = 32, name = "description",
		description = "Long description",
		type = "VARCHAR(100)",
		notNull = 0,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 33, name = "mops_Tracklet";

	INSERT INTO md_Column
	SET columnId = 426, tableId = 33, name = "trackletId",
		description = "Auto-generated internal MOPS tracklet ID",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 427, tableId = 33, name = "ccdExposureId",
		description = "Terminating field ID - pointer to Science_CCD_Exposure",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 428, tableId = 33, name = "procHistoryId",
		description = "Pointer to processing history (prv_ProcHistory)",
		type = "INT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 429, tableId = 33, name = "ssmId",
		description = "Matching SSM ID for clean classifications",
		type = "BIGINT",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 430, tableId = 33, name = "velRa",
		description = "Average RA velocity deg/day, cos(dec) applied",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day",
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 431, tableId = 33, name = "velRaErr",
		description = "Uncertainty in RA velocity",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day",
		displayOrder = 6;

	INSERT INTO md_Column
	SET columnId = 432, tableId = 33, name = "velDecl",
		description = "Average Dec velocity, deg/day)",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day",
		displayOrder = 7;

	INSERT INTO md_Column
	SET columnId = 433, tableId = 33, name = "velDeclErr",
		description = "Uncertainty in Dec velocity",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day",
		displayOrder = 8;

	INSERT INTO md_Column
	SET columnId = 434, tableId = 33, name = "velTot",
		description = "Average total velocity, deg/day",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day",
		displayOrder = 9;

	INSERT INTO md_Column
	SET columnId = 435, tableId = 33, name = "accRa",
		description = "Average RA Acceleration, deg/day^2",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day^2",
		displayOrder = 10;

	INSERT INTO md_Column
	SET columnId = 436, tableId = 33, name = "accRaErr",
		description = "Uncertainty in RA acceleration",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day^2",
		displayOrder = 11;

	INSERT INTO md_Column
	SET columnId = 437, tableId = 33, name = "accDecl",
		description = "Average Dec Acceleration, deg/day^2",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day^2",
		displayOrder = 12;

	INSERT INTO md_Column
	SET columnId = 438, tableId = 33, name = "accDeclErr",
		description = "Uncertainty in Dec acceleration",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree/day^2",
		displayOrder = 13;

	INSERT INTO md_Column
	SET columnId = 439, tableId = 33, name = "extEpoch",
		description = "Extrapolated (central) epoch, MJD (UTC)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 14;

	INSERT INTO md_Column
	SET columnId = 440, tableId = 33, name = "extRa",
		description = "Extrapolated (central) RA, deg",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree",
		displayOrder = 15;

	INSERT INTO md_Column
	SET columnId = 441, tableId = 33, name = "extRaErr",
		description = "Uncertainty in extrapolated RA, deg",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree",
		displayOrder = 16;

	INSERT INTO md_Column
	SET columnId = 442, tableId = 33, name = "extDecl",
		description = "Extrapolated (central) Dec, deg",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree",
		displayOrder = 17;

	INSERT INTO md_Column
	SET columnId = 443, tableId = 33, name = "extDeclErr",
		description = "Uncertainty in extrapolated Dec, deg",
		type = "DOUBLE",
		notNull = 0,
		unit = "degree",
		displayOrder = 18;

	INSERT INTO md_Column
	SET columnId = 444, tableId = 33, name = "extMag",
		description = "Extrapolated (central) magnitude",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 19;

	INSERT INTO md_Column
	SET columnId = 445, tableId = 33, name = "extMagErr",
		description = "Uncertainty in extrapolated mag, deg",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 20;

	INSERT INTO md_Column
	SET columnId = 446, tableId = 33, name = "probability",
		description = "Likelihood tracklet is real (unused currently)",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 21;

	INSERT INTO md_Column
	SET columnId = 447, tableId = 33, name = "status",
		description = "processing status (unfound 'X', unattributed 'U', attributed 'A')",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 22;

	INSERT INTO md_Column
	SET columnId = 448, tableId = 33, name = "classification",
		description = "MOPS efficiency classification",
		type = "CHAR(1)",
		notNull = 0,
		displayOrder = 23;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 34, name = "mops_Tracklets2DIASource",
	description = "Table maintaining many-to-many relationship between tracklets and detections.";

	INSERT INTO md_Column
	SET columnId = 449, tableId = 34, name = "trackletId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 450, tableId = 34, name = "diaSourceId",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 35, name = "prv_Filter",
	engine = "MyISAM",
	description = "One row per color - the table will have 6 rows";

	INSERT INTO md_Column
	SET columnId = 451, tableId = 35, name = "filterId",
		description = "Unique id.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 452, tableId = 35, name = "focalPlaneId",
		description = "Pointer to FocalPlane - focal plane this filter belongs to.",
		type = "TINYINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 453, tableId = 35, name = "name",
		description = "String description of the filter,e.g. 'VR SuperMacho c6027'.",
		type = "VARCHAR(80)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 454, tableId = 35, name = "url",
		description = "URL for filter transmission curve. (Added from archive specs for LSST precursor data).",
		type = "VARCHAR(255)",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 455, tableId = 35, name = "clam",
		description = "Filter centroid wavelength (Angstroms). (Added from archive specs for LSST precursor data).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 456, tableId = 35, name = "bw",
		description = "Filter effective bandwidth (Angstroms). (Added from archive specs for LSST precursor data).",
		type = "FLOAT",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 36, name = "prv_PolicyFile";

	INSERT INTO md_Column
	SET columnId = 457, tableId = 36, name = "policyFileId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 458, tableId = 36, name = "pathName",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 459, tableId = 36, name = "hashValue",
		type = "CHAR(32)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 460, tableId = 36, name = "modifiedDate",
		type = "DATETIME",
		notNull = 1,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 37, name = "prv_PolicyKey";

	INSERT INTO md_Column
	SET columnId = 461, tableId = 37, name = "policyKeyId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 462, tableId = 37, name = "policyFileId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 463, tableId = 37, name = "keyName",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 38, name = "prv_SoftwarePackage";

	INSERT INTO md_Column
	SET columnId = 464, tableId = 38, name = "packageId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 465, tableId = 38, name = "packageName",
		type = "VARCHAR(64)",
		notNull = 1,
		displayOrder = 2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 39, name = "prv_cnf_PolicyKey";

	INSERT INTO md_Column
	SET columnId = 466, tableId = 39, name = "policyKeyId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 467, tableId = 39, name = "value",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 468, tableId = 39, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 469, tableId = 39, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 40, name = "prv_cnf_SoftwarePackage";

	INSERT INTO md_Column
	SET columnId = 470, tableId = 40, name = "packageId",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 471, tableId = 40, name = "version",
		type = "VARCHAR(32)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 472, tableId = 40, name = "directory",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 473, tableId = 40, name = "validityBegin",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 474, tableId = 40, name = "validityEnd",
		type = "DATETIME",
		notNull = 0,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 41, name = "sdqa_ImageStatus",
	description = "Unique set of status names and their definitions, e.g. &quot;passed&quot;, &quot;failed&quot;, etc. ";

	INSERT INTO md_Column
	SET columnId = 475, tableId = 41, name = "sdqa_imageStatusId",
		description = "Primary key",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 476, tableId = 41, name = "statusName",
		description = "One-word, camel-case, descriptive name of a possible image status (e.g., passedAuto, marginallyPassedManual, etc.)",
		type = "VARCHAR(30)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 477, tableId = 41, name = "definition",
		description = "Detailed Definition of the image status",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 42, name = "sdqa_Metric",
	description = "Unique set of metric names and associated metadata (e.g., &quot;nDeadPix&quot;, &quot;median&quot;, etc.). There will be approximately 30 records total in this table.";

	INSERT INTO md_Column
	SET columnId = 478, tableId = 42, name = "sdqa_metricId",
		description = "Primary key.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 479, tableId = 42, name = "metricName",
		description = "One-word, camel-case, descriptive name of a possible metric (e.g., mSatPix, median, etc).",
		type = "VARCHAR(30)",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 480, tableId = 42, name = "physicalUnits",
		description = "Physical units of metric.",
		type = "VARCHAR(30)",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 481, tableId = 42, name = "dataType",
		description = "Flag indicating whether data type of the metric value is integer (0) or float (1)",
		type = "CHAR(1)",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 482, tableId = 42, name = "definition",
		type = "VARCHAR(255)",
		notNull = 1,
		displayOrder = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 43, name = "sdqa_Rating_4ScienceAmpExposure",
	description = "Various SDQA ratings for a given amplifier image. There will approximately 30 of these records per image record.";

	INSERT INTO md_Column
	SET columnId = 483, tableId = 43, name = "sdqa_ratingId",
		description = "Primary key.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 484, tableId = 43, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 485, tableId = 43, name = "sdqa_thresholdId",
		description = "Pointer to sdqa_Threshold.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 486, tableId = 43, name = "ampExposureId",
		description = "Pointer to Science_Amp_Exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 487, tableId = 43, name = "metricValue",
		description = "Value of this SDQA metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 488, tableId = 43, name = "metricErr",
		description = "Uncertainty of the value of this metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 44, name = "sdqa_Rating_4ScienceCCDExposure",
	description = "Various SDQA ratings for a given CCD image.";

	INSERT INTO md_Column
	SET columnId = 489, tableId = 44, name = "sdqa_ratingId",
		description = "Primary key.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 490, tableId = 44, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 491, tableId = 44, name = "sdqa_thresholdId",
		description = "Pointer to sdqa_Threshold.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 492, tableId = 44, name = "ccdExposureId",
		description = "Pointer to Science_CCD_Exposure.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 493, tableId = 44, name = "metricValue",
		description = "Value of this SDQA metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 494, tableId = 44, name = "metricErr",
		description = "Uncertainty of the value of this metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 45, name = "sdqa_Rating_4ScienceFPAExposure",
	description = "Various SDQA ratings for a given FPA image.";

	INSERT INTO md_Column
	SET columnId = 495, tableId = 45, name = "sdqa_ratingId",
		description = "Primary key.",
		type = "BIGINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 496, tableId = 45, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 497, tableId = 45, name = "sdqa_thresholdId",
		description = "Pointer to sdqa_Threshold.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 498, tableId = 45, name = "exposureId",
		description = "Pointer to Science_FPA_Exposure.",
		type = "INTEGER",
		notNull = 1,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 499, tableId = 45, name = "metricValue",
		description = "Value of this SDQA metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 5;

	INSERT INTO md_Column
	SET columnId = 500, tableId = 45, name = "metricErr",
		description = "Uncertainty of the value of this metric.",
		type = "DOUBLE",
		notNull = 1,
		displayOrder = 6;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

INSERT INTO md_Table
SET tableId = 46, name = "sdqa_Threshold",
	description = "Version-controlled metric thresholds. Total number of these records is approximately equal to 30 x the number of times the thresholds will be changed over the entire period of LSST operations (of ordre of 100), with most of the changes occuring in the first year of operations.";

	INSERT INTO md_Column
	SET columnId = 501, tableId = 46, name = "sdqa_thresholdId",
		description = "Primary key.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 1;

	INSERT INTO md_Column
	SET columnId = 502, tableId = 46, name = "sdqa_metricId",
		description = "Pointer to sdqa_Metric table.",
		type = "SMALLINT",
		notNull = 1,
		displayOrder = 2;

	INSERT INTO md_Column
	SET columnId = 503, tableId = 46, name = "upperThreshold",
		description = "Threshold for which a metric value is tested to be greater than.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 3;

	INSERT INTO md_Column
	SET columnId = 504, tableId = 46, name = "lowerThreshold",
		description = "Threshold for which a metric value is tested to be less than.",
		type = "DOUBLE",
		notNull = 0,
		displayOrder = 4;

	INSERT INTO md_Column
	SET columnId = 505, tableId = 46, name = "createdDate",
		description = "Database timestamp when the record is inserted.",
		type = "TIMESTAMP",
		notNull = 1,
		defaultValue = "CURRENT_TIMESTAMP",
		displayOrder = 5;
