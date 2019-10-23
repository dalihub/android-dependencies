# CMakeLists.txt

# Copyright (C) 2019 Samsung

cmake_minimum_required(VERSION 3.1)
cmake_policy(VERSION 3.1)

project(libfribidi C ASM)

include(GNUInstallDirs)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

set(libfribidi_public_hdrs
  lib/bidi-types.h
  lib/common.h
  lib/debug.h
  lib/fribidi-arabic.h
  lib/fribidi-begindecls.h
  lib/fribidi-bidi.h
  lib/fribidi-bidi-types.h
  lib/fribidi-bidi-types-list.h
  lib/fribidi-brackets.h
  lib/fribidi-char-sets-cap-rtl.h
  lib/fribidi-char-sets-cp1255.h
  lib/fribidi-char-sets-cp1256.h
  lib/fribidi-char-sets.h
  lib/fribidi-char-sets-iso8859-6.h
  lib/fribidi-char-sets-iso8859-8.h
  lib/fribidi-char-sets-list.h
  lib/fribidi-char-sets-utf8.h
  lib/fribidi-common.h
  lib/fribidi-config.h
  lib/fribidi-deprecated.h
  lib/fribidi-enddecls.h
  lib/fribidi-flags.h
  lib/fribidi.h
  lib/fribidi-joining.h
  lib/fribidi-joining-types.h
  lib/fribidi-joining-types-list.h
  lib/fribidi-mirroring.h
  lib/fribidi-shape.h
  lib/fribidi-types.h
  lib/fribidi-unicode.h
  lib/fribidi-unicode-version.h
  lib/joining-types.h
  lib/run.h
)

set(libfribidi_private_hdrs
  config.h
)

set(libfribidi_sources
  ${libfribidi_public_hdrs}
  ${libfribidi_private_hdrs}
  lib/fribidi-char-sets-utf8.c
  lib/fribidi-run.c
  lib/fribidi-char-sets.c
  lib/fribidi-char-sets-cp1256.c
  lib/fribidi-joining-types.c
  lib/fribidi.c
  lib/fribidi-bidi.c
  lib/fribidi-shape.c
  lib/fribidi-joining.c
  lib/fribidi-arabic.c
  lib/fribidi-char-sets-iso8859-8.c
  lib/fribidi-mirroring.c
  lib/fribidi-bidi-types.c
  lib/fribidi-char-sets-iso8859-6.c
  lib/fribidi-char-sets-cap-rtl.c
  lib/fribidi-char-sets-cp1255.c
  lib/fribidi-brackets.c
  lib/fribidi-deprecated.c
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DHAVE_CONFIG_H")

unset(FRIBIDI_LIB_TARGETS)

if(FRIBIDI_SHARED)
  add_library(fribidi SHARED ${libfribidi_sources})
  set(FRIBIDI_LIB_TARGETS fribidi)
endif()

if(FRIBIDI_STATIC)
  add_library(fribidi_static STATIC ${libfribidi_sources})
  list(APPEND FRIBIDI_LIB_TARGETS fribidi_static)
endif()

if(NOT FRIBIDI_LIB_TARGETS)
  message(SEND_ERROR
    "No library variant selected to build. "
    "Please enable at least one of the following options: "
    "FRIBIDI_STATIC, FRIBIDI_SHARED")
endif()

# libfribidi is a library so default to 'lib'
if(NOT DEFINED CMAKE_INSTALL_LIBDIR)
  set(CMAKE_INSTALL_LIBDIR lib)
endif()

set(prefix      ${CMAKE_INSTALL_PREFIX})
set(exec_prefix ${CMAKE_INSTALL_PREFIX})
set(libdir      ${CMAKE_INSTALL_FULL_LIBDIR})
set(includedir  ${CMAKE_INSTALL_FULL_INCLUDEDIR})
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/fribidi.pc.in
    ${CMAKE_CURRENT_BINARY_DIR}/libfribidi.pc @ONLY)

# INSTALL
if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
  install(TARGETS ${FRIBIDI_LIB_TARGETS}
          EXPORT libfribidi
          RUNTIME DESTINATION bin
          LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
          ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
          FRAMEWORK DESTINATION ${CMAKE_INSTALL_LIBDIR})
endif()

if(NOT SKIP_INSTALL_HEADERS AND NOT SKIP_INSTALL_ALL)
  install(FILES ${libfribidi_public_hdrs} DESTINATION include/fribidi)
endif()

if(NOT SKIP_INSTALL_FILES AND NOT SKIP_INSTALL_ALL)
  # Install pkg-config files
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libfribidi.pc
          DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
endif()

# Create an export file that CMake users can include() to import our targets.
if(NOT SKIP_INSTALL_EXPORT AND NOT SKIP_INSTALL_ALL)
  install(EXPORT libfribidi DESTINATION lib/libfribidi FILE libfribidi.cmake)
endif()

