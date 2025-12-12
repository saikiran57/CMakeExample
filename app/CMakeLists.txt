cmake_minimum_required(VERSION 3.28.3)

set(HEADER_FILES include/person.hpp)
set(SOURCE_FILES src/main.cpp)

add_executable(${CMAKE_PROJECT_NAME} ${HEADER_FILES} ${SOURCE_FILES})

target_include_directories(${CMAKE_PROJECT_NAME}
        PUBLIC
        include)