CREATE DATABASE tap_schema;

-- minimal tap_schema creation

-- assumes that the tap_schema schema exists

-- sizes for fields are rather arbitrary and generous

-- tested with: PostgreSQL 9.x, 10.x

create table tap_schema.schemas11
(
	schema_name   varchar(64)  NOT NULL,
	utype         varchar(512),
	description   varchar(512),
        schema_index  integer,

-- extension: permissions for user-created content
        owner_id        varchar(32),
        read_anon       integer,
        read_only_group  varchar(128),
        read_write_group varchar(128),

	primary key (schema_name)
)
;

create table tap_schema.schemas
(
	schema_name   varchar(64)  NOT NULL,
	utype         varchar(512),
	description   varchar(512),
        schema_index  integer,

-- extension: permissions for user-created content
        owner_id        varchar(32),
        read_anon       integer,
        read_only_group  varchar(128),
        read_write_group varchar(128),

	primary key (schema_name)
)
;

create table tap_schema.tables11
(
	schema_name   varchar(64)  NOT NULL,
	table_name    varchar(128) NOT NULL,
        table_type    varchar(8)   NOT NULL,
	utype         varchar(512),
	description   varchar(512),
	table_index   integer,

-- extension: permissions for user-created content
        owner_id        varchar(32),
        read_anon       integer,
        read_only_group  varchar(128),
        read_write_group varchar(128),

	primary key (table_name),
	foreign key (schema_name) references tap_schema.schemas11 (schema_name)
)
;

create table tap_schema.tables
(
	schema_name   varchar(64)  NOT NULL,
	table_name    varchar(128) NOT NULL,
        table_type    varchar(8)   NOT NULL,
	utype         varchar(512),
	description   varchar(512),
	table_index   integer,

-- extension: permissions for user-created content
        owner_id        varchar(32),
        read_anon       integer,
        read_only_group  varchar(128),
        read_write_group varchar(128),

	primary key (table_name),
	foreign key (schema_name) references tap_schema.schemas11 (schema_name)
)
;

create table tap_schema.columns11
(
	table_name    varchar(128) NOT NULL,
	column_name   varchar(64)  NOT NULL,
	utype         varchar(512),
	ucd           varchar(64),
	unit          varchar(64),
	description   varchar(512),
	datatype      varchar(64)  NOT NULL,
-- TAP-1.1 arraysize
	arraysize     varchar(16),
-- TAP-1.1 xtype
        xtype         varchar(64),
-- TAP-1.1 size is deprecated
	size          integer,
	principal     integer      NOT NULL,
	indexed       integer      NOT NULL,
	std           integer      NOT NULL,
-- TAP-1.1 column_index
	column_index   integer,
-- extension: globally unique columnID for use as an XML ID attribute on the FIELD in VOTable output
        id            varchar(32),

	primary key (table_name,column_name),
	foreign key (table_name) references tap_schema.tables11 (table_name)
)
;


create table tap_schema.columns
(
	table_name    varchar(128) NOT NULL,
	column_name   varchar(64)  NOT NULL,
	utype         varchar(512),
	ucd           varchar(64),
	unit          varchar(64),
	description   varchar(512),
	datatype      varchar(64)  NOT NULL,
-- TAP-1.1 arraysize
	arraysize     varchar(16),
-- TAP-1.1 xtype
        xtype         varchar(64),
-- TAP-1.1 size is deprecated
	size          integer,
	principal     integer      NOT NULL,
	indexed       integer      NOT NULL,
	std           integer      NOT NULL,
-- TAP-1.1 column_index
	column_index   integer,
-- extension: globally unique columnID for use as an XML ID attribute on the FIELD in VOTable output
        id            varchar(32),

	primary key (table_name,column_name),
	foreign key (table_name) references tap_schema.tables11 (table_name)
)
;

create table tap_schema.keys11
(
	key_id        varchar(64)  NOT NULL,
	from_table    varchar(128) NOT NULL,
	target_table  varchar(128) NOT NULL,
	utype         varchar(512),
	description   varchar(512),

	primary key (key_id),
	foreign key (from_table) references tap_schema.tables11 (table_name),
	foreign key (target_table) references tap_schema.tables11 (table_name)
)
;

