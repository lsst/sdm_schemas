-- LSST Database Schema
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu/trac/wiki/Copyrights>
-- for copyright information.


SET FOREIGN_KEY_CHECKS=0;


CREATE TABLE ZZZ_Db_Description 
    -- <descr>Internal table used for storing database description</descr>
(
    f VARCHAR(255),
        -- <descr>The schema file name.</desc>
    r VARCHAR(255)
        -- <descr>Captures information from 'git describe'.</descr>
) ENGINE=MyISAM;

INSERT INTO ZZZ_Db_Description(f) VALUES('lsstImSimSchema4mysql.sql');


CREATE TABLE SimRefGalaxy
    -- <descr>Stores properties of galaxies used to generate ImSim exposures,
    --        including position, per-filter AB magnitudes, bulge/disk sizes
    --        and variability classification.
    -- </descr>
(
    refGalaxyId BIGINT NOT NULL,
        -- <descr>Unique reference galaxy ID.</descr>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of galaxy center.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of galaxy center.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
    uMag DOUBLE NOT NULL,
        -- <descr>u-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    gMag DOUBLE NOT NULL,
        -- <descr>g-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    rMag DOUBLE NOT NULL,
        -- <descr>r-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    iMag DOUBLE NOT NULL,
        -- <descr>i-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    zMag DOUBLE NOT NULL,
        -- <descr>z-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    yMag DOUBLE NOT NULL,
        -- <descr>y-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    redshift DOUBLE NOT NULL,
        -- <descr>Redshift.</descr>
        -- <ucd>src.redshift</ucd>
    semiMajorBulge DOUBLE NOT NULL,
        -- <descr>Semi-major axis length of galaxy bulge.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    semiMinorBulge DOUBLE NOT NULL,
        -- <descr>Semi-minor axis length of galaxy bulge.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    semiMajorDisk DOUBLE NOT NULL,
        -- <descr>Semi-major axis length of galaxy disk.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    semiMinorDisk DOUBLE NOT NULL,
        -- <descr>Semi-minor axis length of galaxy disk.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    varClass TINYINT NOT NULL,
        -- <descr>Variability classification code:
        -- <ul>
        --    <li>0 = Non-variable</li>
        --    <li>2 = Active galactic nucleus</li>
        --    <li>3 = Lensed Quasar</li>
        -- </ul>
        -- </descr>
    PRIMARY KEY (refGalaxyId),
    KEY IDX_htmId20 (htmId20 ASC)
) ;


CREATE TABLE SimRefStar
    -- <descr>Stores properties of stars used to generate ImSim exposures,
    --        including position, motion, per-filter AB magnitudes and
    --        variability classification.
    -- </descr>
(
    refStarId BIGINT NOT NULL,
        -- <descr>Unique galaxy ID.</descr>
        -- <ucd>meta.id</ucd>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of star.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of star.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
    gLat DOUBLE NOT NULL,
        -- <descr>Galactic latitude of star.</descr>
        -- <ucd>pos.galactic.lat</ucd>
        -- <unit>degree</unit>
    gLon DOUBLE NOT NULL,
        -- <descr>Galactic longitude of star.</descr>
        -- <ucd>pos.galactic.lon</ucd>
        -- <unit>degree</unit>
    sedName VARCHAR(255) NULL,
        -- <descr>Best-fit SED name.</descr>
        -- <ucd>src.sec</ucd>
    uMag DOUBLE NOT NULL,
        -- <descr>u-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    gMag DOUBLE NOT NULL,
        -- <descr>g-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    rMag DOUBLE NOT NULL,
        -- <descr>r-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    iMag DOUBLE NOT NULL,
        -- <descr>i-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    zMag DOUBLE NOT NULL,
        -- <descr>z-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    yMag DOUBLE NOT NULL,
        -- <descr>y-band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    muRa DOUBLE NOT NULL,
        -- <descr>Proper-motion in R.A. : dRA/dt*cos(decl)</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>milliarcsec/year</unit>
    muDecl DOUBLE NOT NULL,
        -- <descr>Proper-motion in Dec. : dDec/dt</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>milliarcsec/year</unit>
    parallax DOUBLE NOT NULL,
        -- <descr>Stellar parallax.</descr>
        -- <ucd>pos.parallax</ucd>
        -- <unit>milliarcsec</unit>
    vRad DOUBLE NOT NULL,
        -- <descr>Radial velocity.</descr>
        -- <ucd>spect.dopplerVeloc.opt</ucd>
        -- <unit>km/s</unit>
    varClass TINYINT NOT NULL,
        -- <descr>Variability classification code:
        -- <ul>
        --    <li>0 = Non-variable</li>
        --    <li>1 = RR-Lyrae</li>
        --    <li>4 = M-Dwarf flares</li>
        --    <li>5 = Eclipsing binary</li>
        --    <li>6 = Microlensing</li>
        --    <li>7 = Long duration microlensing</li>
        --    <li>8 = AM CVn</li>
        --    <li>9 = Cepheid</li>
        -- </ul>
        -- </descr>
    PRIMARY KEY (refStarId),
    KEY IDX_htmId20 (htmId20 ASC)
) ;


