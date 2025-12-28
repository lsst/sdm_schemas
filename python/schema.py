# ***** GENERATED FILE, DO NOT EDIT BY HAND *****
# ruff: noqa: W505
# generated with /Users/mjuric/miniforge3/envs/ddpp-dev/bin/ssp-generate-dtypes ppdb.yaml DiaSource SSObject SSSource mpc_orbits current_identifications numbered_identifications NearbySSO # noqa: E501

import numpy as np

# DiaSource: Table to store 'difference image sources'; - sources detected at SNR >=5 on difference images.
DiaSourceDtype = np.dtype([
    ('diaSourceId', '<i8'),         # Unique identifier of this DiaSource.
    ('visit', '<i8'),               # Id of the visit where this diaSource was measured.
    ('detector', '<i2'),            # Id of the detector where this diaSource was measured. Datatype short
                                    # instead of byte because of DB concerns about unsigned bytes.
    ('diaObjectId', '<i8'),         # Id of the diaObject this source was associated with, if any. If not, it
                                    # is set to NULL (each diaSource will be associated with either a...
    ('parentDiaSourceId', '<i8'),   # Id of the parent diaSource this diaSource has been deblended from, if
                                    # any.
    ('ssObjectReassocTimeMjdTai', '<f8'), # Time when this diaSource was reassociated from diaObject to
                                          # ssObject, expressed as Modified Julian Date, International Ato...
    ('midpointMjdTai', '<f8'),      # Effective mid-visit time for this diaSource, expressed as Modified
                                    # Julian Date, International Atomic Time.
    ('ra', '<f8'),                  # Right ascension coordinate of the center of this diaSource.
    ('raErr', '<f4'),               # Uncertainty of ra.
    ('dec', '<f8'),                 # Declination coordinate of the center of this diaSource.
    ('decErr', '<f4'),              # Uncertainty of dec.
    ('ra_dec_Cov', '<f4'),          # Covariance between ra and dec.
    ('x', '<f4'),                   # x position computed by a centroiding algorithm.
    ('xErr', '<f4'),                # Uncertainty of x.
    ('y', '<f4'),                   # y position computed by a centroiding algorithm.
    ('yErr', '<f4'),                # Uncertainty of y.
    ('centroid_flag', '|b1'),       # General centroid algorithm failure flag; set if anything went wrong
                                    # when fitting the centroid. Another centroid flag field should also b...
    ('apFlux', '<f4'),              # Flux in a 12 pixel radius aperture on the difference image.
    ('apFluxErr', '<f4'),           # Estimated uncertainty of apFlux.
    ('apFlux_flag', '|b1'),         # General aperture flux algorithm failure flag; set if anything went
                                    # wrong when measuring aperture fluxes. Another apFlux flag field shou...
    ('apFlux_flag_apertureTruncated', '|b1'), # Aperture did not fit within measurement image.
    ('isNegative', '|b1'),          # Source was detected as significantly negative.
    ('snr', '<f4'),                 # The signal-to-noise ratio at which this source was detected in the
                                    # difference image.
    ('psfFlux', '<f4'),             # Flux for Point Source model. Note this actually measures the flux
                                    # difference between the template and the visit image.
    ('psfFluxErr', '<f4'),          # Uncertainty of psfFlux.
    ('psfLnL', '<f4'),              # Natural log likelihood of the observed data given the point source
                                    # model.
    ('psfChi2', '<f4'),             # Chi^2 statistic of the point source model fit.
    ('psfNdata', '<i4'),            # The number of data points (pixels) used to fit the point source model.
    ('psfFlux_flag', '|b1'),        # Failure to derive linear least-squares fit of psf model. Another
                                    # psfFlux flag field should also be set to provide more information.
    ('psfFlux_flag_edge', '|b1'),   # Object was too close to the edge of the image to use the full PSF
                                    # model.
    ('psfFlux_flag_noGoodPixels', '|b1'), # Not enough non-rejected pixels in data to attempt the fit.
    ('trailFlux', '<f4'),           # Flux for a trailed source model. Note this actually measures the flux
                                    # difference between the template and the visit image.
    ('trailFluxErr', '<f4'),        # Uncertainty of trailFlux.
    ('trailRa', '<f8'),             # Right ascension coordinate of centroid for trailed source model.
    ('trailRaErr', '<f4'),          # Uncertainty of trailRa.
    ('trailDec', '<f8'),            # Declination coordinate of centroid for trailed source model.
    ('trailDecErr', '<f4'),         # Uncertainty of trailDec.
    ('trailLength', '<f4'),         # Maximum likelihood fit of trail length.
    ('trailLengthErr', '<f4'),      # Uncertainty of trailLength.
    ('trailAngle', '<f4'),          # Maximum likelihood fit of the angle between the meridian through the
                                    # centroid and the trail direction (bearing).
    ('trailAngleErr', '<f4'),       # Uncertainty of trailAngle.
    ('trailChi2', '<f4'),           # Chi^2 statistic of the trailed source model fit.
    ('trailNdata', '<i4'),          # The number of data points (pixels) used to fit the trailed source
                                    # model.
    ('trail_flag_edge', '|b1'),     # This flag is set if a trailed source extends onto or past edge pixels.
    ('dipoleMeanFlux', '<f4'),      # Maximum likelihood value for the mean absolute flux of the two lobes
                                    # for a dipole model.
    ('dipoleMeanFluxErr', '<f4'),   # Uncertainty of dipoleMeanFlux.
    ('dipoleFluxDiff', '<f4'),      # Maximum likelihood value for the difference of absolute fluxes of the
                                    # two lobes for a dipole model.
    ('dipoleFluxDiffErr', '<f4'),   # Uncertainty of dipoleFluxDiff.
    ('dipoleLength', '<f4'),        # Maximum likelihood value for the lobe separation in dipole model.
    ('dipoleAngle', '<f4'),         # Maximum likelihood fit of the angle between the meridian through the
                                    # centroid and the dipole direction (bearing, from negative to positiv...
    ('dipoleChi2', '<f4'),          # Chi^2 statistic of the model fit.
    ('dipoleNdata', '<i4'),         # The number of data points (pixels) used to fit the model.
    ('scienceFlux', '<f4'),         # Forced photometry flux for a point source model measured on the visit
                                    # image centered at DiaSource position.
    ('scienceFluxErr', '<f4'),      # Estimated uncertainty of scienceFlux.
    ('forced_PsfFlux_flag', '|b1'), # Forced PSF photometry on science image failed. Another forced_PsfFlux
                                    # flag field should also be set to provide more information.
    ('forced_PsfFlux_flag_edge', '|b1'), # Forced PSF flux on science image was too close to the edge of the
                                         # image to use the full PSF model.
    ('forced_PsfFlux_flag_noGoodPixels', '|b1'), # Forced PSF flux not enough non-rejected pixels in data to
                                                 # attempt the fit.
    ('templateFlux', '<f4'),        # Forced photometry flux for a point source model measured on the
                                    # template image centered at the DiaObject position.
    ('templateFluxErr', '<f4'),     # Uncertainty of templateFlux.
    ('ixx', '<f4'),                 # Adaptive second moment of the source intensity.
    ('iyy', '<f4'),                 # Adaptive second moment of the source intensity.
    ('ixy', '<f4'),                 # Adaptive second moment of the source intensity.
    ('ixxPSF', '<f4'),              # Adaptive second moment for the PSF.
    ('iyyPSF', '<f4'),              # Adaptive second moment for the PSF.
    ('ixyPSF', '<f4'),              # Adaptive second moment for the PSF.
    ('shape_flag', '|b1'),          # General source shape algorithm failure flag; set if anything went wrong
                                    # when measuring the shape. Another shape flag field should also be se...
    ('shape_flag_no_pixels', '|b1'), # No pixels to measure shape.
    ('shape_flag_not_contained', '|b1'), # Center not contained in footprint bounding box.
    ('shape_flag_parent_source', '|b1'), # This source is a parent source; we should only be measuring on
                                         # deblended children in difference imaging.
    ('extendedness', '<f4'),        # A measure of extendedness, computed by comparing an object's
                                    # moment-based traced radius to the PSF moments. extendedness = 1 impl...
    ('reliability', '<f4'),         # Probability (0-1) that the diaSource is astrophysical, derived from a
                                    # machine learning model.
    ('band', '<U1'),                # Filter band this source was observed with.
    ('isDipole', '|b1'),            # Source well fit by a dipole.
    ('dipoleFitAttempted', '|b1'),  # Attempted to fit a dipole model to this source.
    ('timeProcessedMjdTai', '<f8'), # Time when the image was processed and this DiaSource record was
                                    # generated, expressed as Modified Julian Date, International Atomic...
    ('timeWithdrawnMjdTai', '<f8'), # Time when this record was marked invalid, expressed as Modified Julian
                                    # Date, International Atomic Time.
    ('bboxSize', '<i4'),            # Size of the square bounding box that fully contains the detection
                                    # footprint.
    ('pixelFlags', '|b1'),          # General pixel flags failure; set if anything went wrong when setting
                                    # pixels flags from this footprint's mask. This implies that some...
    ('pixelFlags_bad', '|b1'),      # Bad pixel in the DiaSource footprint.
    ('pixelFlags_cr', '|b1'),       # Cosmic ray in the DiaSource footprint.
    ('pixelFlags_crCenter', '|b1'), # Cosmic ray in the 3x3 region around the centroid.
    ('pixelFlags_edge', '|b1'),     # Some of the source footprint is outside usable exposure region (masked
                                    # EDGE or centroid off image).
    ('pixelFlags_nodata', '|b1'),   # NO_DATA pixel in the source footprint.
    ('pixelFlags_nodataCenter', '|b1'), # NO_DATA pixel in the 3x3 region around the centroid.
    ('pixelFlags_interpolated', '|b1'), # Interpolated pixel in the DiaSource footprint.
    ('pixelFlags_interpolatedCenter', '|b1'), # Interpolated pixel in the 3x3 region around the centroid.
    ('pixelFlags_offimage', '|b1'), # DiaSource center is off image.
    ('pixelFlags_saturated', '|b1'), # Saturated pixel in the DiaSource footprint.
    ('pixelFlags_saturatedCenter', '|b1'), # Saturated pixel in the 3x3 region around the centroid.
    ('pixelFlags_suspect', '|b1'),  # DiaSource's footprint includes suspect pixels.
    ('pixelFlags_suspectCenter', '|b1'), # Suspect pixel in the 3x3 region around the centroid.
    ('pixelFlags_streak', '|b1'),   # Streak in the DiaSource footprint.
    ('pixelFlags_streakCenter', '|b1'), # Streak in the 3x3 region around the centroid.
    ('pixelFlags_injected', '|b1'), # Injection in the DiaSource footprint.
    ('pixelFlags_injectedCenter', '|b1'), # Injection in the 3x3 region around the centroid.
    ('pixelFlags_injected_template', '|b1'), # Template injection in the DiaSource footprint.
    ('pixelFlags_injected_templateCenter', '|b1'), # Template injection in the 3x3 region around the
                                                   # centroid.
    ('glint_trail', '|b1'),         # This flag is set if the source is part of a glint trail.
])

