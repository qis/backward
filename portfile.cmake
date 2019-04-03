include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_SHARED_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO bombela/backward-cpp
    REF v1.4
    SHA512 dc5642d1ea7ad40633e63ead7faadb6bc1c4ddd40ba63343dd95f6c3d41f40085ca1cda992ec1d9724572ae3caad9f8117de9f41380b80d85f5a270179a7334e
    HEAD_REF master
)

file(COPY
  ${CURRENT_PORT_DIR}/backward-config.cmake.in
  ${CURRENT_PORT_DIR}/CMakeLists.txt
  DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH} PREFER_NINJA)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})

file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

vcpkg_copy_pdbs()
