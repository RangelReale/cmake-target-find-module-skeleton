#.rst:
# FindSkellib
# -------
#
# Finds the Skellib library
#
# This will define the following variables:
#
#   Skellib_FOUND    - True if the system has the Skellib library
#   Skellib_VERSION  - The version of the Skellib library which was found
#
# and the following imported targets:
#
#   Skellib::Skellib   - The Skellib library
#

# find the include path
find_path(Skellib_INCLUDE_DIR
  NAMES skelbase.h
  PATH_SUFFIXES Skellib
)

include(FindPackageHandleStandardArgs)

# determine if should search separate debug and release libraries
set(Skellib_DEBUG_AND_RELEASE OFF)
if (WIN32)
	set(Skellib_DEBUG_AND_RELEASE ON)
endif()

if (Skellib_DEBUG_AND_RELEASE)
	# find release library
	find_library(Skellib_LIBRARY_RELEASE
	  NAMES skellib
	)

	# find debug library
	find_library(Skellib_LIBRARY_DEBUG
	  NAMES skellib
	)

	# only release is required
	find_package_handle_standard_args(Skellib
	  FOUND_VAR Skellib_FOUND
	  REQUIRED_VARS
		Skellib_LIBRARY_RELEASE
		Skellib_INCLUDE_DIR
	)

else()
	# find library
	find_library(Skellib_LIBRARY
	  NAMES skellib
	)

	find_package_handle_standard_args(Skellib
	  FOUND_VAR Skellib_FOUND
	  REQUIRED_VARS
		Skellib_LIBRARY
		Skellib_INCLUDE_DIR
	)
endif()

if(Skellib_FOUND AND NOT TARGET Skellib::Skellib)
  add_library(Skellib::Skellib UNKNOWN IMPORTED)
  set_target_properties(Skellib::Skellib PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${Skellib_INCLUDE_DIR}"
#    INTERFACE_COMPILE_OPTIONS "${Skellib_CFLAGS_OTHER}"
  )

  if (Skellib_DEBUG_AND_RELEASE)
	# release (must be first, so it is the default)
    set_property(TARGET Skellib::Skellib APPEND PROPERTY
      IMPORTED_CONFIGURATIONS RELEASE
    )
    set_target_properties(Skellib::Skellib PROPERTIES
      IMPORTED_LOCATION_RELEASE "${Skellib_LIBRARY_RELEASE}"
    )

	# debug (optional)
	if (Skellib_LIBRARY_DEBUG)
		set_property(TARGET Skellib::Skellib APPEND PROPERTY
		  IMPORTED_CONFIGURATIONS DEBUG
		)
		set_target_properties(Skellib::Skellib PROPERTIES
		  IMPORTED_LOCATION_DEBUG "${Skellib_LIBRARY_DEBUG}"
		)
	endif()

  else()
	# only release
	set_target_properties(Skellib::Skellib PROPERTIES
		IMPORTED_LOCATION "${Skellib_LIBRARY}"
    )	
  endif()
endif()

mark_as_advanced(
  Skellib_INCLUDE_DIR
  Skellib_LIBRARY
  Skellib_LIBRARY_RELEASE
  Skellib_LIBRARY_DEBUG
)