# SSObject: LSST-computed per-object quantities.
SSObjectDtype = np.dtype([
    ('ssObjectId', '<i8'),          # Unique identifier.
    ('designation', '<U16'),        # The unpacked primary provisional designation for this object.
    ('nObs', '<i4'),                # Total number of LSST observations of this object.
    ('arc', '<f4'),                 # [d] Timespan ("arc") of all LSST observations, t_{last} - t_{first}
    ('firstObservationMjdTai', '<f8'), # [d] The time of the first LSST observation of this object (could be
                                       # precovered), TAI.
    ('MOIDEarth', '<f4'),           # [AU] Minimum orbit intersection distance to Earth.
    ('MOIDEarthDeltaV', '<f4'),     # [km/s] DeltaV at the MOID point.
    ('MOIDEarthEclipticLongitude', '<f4'), # [deg] Ecliptic longitude of the MOID point (Earth's orbit).
    ('MOIDEarthTrueAnomaly', '<f4'),       # [deg] True anomaly of the MOID point on Earth's orbit.
    ('MOIDEarthTrueAnomalyObject', '<f4'), # [deg] True anomaly of the MOID point on the object's orbit.
    ('tisserand_J', '<f4'),         # Tisserand parameter with respect to Jupiter (T_J).
    ('extendednessMax', '<f4'),     # Maximum `extendedness` value from the DiaSource.
    ('extendednessMedian', '<f4'),  # Median `extendedness` value from the DiaSource.
    ('extendednessMin', '<f4'),     # Minimum `extendedness` value from the DiaSource.
    ('u_nObs', '<i4'),              # Total number of data points (u band).
    ('u_H', '<f4'),                 # [mag] Best fit absolute magnitude (u band).
    ('u_HErr', '<f4'),              # [mag] Error in the estimate of H (u band).
    ('u_G12', '<f4'),               # Best fit G12 slope parameter (u band).
    ('u_G12Err', '<f4'),            # Error in the estimate of G12 (u band).
    ('u_H_u_G12_Cov', '<f4'),       # [mag**2] H–G12 covariance (u band).
    ('u_nObsUsed', '<i4'),          # The number of data points used to fit the phase curve (u band).
    ('u_Chi2', '<f4'),              # Chi^2 statistic of the phase curve fit (u band).
    ('u_phaseAngleMin', '<f4'),     # [deg] Minimum phase angle observed (u band).
    ('u_phaseAngleMax', '<f4'),     # [deg] Maximum phase angle observed (u band).
    ('u_slope_fit_failed', '|b1'),  # G12 fit failed in u band. G12 contains a fiducial value used to fit H.
    ('g_nObs', '<i4'),              # Total number of data points (g band).
    ('g_H', '<f4'),                 # [mag] Best fit absolute magnitude (g band).
    ('g_HErr', '<f4'),              # [mag] Error in the estimate of H (g band).
    ('g_G12', '<f4'),               # Best fit G12 slope parameter (g band).
    ('g_G12Err', '<f4'),            # Error in the estimate of G12 (g band).
    ('g_H_g_G12_Cov', '<f4'),       # [mag**2] H–G12 covariance (g band).
    ('g_nObsUsed', '<i4'),          # The number of data points used to fit the phase curve (g band).
    ('g_Chi2', '<f4'),              # Chi^2 statistic of the phase curve fit (g band).
    ('g_phaseAngleMin', '<f4'),     # [deg] Minimum phase angle observed (g band).
    ('g_phaseAngleMax', '<f4'),     # [deg] Maximum phase angle observed (g band).
    ('g_slope_fit_failed', '|b1'),  # G12 fit failed in g band. G12 contains a fiducial value used to fit H.
    ('r_nObs', '<i4'),              # Total number of data points (r band).
    ('r_H', '<f4'),                 # [mag] Best fit absolute magnitude (r band).
    ('r_HErr', '<f4'),              # [mag] Error in the estimate of H (r band).
    ('r_G12', '<f4'),               # Best fit G12 slope parameter (r band).
    ('r_G12Err', '<f4'),            # Error in the estimate of G12 (r band).
    ('r_H_r_G12_Cov', '<f4'),       # [mag**2] H–G12 covariance (r band).
    ('r_nObsUsed', '<i4'),          # The number of data points used to fit the phase curve (r band).
    ('r_Chi2', '<f4'),              # Chi^2 statistic of the phase curve fit (r band).
    ('r_phaseAngleMin', '<f4'),     # [deg] Minimum phase angle observed (r band).
    ('r_phaseAngleMax', '<f4'),     # [deg] Maximum phase angle observed (r band).
    ('r_slope_fit_failed', '|b1'),  # G12 fit failed in r band. G12 contains a fiducial value used to fit H.
    ('i_nObs', '<i4'),              # Total number of data points (i band).
    ('i_H', '<f4'),                 # [mag] Best fit absolute magnitude (i band).
    ('i_HErr', '<f4'),              # [mag] Error in the estimate of H (i band).
    ('i_G12', '<f4'),               # Best fit G12 slope parameter (i band).
    ('i_G12Err', '<f4'),            # Error in the estimate of G12 (i band).
    ('i_H_i_G12_Cov', '<f4'),       # [mag**2] H–G12 covariance (i band).
    ('i_nObsUsed', '<i4'),          # The number of data points used to fit the phase curve (i band).
    ('i_Chi2', '<f4'),              # Chi^2 statistic of the phase curve fit (i band).
    ('i_phaseAngleMin', '<f4'),     # [deg] Minimum phase angle observed (i band).
    ('i_phaseAngleMax', '<f4'),     # [deg] Maximum phase angle observed (i band).
    ('i_slope_fit_failed', '|b1'),  # G12 fit failed in i band. G12 contains a fiducial value used to fit H.
    ('z_nObs', '<i4'),              # Total number of data points (z band).
    ('z_H', '<f4'),                 # [mag] Best fit absolute magnitude (z band).
    ('z_HErr', '<f4'),              # [mag] Error in the estimate of H (z band).
    ('z_G12', '<f4'),               # Best fit G12 slope parameter (z band).
    ('z_G12Err', '<f4'),            # Error in the estimate of G12 (z band).
    ('z_H_z_G12_Cov', '<f4'),       # [mag**2] H–G12 covariance (z band).
    ('z_nObsUsed', '<i4'),          # The number of data points used to fit the phase curve (z band).
    ('z_Chi2', '<f4'),              # Chi^2 statistic of the phase curve fit (z band).
    ('z_phaseAngleMin', '<f4'),     # [deg] Minimum phase angle observed (z band).
    ('z_phaseAngleMax', '<f4'),     # [deg] Maximum phase angle observed (z band).
    ('z_slope_fit_failed', '|b1'),  # G12 fit failed in z band. G12 contains a fiducial value used to fit H.
    ('y_nObs', '<i4'),              # Total number of data points (y band).
    ('y_H', '<f4'),                 # [mag] Best fit absolute magnitude (y band).
    ('y_HErr', '<f4'),              # [mag] Error in the estimate of H (y band).
    ('y_G12', '<f4'),               # Best fit G12 slope parameter (y band).
    ('y_G12Err', '<f4'),            # Error in the estimate of G12 (y band).
    ('y_H_y_G12_Cov', '<f4'),       # [mag**2] H–G12 covariance (y band).
    ('y_nObsUsed', '<i4'),          # The number of data points used to fit the phase curve (y band).
    ('y_Chi2', '<f4'),              # Chi^2 statistic of the phase curve fit (y band).
    ('y_phaseAngleMin', '<f4'),     # [deg] Minimum phase angle observed (y band).
    ('y_phaseAngleMax', '<f4'),     # [deg] Maximum phase angle observed (y band).
    ('y_slope_fit_failed', '|b1'),  # G12 fit failed in y band. G12 contains a fiducial value used to fit H.
])