create table tap_schema.keys
(
	key_id        varchar(64)  NOT NULL,
	from_table    varchar(128) NOT NULL,
	target_table  varchar(128) NOT NULL,
	utype         varchar(512),
	description   varchar(512),

	primary key (key_id),
	foreign key (from_table) references tap_schema.tables11 (table_name),
	foreign key (target_table) references tap_schema.tables11 (table_name)
)
;

create table tap_schema.key_columns11
(
	key_id          varchar(64) NOT NULL,
	from_column     varchar(64) NOT NULL,
	target_column   varchar(64) NOT NULL,

	foreign key (key_id) references tap_schema.keys11 (key_id)
)
;


create table tap_schema.key_columns
(
	key_id          varchar(64) NOT NULL,
	from_column     varchar(64) NOT NULL,
	target_column   varchar(64) NOT NULL,

	foreign key (key_id) references tap_schema.keys11 (key_id)
)
;

create table tap_schema.KeyValue
(
    name varchar(64) not null primary key,
    value varchar(256) not null,
    lastModified timestamp not null
)
;

create table tap_schema.Modelversion
(
    model varchar(16) not null primary key,
    version varchar(16) not null,
    lastModified timestamp not null
)
;

-- content of the tap_schema tables that describes the tap_schema itself
-- the 11 suffix on all physical table names means this is the TAP-1.1 version
-- as required by the cadc-tap-schema library

-- delete key columns for keys from tables in the tap_schema schema
delete from tap_schema.key_columns11 where
key_id in (select key_id from tap_schema.keys11 where
    from_table in   (select table_name from tap_schema.tables11 where lower(table_name) like 'tap_schema.%')
    or
    target_table in (select table_name from tap_schema.tables11 where lower(table_name) like 'tap_schema.%')
)
;

-- delete keys from tables in the tap_schema schema
delete from tap_schema.keys11 where
from_table in   (select table_name from tap_schema.tables11 where lower(table_name) like 'tap_schema.%')
or
target_table in (select table_name from tap_schema.tables11 where lower(table_name) like 'tap_schema.%')
;

-- delete columns from tables in the tap_schema schema
delete from tap_schema.columns11 where table_name in
(select table_name from tap_schema.tables11 where lower(table_name) like 'tap_schema.%')
;

-- delete tables
delete from tap_schema.tables11 where lower(table_name) like 'tap_schema.%'
;

-- delete schema
delete from tap_schema.schemas11 where lower(schema_name) = 'tap_schema'
;


insert into tap_schema.schemas11 (schema_name,description,utype,schema_index) values
( 'tap_schema', 'A TAP-standard-mandated schema to describe tablesets in a TAP 1.1 service', NULL, 100000)
;

insert into tap_schema.tables11 (schema_name,table_name,table_type,description,utype,table_index) values
( 'tap_schema', 'tap_schema.schemas', 'table', 'description of schemas in this tableset', NULL, 100000),
( 'tap_schema', 'tap_schema.tables', 'table', 'description of tables in this tableset', NULL, 101000),
( 'tap_schema', 'tap_schema.columns', 'table', 'description of columns in this tableset', NULL, 102000),
( 'tap_schema', 'tap_schema.keys', 'table', 'description of foreign keys in this tableset', NULL, 103000),
( 'tap_schema', 'tap_schema.key_columns', 'table', 'description of foreign key columns in this tableset', NULL, 104000)
;

insert into tap_schema.columns11 (table_name,column_name,description,utype,ucd,unit,datatype,arraysize,xtype,principal,indexed,std, column_index) values
( 'tap_schema.schemas', 'schema_name', 'schema name for reference to tap_schema.schemas', NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,1 ),
( 'tap_schema.schemas', 'utype', 'lists the utypes of schemas in the tableset',           NULL, NULL, NULL, 'char', '512*', NULL, 1,0,1,2 ),
( 'tap_schema.schemas', 'description', 'describes schemas in the tableset',               NULL, NULL, NULL, 'char', '512*', NULL, 1,0,1,3 ),
( 'tap_schema.schemas', 'schema_index', 'recommended sort order when listing schemas',    NULL, NULL, NULL, 'int', NULL, NULL, 1,0,1,4 ),

