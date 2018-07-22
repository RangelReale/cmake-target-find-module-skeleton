cmake_minimum_required(VERSION 3.2)
project(skelapp)

# The library output directory
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

# The modules path
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules)

# find the Skellib library

find_package(Skellib REQUIRED)

add_executable(skelapp 
  main.cpp
)

target_link_libraries(skelapp
	Skellib::Skellib
)