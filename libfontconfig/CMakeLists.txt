# CMakeLists.txt

# Copyright (C) 2019 Samsung

cmake_minimum_required(VERSION 3.1)
cmake_policy(VERSION 3.1)

project(libfontconfig C ASM)

set(VERSION "2.2.6")
set(SOVERSION "2")
set(FONTCONFIG_PATH "${READ_ONLY_DIR}")
set(FC_DEFAULT_FONTS "${READ_ONLY_DIR}")
execute_process ( COMMAND date OUTPUT_VARIABLE FC_FONTDATE) 

add_definitions(-DHAVE_CONFIG_H=1)
add_definitions(-DFONTCONFIG_PATH=\"${FONTCONFIG_PATH}/fonts.conf\")
add_definitions(-DFC_DEFAULT_FONTS=\"${FC_DEFAULT_FONTS}\")
#TODO
#add_definitions(-DFC_FONTDATE="${FC_FONTDATE}")

include(GNUInstallDirs)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/fontconfig)

set(libfontconfig_public_hdrs
  fontconfig/fontconfig.h
  fontconfig/fcfreetype.h
)

set(libfontconfig_private_hdrs
  config.h
  fontconfig/fcprivate.h
  src/fcint.h
)

set(libfontconfig_sources
  ${libfontconfig_public_hdrs}
  ${libfontconfig_private_hdrs}
  src/fcatomic.c
  src/fcblanks.c
  src/fccache.c
  src/fccfg.c
  src/fccharset.c
  src/fcdbg.c
  src/fcdefault.c
  src/fcdir.c
  src/fcfreetype.c
  src/fcfs.c
  src/fcinit.c
  src/fclang.c
  src/fclist.c
  src/fcmatch.c
  src/fcmatrix.c
  src/fcname.c
  src/fcpat.c
  src/fcstr.c
  src/fcxml.c
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

find_package(PkgConfig)

pkg_check_modules(FREETYPE freetype2)
if (NOT FREETYPE_FOUND)
  include (FindFreetype)
  if (NOT FREETYPE_FOUND)
    message(FATAL_ERROR "Failed to find freetype. Maybe add a CMAKE_PREFIX_PATH= to your Freetype2 install prefix")
  endif ()
endif ()

include_directories(AFTER ${FREETYPE_INCLUDE_DIRS})
add_definitions(-DHAVE_FREETYPE=1)

pkg_check_modules(EXPAT expat)
if (NOT EXPAT_FOUND)
  include (FindExpat)
  if (NOT EXPAT_FOUND)
    message(FATAL_ERROR "Failed to find expat. Maybe add a CMAKE_PREFIX_PATH= to your Expat install prefix")
  endif ()
endif ()

include_directories(AFTER ${EXPAT_INCLUDE_DIRS})
add_definitions(-DHAVE_EXPAT=1)

unset(FONTCONFIG_LIB_TARGETS)

if(FONTCONFIG_SHARED)
  add_library(fontconfig SHARED ${libfontconfig_sources})
  set(FONTCONFIG_LIB_TARGETS fontconfig)
  if(ANDROID)
    target_link_libraries(${FONTCONFIG_LIB_TARGETS} ${FREETYPE_LDFLAGS} ${EXPAT_LDFLAGS} log)
  else()
    target_link_libraries(${FONTCONFIG_LIB_TARGETS} ${FREETYPE_LDFLAGS} ${EXPAT_LDFLAGS})
  endif()
  link_directories(${FREETYPE_LIBRARY_DIRS})
endif()

if(FONTCONFIG_STATIC)
  add_library(fontconfig_static STATIC ${libfontconfig_sources})
  set_target_properties(fontconfig_static PROPERTIES OUTPUT_NAME "fontconfig")
  list(APPEND FONTCONFIG_LIB_TARGETS fontconfig_static)
endif()

if(NOT FONTCONFIG_LIB_TARGETS)
  message(SEND_ERROR
    "No library variant selected to build. "
    "Please enable at least one of the following options: "
    "FONTCONFIG_STATIC, FONTCONFIG_SHARED")
endif()

# libfontconfig is a library so default to 'lib'
if(NOT DEFINED CMAKE_INSTALL_LIBDIR)
  set(CMAKE_INSTALL_LIBDIR lib)
endif()

set(prefix      ${CMAKE_INSTALL_PREFIX})
set(exec_prefix ${CMAKE_INSTALL_PREFIX})
set(libdir      ${CMAKE_INSTALL_FULL_LIBDIR})
set(includedir  ${CMAKE_INSTALL_FULL_INCLUDEDIR})
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/fontconfig.pc.in
    ${CMAKE_CURRENT_BINARY_DIR}/fontconfig.pc @ONLY)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/fonts.conf.in
    ${CMAKE_CURRENT_BINARY_DIR}/fonts.conf @ONLY)

# INSTALL
if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
  install(TARGETS ${FONTCONFIG_LIB_TARGETS}
          EXPORT libfontconfig
          RUNTIME DESTINATION bin
          LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
          ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
          FRAMEWORK DESTINATION ${CMAKE_INSTALL_LIBDIR})
endif()

if(NOT SKIP_INSTALL_HEADERS AND NOT SKIP_INSTALL_ALL)
  install(FILES ${libfontconfig_public_hdrs} DESTINATION include/fontconfig)
endif()

if(NOT SKIP_INSTALL_FILES AND NOT SKIP_INSTALL_ALL)
  # Install pkg-config files
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/fontconfig.pc
          DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
  # Install font config files
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/fonts.conf
          DESTINATION ${FONTCONFIG_INSTALL_PATH})
  install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/fonts.dtd
          DESTINATION ${FONTCONFIG_INSTALL_PATH})
  install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/local.conf
          DESTINATION ${FONTCONFIG_INSTALL_PATH})
endif()

# Create an export file that CMake users can include() to import our targets.
if(NOT SKIP_INSTALL_EXPORT AND NOT SKIP_INSTALL_ALL)
  install(EXPORT libfontconfig DESTINATION lib/libfontconfig FILE libfontconfig.cmake)
endif()