# SSSource: LSST-computed per-source quantities. 1::1 relationship with DiaSource.
SSSourceDtype = np.dtype([
    ('diaSourceId', '<i8'),         # Unique identifier of the observation (matching DiaSource.diaSourceId).
    ('ssObjectId', '<i8'),          # Unique LSST identifier of the Solar System object.
    ('designation', '<U16'),        # The unpacked primary provisional designation for this object.
    ('eclLambda', '<f8'),           # [deg] Ecliptic longitude, converted from the observed coordinates.
    ('eclBeta', '<f8'),             # [deg] Ecliptic latitude, converted from the observed coordinates.
    ('galLon', '<f8'),              # [deg] Galactic longitude, converted from the observed coordinates.
    ('galLat', '<f8'),              # [deg] Galactic latitude, converted from the observed coordinates.
    ('elongation', '<f4'),          # [deg] Solar elongation of the object at the time of observation.
    ('phaseAngle', '<f4'),          # [deg] Phase angle between the Sun, object, and observer.
    ('topoRange', '<f4'),           # [AU] Topocentric distance (delta) at light-emission time.
    ('topoRangeRate', '<f4'),       # [km/s] Topocentric radial (line-of-sight) velocity (deldot); positive
                                    # values indicate motion away from the observer.
    ('helioRange', '<f4'),          # [AU] Heliocentric distance (r) at light-emission time.
    ('helioRangeRate', '<f4'),      # [km/s] Heliocentric radial velocity (rdot); positive values indicate
                                    # motion away from the Sun.
    ('ephRa', '<f8'),               # [deg] Predicted ICRS right ascension from the orbit in mpc_orbits.
    ('ephDec', '<f8'),              # [deg] Predicted ICRS declination from the orbit in mpc_orbits.
    ('ephVmag', '<f4'),             # [mag] Predicted magnitude in V band, computed from mpc_orbits data
                                    # including the mpc_orbits-provided (H, G) estimates
    ('ephRate', '<f4'),             # [deg/d] Total predicted on-sky angular rate of motion.
    ('ephRateRa', '<f4'),           # [deg/d] Predicted on-sky angular rate in the R.A. direction (includes
                                    # the cos(dec) factor).
    ('ephRateDec', '<f4'),          # [deg/d] Predicted on-sky angular rate in the declination direction.
    ('ephOffset', '<f4'),           # [arcsec] Total observed versus predicted angular separation on the sky.
    ('ephOffsetRa', '<f8'),         # [arcsec] Offset between observed and predicted position in the R.A.
                                    # direction (includes cos(dec) term).
    ('ephOffsetDec', '<f8'),        # [arcsec] Offset between observed and predicted position in declination.
    ('ephOffsetAlongTrack', '<f4'), # [arcsec] Offset between observed and predicted position in the
                                    # along-track direction on the sky.
    ('ephOffsetCrossTrack', '<f4'), # [arcsec] Offset between observed and predicted position in the
                                    # cross-track direction on the sky.
    ('helio_x', '<f4'),             # [AU] Cartesian heliocentric X coordinate at light-emission time (ICRS).
    ('helio_y', '<f4'),             # [AU] Cartesian heliocentric Y coordinate at light-emission time (ICRS).
    ('helio_z', '<f4'),             # [AU] Cartesian heliocentric Z coordinate at light-emission time (ICRS).
    ('helio_vx', '<f4'),            # [km/s] Cartesian heliocentric X velocity at light-emission time (ICRS).
    ('helio_vy', '<f4'),            # [km/s] Cartesian heliocentric Y velocity at light-emission time (ICRS).
    ('helio_vz', '<f4'),            # [km/s] Cartesian heliocentric Z velocity at light-emission time (ICRS).
    ('helio_vtot', '<f4'),          # [km/s] The magnitude of the heliocentric velocity vector, sqrt(vx*vx +
                                    # vy*vy + vz*vz).
    ('topo_x', '<f4'),              # [AU] Cartesian topocentric X coordinate at light-emission time (ICRS).
    ('topo_y', '<f4'),              # [AU] Cartesian topocentric Y coordinate at light-emission time (ICRS).
    ('topo_z', '<f4'),              # [AU] Cartesian topocentric Z coordinate at light-emission time (ICRS).
    ('topo_vx', '<f4'),             # [km/s] Cartesian topocentric X velocity at light-emission time (ICRS).
    ('topo_vy', '<f4'),             # [km/s] Cartesian topocentric Y velocity at light-emission time (ICRS).
    ('topo_vz', '<f4'),             # [km/s] Cartesian topocentric Z velocity at light-emission time (ICRS).
    ('topo_vtot', '<f4'),           # [km/s] The magnitude of the topocentric velocity vector, sqrt(vx*vx +
                                    # vy*vy + vz*vz).
    ('diaDistanceRank', '<i2'),     # The rank of the diaSourceId-identified source in terms of its closeness
                                    # to the predicted SSO position. If diaSourceId is the nearest DiaSour...
    ('visit', '<i8'),               # Id of the visit where this diaSource was measured.
    ('detector', '<i2'),            # Id of the detector where this diaSource was measured. Datatype short
                                    # instead of byte because of DB concerns about unsigned bytes.
    ('parentDiaSourceId', '<i8'),   # Id of the parent diaSource this diaSource has been deblended from, if
                                    # any.
    ('midpointMjdTai', '<f8'),      # Effective mid-visit time for this diaSource, expressed as Modified
                                    # Julian Date, International Atomic Time.
    ('ra', '<f8'),                  # Right ascension coordinate of the center of this diaSource.
    ('raErr', '<f4'),               # Uncertainty of ra.
    ('dec', '<f8'),                 # Declination coordinate of the center of this diaSource.
    ('decErr', '<f4'),              # Uncertainty of dec.
    ('ra_dec_Cov', '<f4'),          # Covariance between ra and dec.
    ('x', '<f4'),                   # x position computed by a centroiding algorithm.
    ('xErr', '<f4'),                # Uncertainty of x.
    ('y', '<f4'),                   # y position computed by a centroiding algorithm.
    ('yErr', '<f4'),                # Uncertainty of y.
    ('centroid_flag', '|b1'),       # General centroid algorithm failure flag; set if anything went wrong
                                    # when fitting the centroid. Another centroid flag field should also b...
    ('apFlux', '<f4'),              # Flux in a 12 pixel radius aperture on the difference image.
    ('apFluxErr', '<f4'),           # Estimated uncertainty of apFlux.
    ('apFlux_flag', '|b1'),         # General aperture flux algorithm failure flag; set if anything went
                                    # wrong when measuring aperture fluxes. Another apFlux flag field shou...
    ('apFlux_flag_apertureTruncated', '|b1'), # Aperture did not fit within measurement image.
    ('isNegative', '|b1'),          # Source was detected as significantly negative.
    ('snr', '<f4'),                 # The signal-to-noise ratio at which this source was detected in the
                                    # difference image.
    ('psfFlux', '<f4'),             # Flux for Point Source model. Note this actually measures the flux
                                    # difference between the template and the visit image.
    ('psfFluxErr', '<f4'),          # Uncertainty of psfFlux.
    ('psfLnL', '<f4'),              # Natural log likelihood of the observed data given the point source
                                    # model.
    ('psfChi2', '<f4'),             # Chi^2 statistic of the point source model fit.
    ('psfNdata', '<i4'),            # The number of data points (pixels) used to fit the point source model.
    ('psfFlux_flag', '|b1'),        # Failure to derive linear least-squares fit of psf model. Another
                                    # psfFlux flag field should also be set to provide more information.
    ('psfFlux_flag_edge', '|b1'),   # Object was too close to the edge of the image to use the full PSF
                                    # model.
    ('psfFlux_flag_noGoodPixels', '|b1'), # Not enough non-rejected pixels in data to attempt the fit.
    ('trailFlux', '<f4'),           # Flux for a trailed source model. Note this actually measures the flux
                                    # difference between the template and the visit image.
    ('trailFluxErr', '<f4'),        # Uncertainty of trailFlux.
    ('trailRa', '<f8'),             # Right ascension coordinate of centroid for trailed source model.
    ('trailRaErr', '<f4'),          # Uncertainty of trailRa.
    ('trailDec', '<f8'),            # Declination coordinate of centroid for trailed source model.
    ('trailDecErr', '<f4'),         # Uncertainty of trailDec.
    ('trailLength', '<f4'),         # Maximum likelihood fit of trail length.
    ('trailLengthErr', '<f4'),      # Uncertainty of trailLength.
    ('trailAngle', '<f4'),          # Maximum likelihood fit of the angle between the meridian through the
                                    # centroid and the trail direction (bearing).
    ('trailAngleErr', '<f4'),       # Uncertainty of trailAngle.
    ('trailChi2', '<f4'),           # Chi^2 statistic of the trailed source model fit.
    ('trailNdata', '<i4'),          # The number of data points (pixels) used to fit the trailed source
                                    # model.
    ('trail_flag_edge', '|b1'),     # This flag is set if a trailed source extends onto or past edge pixels.
    ('dipoleMeanFlux', '<f4'),      # Maximum likelihood value for the mean absolute flux of the two lobes
                                    # for a dipole model.
    ('dipoleMeanFluxErr', '<f4'),   # Uncertainty of dipoleMeanFlux.
    ('dipoleFluxDiff', '<f4'),      # Maximum likelihood value for the difference of absolute fluxes of the
                                    # two lobes for a dipole model.
    ('dipoleFluxDiffErr', '<f4'),   # Uncertainty of dipoleFluxDiff.
    ('dipoleLength', '<f4'),        # Maximum likelihood value for the lobe separation in dipole model.
    ('dipoleAngle', '<f4'),         # Maximum likelihood fit of the angle between the meridian through the
                                    # centroid and the dipole direction (bearing, from negative to positiv...
    ('dipoleChi2', '<f4'),          # Chi^2 statistic of the model fit.
    ('dipoleNdata', '<i4'),         # The number of data points (pixels) used to fit the model.
    ('scienceFlux', '<f4'),         # Forced photometry flux for a point source model measured on the visit
                                    # image centered at DiaSource position.
    ('scienceFluxErr', '<f4'),      # Estimated uncertainty of scienceFlux.
    ('forced_PsfFlux_flag', '|b1'), # Forced PSF photometry on science image failed. Another forced_PsfFlux
                                    # flag field should also be set to provide more information.
    ('forced_PsfFlux_flag_edge', '|b1'), # Forced PSF flux on science image was too close to the edge of the
                                         # image to use the full PSF model.
    ('forced_PsfFlux_flag_noGoodPixels', '|b1'), # Forced PSF flux not enough non-rejected pixels in data to
                                                 # attempt the fit.
    ('templateFlux', '<f4'),        # Forced photometry flux for a point source model measured on the
                                    # template image centered at the DiaObject position.
    ('templateFluxErr', '<f4'),     # Uncertainty of templateFlux.
    ('ixx', '<f4'),                 # Adaptive second moment of the source intensity.
    ('iyy', '<f4'),                 # Adaptive second moment of the source intensity.
    ('ixy', '<f4'),                 # Adaptive second moment of the source intensity.
    ('ixxPSF', '<f4'),              # Adaptive second moment for the PSF.
    ('iyyPSF', '<f4'),              # Adaptive second moment for the PSF.
    ('ixyPSF', '<f4'),              # Adaptive second moment for the PSF.
    ('shape_flag', '|b1'),          # General source shape algorithm failure flag; set if anything went wrong
                                    # when measuring the shape. Another shape flag field should also be se...
    ('shape_flag_no_pixels', '|b1'), # No pixels to measure shape.
    ('shape_flag_not_contained', '|b1'), # Center not contained in footprint bounding box.
    ('shape_flag_parent_source', '|b1'), # This source is a parent source; we should only be measuring on
                                         # deblended children in difference imaging.
    ('extendedness', '<f4'),        # A measure of extendedness, computed by comparing an object''s
                                    # moment-based traced radius to the PSF moments. extendedness = 1 impl...
    ('reliability', '<f4'),         # Probability (0-1) that the diaSource is astrophysical, derived from a
                                    # machine learning model.
    ('band', '<U1'),                # Filter band this source was observed with.
    ('isDipole', '|b1'),            # Source well fit by a dipole.
    ('dipoleFitAttempted', '|b1'),  # Attempted to fit a dipole model to this source.
    ('timeProcessedMjdTai', '<f8'), # Time when the image was processed and this DiaSource record was
                                    # generated, expressed as Modified Julian Date, International Atomic...
    ('bboxSize', '<i4'),            # Size of the square bounding box that fully contains the detection
                                    # footprint.
    ('pixelFlags', '|b1'),          # General pixel flags failure; set if anything went wrong when setting
                                    # pixels flags from this footprint's mask. This implies that some...
    ('pixelFlags_bad', '|b1'),      # Bad pixel in the DiaSource footprint.
    ('pixelFlags_cr', '|b1'),       # Cosmic ray in the DiaSource footprint.
    ('pixelFlags_crCenter', '|b1'), # Cosmic ray in the 3x3 region around the centroid.
    ('pixelFlags_edge', '|b1'),     # Some of the source footprint is outside usable exposure region (masked
                                    # EDGE or centroid off image).
    ('pixelFlags_nodata', '|b1'),   # NO_DATA pixel in the source footprint.
    ('pixelFlags_nodataCenter', '|b1'), # NO_DATA pixel in the 3x3 region around the centroid.
    ('pixelFlags_interpolated', '|b1'), # Interpolated pixel in the DiaSource footprint.
    ('pixelFlags_interpolatedCenter', '|b1'), # Interpolated pixel in the 3x3 region around the centroid.
    ('pixelFlags_offimage', '|b1'), # DiaSource center is off image.
    ('pixelFlags_saturated', '|b1'), # Saturated pixel in the DiaSource footprint.
    ('pixelFlags_saturatedCenter', '|b1'), # Saturated pixel in the 3x3 region around the centroid.
    ('pixelFlags_suspect', '|b1'),  # DiaSource's footprint includes suspect pixels.
    ('pixelFlags_suspectCenter', '|b1'), # Suspect pixel in the 3x3 region around the centroid.
    ('pixelFlags_streak', '|b1'),   # Streak in the DiaSource footprint.
    ('pixelFlags_streakCenter', '|b1'), # Streak in the 3x3 region around the centroid.
    ('pixelFlags_injected', '|b1'), # Injection in the DiaSource footprint.
    ('pixelFlags_injectedCenter', '|b1'), # Injection in the 3x3 region around the centroid.
    ('pixelFlags_injected_template', '|b1'), # Template injection in the DiaSource footprint.
    ('pixelFlags_injected_templateCenter', '|b1'), # Template injection in the 3x3 region around the
                                                   # centroid.
    ('glint_trail', '|b1'),         # This flag is set if the source is part of a glint trail.
])

