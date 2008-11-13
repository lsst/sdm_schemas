
-- One-time setup actions for LSST pipelines - assumes the LSST Database Schema already exists.
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu:8100/trac/wiki/Copyrights>
-- for copyright information.

-- ================================================= --
-- Populate lookup/mapping tables with fixed content --
-- ================================================= --

-- LSST filters
INSERT INTO prv_Filter VALUES (0,  0, 'u', NULL, 0.0, 0.0);
INSERT INTO prv_Filter VALUES (1,  0, 'g', NULL, 0.0, 0.0);
INSERT INTO prv_Filter VALUES (2,  0, 'r', NULL, 0.0, 0.0);
INSERT INTO prv_Filter VALUES (3,  0, 'i', NULL, 0.0, 0.0);
INSERT INTO prv_Filter VALUES (4,  0, 'z', NULL, 0.0, 0.0);
INSERT INTO prv_Filter VALUES (5,  0, 'y', NULL, 0.0, 0.0);
-- Additional filters used by MOPS
INSERT INTO prv_Filter VALUES (6,  0, 'w', NULL, 0.0, 0.0);
INSERT INTO prv_Filter VALUES (7,  0, 'V', NULL, 0.0, 0.0);
INSERT INTO prv_Filter VALUES (-99, 0, 'DD', NULL, 0.0, 0.0); -- dummy filter

INSERT INTO mops_SSMDesc (prefix, description) VALUES ( 'S0', 'MOPS synthetic NEO');
INSERT INTO mops_SSMDesc (prefix, description) VALUES ( 'S1', 'MOPS synthetic main-belt object');
INSERT INTO mops_SSMDesc (prefix, description) VALUES ( 'St', 'MOPS synthetic Trojan');
INSERT INTO mops_SSMDesc (prefix, description) VALUES ( 'SC', 'MOPS synthetic Centaur');
INSERT INTO mops_SSMDesc (prefix, description) VALUES ( 'ST', 'MOPS synthetic trans-Neptunian object');
INSERT INTO mops_SSMDesc (prefix, description) VALUES ( 'SS', 'MOPS synthetic scattered disk object');
INSERT INTO mops_SSMDesc (prefix, description) VALUES ( 'Sc', 'MOPS synthetic comet');
INSERT INTO mops_SSMDesc (prefix, description) VALUES ( 'SM', 'MOPS synthetic control object');


-- ================================================================ --
-- Create tables in the form (ENGINE/indexes) expected by pipelines --
-- ================================================================ --

CREATE TABLE DIASourceTemplate LIKE DIASource;

ALTER TABLE DIASourceTemplate
    DROP KEY ccdExposureId,
    DROP KEY filterId,
    DROP KEY movingObjectId,
    DROP KEY objectId,
    DROP KEY scId;

-- This should be a permanent table, but copy it from Object for now.
CREATE TABLE NonVarObject LIKE Object;

CREATE TABLE InMemoryObjectTemplate LIKE Object;

ALTER TABLE InMemoryObjectTemplate
    DROP INDEX idx_Object_ugColor,
    DROP INDEX idx_Object_grColor,
    DROP INDEX idx_Object_riColor,
    DROP INDEX idx_Object_izColor,
    DROP INDEX idx_Object_latestObsTime,
    DROP KEY   procHistoryId;

ALTER TABLE InMemoryObjectTemplate ENGINE=MEMORY;

CREATE TABLE InMemoryMatchPairTemplate LIKE MatchPair;
ALTER TABLE InMemoryMatchPairTemplate ENGINE=MEMORY;

CREATE TABLE InMemoryIdTemplate LIKE Id;
ALTER TABLE InMemoryIdTemplate ENGINE=MEMORY;

-- Populate the Object table for the run
INSERT INTO Object SELECT * FROM DC2.Object;

-- Create tables that accumulate data from per-visit tables
CREATE TABLE MopsPreds LIKE mops_pred;
ALTER TABLE MopsPreds
    ADD COLUMN visitId INTEGER NOT NULL, 
    ADD INDEX  idx_visitId (visitId);

CREATE TABLE DiaSourceToObjectMatches LIKE MatchPair;
ALTER TABLE DiaSourceToObjectMatches
    ADD COLUMN visitId INTEGER NOT NULL,
    ADD INDEX  idx_visitId (visitId);

CREATE TABLE MopsPredToDiaSourceMatches LIKE MatchPair;
ALTER TABLE MopsPredToDiaSourceMatches
    ADD COLUMN visitId INTEGER NOT NULL, 
    ADD INDEX  idx_visitId (visitId);

CREATE TABLE NewObjectIdPairs LIKE IdPair;
ALTER TABLE NewObjectIdPairs
    ADD COLUMN visitId INTEGER NOT NULL, 
    ADD INDEX  idx_visitId (visitId);

