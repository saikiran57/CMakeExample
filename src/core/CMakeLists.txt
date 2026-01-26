cmake_minimum_required(VERSION 3.28.3)

# Get current folder name as project name
get_filename_component(PROJECT_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)
project(${PROJECT_NAME} LANGUAGES CXX)

set(HEADER_FILES include/person.hpp include/agent_data.hpp)
set(SOURCE_FILES src/agent_data.cpp)

add_library(${PROJECT_NAME} SHARED ${HEADER_FILES} ${SOURCE_FILES})

target_include_directories(${PROJECT_NAME}
                           PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

if(ENABLE_WARNINGS)
  enable_project_warnings(${PROJECT_NAME})
endif()

print_target_build_info(${PROJECT_NAME})
enable_fast_build(${PROJECT_NAME})
