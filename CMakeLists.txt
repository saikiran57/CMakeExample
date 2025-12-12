cmake_minimum_required(VERSION 3.28.3)
project(app VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)

option(ENABLE_TESTS "Enable unit testing" OFF)
option(BUILD_DEBUG_MODE "Enable debug mode" OFF)
# Define DEBUG_BUILD only if BUILD_DEBUG_MODE is TRUE
add_compile_definitions(
    "$<$<BOOL:${BUILD_DEBUG_MODE}>:DEBUG_BUILD>"
)

# Using CMAKE_BUILD_TYPE for Single-Configuration Generators:
if(CMAKE_BUILD_TYPE STREQUAL "DEBUG")
    message(STATUS "Building in Debug mode.")
    # Add debug-specific settings or definitions
    add_compile_definitions(DEBUG_MODE)
elseif(CMAKE_BUILD_TYPE STREQUAL "RELEASE")
    message(STATUS "Building in Release mode.")
    # Add release-specific settings or optimizations
    add_compile_definitions(NDEBUG)
endif()

add_subdirectory(app)

if(ENABLE_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()