( 'tap_schema.tables', 'schema_name', 'the schema this table belongs to',                 NULL, NULL, NULL, 'char', '512*', NULL, 1,0,1,1 ),
( 'tap_schema.tables', 'table_name', 'the fully qualified table name',                    NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,2 ),
( 'tap_schema.tables', 'table_type', 'one of: table view',                                NULL, NULL, NULL, 'char', '8*', NULL, 1,0,1,3 ),
( 'tap_schema.tables', 'utype', 'lists the utype of tables in the tableset',              NULL, NULL, NULL, 'char', '512*', NULL, 1,0,1,4 ),
( 'tap_schema.tables', 'description', 'describes tables in the tableset',                 NULL, NULL, NULL, 'char', '512*', NULL, 1,0,1,5 ),
( 'tap_schema.tables', 'table_index', 'recommended sort order when listing tables',       NULL, NULL, NULL, 'int', NULL, NULL, 1,0,1,6 ),

( 'tap_schema.columns', 'table_name', 'the table this column belongs to',                 NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,1 ),
( 'tap_schema.columns', 'column_name', 'the column name',                                 NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,2 ),
( 'tap_schema.columns', 'utype', 'lists the utypes of columns in the tableset',           NULL, NULL, NULL, 'char', '512*', NULL, 1,0,1,3 ),
( 'tap_schema.columns', 'ucd', 'lists the UCDs of columns in the tableset',               NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,4 ),
( 'tap_schema.columns', 'unit', 'lists the unit used for column values in the tableset',  NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,5 ),
( 'tap_schema.columns', 'description', 'describes the columns in the tableset',           NULL, NULL, NULL, 'char', '512*', NULL, 1,0,1,6 ),
( 'tap_schema.columns', 'datatype', 'lists the ADQL datatype of columns in the tableset', NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,7 ),
( 'tap_schema.columns', 'arraysize', 'lists the size of variable-length columns in the tableset', NULL, NULL, NULL, 'char', '16*', NULL, 1,0,1,8 ),
( 'tap_schema.columns', 'xtype', 'a DALI or custom extended type annotation',             NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,7 ),

( 'tap_schema.columns', '"size"', 'deprecated: use arraysize', NULL, NULL, NULL, 'int', NULL, NULL, 1,0,1,9 ),
( 'tap_schema.columns', 'principal', 'a principal column; 1 means 1, 0 means 0',      NULL, NULL, NULL, 'int', NULL, NULL, 1,0,1,10 ),
( 'tap_schema.columns', 'indexed', 'an indexed column; 1 means 1, 0 means 0',         NULL, NULL, NULL, 'int', NULL, NULL, 1,0,1,11 ),
( 'tap_schema.columns', 'std', 'a standard column; 1 means 1, 0 means 0',             NULL, NULL, NULL, 'int', NULL, NULL, 1,0,1,12 ),
( 'tap_schema.columns', 'column_index', 'recommended sort order when listing columns of a table',  NULL, NULL, NULL, 'int', NULL, NULL, 1,0,1,13 ),

( 'tap_schema.keys', 'key_id', 'unique key to join to tap_schema.key_columns',            NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,1 ),
( 'tap_schema.keys', 'from_table', 'the table with the foreign key',                      NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,2 ),
( 'tap_schema.keys', 'target_table', 'the table with the primary key',                    NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,3 ),
( 'tap_schema.keys', 'utype', 'lists the utype of keys in the tableset',              NULL, NULL, NULL, 'char', '512*', NULL, 1,0,1,4 ),
( 'tap_schema.keys', 'description', 'describes keys in the tableset',                 NULL, NULL, NULL, 'char', '512*', NULL, 1,0,1,5 ),

( 'tap_schema.key_columns', 'key_id', 'key to join to tap_schema.keys',                   NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,1 ),
( 'tap_schema.key_columns', 'from_column', 'column in the from_table',                    NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,2 ),
( 'tap_schema.key_columns', 'target_column', 'column in the target_table',                NULL, NULL, NULL, 'char', '64*', NULL, 1,0,1,3 )
;

