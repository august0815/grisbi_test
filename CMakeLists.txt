include(${CMAKE_SOURCE_DIR}/cmake/project.cmake)

cmake_minimum_required(VERSION 2.8)
project("${project_name}" C)

set(CMAKE_INSTALL_PREFIX "/usr")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/vala")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

find_package(Vala "0.16" REQUIRED)

if(VALA_VERSION STRGREATER "0.17.0")
  list(REMOVE_ITEM required_pkgs "libvala-0.16" )
  set(valashort_ver "0.18")
  set(valac_cond)
else()
  list(REMOVE_ITEM required_pkgs "libvala-0.18" )
  set(valashort_ver "0.16")
  set(valac_cond "-D;VALA_LESS_0_18")
endif()
set(srcfiles "${PROJECT_SOURCE_DIR}/src/*.vala")
include(ValaPkgs)
vala_pkgs(VALA_C
  PACKAGES
    ${required_pkgs}
  OPTIONAL
    ${optional_pkgs}
  SRCFILES
    ${srcfiles}
    ${PROJECT_SOURCE_DIR}/config.vala
  OPTIONS
    --thread
    ${valac_cond}
)
if(NOT PkgConfig_FOUND)
  find_package(PkgConfig)
endif()
pkg_check_modules(GTHREAD REQUIRED gthread-2.0)
add_definitions(${GTHREAD_CFLAGS})
link_libraries(${GTHREAD_LIBRARIES})

add_executable("${project_name}" ${VALA_C})
