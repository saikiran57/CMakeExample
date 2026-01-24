# =========================================================
# BuildInfo.cmake
# =========================================================

function(print_global_build_info_once)

  # Guard: print once
  get_property(_printed GLOBAL PROPERTY BUILD_INFO_PRINTED)
  if(_printed)
    return()
  endif()
  set_property(GLOBAL PROPERTY BUILD_INFO_PRINTED TRUE)

  message(STATUS "==================== BUILD INFORMATION ====================")

  # ---------------------------------------------------------
  # Project info
  # ---------------------------------------------------------
  message(STATUS "Project Name    : ${PROJECT_NAME}")
  message(STATUS "Project Version : ${PROJECT_VERSION}")
  message(STATUS "Source Dir      : ${CMAKE_SOURCE_DIR}")
  message(STATUS "Binary Dir      : ${CMAKE_BINARY_DIR}")

  # ---------------------------------------------------------
  # CMake info
  # ---------------------------------------------------------
  message(STATUS "CMake Version   : ${CMAKE_VERSION}")
  message(STATUS "Generator       : ${CMAKE_GENERATOR}")
  message(STATUS "Toolchain File  : ${CMAKE_TOOLCHAIN_FILE}")

  # ---------------------------------------------------------
  # Compiler info
  # ---------------------------------------------------------
  message(STATUS "CXX Compiler    : ${CMAKE_CXX_COMPILER}")
  message(STATUS "CXX Compiler ID : ${CMAKE_CXX_COMPILER_ID}")
  message(STATUS "CXX Version     : ${CMAKE_CXX_COMPILER_VERSION}")
  message(STATUS "CXX Standard    : ${CMAKE_CXX_STANDARD}")

  include(ProcessorCount)

  ProcessorCount(NUM_CORES)
  if(NUM_CORES EQUAL 0)
    set(NUM_CORES "Unknown")
  endif()

  # ---------------------------------------------------------
  # Platform info
  # ---------------------------------------------------------
  message(STATUS "System          : ${CMAKE_SYSTEM_NAME}")
  message(STATUS "Processor       : ${CMAKE_SYSTEM_PROCESSOR}")
  message(STATUS "CPU Cores       : ${NUM_CORES}")

  # ---------------------------------------------------------
  # Options (AUTO-DISCOVERED)
  # ---------------------------------------------------------
  get_cmake_property(_vars VARIABLES)

  message(STATUS "-------------------- OPTIONS --------------------")
  foreach(v ${_vars})
    if(v MATCHES "^ENABLE_")
      message(STATUS "${v} = ${${v}}")
    endif()
  endforeach()

  message(STATUS "============================================================")
endfunction()

function(print_target_build_info TARGET_NAME)

  if(NOT TARGET ${TARGET_NAME})
    message(WARNING "Target '${TARGET_NAME}' does not exist")
    return()
  endif()

  message(
    STATUS "-------------------- TARGET: ${TARGET_NAME} --------------------")

  get_target_property(_type ${TARGET_NAME} TYPE)
  get_target_property(_incs ${TARGET_NAME} INCLUDE_DIRECTORIES)
  get_target_property(_defs ${TARGET_NAME} COMPILE_DEFINITIONS)
  get_target_property(_opts ${TARGET_NAME} COMPILE_OPTIONS)
  get_target_property(_libs ${TARGET_NAME} LINK_LIBRARIES)

  message(STATUS "Type                : ${_type}")
  message(STATUS "Include Dirs        : ${_incs}")
  message(STATUS "Compile Definitions : ${_defs}")
  message(STATUS "Compile Options     : ${_opts}")
  message(STATUS "Link Libraries      : ${_libs}")
endfunction()
