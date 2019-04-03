cmake_minimum_required(VERSION 3.12.0 FATAL_ERROR)
project(backward VERSION 1.4.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(backward SHARED backward.hpp backward.cpp)
target_include_directories(backward PRIVATE src)

target_compile_definitions(backward PRIVATE
  BACKWARD_CXX11=1
  BACKWARD_ATLEAST_CXX11=1
  BACKWARD_ATLEAST_CXX98=1
  BACKWARD_SYSTEM_LINUX=1
  BACKWARD_HAS_UNWIND=1
  BACKWARD_HAS_BFD=1)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  target_link_libraries(backward PUBLIC bfd)
endif()

find_package(Threads REQUIRED)
target_link_libraries(backward PUBLIC Threads::Threads)

install(TARGETS backward EXPORT backward
  RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib)

install(EXPORT backward FILE backward-targets.cmake NAMESPACE backward::
  DESTINATION lib/cmake/backward)

include(CMakePackageConfigHelpers)

configure_package_config_file(backward-config.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/backward-config.cmake
  INSTALL_DESTINATION lib/cmake/backward)

write_basic_package_version_file(${CMAKE_CURRENT_BINARY_DIR}/backward-config-version.cmake
  VERSION ${PROJECT_VERSION} COMPATIBILITY SameMajorVersion)

install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/backward-config.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/backward-config-version.cmake
  DESTINATION lib/cmake/backward)