# mpc_orbits: Table of orbital elements and related information of known (sun-orbiting and unbound) Solar
# System objects. Replicated from the Minor Planet Center (Postgres) database. This schema will generally
# closely follow the schema of the upstream table, to allow end-users to rerun queries developed elsewhere on
# the RSP.
mpc_orbitsDtype = np.dtype([
    ('id', '<i4'),                  # Internal ID (generally not seen/used by the user)
    ('designation', '<U16'),        # The primary provisional designation in unpacked form (e.g. 2008 AB).
    ('packed_primary_provisional_designation', '<U16'), # The primary provisional designation in packed form
                                                        # (e.g. K08A00B)
    ('unpacked_primary_provisional_designation', '<U16'), # The primary provisional designation in unpacked
                                                          # form (e.g. 2008 AB)
    ('mpc_orb_jsonb', '|O'),        # Details of the orbit solution in JSON form
    ('created_at', '<M8[ns]'),      # When this row was created
    ('updated_at', '<M8[ns]'),      # When this row was updated
    ('orbit_type_int', '<i4'),      # Orbit Type (Integer)
    ('u_param', '<i4'),             # U parameter
    ('nopp', '<i4'),                # number of oppositions
    ('arc_length_total', '<f8'),    # [d] Arc length over total observations [days]
    ('arc_length_sel', '<f8'),      # [d] Arc length over total observations *selected* [days]
    ('nobs_total', '<i4'),          # Total number of all observations (optical + radar) available
    ('nobs_total_sel', '<i4'),      # Total number of all observations (optical + radar) selected for use in
                                    # orbit fitting
    ('a', '<f8'),                   # [AU] Semi Major Axis [au]
    ('q', '<f8'),                   # [AU] Pericenter Distance [au]
    ('e', '<f8'),                   # Eccentricity
    ('i', '<f8'),                   # [deg] Inclination [degrees]
    ('node', '<f8'),                # [deg] Longitude of Ascending Node [degrees]
    ('argperi', '<f8'),             # [deg] Argument of Pericenter [degrees]
    ('peri_time', '<f8'),           # [d] Time from Pericenter Passage [days]
    ('yarkovsky', '<f8'),           # [1e-10.au.d-2] Yarkovsky Component [10^(-10)*au/day^2]
    ('srp', '<f8'),                 # [m2.t-1] Solar-Radiation Pressure Component [m^2/ton]
    ('a1', '<f8'),                  # [m2.t-1] A1 non-grav components [m^2/ton]
    ('a2', '<f8'),                  # [m2.t-1] A2 non-grav components [m^2/ton]
    ('a3', '<f8'),                  # [m2.t-1] A3 non-grav components [m^2/ton]
    ('dt', '<f8'),                  # DT non-grav component
    ('mean_anomaly', '<f8'),        # [deg] Mean Anomaly [degrees]
    ('period', '<f8'),              # [d] Orbital Period [days]
    ('mean_motion', '<f8'),         # [deg.d-1] Orbital Mean Motion [degrees per day]
    ('a_unc', '<f8'),               # [AU] Uncertainty on Semi Major Axis [au]
    ('q_unc', '<f8'),               # [AU] Uncertainty on Pericenter Distance [au]
    ('e_unc', '<f8'),               # Uncertainty on Eccentricity
    ('i_unc', '<f8'),               # [deg] Uncertainty on Inclination [degrees]
    ('node_unc', '<f8'),            # [deg] Uncertainty on Longitude of Ascending Node [degrees]
    ('argperi_unc', '<f8'),         # [deg] Uncertainty on Argument of Pericenter [degrees]
    ('peri_time_unc', '<f8'),       # [d] Uncertainty on Time from Pericenter Passage [days]
    ('yarkovsky_unc', '<f8'),       # [1e-10.au.d-2] Uncertainty on Yarkovsky Component [10^(-10)*au/day^2]
    ('srp_unc', '<f8'),             # [m2.t-1] Uncertainty on Solar-Radiation Pressure Component [m^2/ton]
    ('a1_unc', '<f8'),              # [m2.t-1] Uncertainty on A1 non-grav components [m^2/ton]
    ('a2_unc', '<f8'),              # [m2.t-1] Uncertainty on A2 non-grav components [m^2/ton]
    ('a3_unc', '<f8'),              # [m2.t-1] Uncertainty on A3 non-grav components [m^2/ton]
    ('dt_unc', '<f8'),              # Uncertainty on DT non-grav component
    ('mean_anomaly_unc', '<f8'),    # [deg] Uncertainty on Mean Anomaly [degrees]
    ('period_unc', '<f8'),          # [d] Uncertainty on Orbital Period [days]
    ('mean_motion_unc', '<f8'),     # [deg.d-1] Uncertainty on Orbital Mean Motion [degrees per day]
    ('epoch_mjd', '<f8'),           # [d] Epoch of the Orbfit-Solution in MJD
    ('h', '<f8'),                   # [mag] H-Magnitude
    ('g', '<f8'),                   # G-Slope Parameter
    ('not_normalized_rms', '<f8'),  # [arcsec] unnormalized rms of the fit [arcsec]
    ('normalized_rms', '<f8'),      # rms of the fit [unitless]
    ('earth_moid', '<f8'),          # [AU] Minimum Orbit Intersection Distance [au] with respect to the
                                    # Earths Orbit
    ('fitting_datetime', '<M8[ns]'), # Date of the last orbit fit
])