insert into tap_schema.keys11 (key_id,from_table,target_table) values
( 'k1', 'tap_schema.tables', 'tap_schema.schemas' ),
( 'k2', 'tap_schema.columns', 'tap_schema.tables' ),
( 'k3', 'tap_schema.keys', 'tap_schema.tables' ),
( 'k4', 'tap_schema.keys', 'tap_schema.tables' ),
( 'k5', 'tap_schema.key_columns', 'tap_schema.keys' ),
( 'k6', 'tap_schema.key_columns', 'tap_schema.columns' ),
( 'k7', 'tap_schema.key_columns', 'tap_schema.columns' )
;

insert into tap_schema.key_columns11 (key_id,from_column,target_column) values
( 'k1', 'schema_name', 'schema_name' ),
( 'k2', 'table_name', 'table_name' ),
( 'k3', 'from_table', 'table_name' ),
( 'k4', 'target_table', 'table_name' ),
( 'k5', 'key_id', 'key_id' ),
( 'k6', 'from_column', 'column_name'),
( 'k7', 'target_column', 'column_name')
;

-- setup obscore table
CREATE TABLE tap_schema.obscore
(
   obs_publisher_did varchar(256) NOT NULL,
   obs_id varchar(128),
   obs_collection char(32),
   dataproduct_type varchar(5),
   calib_level char(20),
   access_url varchar(256),
   access_format varchar(16),
   access_estsize decimal(20,0),
   target_name varchar(256),
   s_ra DOUBLE,
   s_dec DOUBLE,
   s_fov DOUBLE,
   s_region VARCHAR(2048),
   s_resolution DOUBLE,
   t_min timestamp,
   t_max timestamp,
   t_exptime decimal(10,3),
   t_resolution decimal(10,3),
   em_min DOUBLE,
   em_max DOUBLE,
   em_res_power DOUBLE,
   o_ucd char(35),
   pol_states varchar(64),
   facility_name char(32),
   instrument_name char(32),
   PRIMARY KEY (obs_publisher_did)
);

INSERT INTO tap_schema.schemas11 (schema_name, description, utype, schema_index)
  VALUES ('SYS', 'An Oracle system schema', NULL, 130000);

INSERT INTO tap_schema.tables11 (schema_name, table_name, table_type, description, utype, table_index)
  VALUES ('tap_schema', 'tap_schema.obscore', 'table', '(experimental) basic ObsCore table', NULL, 105000);

INSERT INTO tap_schema.tables11 (schema_name, table_name, table_type, description, utype, table_index)
  VALUES ('SYS', 'SYS.DUAL', 'table', 'Oracle system table.', NULL, 130000);

