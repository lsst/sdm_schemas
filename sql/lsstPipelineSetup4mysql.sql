
-- One-time setup actions for LSST pipelines - assumes the LSST Database Schema already exists.
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu:8100/trac/wiki/Copyrights>
-- for copyright information.

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

