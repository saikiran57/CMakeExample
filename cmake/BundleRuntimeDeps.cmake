include(GNUInstallDirs)

if(WIN32)
  set(_bundle_dir ${CMAKE_INSTALL_PREFIX}/bin)
else()
  set(_bundle_dir ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR})
endif()

file(
  GET_RUNTIME_DEPENDENCIES
  EXECUTABLES
  $<TARGET_FILE:my_app>
  RESOLVED_DEPENDENCIES_VAR
  deps
  UNRESOLVED_DEPENDENCIES_VAR
  missing)

foreach(dep IN LISTS deps)
  file(
    INSTALL
    DESTINATION ${_bundle_dir}
    TYPE SHARED_LIBRARY FOLLOW_SYMLINK_CHAIN FILES ${dep})
endforeach()

if(missing)
  message(WARNING "Unresolved runtime deps: ${missing}")
endif()
