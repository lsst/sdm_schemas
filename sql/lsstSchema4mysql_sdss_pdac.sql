

    CREATE TABLE Filter (
    filterId tinyint(4) NOT NULL,
        -- <descr>Unique id (primary key).</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    filterName char(3) NOT NULL,
        -- <descr>Filter name. Valid values: 'u', 'g', 'r', 'i', 'z'</descr>
        -- <ucd>instr.bandpass</ucd>
    photClam float NOT NULL,
        -- <descr>Filter centroid wavelength.</descr>
        -- <ucd>em.wl.effective;instr.filter</ucd>
        -- <unit>nm</unit>
    photBW float NOT NULL,
        -- <descr>System effective bandwidth.</descr>
        -- <ucd>instr.bandwidth</ucd>
        -- <unit>nm</unit>
    PRIMARY KEY (filterId)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE DeepCoadd (
    deepCoaddId bigint(20) NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    tract int(11) NOT NULL,
        -- <descr>Sky-tract number.</descr>
    patch char(16) NOT NULL,
        -- <descr>Sky-patch.</descr>
    filterId tinyint(4) NOT NULL,
        -- <descr>Id of the filter for the band.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
        -- <unit></unit>
    filterName char(3) NOT NULL,
        -- <descr>Filter name, pulled in from the Filter table.</descr>
        -- <ucd>instr.bandpass</ucd>
    ra double NOT NULL,
        -- <descr>ICRS R.A. of image center, corresponding to FITS pixel coordinates ((NAXIS1 + 1)/2, (NAXIS2 + 1)/2).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl double NOT NULL,
        -- <descr>ICRS Dec. of image center, corresponding to FITS pixel coordinates ((NAXIS1 + 1)/2, (NAXIS2 + 1)/2).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    htmId20 bigint(20) NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
        -- <ucd>pos.HTM</ucd>
    equinox float NOT NULL,
        -- <ucd>pos.equinox </ucd>
    raDeSys varchar(20) NOT NULL,
        -- <ucd>pos.frame</ucd>
    ctype1 varchar(20) NOT NULL,
        -- <ucd>pos.wcs.ctype</ucd>
    ctype2 varchar(20) NOT NULL,
        -- <ucd>pos.wcs.ctype</ucd>
    crpix1 float NOT NULL,
        -- <ucd>pos.wcs.crpix</ucd>
        -- <unit>pixel</unit>
    crpix2 float NOT NULL,
        -- <ucd>pos.wcs.crpix </ucd>
        -- <unit>pixel</unit>
    crval1 double NOT NULL,
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    crval2 double NOT NULL,
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    cd1_1 double NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd1_2 double NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_1 double NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_2 double NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    corner1Ra double NOT NULL,
        -- <descr>ICRS RA of image corner 1, corresponding to FITS pixel coordinates (0.5, 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner1Decl double NOT NULL,
        -- <descr>ICRS RA of image corner 1, corresponding to FITS pixel coordinates (0.5, 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    corner2Ra double NOT NULL,
        -- <descr>ICRS RA of image corner 2, corresponding to FITS pixel coordinates (0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner2Decl double NOT NULL,
        -- <descr>ICRS Dec of image corner 2, corresponding to FITS pixel coordinates (0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    corner3Ra double NOT NULL,
        -- <descr>ICRS RA of image corner 3, corresponding to FITS pixel coordinates (NAXIS1 + 0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner3Decl double NOT NULL,
        -- <descr>ICRS Dec of image corner 3, corresponding to FITS pixel coordinates (NAXIS1 + 0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    corner4Ra double NOT NULL,
        -- <descr>ICRS RA of image corner 4, corresponding to FITS pixel coordinates (NAXIS1 + 0.5, 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner4Decl double NOT NULL,
        -- <descr>ICRS Dec of image corner 4, corresponding to FITS pixel coordinates (NAXIS1 + 0.5, 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    poly binary(120) NOT NULL,
        -- <descr>binary representation of the 4-corner polygon for the exposure.</descr>
    fluxMag0 float NOT NULL,
        -- <ucd>phot.flux.density</ucd>
    fluxMag0Sigma float NOT NULL,
        -- <ucd>stat.error;phot.flux.density</ucd>
    matchedFwhm double DEFAULT NULL,
        -- <descr>FWHM computed from PSF that was matched to during coaddition. NULL if coadds were created with PSF-matching turned off.</descr>
        -- <ucd>instr.obsty.seeing</ucd>
        -- <unit>arcsec</unit>
    measuredFwhm double DEFAULT NULL,
        -- <descr>FWHM computed from measured PSF. NULL if coadds were created with PSF-matching turned on and the pipeline was configured to use the matched-to PSF.</descr>
        -- <ucd>instr.obsty.seeing</ucd>
        -- <unit>arcsec</unit>
    path varchar(255) NOT NULL,
        -- <descr>FITS file path relative to the SFM pipeline output directory.</descr>
    PRIMARY KEY (deepCoaddId),
    KEY IDX_htmId20 (htmId20),
    KEY IDX_tract_patch_filterName (tract,patch,filterName),
    KEY FK_DeepCoadd_filterId (filterId)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE DeepCoadd_Metadata (
    deepCoaddId bigint(20) NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey varchar(255) NOT NULL,
    exposureType tinyint(4) NOT NULL,
        -- <descr>Description of the schema.
        -- <ul>
        -- <li>Type of exposure</li>
        -- <li>1: Science CCD</li>
        -- <li>2: Difference Imaging CCD</li>
        -- <li>3: Good-seeing coadd</li>
        -- <li>4: Deep coadd</li>
        -- <li>5: Chi-squared coadd</li>
        -- <li>6: Keith coadd</li>
        -- </ul>
        -- </descr>
    intValue int(11) DEFAULT NULL,
    doubleValue double DEFAULT NULL,
    stringValue varchar(255) DEFAULT NULL,
    PRIMARY KEY (deepCoaddId,metadataKey),
    KEY IDX_metadataKey (metadataKey)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE DeepCoadd_To_Htm10 (
    deepCoaddId bigint(20) NOT NULL,
        -- <descr>Pointer to DeepCoadd.</descr>
    htmId10 int(11) NOT NULL,
        -- <ucd>pos.HTM</ucd>
        -- <descr>ID for Level 10 HTM triangle overlapping exposure. For each exposure in DeepCoadd, there will be one row for every overlapping triangle.</descr>
    KEY IDX_htmId10 (htmId10),
    KEY IDX_deepCoaddId (deepCoaddId)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE LeapSeconds (
    whenJd float NOT NULL,
        -- <descr>JD of change in TAI-UTC difference (leap second).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    offset float NOT NULL,
        -- <descr>New number of leap seconds.</descr>
        -- <ucd>time.interval</ucd>
        -- <unit>s</unit>
    mjdRef float NOT NULL,
        -- <descr>Reference MJD for drift (prior to 1972-Jan-1).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    drift float NOT NULL,
        -- <descr>Drift in seconds per day (prior to 1972-Jan-1).</descr>
        -- <ucd>arith.rate</ucd>
        -- <unit>s/d</unit>
    whenMjdUtc float DEFAULT NULL,
        -- <descr>MJD in UTC system of change (computed).</descr>
        -- <ucd>time.epoch</ucd>
        -- <unit>d</unit>
    whenUtc bigint(20) DEFAULT NULL,
        -- <descr>Nanoseconds from epoch in UTC system of change (computed).</descr>
        -- <ucd>time</ucd>
        -- <unit>ns</unit>
    whenTai bigint(20) DEFAULT NULL
        -- <descr>Nanoseconds from epoch in TAI system of change (computed).</descr>
        -- <ucd>time</ucd>
        -- <unit>ns</unit>
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE RunDeepForcedSource (
    id bigint(20) NOT NULL,
        -- <ucd>meta.id;src</ucd>
    coord_ra double DEFAULT NULL,
        -- <descr>ICRS RA of source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    coord_decl double DEFAULT NULL,
        -- <descr>ICRS Dec of source centroid (x, y).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    coord_htmId20 bigint(20) DEFAULT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
        -- <ucd>pos.HTM</ucd>
    parent bigint(20) DEFAULT NULL,
        -- <descr>goodSeeingSourceId of parent if source is deblended, otherwise NULL.</descr>
        -- <ucd>meta.id.parent;src</ucd>
    flags_badcentroid bit(1) NOT NULL,
        -- <descr>Set if the centroid measurement failed.</descr>
        -- <ucd>meta.code.error</ucd>
    centroid_sdss_x double DEFAULT NULL,
        -- <descr>Pixel axis 1 coordinate of forced-source SDSS entroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    centroid_sdss_y double DEFAULT NULL,
        -- <descr>Pixel axis 2 coordinate of forced-source SDSS centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    centroid_sdss_xVar float DEFAULT NULL,
        -- <descr>Variance of x. of forced-source SDSS centroid</descr>
        -- <ucd>stat.variance;pos.cartesian.x</ucd>
        -- <unit>pixel^2</unit>
    centroid_sdss_xyCov float DEFAULT NULL,
        -- <descr>Covariance of x and y of forced-source SDSS centroid</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^2</unit>
    centroid_sdss_yVar float DEFAULT NULL,
        -- <descr>Variance of y. forced-source SDSS centroid</descr>
        -- <ucd>stat.variance;pos.cartesian.y</ucd>
        -- <unit>pixel^2</unit>
    centroid_sdss_flags bit(1) NOT NULL,
        -- <descr>set if SDSS centroid is unreliable</descr>
        -- <ucd>meta.code.error</ucd>
    centroid_gaussian_x double DEFAULT NULL,
        -- <descr>Pixel axis 1 coordinate of forced-source gaussian centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    centroid_gaussian_y double DEFAULT NULL,
        -- <descr>Pixel axis 2 coordinate of forced-source gaussian centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    centroid_gaussian_xVar float DEFAULT NULL,
        -- <descr>Variance of x. of forced-source gaussian centroid</descr>
        -- <ucd>stat.variance;pos.cartesian.x</ucd>
        -- <unit>pixel^2</unit>
    centroid_gaussian_xyCov float DEFAULT NULL,
        -- <descr>Covariance of x and y of forced-source gaussian centroid</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^2</unit>
    centroid_gaussian_yVar float DEFAULT NULL,
        -- <descr>Variance of y. forced-source gaussian centroid</descr>
        -- <ucd>stat.variance;pos.cartesian.y</ucd>
        -- <unit>pixel^2</unit>
    centroid_gaussian_flags bit(1) NOT NULL,
        -- <descr>set if gaussian centroid is unreliable</descr>
        -- <ucd>meta.code.error</ucd>
    centroid_naive_x double DEFAULT NULL,
        -- <descr>Pixel axis 1 coordinate of forced-source naive centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    centroid_naive_y double DEFAULT NULL,
        -- <descr>Pixel axis 2 coordinate of forced-source naive centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    centroid_naive_xVar float DEFAULT NULL,
        -- <descr>Variance of x. of forced-source naive centroid</descr>
        -- <ucd>stat.variance;pos.cartesian.x</ucd>
        -- <unit>pixel^2</unit>
    centroid_naive_xyCov float DEFAULT NULL,
        -- <descr>Covariance of x and y of forced-source naive centroid</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^2</unit>
    centroid_naive_yVar float DEFAULT NULL,
        -- <descr>Variance of y. forced-source naive centroid</descr>
        -- <ucd>stat.variance;pos.cartesian.y</ucd>
        -- <unit>pixel^2</unit>
    centroid_naive_flags bit(1) NOT NULL,
        -- <descr>set if naive centroid is unreliable</descr>
        -- <ucd>meta.code.error</ucd>
    flags_pixel_edge bit(1) NOT NULL,
        -- <descr>Set if forced-source is in region labeled EDGE.</descr>
        -- <ucd>meta.code</ucd>
    flags_pixel_interpolated_any bit(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flags_pixel_interpolated_center bit(1) NOT NULL,
        -- <descr>Set if forced-source center is close to
        -- interpolated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flags_pixel_saturated_any bit(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flags_pixel_saturated_center bit(1) NOT NULL,
        -- <descr>Set if forced-source center is close to
        -- saturated pixels.</descr>
        -- <ucd>meta.code</ucd>
    flags_pixel_cr_any bit(1) NOT NULL,
        -- <descr>Set if forced-source footprint includes cosmic ray pixels</descr>
        -- <ucd>meta.code</ucd>
    flags_pixel_cr_center bit(1) NOT NULL,
        -- <descr>Set if forced-source center is close to cosmic ray pixels</descr>
        -- <ucd>meta.code</ucd>
    flags_pixel_bad bit(1) NOT NULL,
        -- <descr>Set if forced-source footptinyt incoudes bad pixels </descr>
        -- <ucd>meta.code</ucd>
    shape_sdss_Ixx double DEFAULT NULL,
        -- <descr>Second moment.</descr>
        -- <unit>pixel^2</unit>
    shape_sdss_Iyy double DEFAULT NULL,
        -- <descr>Second moment.</descr>
        -- <unit>pixel^2</unit>
    shape_sdss_Ixy double DEFAULT NULL,
        -- <descr>Second moment.</descr>
        -- <unit>pixel^2</unit>
    shape_sdss_IxxVar float DEFAULT NULL,
        -- <descr>Variance of shapeIxx.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_IxxIyyCov float DEFAULT NULL,
        -- <descr>Covariance of shapeIxx and shapeIyy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_IxxIxyCov float DEFAULT NULL,
        -- <descr>Covariance of shapeIxx and shapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_IyyVar float DEFAULT NULL,
        -- <descr>Variance of shapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_IyyIxyCov float DEFAULT NULL,
        -- <descr>Covariance of shapeIyy and shapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_IxyVar float DEFAULT NULL,
        -- <descr>Variance of shapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_flags bit(1) NOT NULL,
        -- <descr>set if SDSS shape measurement is unreliable</descr>
        -- <ucd>meta.code.error</ucd>
    shape_sdss_centroid_x double DEFAULT NULL,
        -- <descr>Pixel axis 1 coordinate of forced-source shape centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    shape_sdss_centroid_y double DEFAULT NULL,
        -- <descr>Pixel axis 2 coordinate of forced-source shape centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    shape_sdss_centroid_xVar float DEFAULT NULL,
        -- <descr>Variance of x. of forced-source shape centroid</descr>
        -- <ucd>stat.variance;pos.cartesian.x</ucd>
        -- <unit>pixel^2</unit>
    shape_sdss_centroid_xyCov float DEFAULT NULL,
        -- <descr>Covariance of x and y of forced-source shape centroid</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^2</unit>
    shape_sdss_centroid_yVar float DEFAULT NULL,
        -- <descr>Variance of y. forced-source naive centroid</descr>
        -- <ucd>stat.variance;pos.cartesian.y</ucd>
        -- <unit>pixel^2</unit>
    shape_sdss_centroid_flags bit(1) NOT NULL,
        -- <descr>set if centroid measured by SDSS shape algorithm is unreliable</descr>
        -- <ucd>meta.code.error</ucd>
    shape_sdss_flags_unweightedbad bit(1) NOT NULL,
    shape_sdss_flags_unweighted bit(1) NOT NULL,
    shape_sdss_flags_shift bit(1) NOT NULL,
    shape_sdss_flags_maxiter bit(1) NOT NULL,
    flux_gaussian double DEFAULT NULL,
        -- <descr>Uncalibrated gaussian flux.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_gaussian_err double DEFAULT NULL,
        -- <descr>Uncertainty of flux_gaussian.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_gaussian_flags bit(1) NOT NULL,
    flux_gaussian_psffactor float DEFAULT NULL,
    flux_gaussian_flags_psffactor bit(1) NOT NULL,
    flux_naive double DEFAULT NULL,
        -- <descr>Uncalibrated naive flux.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_naive_err double DEFAULT NULL,
        -- <descr>Uncertainty of flux_naive.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_naive_flags bit(1) NOT NULL,
    flux_psf double DEFAULT NULL,
        -- <descr>Uncalibrated PSF flux.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_psf_err double DEFAULT NULL,
        -- <descr>Uncertainty of flux_psf.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_psf_flags bit(1) NOT NULL,
    flux_psf_psffactor float DEFAULT NULL,
    flux_psf_flags_psffactor bit(1) NOT NULL,
    flux_sinc double DEFAULT NULL,
        -- <descr>Uncalibrated sinc flux.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_sinc_err double DEFAULT NULL,
        -- <descr>Uncertainty of flux_sinc.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_sinc_flags bit(1) NOT NULL,
    correctfluxes_apcorr float DEFAULT NULL,
        -- <descr>Aperture correction factor applied to fluxes</descr>
        -- <ucd>arith.factor</ucd>
    correctfluxes_apcorr_flags bit(1) NOT NULL,
    centroid_record_x double DEFAULT NULL,
    centroid_record_y double DEFAULT NULL,
    classification_extendedness double DEFAULT NULL,
        -- <descr>Probability of being extended.<descr>
        -- <ucd>stat.probability</ucd>
    refFlux double DEFAULT NULL,
        -- <descr>Flux of the reference deep source on coadd.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    refFlux_err double DEFAULT NULL,
        -- <descr>Error of lux of the reference deep source on coadd.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    objectId bigint(20) NOT NULL,
        -- <descr>ID of object this source was assigned to. NULL if the source
        -- did not participate in spatial clustering, or if the clustering
        -- algorithm considered the source to be a 'noise' source.</descr>
        -- <ucd>meta.id;src</ucd>
    coord_raVar float DEFAULT NULL,
        -- <descr>Variance of ra, taken from the sample covariance matrix
        -- of (ra, decl). The standard error of the mean ra is
        -- sqrt(raVar/obsCount)</descr>
        -- <ucd>stat.variance;pos.eq.ra</ucd>
        -- <unit>arcsec^2</unit>
    coord_radeclCov float DEFAULT NULL,
        -- <descr>Sample covariance of ra and decl.</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <unit>arcsec^2</unit>
    coord_declVar float DEFAULT NULL,
        -- <descr>Variance of decl, taken from the sample covariance matrix
        -- of (ra, decl). The standard error of the mean decl is
        -- sqrt(declVar/obsCount)</descr>
        -- <ucd>stat.variance;pos.eq.dec</ucd>
        -- <unit>arcsec^2</unit>
    exposure_id bigint(20) NOT NULL,
        -- <descr>Exposure identifier.</descr>
        -- <ucd>meta.id;obs.image</ucd>
    exposure_filter_id int(11) NOT NULL,
        -- <descr>Id of the filter for the band.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    exposure_time float DEFAULT NULL,
        -- <descr>Duration of exposure.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    exposure_time_mid double DEFAULT NULL,
        -- <descr>Time (ISO8601 format, UTC) at the mid-point of the
        -- combined exposure.</descr>
        -- <ucd>time.epoch</ucd>
    cluster_id bigint(20) DEFAULT NULL,
        -- <descr> ID of a deduplication cluster.</descr>
    cluster_coord_ra double DEFAULT NULL,
        -- <descr> RA-coordinate of the center of cluster.</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    cluster_coord_decl double DEFAULT NULL,
        -- <descr> Decl-coordinate of the center of cluster.</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    is_primary bit(1) DEFAULT NULL,
        -- <descr> True if does not come from de-duplication.</descr>
    object_coord_ra double DEFAULT NULL,
        -- <descr>ICRS RA of object associated with this source, or ra if the
        -- source was not associated with any object (objectId is NULL).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    object_coord_decl double DEFAULT NULL,
        -- <descr>ICRS Dec of object associated with this source, or decl if the
        -- source was not associated with any object (objectId is NULL).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    PRIMARY KEY (id),
    KEY IDX_coord_htmId20 (coord_htmId20),
    KEY IDX_coord_decl (coord_decl),
    KEY IDX_parent (parent),
    KEY IDX_exposure_id (exposure_id),
    KEY IDX_exposure_filter_id (exposure_filter_id),
    KEY IDX_objectId (objectId),
    KEY IDX_objectId_exposure (objectId,exposure_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE RunDeepSource (
    id bigint(20) NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;src</ucd>
    coord_ra double DEFAULT NULL,
        -- <descr>ICRS RA of source centroid (x, y).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    coord_decl double DEFAULT NULL,
        -- <descr>ICRS Dec of source centroid (x, y).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    coord_htmId20 bigint(20) DEFAULT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
        -- <ucd>pos.HTM</ucd>
    parent bigint(20) DEFAULT NULL,
        -- <descr>SDSS parentID</descr>
    calib_detected bit(1) NOT NULL,
    flags_negative bit(1) NOT NULL,
    deblend_nchild int(11) NOT NULL,
        -- <descr>Number of children that this source has. Zero if it's the final deblending product.</desc>
    deblend_deblended_as_psf bit(1) NOT NULL,
    deblend_psf_center_x double DEFAULT NULL,
    deblend_psf_center_y double DEFAULT NULL,
    deblend_psf_flux double DEFAULT NULL,
        -- <descr>Deblended PSF flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    deblend_too_many_peaks bit(1) NOT NULL,
    deblend_failed bit(1) NOT NULL,
    flags_badcentroid bit(1) NOT NULL,
    centroid_sdss_x double DEFAULT NULL,
        -- <descr>Pixel axis 1 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    centroid_sdss_y double DEFAULT NULL,
        -- <descr>Pixel axis 2 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    centroid_sdss_xVar float DEFAULT NULL,
        -- <descr>Variance of x.</descr>
        -- <ucd>stat.variance;pos.cartesian.x</ucd>
        -- <unit>pixel^2</unit>
    centroid_sdss_xyCov float DEFAULT NULL,
        -- <descr>Covariance of x and y</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^2</unit>
    centroid_sdss_yVar float DEFAULT NULL,
        -- <descr>Variance of y.</descr>
        -- <ucd>stat.variance;pos.cartesian.y</ucd>
        -- <unit>pixel^2</unit>
    centroid_sdss_flags bit(1) NOT NULL,
        -- <ucd>meta.code.error</ucd>
    centroid_gaussian_x double DEFAULT NULL,
        -- <descr>Pixel axis 1 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    centroid_gaussian_y double DEFAULT NULL,
        -- <descr>Pixel axis 2 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    centroid_gaussian_xVar float DEFAULT NULL,
        -- <descr>Variance of x.</descr>
        -- <ucd>stat.variance;pos.cartesian.x</ucd>
        -- <unit>pixel^2</unit>
    centroid_gaussian_xyCov float DEFAULT NULL,
        -- <descr>Covariance of x and y</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^2</unit>  
    centroid_gaussian_yVar float DEFAULT NULL,
        -- <descr>Variance of y.</descr>
        -- <ucd>stat.variance;pos.cartesian.y</ucd>
        -- <unit>pixel^2</unit>  
    centroid_gaussian_flags bit(1) NOT NULL,
        -- <ucd>meta.code.error</ucd>
    centroid_naive_x double DEFAULT NULL,
        -- <descr>Pixel axis 1 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    centroid_naive_y double DEFAULT NULL,
        -- <descr>Pixel axis 2 coordinate of source centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>  
    centroid_naive_xVar float DEFAULT NULL,
        -- <descr>Variance of x.</descr>
        -- <ucd>stat.variance;pos.cartesian.x</ucd>
        -- <unit>pixel^2</unit>  
    centroid_naive_xyCov float DEFAULT NULL,
        -- <descr>Covariance of x and y</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^2</unit>  
    centroid_naive_yVar float DEFAULT NULL,
        -- <descr>Variance of y.</descr>
        -- <ucd>stat.variance;pos.cartesian.y</ucd>
        -- <unit>pixel^2</unit>  
    centroid_naive_flags bit(1) NOT NULL,
        -- <ucd>meta.code.error</ucd>
    flags_pixel_edge bit(1) NOT NULL,
    flags_pixel_interpolated_any bit(1) NOT NULL,
    flags_pixel_interpolated_center bit(1) NOT NULL,
    flags_pixel_saturated_any bit(1) NOT NULL,
    flags_pixel_saturated_center bit(1) NOT NULL,
    flags_pixel_cr_any bit(1) NOT NULL,
    flags_pixel_cr_center bit(1) NOT NULL,
    flags_pixel_bad bit(1) NOT NULL,
    shape_sdss_Ixx double DEFAULT NULL,
        -- <descr>Second moment.</descr>
        -- <unit>pixel^2</unit>
    shape_sdss_Iyy double DEFAULT NULL,
        -- <descr>Second moment.</descr>
        -- <unit>pixel^2</unit>
    shape_sdss_Ixy double DEFAULT NULL,
        -- <descr>Second moment.</descr>
        -- <unit>pixel^2</unit>
    shape_sdss_IxxVar float DEFAULT NULL,
        -- <descr>Variance of shapeIxx.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_IxxIyyCov float DEFAULT NULL,
        -- <descr>Covariance of shapeIxx and shapeIyy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_IxxIxyCov float DEFAULT NULL,
        -- <descr>Covariance of shapeIxx and shapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_IyyVar float DEFAULT NULL,
        -- <descr>Variance of shapeIyy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_IyyIxyCov float DEFAULT NULL,
        -- <descr>Covariance of shapeIyy and shapeIxy.</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_IxyVar float DEFAULT NULL,
        -- <descr>Variance of shapeIxy.</descr>
        -- <ucd>stat.variance</ucd>
        -- <unit>pixel^4</unit>
    shape_sdss_flags bit(1) NOT NULL,
        -- <descr>set if SDSS shape measurement is unreliable</descr>
        -- <ucd>meta.code.error</ucd>
    shape_sdss_centroid_x double DEFAULT NULL,
        -- <descr>Pixel axis 1 coordinate of source shape centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.x</ucd>
        -- <unit>pixel</unit>
    shape_sdss_centroid_y double DEFAULT NULL,
        -- <descr>Pixel axis 2 coordinate of source shape centroid,
        -- LSST pixel coordinate conventions.</descr>
        -- <ucd>pos.cartesian.y</ucd>
        -- <unit>pixel</unit>
    shape_sdss_centroid_xVar float DEFAULT NULL,
        -- <descr>Variance of x. of source shape centroid</descr>
        -- <ucd>stat.variance;pos.cartesian.x</ucd>
        -- <unit>pixel^2</unit>
    shape_sdss_centroid_xyCov float DEFAULT NULL,
        -- <descr>Covariance of x and y of source shape centroid</descr>
        -- <ucd>stat.covariance</ucd>
        -- <unit>pixel^2</unit>
    shape_sdss_centroid_yVar float DEFAULT NULL,
        -- <descr>Variance of y. source naive centroid</descr>
        -- <ucd>stat.variance;pos.cartesian.y</ucd>
        -- <unit>pixel^2</unit>
    shape_sdss_centroid_flags bit(1) NOT NULL,
        -- <descr>set if centroid measured by SDSS shape algorithm is unreliable</descr>
        -- <ucd>meta.code.error</ucd>
    shape_sdss_flags_unweightedbad bit(1) NOT NULL,
        -- <ucd>meta.code</ucd>
    shape_sdss_flags_unweighted bit(1) NOT NULL,
        -- <ucd>meta.code</ucd>
    shape_sdss_flags_shift bit(1) NOT NULL,
        -- <ucd>meta.code</ucd>
    shape_sdss_flags_maxiter bit(1) NOT NULL,
        -- <ucd>meta.code</ucd>
    flux_gaussian double DEFAULT NULL,
        -- <descr>Gaussian flux of source.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_gaussian_err double DEFAULT NULL,
        -- <descr>Uncertainty of gaussian flux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_gaussian_flags bit(1) NOT NULL,
        -- <ucd>meta.code</ucd>
    flux_gaussian_psffactor float DEFAULT NULL,
    flux_gaussian_flags_psffactor bit(1) NOT NULL,
    flux_naive double DEFAULT NULL,
        -- <descr>Uncalibrated naive flux.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_naive_err double DEFAULT NULL,
        -- <descr>Uncertainty of flux_naive.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_naive_flags bit(1) NOT NULL,
    flux_psf double DEFAULT NULL,
        -- <descr>Uncalibrated PSF flux.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_psf_err double DEFAULT NULL,
        -- <descr>Uncertainty of flux_psf.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_psf_flags bit(1) NOT NULL,
    flux_psf_psffactor float DEFAULT NULL,
    flux_psf_flags_psffactor bit(1) NOT NULL,
    flux_sinc double DEFAULT NULL,
        -- <descr>Uncalibrated sinc flux.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_sinc_err double DEFAULT NULL,
        -- <descr>Uncertainty of flux_sinc.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <unit>adu</unit>
    flux_sinc_flags bit(1) NOT NULL,
    multishapelet_psf_inner_1 float DEFAULT NULL,
    multishapelet_psf_outer_1 float DEFAULT NULL,
    multishapelet_psf_ellipse_Ixx float DEFAULT NULL,
    multishapelet_psf_ellipse_Iyy float DEFAULT NULL,
    multishapelet_psf_ellipse_Ixy float DEFAULT NULL,
    multishapelet_psf_chisq float DEFAULT NULL,
    multishapelet_psf_integral float DEFAULT NULL,
    multishapelet_psf_flags bit(1) NOT NULL,
        -- <descr>The multishapelet PSF fit is unreliable.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_psf_flags_maxiter bit(1) NOT NULL,
        -- <descr>Set if the optimizer ran into the maximum number of iterations limit for the multishapelet PSF fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_psf_flags_tinystep bit(1) NOT NULL,
        -- <descr>Set if the optimizer step or trust region got so small no progress could be made for the multishapelet PSF fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_psf_flags_constraint_r bit(1) NOT NULL,
        -- <descr>Set if the best-fit ellipticity was the minimum allowed by the constraint (not a failure) for the multishapelet PSF fit.</descr>
        -- <ucd>meta.code</ucd>
    multishapelet_psf_flags_constraint_q bit(1) NOT NULL,
        -- <descr>Set if the best-fit ellipticity was the maximum allowed by the constraint for the multishapelet PSF fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_dev_flux double DEFAULT NULL,
        -- <descr>Uncalibrated flux from the multishapelet de Vaucouleur fit.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <units>adu</units>
    multishapelet_dev_flux_err double DEFAULT NULL,
        -- <descr>Uncertainty of multishapelet_dev_flux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
    multishapelet_dev_flux_flags bit(1) NOT NULL,
        -- <descr>Flux from the multishapelet de Vaucouleur fit is unreliable.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_dev_psffactor float DEFAULT NULL,
        -- <descr>PSF factor for the multishapelet de Vaucouleur fit is unreliable.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_dev_flags_psffactor bit(1) NOT NULL,
        -- <descr>PSF factor for the multishapelet de Vaucouleur fit is unreliable.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_dev_ellipse_Ixx double DEFAULT NULL,
        -- <descr>Ellipse xx moment for the multishapelet de Vaucouleur fit.</descr>
    multishapelet_dev_ellipse_Iyy double DEFAULT NULL,
        -- <descr>Ellipse yy moment for the multishapelet de Vaucouleur fit.</descr>
    multishapelet_dev_ellipse_Ixy double DEFAULT NULL,
        -- <descr>Ellipse xy moment for the multishapelet de Vaucouleur fit.</descr>
    multishapelet_dev_psffactor_ellipse_Ixx double DEFAULT NULL,
        -- <descr>Ellipse xx moment for the PSF factor for the multishapelet de Vaucouleur fit.</descr>
    multishapelet_dev_psffactor_ellipse_Iyy double DEFAULT NULL,
        -- <descr>Ellipse yy moment for the PSF factor for the multishapelet de Vaucouleur fit.</descr>
    multishapelet_dev_psffactor_ellipse_Ixy double DEFAULT NULL,
        -- <descr>Ellipse xy moment for the PSF factor for the multishapelet de Vaucouleur fit.</descr>
    multishapelet_dev_chisq float DEFAULT NULL,
        -- <descr>Reduced chi-square for the multishapelet de Vaucouleur fit.</descr>
    multishapelet_dev_flags_maxiter bit(1) NOT NULL,
        -- <descr>Set if the optimizer ran into the maximum number of iterations limit for the multishapelet de Vaucouleur fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_dev_flags_tinystep bit(1) NOT NULL,
        -- <descr>Set if the optimizer step or trust region got so small no progress could be made for the multishapelet de Vaucouleur fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_dev_flags_constraint_r bit(1) NOT NULL,
        -- <descr>Set if the best-fit ellipticity was the minimum allowed by the constraint (not a failure) for the multishapelet de Vaucouleur fit.</descr>
        -- <ucd>meta.code</ucd>
    multishapelet_dev_flags_constraint_q bit(1) NOT NULL,
        -- <descr>Set if the best-fit ellipticity was the maximum allowed by the constraint for the multishapelet de Vaucouleur fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_dev_flags_largearea bit(1) NOT NULL,
        -- <descr>Set if the best-fit half-light ellipse area is larger than the number of pixels used for the multishapelet de Vaucouleur fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_exp_flux double DEFAULT NULL,
        -- <descr>Uncalibrated flux from the multishapelet exponential fit.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <units>adu</units>
    multishapelet_exp_flux_err double DEFAULT NULL,
        -- <descr>Uncertainty of multishapelet_exp_flux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <units>adu</units>
    multishapelet_exp_flux_flags bit(1) NOT NULL,
        -- <descr>Flux from the multishapelet exponential fit is unreliable.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_exp_psffactor float DEFAULT NULL,
        -- <descr>PSF factor for the multishapelet exponential fit.</descr>
    multishapelet_exp_flags_psffactor bit(1) NOT NULL,
        -- <descr>PSF factor for the multishapelet combo fit is unreliable.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_exp_ellipse_Ixx double DEFAULT NULL,
        -- <descr>Ellipse xx moment for the multishapelet exponential fit.</descr>
    multishapelet_exp_ellipse_Iyy double DEFAULT NULL,
        -- <descr>Ellipse yy moment for the multishapelet exponential fit.</descr>
    multishapelet_exp_ellipse_Ixy double DEFAULT NULL,
        -- <descr>Ellipse xy moment for the multishapelet exponential fit.</descr>
    multishapelet_exp_psffactor_ellipse_Ixx double DEFAULT NULL,
        -- <descr>Ellipse xx moment for the PSF factor for the multishapelet exponential fit.</descr>
    multishapelet_exp_psffactor_ellipse_Iyy double DEFAULT NULL,
        -- <descr>Ellipse yy moment for the PSF factor for the multishapelet exponential fit.</descr>
    multishapelet_exp_psffactor_ellipse_Ixy double DEFAULT NULL,
        -- <descr>Ellipse xy moment for the PSF factor for the multishapelet exponential fit.</descr>
    multishapelet_exp_chisq float DEFAULT NULL,
        -- <descr>Reduced chi-square for the multishapelet exponential fit.</descr>
    multishapelet_exp_flags_maxiter bit(1) NOT NULL,
        -- <descr>Set if the optimizer ran into the maximum number of iterations limit for the multishapelet exponential fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_exp_flags_tinystep bit(1) NOT NULL,
        -- <descr>Set if the optimizer step or trust region got so small no progress could be made for the multishapelet exponential fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_exp_flags_constraint_r bit(1) NOT NULL,
        -- <descr>Set if the best-fit ellipticity was the minimum allowed by the constraint (not a failure) for the multishapelet exponential fit.</descr>
        -- <ucd>meta.code</ucd>
    multishapelet_exp_flags_constraint_q bit(1) NOT NULL,
        -- <descr>Set if the best-fit ellipticity was the maximum allowed by the constraint for the multishapelet exponential fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_exp_flags_largearea bit(1) NOT NULL,
        -- <descr>Set if the best-fit half-light ellipse area is larger than the number of pixels used for the multishapelet exponential fit.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_combo_flux double DEFAULT NULL,
        -- <descr>Uncalibrated flux from the multishapelet combo fit.</descr>
        -- <ucd>phot.count;stat.uncalib</ucd>
        -- <units>adu</units>
    multishapelet_combo_flux_err double DEFAULT NULL,
        -- <descr>Uncertainty of multishapelet_combo_flux.</descr>
        -- <ucd>stat.error;phot.count;stat.uncalib</ucd>
        -- <units>adu</units>
    multishapelet_combo_flux_flags bit(1) NOT NULL,
        -- <descr>Flux from the multishapelet combo fit is unreliable.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_combo_psffactor float DEFAULT NULL,
        -- <descr>PSF factor for the multishapelet combo fit.</descr>
    multishapelet_combo_flags_psffactor bit(1) NOT NULL,
        -- <descr>PSF factor for the multishapelet combo fit is unreliable.</descr>
        -- <ucd>meta.code.error</ucd>
    multishapelet_combo_components_1 float DEFAULT NULL,
        -- <descr>Component 1 coefficient for the multishapelet combo fit.</descr>
    multishapelet_combo_components_2 float DEFAULT NULL,
        -- <descr>Component 2 coefficient for the multishapelet combo fit.</descr>
    multishapelet_combo_chisq float DEFAULT NULL,
        -- <descr>Chi-square for the multishapelet combo fit.</descr>
    correctfluxes_apcorr float DEFAULT NULL,
        -- <descr>Aperture correction factor applied to fluxes.</descr>
        -- <ucd>arith.factor</ucd>
    correctfluxes_apcorr_flags bit(1) NOT NULL,
        -- <descr>Set if aperture correction is unreliable.</descr>
        -- <ucd>meta.code.error</ucd>
    classification_extendedness double DEFAULT NULL,
        -- <descr>Probability of being extended.</descr>
        -- <ucd>stat.probability</ucd>
    detect_is_patch_inner bit(1) NOT NULL,
        -- <descr>Detection is in the non-overlapping region of the patch.</descr>
        -- <ucd>meta.code</ucd>
    detect_is_tract_inner bit(1) NOT NULL,
        -- <descr>Detection is in the non-overlapping region of the tract.</descr>
        -- <ucd>meta.code</ucd>
    detect_is_primary bit(1) NOT NULL,
        -- <descr>Detection is the primary of a set of overlapping detections.</descr>
        -- <ucd>meta.code</ucd>
    coord_raVar float DEFAULT NULL,
        -- <descr>Variance of ra due to centroid uncertainty (xVar, xyCov, yVar).</descr>
        -- <ucd>stat.variance;pos.eq</ucd>
        -- <units>arcsec^2</units>
    coord_radeclCov float DEFAULT NULL,
        -- <descr>Covariance of ra, decl due to centroid uncertainty (xVar, xyCov, yVar).</descr>
        -- <ucd>stat.covariance;pos.eq</ucd>
        -- <units>arcsec^2</units>
    coord_declVar float DEFAULT NULL,
        -- <descr>Variance of decl due to centroid uncertainty (xVar, xyCov, yVar).</descr>
        -- <ucd>stat.variance;pos.eq.dec</ucd>
        -- <units>arcsec^2</units>
    coadd_id bigint(20) NOT NULL,
        -- <descr>ID of the coadd the source was detected and measured on (pointer to DeepCoadd).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    coadd_filter_id int(11) NOT NULL,
        -- <descr>ID of filter used for the coadd the source was detected and measured on (pointer to DeepCoadd).</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    PRIMARY KEY (id),
    KEY IDX_coord_htmId20 (coord_htmId20),
    KEY IDX_coord_decl (coord_decl),
    KEY IDX_parent (parent),
    KEY IDX_coadd_id (coadd_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE Science_Ccd_Exposure
(
    scienceCcdExposureId bigint(20) NOT NULL,
        -- <descr>Primary key (unique identifier).</descr>
        -- <ucd>meta.id;obs.image</ucd>
    run int(11) NOT NULL,
        -- <descr>Run number.</descr>
    camcol tinyint(4) NOT NULL,
        -- <descr>Camera column.</descr>
    filterId tinyint(4) NOT NULL,
        -- <descr>Id of the filter for the band.</descr>
        -- <ucd>meta.id;instr.filter</ucd>
    field int(11) NOT NULL,
        -- <descr>Field number.</descr>
    filterName char(3) NOT NULL,
        -- <descr>Filter name, pulled in from the Filter table.</descr>
        -- <ucd>instr.bandpass</ucd>
    ra double NOT NULL,
        -- <descr>ICRS R.A. of image center, corresponding to FITS pixel coordinates
        -- ((NAXIS1 + 1)/2, (NAXIS2 + 1)/2).</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    decl double NOT NULL,
        -- <descr>ICRS Dec. of image center, corresponding to FITS pixel coordinates
        -- ((NAXIS1 + 1)/2, (NAXIS2 + 1)/2).</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    htmId20 bigint(20) NOT NULL,
        -- <descr>Level 20 HTM ID of (ra, decl)</descr>
        -- <ucd>pos.HTM</ucd>
    equinox float NOT NULL,
        -- <descr>Equinox of coordinates</descr>
        -- <ucd>pos.equinox</ucd>
    raDeSys varchar(20) NOT NULL,
        -- <descr>Coordinate system for equinox</descr>
        -- <ucd>pos.frame</ucd>
    ctype1 varchar(20) NOT NULL,
        -- <descr>Coordinate type</descr>
        -- <ucd>pos.wcs.ctype</ucd>
    ctype2 varchar(20) NOT NULL,
        -- <descr>Coordinate type</descr>
        -- <ucd>pos.wcs.ctype</ucd>
    crpix1 float NOT NULL,
        -- <ucd>pos.wcs.ctype</ucd>
        -- <unit>pixel</unit>
    crpix2 float NOT NULL,
        -- <ucd>pos.wcs.ctype</ucd>
        -- <unit>pixel</unit>
    crval1 double NOT NULL,
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    crval2 double NOT NULL,
        -- <ucd>pos.wcs.crval</ucd>
        -- <unit>deg</unit>
    cd1_1 double NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd1_2 double NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_1 double NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    cd2_2 double NOT NULL,
        -- <ucd>pos.wcs.cdmatrix</ucd>
        -- <unit>deg/pixel</unit>
    corner1Ra double NOT NULL,
        -- <descr>ICRS RA of image corner 1, corresponding to FITS pixel coordinates
        -- (0.5, 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner1Decl double NOT NULL,
        -- <descr>ICRS Dec of image corner 1, corresponding to FITS pixel coordinates
        -- (0.5, 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    corner2Ra double NOT NULL,
        -- <descr>ICRS RA of image corner 2, corresponding to FITS pixel coordinates
        -- (0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner2Decl double NOT NULL,
        -- <descr>ICRS Dec of image corner 2, corresponding to FITS pixel coordinates
        -- (0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    corner3Ra double NOT NULL,
        -- <descr>ICRS RA of image corner 3, corresponding to FITS pixel coordinates
        -- (NAXIS1 + 0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner3Decl double NOT NULL,
        -- <descr>ICRS Dec of image corner 3, corresponding to FITS pixel coordinates
        -- (NAXIS1 + 0.5, NAXIS2 + 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    corner4Ra double NOT NULL,
        -- <descr>ICRS RA of image corner 4, corresponding to FITS pixel coordinates
        -- (NAXIS1 + 0.5, 0.5)</descr>
        -- <ucd>pos.eq.ra</ucd>
        -- <unit>deg</unit>
    corner4Decl double NOT NULL,
        -- <descr>ICRS Dec of image corner 4, corresponding to FITS pixel coordinates
        -- (NAXIS1 + 0.5, 0.5)</descr>
        -- <ucd>pos.eq.dec</ucd>
        -- <unit>deg</unit>
    poly binary(120) NOT NULL,
        -- <descr>Binary representation of the 4-corner polygon for the exposure.</descr>
    taiMjd double NOT NULL,
        -- <descr>Time (MJD, TAI) at the start of the exposure.</descr>
        -- <ucd>time.start</ucd>
        -- <unit>d</unit>
    obsStart timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
        -- <descr>Time (UTC, 1s precision) at the start of the exposure.</descr>
        -- <ucd>time.start</ucd>
    expMidpt varchar(30) NOT NULL,
        -- <descr>Time (ISO8601 format, UTC) at the mid-point of the combined exposure.</descr>
        -- <ucd>time.epoch</ucd>
    expTime float NOT NULL,
        -- <descr>Duration of exposure.</descr>
        -- <ucd>time.duration</ucd>
        -- <unit>s</unit>
    nCombine int(11) NOT NULL,
        -- <descr>Number of images co-added to create a deeper image.</descr>
    binX int(11) NOT NULL,
        -- <descr>Binning of the CCD in x.</descr>
        -- <ucd>meta.number</ucd>
        -- <unit>pixel</unit>
    binY int(11) NOT NULL,
        -- <descr>Binning of the CCD in y.</descr>
        -- <ucd>meta.number</ucd>
        -- <unit>pixel</unit>
    fluxMag0 float NOT NULL,
        -- <descr>Flux of a zero-magnitude object.</descr>
        -- <ucd>phot.flux.density</ucd>
    fluxMag0Sigma float NOT NULL,
        -- <descr>1-sigma error on fluxmag0.</descr>
        -- <ucd>stat.error;phot.flux.density</ucd>
    fwhm double NOT NULL,
        -- <descr>Full width at half maximum</descr>
        -- <ucd>instr.obsty.seeing</ucd>
        -- <unit>arcsec</unit>
    path varchar(255) NOT NULL,
        -- <descr>CCD FITS file path relative to the SFM pipeline output directory.</descr>
    PRIMARY KEY (scienceCcdExposureId),
    KEY IDX_htmId20 (htmId20),
    KEY FK_Science_Ccd_Exposure_filterId (filterId)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE Science_Ccd_Exposure_Metadata (
        -- <descr> Generic key-value pair metadata for Science_Ccd_Exposure.</descr>
    scienceCcdExposureId bigint(20) NOT NULL,
        -- <ucd>meta.id;obs.image</ucd>
    metadataKey varchar(255) NOT NULL,
    exposureType tinyint(4) NOT NULL,
        -- <descr> Type of exposure.
        -- 1: Science CCD
        -- 2: Difference Imaging CCD
        -- 3: Good-seeing coadd
        -- 4: Deep coadd
        -- 5: Chi-squared coadd
        -- 6: Keith coadd </descr>
    intValue int(11) DEFAULT NULL,
    doubleValue double DEFAULT NULL,
    stringValue varchar(255) DEFAULT NULL,
    PRIMARY KEY (scienceCcdExposureId,metadataKey),
    KEY IDX_metadataKey (metadataKey)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE Science_Ccd_Exposure_NoFile (
    scienceCcdExposureId bigint(20) NOT NULL,
    run int(11) NOT NULL,
    filterId tinyint(4) NOT NULL,
    camcol tinyint(4) NOT NULL,
    field int(11) NOT NULL,
    path varchar(255) NOT NULL,
    PRIMARY KEY (scienceCcdExposureId)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE Science_Ccd_Exposure_To_Htm10 (
    scienceCcdExposureId bigint(20) NOT NULL,
        -- <descr>Pointer to Science_Ccd_Exposure.</descr>
    htmId10 int(11) NOT NULL,
        -- <descr>ID for Level 10 HTM triangle overlapping exposure. For each exposure in DeepCoadd, there will be one row for every overlapping triangle.</descr>
        -- <ucd>pos.HTM</ucd>
    KEY IDX_htmId10 (htmId10),
    KEY IDX_scienceCcdExposureId (scienceCcdExposureId)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- MySQL dump 10.14  Distrib 5.5.47-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: gapon_SDRP_Stripe82
-- ------------------------------------------------------
-- Server version	5.5.47-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Final view structure for view DeepSource
--

/*!50001 DROP TABLE IF EXISTS DeepSource*/;
/*!50001 DROP VIEW IF EXISTS DeepSource*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=gapon@% SQL SECURITY DEFINER */
/*!50001 VIEW DeepSource AS select gapon_SDRP_Stripe82.RunDeepSource.id AS deepSourceId,gapon_SDRP_Stripe82.RunDeepSource.parent AS parentDeepSourceId,gapon_SDRP_Stripe82.RunDeepSource.coadd_id AS deepCoaddId,gapon_SDRP_Stripe82.RunDeepSource.coadd_filter_id AS filterId,gapon_SDRP_Stripe82.RunDeepSource.coord_ra AS ra,gapon_SDRP_Stripe82.RunDeepSource.coord_decl AS decl,gapon_SDRP_Stripe82.RunDeepSource.coord_raVar AS raVar,gapon_SDRP_Stripe82.RunDeepSource.coord_declVar AS declVar,gapon_SDRP_Stripe82.RunDeepSource.coord_radeclCov AS radeclCov,gapon_SDRP_Stripe82.RunDeepSource.coord_htmId20 AS htmId20,gapon_SDRP_Stripe82.RunDeepSource.centroid_sdss_x AS x,gapon_SDRP_Stripe82.RunDeepSource.centroid_sdss_y AS y,gapon_SDRP_Stripe82.RunDeepSource.centroid_sdss_xVar AS xVar,gapon_SDRP_Stripe82.RunDeepSource.centroid_sdss_yVar AS yVar,gapon_SDRP_Stripe82.RunDeepSource.centroid_sdss_xyCov AS xyCov,gapon_SDRP_Stripe82.RunDeepSource.flux_psf AS psfFlux,gapon_SDRP_Stripe82.RunDeepSource.flux_psf_err AS psfFluxSigma,gapon_SDRP_Stripe82.RunDeepSource.flux_sinc AS apFlux,gapon_SDRP_Stripe82.RunDeepSource.flux_sinc_err AS apFluxSigma,gapon_SDRP_Stripe82.RunDeepSource.multishapelet_combo_flux AS modelFlux,gapon_SDRP_Stripe82.RunDeepSource.multishapelet_combo_flux_err AS modelFluxSigma,gapon_SDRP_Stripe82.RunDeepSource.flux_gaussian AS instFlux,gapon_SDRP_Stripe82.RunDeepSource.flux_gaussian_err AS instFluxSigma,NULL AS apCorrection,NULL AS apCorrectionSigma,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_centroid_x AS shapeIx,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_centroid_y AS shapeIy,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_centroid_xVar AS shapeIxVar,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_centroid_yVar AS shapeIyVar,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_centroid_xyCov AS shapeIxIyCov,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_Ixx AS shapeIxx,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_Iyy AS shapeIyy,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_Ixy AS shapeIxy,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_IxxVar AS shapeIxxVar,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_IyyVar AS shapeIyyVar,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_IxyVar AS shapeIxyVar,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_IxxIyyCov AS shapeIxxIyyCov,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_IxxIxyCov AS shapeIxxIxyCov,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_IxxIxyCov AS shapeIyyIxyCov,gapon_SDRP_Stripe82.RunDeepSource.classification_extendedness AS extendedness,gapon_SDRP_Stripe82.RunDeepSource.flags_negative AS flagNegative,gapon_SDRP_Stripe82.RunDeepSource.flags_badcentroid AS flagBadMeasCentroid,gapon_SDRP_Stripe82.RunDeepSource.flags_pixel_edge AS flagPixEdge,gapon_SDRP_Stripe82.RunDeepSource.flags_pixel_interpolated_any AS flagPixInterpAny,gapon_SDRP_Stripe82.RunDeepSource.flags_pixel_interpolated_center AS flagPixInterpCen,gapon_SDRP_Stripe82.RunDeepSource.flags_pixel_saturated_any AS flagPixSaturAny,gapon_SDRP_Stripe82.RunDeepSource.flags_pixel_saturated_center AS flagPixSaturCen,gapon_SDRP_Stripe82.RunDeepSource.flux_psf_flags AS flagBadPsfFlux,gapon_SDRP_Stripe82.RunDeepSource.flux_sinc_flags AS flagBadApFlux,gapon_SDRP_Stripe82.RunDeepSource.multishapelet_combo_flux_flags AS flagBadModelFlux,gapon_SDRP_Stripe82.RunDeepSource.flux_gaussian_flags AS flagBadInstFlux,gapon_SDRP_Stripe82.RunDeepSource.centroid_sdss_flags AS flagBadCentroid,gapon_SDRP_Stripe82.RunDeepSource.shape_sdss_flags AS flagBadShape from RunDeepSource */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-19 23:37:44


CREATE TABLE ZZZ_Db_Description (
    f varchar(255) DEFAULT NULL,
    r varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