# current_identifications: All single-designations, and all identifications between designations. Always uses
# primary provisional designation (even for numbered objects). Includes all comets and satellites. Replicated
# from the Minor Planet Center (Postgres) database. This schema will generally closely follow the schema of
# the upstream table, to allow end-users to rerun queries developed elsewhere on the RSP.
current_identificationsDtype = np.dtype([
    ('id', '<i4'),                  # Internal ID (generally not seen/used by the user)
    ('packed_primary_provisional_designation', '<U16'), # The primary provisional designation in packed form
                                                        # (e.g. K08A00B)
    ('packed_secondary_provisional_designation', '<U16'), # The secondary provisional designation in packed
                                                          # form (e.g. K08A00B). May be the same-as (A=A)...
    ('unpacked_primary_provisional_designation', '<U16'), # The primary provisional designation in unpacked
                                                          # form (e.g. 2008 AB)
    ('unpacked_secondary_provisional_designation', '<U16'), # The secondary provisional designation in
                                                            # unpacked form (e.g. 2008 AB). May be the...
    ('published', '|b1'),           # Has this been published yet? i.e. has it been released to the public?
    ('identifier_ids', '|O'),       # This is a set of unique identifier_ids in an array that points to the
                                    # identification_metadata table.
    ('object_type', '<i4'),         # Integer to indicate the object type. To be linked (foreign key) to
                                    # object_type lookup table
    ('numbered', '|b1'),            # Has the object been numbered and hence does it appear in the
                                    # numbered_objects table?
    ('created_at', '<M8[ns]'),      # When this row was created
    ('updated_at', '<M8[ns]'),      # When this row was updated
])

