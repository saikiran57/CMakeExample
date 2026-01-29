cmake_minimum_required(VERSION 3.28.3)

set(SOURCE_FILES src/main.cpp)

add_executable(${CMAKE_PROJECT_NAME} ${HEADER_FILES} ${SOURCE_FILES})

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE core)

if(ENABLE_WARNINGS)
  enable_project_warnings(${CMAKE_PROJECT_NAME})
  enable_project_runtime(${CMAKE_PROJECT_NAME})
endif()

enable_sanitizers(${CMAKE_PROJECT_NAME})
print_target_build_info(${CMAKE_PROJECT_NAME})