CREATE TABLE SimRefObject
    -- <descr>Stores properties of ImSim reference objects. 
    --        Includes both stars and galaxies.
    -- </descr>
(
    refObjectId BIGINT NOT NULL,
        -- <descr>Unique reference object ID.</descr>
        -- <ucd>meta.id;src</ucd>
    isStar TINYINT NOT NULL,
        -- <descr>1 for stars, 0 for galaxies.</descr>
        -- <ucd>src.class</ucd>
    varClass TINYINT NOT NULL,
        -- <descr>Variability classification code:
        -- <ul>
        --    <li>0 = Non-variable</li>
        --    <li>1 = RR-Lyrae</li>
        --    <li>2 = Active galactic nucleus</li>
        --    <li>3 = Lensed Quasar</li>
        --    <li>4 = M-Dwarf flares</li>
        --    <li>5 = Eclipsing binary</li>
        --    <li>6 = Microlensing</li>
        --    <li>7 = Long duration microlensing</li>
        --    <li>8 = AM CVn</li>
        --    <li>9 = Cepheid</li>
        -- </ul>
        -- </descr>
    ra DOUBLE NOT NULL,
        -- <descr>ICRS R.A. of object.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>degree</unit>
    decl DOUBLE NOT NULL,
        -- <descr>ICRS Dec. of object.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>degree</unit>
    htmId20 BIGINT NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
    gLat DOUBLE NULL,
        -- <descr>Galactic latitude, NULL for galaxies.</descr>
        -- <ucd>pos.galactic.lat</ucd>
        -- <unit>degree</unit>
    gLon DOUBLE NULL,
        -- <descr>Galactic longitude. Null for galaxies.</descr>
        -- <ucd>pos.galactic.lon</ucd>
        -- <unit>degree</unit>
    sedName VARCHAR(255) NULL,
        -- <descr>Best-fit SED name. Null for galaxies.</descr>
        -- <ucd>src.sec</ucd>
    uMag DOUBLE NOT NULL,
        -- <descr>u band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    gMag DOUBLE NOT NULL,
        -- <descr>g band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    rMag DOUBLE NOT NULL,
        -- <descr>r band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    iMag DOUBLE NOT NULL,
        -- <descr>i band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    zMag DOUBLE NOT NULL,
        -- <descr>z band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    yMag DOUBLE NOT NULL,
        -- <descr>y band AB magnitude.</descr>
        -- <ucd>phot.mag</ucd>
    muRa DOUBLE NULL,
        -- <descr>dRA/dt*cos(decl). NULL for galaxies.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>milliarcsec/year</unit>
    muDecl DOUBLE NULL,
        -- <descr>dDec/dt. NULL for galaxies.</descr>
        -- <ucd>pos.pm</ucd>
        -- <unit>milliarcsec/year</unit>
    parallax DOUBLE NULL,
        -- <descr>Parallal. NULL for galaxies.</descr>
        -- <ucd>pos.parallax</ucd>
        -- <unit>milliarcsec</unit>
    vRad DOUBLE NULL,
        -- <descr>Radial velocity. NULL for galaxies.</descr>
        -- <ucd>spect.dopplerVeloc.opt</ucd>
        -- <unit>km/sec</unit>
    redshift DOUBLE NULL,
        -- <descr>Redshift. NULL for stars.</descr>
        -- <ucd>src.redshift</ucd>
    semiMajorBulge DOUBLE NULL,
        -- <descr>Semi-major axis length of galaxy bulge. NULL for stars.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    semiMinorBulge DOUBLE NULL,
        -- <descr>Semi-minor axis length of galaxy bulge. NULL for stars.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    semiMajorDisk DOUBLE NULL,
        -- <descr>Semi-major axis length of galaxy disk. NULL for stars.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    semiMinorDisk DOUBLE NULL,
        -- <descr>Semi-minor axis length of galaxy disk. NULL for stars.</descr>
        -- <ucd>src.morph.scLength</ucd>
        -- <unit>arcsec</unit>
    PRIMARY KEY (refObjectId),
    KEY IDX_htmId20 (htmId20 ASC)
) ;


SET FOREIGN_KEY_CHECKS=1;