# numbered_identifications: The numbered identification table contains all the numbered objects (minor
# planets, comets and natural satellites) with their primary provisional designations. The table is
# continously updated everytime a new object is numbered. Replicated from the Minor Planet Center (Postgres)
# database. This schema will generally closely follow the schema of the upstream table, to allow end-users to
# rerun queries developed elsewhere on the RSP.
numbered_identificationsDtype = np.dtype([
    ('id', '<i4'),                  # Internal ID (generally not seen/used by the user)
    ('packed_primary_provisional_designation', '<U16'), # The primary provisional designation in packed form
                                                        # (e.g. K08A00B)
    ('unpacked_primary_provisional_designation', '<U16'), # The primary provisional designation in unpacked
                                                          # form (e.g. 2008 AB)
    ('permid', '<U16'),             # Permanent designation (number)
    ('iau_designation', '|O'),      # IAU-approved designation (not filled at the moment)
    ('iau_name', '<U32'),           # IAU-approved name (not filled at the moment)
    ('numbered_publication_references', '|O'), # MPEC where this object was numbered
    ('named_publication_references', '|O'),    # MPEC where this object was named
    ('naming_credit', '|O'),        # Credit for suggesting the name
    ('created_at', '<M8[ns]'),      # When this row was created
    ('updated_at', '<M8[ns]'),      # When this row was updated
])

# NearbySSO: Indices to solar system objects closest to DiaSources, within some matching radius.
NearbySSODtype = np.dtype([
    ('diaSourceId', '<i8'),         # Unique identifier of the DiaSource.
    ('ssObjectId', '<i8'),          # Id of the ssObject found within a matching radius of this source, if
                                    # any.
    ('designation', '<U16'),        # The primary provisional designation in unpacked form (e.g. 2008 AB).
    ('ephRa', '<f8'),               # [deg] Predicted ICRS right ascension from the orbit in mpc_orbits.
    ('ephDec', '<f8'),              # [deg] Predicted ICRS declination from the orbit in mpc_orbits.
    ('ephOffset', '<f4'),           # [arcsec] Total observed versus predicted angular separation on the sky.
    ('ephVmag', '<f4'),             # [mag] Predicted magnitude in V band, computed from mpc_orbits data
                                    # including the mpc_orbits-provided (H, G) estimates
    ('ephRateRa', '<f4'),           # [deg/d] Predicted on-sky angular rate in the R.A. direction (includes
                                    # the cos(dec) factor).
    ('ephRateDec', '<f4'),          # [deg/d] Predicted on-sky angular rate in the declination direction.
])
