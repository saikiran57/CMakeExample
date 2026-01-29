cmake_minimum_required(VERSION 3.28.3)

# Must call project() literally at top
project(
  app
  VERSION 0.1.0
  DESCRIPTION "Application with core library"
  LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(Options)
include(ProjectSetup)

# Add subdirectories
add_subdirectory(src)

if(ENABLE_TESTS)
  add_subdirectory(tests)
endif()

if(ENABLE_BENCHMARKS)
  add_subdirectory(benchmarks)
endif()
