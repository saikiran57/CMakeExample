# -------------------------------------------------
# Sub projects
# -------------------------------------------------
add_subdirectory(core)
add_subdirectory(utils)

if(ENABLE_APP)
  add_subdirectory(app)
endif()
