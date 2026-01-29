include(FetchContent)

FetchContent_Declare(
  benchmark
  GIT_REPOSITORY https://github.com/google/benchmark.git
  GIT_TAG v1.9.5
  EXCLUDE_FROM_ALL)

set(BENCHMARK_ENABLE_TESTING
    OFF
    CACHE BOOL "Disable testing" FORCE)

FetchContent_MakeAvailable(benchmark)

project(${CMAKE_PROJECT_NAME}_benchmarks)

set(SOURCE_FILES main.cpp agent_data_benchmark.cpp)

add_executable(${PROJECT_NAME} ${SOURCE_FILES})

target_link_libraries(${PROJECT_NAME} PRIVATE core benchmark::benchmark)

target_compile_options(${PROJECT_NAME} PRIVATE -O3)

# if(ENABLE_WARNINGS) enable_project_warnings(${PROJECT_NAME}) endif()
print_target_build_info(${PROJECT_NAME})

# enable_fast_build(${PROJECT_NAME})
