cmake_minimum_required(VERSION 3.28)

project(${CMAKE_PROJECT_NAME}_ut_tests)

# -------------------------------------------------
# Testing
# -------------------------------------------------
include(CTest)
enable_testing()

# -------------------------------------------------
# GoogleTest
# -------------------------------------------------
include(FetchContent)

FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG v1.17.0)

# Recommended for Windows / MSVC
set(gtest_force_shared_crt
    ON
    CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(googletest)

# -------------------------------------------------
# Test executable
# -------------------------------------------------
add_executable(${PROJECT_NAME} main.cpp person_tests.cpp)

target_link_libraries(${PROJECT_NAME} PRIVATE core GTest::gtest
                                              GTest::gtest_main)

# -------------------------------------------------
# GoogleTest discovery
# -------------------------------------------------
include(GoogleTest)

# Test registration
set(GTEST_COMMAND ${PROJECT_NAME})

# Cache variables
set(GTEST_OUTPUT_TYPE
    "xml"
    CACHE STRING "GTest test output format")
set_property(CACHE GTEST_OUTPUT_TYPE PROPERTY STRINGS "none;xml;json")

string(TOUPPER ${GTEST_OUTPUT_TYPE} GTEST_OUTPUT_TYPE_UPPER)
if(NOT GTEST_OUTPUT_TYPE_UPPER STREQUAL "NONE")
  list(APPEND GTEST_COMMAND
       "--gtest_output=${GTEST_OUTPUT_TYPE}:${GTEST_OUTPUT}")
endif()

gtest_discover_tests(${PROJECT_NAME}
                     WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

# -------------------------------------------------
# Optional project tooling
# -------------------------------------------------
if(ENABLE_WARNINGS)
  enable_project_warnings(${PROJECT_NAME})
endif()

print_target_build_info(${PROJECT_NAME})
