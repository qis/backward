cmake_minimum_required(VERSION 3.16 FATAL_ERROR)
project(backward VERSION 1.4.0 LANGUAGES CXX)

add_library(backward SHARED backward.hpp backward.cpp)
target_compile_features(backward PRIVATE cxx_std_11)
target_include_directories(backward PRIVATE src)

target_compile_definitions(backward PRIVATE
  BACKWARD_CXX11=1
  BACKWARD_ATLEAST_CXX11=1
  BACKWARD_ATLEAST_CXX98=1
  BACKWARD_SYSTEM_LINUX=1
  BACKWARD_HAS_UNWIND=1
  BACKWARD_HAS_BFD=1)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  target_link_libraries(backward PUBLIC bfd unwind)
endif()

install(TARGETS backward EXPORT backward LIBRARY DESTINATION lib ARCHIVE DESTINATION lib)
install(EXPORT backward FILE backward-config.cmake NAMESPACE backward:: DESTINATION lib/cmake/backward)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(${CMAKE_CURRENT_BINARY_DIR}/backward-config-version.cmake
  VERSION ${PROJECT_VERSION} COMPATIBILITY SameMajorVersion)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/backward-config-version.cmake DESTINATION lib/cmake/backward)

add_library(backward::backward ALIAS backward)
