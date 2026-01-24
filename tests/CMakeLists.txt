include(FetchContent)

FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG v1.17.0)
FetchContent_MakeAvailable(googletest)

add_library(GTest::GTest INTERFACE IMPORTED)
target_link_libraries(GTest::GTest INTERFACE gtest_main)

project(${CMAKE_PROJECT_NAME}_ut_tests)

set(SOURCE_FILES main.cpp person_tests.cpp)

add_executable(${PROJECT_NAME} ${SOURCE_FILES})

target_link_libraries(${PROJECT_NAME} PRIVATE core GTest::GTest)

# target_include_directories(${PROJECT_NAME} PRIVATE
# ${CMAKE_SOURCE_DIR}/app/include)
if(ENABLE_WARNINGS)
  enable_project_warnings(${PROJECT_NAME})
endif()

print_target_build_info(${PROJECT_NAME})
# enable_fast_build(${PROJECT_NAME})