INSERT
  INTO tap_schema.columns11 (table_name,column_name,utype,ucd,unit,description,datatype,arraysize,xtype,principal,indexed,std,column_index,id)
  VALUES
  ('tap_schema.obscore','calib_level','obscore:ObsDataset.calibLevel','meta.code;obs.calib',null,'calibration level (0,1,2,3)','int',null,null,1,0,1,5,null),
  ('tap_schema.obscore','s_ra','obscore:Char.SpatialAxis.Coverage.Location.Coord.Position2D.Value2.C1','pos.eq.ra','deg','RA of central coordinates','double',null,null,1,0,1,9,null),
  ('tap_schema.obscore','s_dec','obscore:Char.SpatialAxis.Coverage.Location.Coord.Position2D.Value2.C2','pos.eq.dec','deg','DEC of central coordinates','double',null,null,1,0,1,10,null),
  ('tap_schema.obscore','s_fov','obscore:Char.SpatialAxis.Coverage.Bounds.Extent.diameter','phys.angSize;instr.fov','deg','size of the region covered (~diameter of minimum bounding circle)','double',null,null,1,0,1,11,null),
  ('tap_schema.obscore','s_region','obscore:Char.SpatialAxis.Coverage.Support.Area','phys.outline;obs.field','deg','region bounded by observation','char','*','adql:REGION',1,1,1,12,null),
  ('tap_schema.obscore','s_resolution','obscore:Char.SpatialAxis.Resolution.refval.value','pos.angResolution','arcsec','typical spatial resolution','double',null,null,1,0,1,13,null),
  ('tap_schema.obscore','t_min','obscore:Char.TimeAxis.Coverage.Bounds.Limits.StartTime','time.start;obs.exposure','d','start time of observation (MJD)','double',null,null,1,1,1,14,null),
  ('tap_schema.obscore','t_max','obscore:Char.TimeAxis.Coverage.Bounds.Limits.StopTime','time.end;obs.exposure','d','end time of observation (MJD)','double',null,null,1,1,1,15,null),
  ('tap_schema.obscore','t_exptime','obscore:Char.TimeAxis.Coverage.Support.Extent','time.duration;obs.exposure','s','exposure time of observation','double',null,null,1,1,1,16,null),
  ('tap_schema.obscore','t_resolution','obscore:Char.TimeAxis.Resolution.refval.value','time.resolution','s','typical temporal resolution','double',null,null,1,0,1,17,null),
  ('tap_schema.obscore','em_min','obscore:Char.SpectralAxis.Coverage.Bounds.Limits.LoLimit','em.wl;stat.min','m','start spectral coordinate value','double',null,null,1,1,1,18,null),
  ('tap_schema.obscore','em_max','obscore:Char.SpectralAxis.Coverage.Bounds.Limits.HiLimit','em.wl;stat.max','m','stop spectral coordinate value','double',null,null,1,1,1,19,null),
  ('tap_schema.obscore','em_res_power','obscore:Char.SpectralAxis.Resolution.ResolPower.refval','spect.resolution',null,'typical spectral resolution','double',null,null,1,0,1,20,null),
  ('tap_schema.obscore','access_url','obscore:Access.Reference','meta.ref.url',null,'URL to download the data','char','*','clob',1,0,1,6,null),
  ('tap_schema.obscore','access_format','obscore:Access.Format','meta.code.mime',null,'Content format of the data','char','128*',null,1,0,1,31,null),
  ('tap_schema.obscore','access_estsize','obscore:Access.Size','phys.size;meta.file','kbyte','estimated size of the download','long',null,null,1,0,1,7,null),
  ('tap_schema.obscore','obs_publisher_did','obscore:Curation.PublisherDID','meta.ref.url;meta.curation',null,'publisher dataset identifier','char','256*',null,1,1,1,1,null),
  ('tap_schema.obscore','obs_collection','obscore:DataID.Collection','meta.id',null,'short name for the data colection','char','128*',null,1,0,1,3,null),
  ('tap_schema.obscore','facility_name','obscore:Provenance.ObsConfig.Facility.name','meta.id;instr.tel',null,'telescope name','char','128*',null,1,0,1,23,null),
  ('tap_schema.obscore','instrument_name','obscore:Provenance.ObsConfig.Instrument.name','meta.id;instr',null,'instrument name','char','128*',null,1,0,1,24,null),
  ('tap_schema.obscore','obs_id','obscore:DataID.observationID','meta.id',null,'internal dataset identifier','char','128*',null,1,0,1,2,null),
  ('tap_schema.obscore','dataproduct_type','obscore:ObsDataset.dataProductType','meta.id',null,'type of product','char','128*',null,1,0,1,4,null),
  ('tap_schema.obscore','target_name','obscore:Target.Name','meta.id;src',null,'name of intended target','char','32*',null,1,0,1,8,null),
  ('tap_schema.obscore','pol_states','obscore:Char.PolarizationAxis.stateList','meta.code;phys.polarization',null,'polarization states present in the data','char','32*',null,1,0,1,22,null),
  ('tap_schema.obscore','o_ucd','obscore:Char.ObservableAxis.ucd','meta.ucd',null,'UCD describing the observable axis (pixel values)','char','32*',null,1,0,1,21,null),
  ('SYS.DUAL','SYSDATE',NULL, NULL,null,'Current date','char','64*',null,1,0,1,25,null);
