cmake_minimum_required(VERSION 3.28.3)

# set(HEADER_FILES include/person.hpp)
set(SOURCE_FILES src/main.cpp)

add_executable(${CMAKE_PROJECT_NAME} ${HEADER_FILES} ${SOURCE_FILES})

target_link_libraries(${CMAKE_PROJECT_NAME} core)

# target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC include)

if(ENABLE_WARNINGS)
  enable_project_warnings(${CMAKE_PROJECT_NAME})
endif()

print_target_build_info(${CMAKE_PROJECT_NAME})
enable_fast_build(${CMAKE_PROJECT_NAME})
