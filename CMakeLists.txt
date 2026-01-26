cmake_minimum_required(VERSION 3.28.3)

# -------------------------------------------------
# Project
# -------------------------------------------------
project(
  app
  VERSION 0.1.0
  DESCRIPTION "Application with core library"
  LANGUAGES C CXX)

# -------------------------------------------------
# Global C++ settings
# -------------------------------------------------
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# -------------------------------------------------
# Options
# -------------------------------------------------
option(ENABLE_WARNINGS "Enable compiler warnings" ON)
option(ENABLE_APP "Build application executable" ON)
option(ENABLE_TESTS "Build unit tests" OFF)
option(ENABLE_BENCHMARKS "Build benchmark targets" OFF)
option(BUILD_DEBUG_MODE "Enable extra debug definitions" OFF)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# -------------------------------------------------
# CMake modules
# -------------------------------------------------
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(CompilerDefinitions)
include(CompilerWarnings)
include(Sanitizers)
include(BuildInfo)
include(FastBuild)

print_global_build_info_once()

# -------------------------------------------------
# Global compile definitions
# -------------------------------------------------
if(BUILD_DEBUG_MODE)
  add_compile_definitions(DEBUG_BUILD)
endif()

add_subdirectory(src)

if(ENABLE_TESTS)
  include(CTest)
  enable_testing()
  add_subdirectory(tests)
endif()

if(ENABLE_BENCHMARKS)
  add_subdirectory(benchmarks)
endif()

# if(ENABLE_ASAN) enable_sanitizers(tests) enable_sanitizers(app)
# enable_sanitizers(benchmarks) endif()
