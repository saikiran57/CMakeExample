# ============================================================
# ProjectSetup.cmake — Global project and target configuration
# ============================================================

include_guard(GLOBAL)

# ============================================================
# Global C++ settings
# ============================================================

# Standard, extensions, modules
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_SCAN_FOR_MODULES OFF)

# Output dirs
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# MSVC-specific debug info
if(MSVC)
  set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT Embedded)
endif()

# ============================================================
# Include common modules
# ============================================================
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(CompilerDefinitions)
include(CompilerWarnings)
include(CompilerRuntime)
include(FastBuild)
include(Sanitizers)
include(BuildInfo) # Existing module handles printing global build info

# Optional: print global build info
print_global_build_info_once()

# ============================================================
# Public API
# ============================================================

# Configure a target with compile defs, PCH, sanitizers, FastBuild
function(configure_target TARGET_NAME)
  if(NOT TARGET ${TARGET_NAME})
    message(
      FATAL_ERROR "configure_target: Target '${TARGET_NAME}' does not exist")
  endif()

  message(STATUS "-- Configuring target '${TARGET_NAME}'")

  # ----------------------------
  # Compile definitions
  # ----------------------------
  set_project_compile_definitions(${TARGET_NAME})

  # ----------------------------
  # FastBuild / PCH / unity
  # ----------------------------
  enable_fast_build(${TARGET_NAME})

  # ----------------------------
  # Sanitizers
  # ----------------------------
  enable_sanitizers(${TARGET_NAME})

  print_target_build_info(${TARGET_NAME})

  # # ---------------------------- # Print basic info safely #
  # ---------------------------- get_target_property(_type ${TARGET_NAME} TYPE)
  # get_target_property(_incs ${TARGET_NAME} INCLUDE_DIRECTORIES)
  # get_target_property(_defs ${TARGET_NAME} COMPILE_DEFINITIONS)
  # get_target_property(_libs ${TARGET_NAME} LINK_LIBRARIES)

  # message(STATUS "-- Type                : ${_type}")

  # if(_incs) message(STATUS "-- Include Dirs        : ${_incs}") endif()

  # if(_defs) message(STATUS "-- Compile Definitions : ${_defs}") endif()

  # if(_libs) message(STATUS "-- Link Libraries      : ${_libs}") endif()
endfunction()
