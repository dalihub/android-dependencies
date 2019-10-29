# CMakeLists.txt

# Copyright (C) 2019 Samsung

cmake_minimum_required(VERSION 3.1)
cmake_policy(VERSION 3.1)

project(libexif C ASM)

set(VERSION "0.6.21.1")

include(GNUInstallDirs)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

set(libexif_public_hdrs
  libexif/exif-byte-order.h
  libexif/exif-content.h
  libexif/exif-data.h
  libexif/exif-data-type.h
  libexif/exif-entry.h
  libexif/exif-format.h
  libexif/exif.h
  libexif/exif-ifd.h
  libexif/exif-loader.h
  libexif/exif-log.h
  libexif/exif-mem.h
  libexif/exif-mnote-data.h
  libexif/exif-system.h
  libexif/exif-tag.h
  libexif/exif-utils.h
  libexif/_stdint.h
)

set(libexif_private_hdrs
  config.h
  libexif/i18n.h
  libexif/canon/exif-mnote-data-canon.h
  libexif/canon/mnote-canon-entry.h
  libexif/canon/mnote-canon-tag.h
  libexif/exif-mnote-data-priv.h
  libexif/fuji/exif-mnote-data-fuji.h
  libexif/fuji/mnote-fuji-entry.h
  libexif/fuji/mnote-fuji-tag.h
  libexif/olympus/exif-mnote-data-olympus.h
  libexif/olympus/mnote-olympus-entry.h
  libexif/olympus/mnote-olympus-tag.h
  libexif/pentax/exif-mnote-data-pentax.h
  libexif/pentax/mnote-pentax-entry.h
  libexif/pentax/mnote-pentax-tag.h
)

set(libexif_sources
  ${libexif_public_hdrs}
  ${libexif_private_hdrs}
  libexif/canon/exif-mnote-data-canon.c
  libexif/canon/mnote-canon-entry.c
  libexif/canon/mnote-canon-tag.c
  libexif/exif-byte-order.c
  libexif/exif-content.c
  libexif/exif-data.c
  libexif/exif-entry.c
  libexif/exif-format.c
  libexif/exif-ifd.c
  libexif/exif-loader.c
  libexif/exif-log.c
  libexif/exif-mem.c
  libexif/exif-mnote-data.c
  libexif/exif-tag.c
  libexif/exif-utils.c
  libexif/fuji/exif-mnote-data-fuji.c
  libexif/fuji/mnote-fuji-entry.c
  libexif/fuji/mnote-fuji-tag.c
  libexif/olympus/exif-mnote-data-olympus.c
  libexif/olympus/mnote-olympus-entry.c
  libexif/olympus/mnote-olympus-tag.c
  libexif/pentax/exif-mnote-data-pentax.c
  libexif/pentax/mnote-pentax-entry.c
  libexif/pentax/mnote-pentax-tag.c
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

unset(EXIF_LIB_TARGETS)

if(EXIF_SHARED)
  add_library(exif SHARED ${libexif_sources})
  set(EXIF_LIB_TARGETS exif)
endif()

if(EXIF_STATIC)
  add_library(exif_static STATIC ${libexif_sources})
  list(APPEND EXIF_LIB_TARGETS exif_static)
endif()

if(NOT EXIF_LIB_TARGETS)
  message(SEND_ERROR
    "No library variant selected to build. "
    "Please enable at least one of the following options: "
    "EXIF_STATIC, EXIF_SHARED")
endif()

# libexif is a library so default to 'lib'
if(NOT DEFINED CMAKE_INSTALL_LIBDIR)
  set(CMAKE_INSTALL_LIBDIR lib)
endif()

set(prefix      ${CMAKE_INSTALL_PREFIX})
set(exec_prefix ${CMAKE_INSTALL_PREFIX})
set(libdir      ${CMAKE_INSTALL_FULL_LIBDIR})
set(includedir  ${CMAKE_INSTALL_FULL_INCLUDEDIR}/libexif)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/libexif.pc.in
    ${CMAKE_CURRENT_BINARY_DIR}/exif.pc @ONLY)

# INSTALL
if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
  install(TARGETS ${EXIF_LIB_TARGETS}
          EXPORT libexif
          RUNTIME DESTINATION bin
          LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
          ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
          FRAMEWORK DESTINATION ${CMAKE_INSTALL_LIBDIR})
endif()

if(NOT SKIP_INSTALL_HEADERS AND NOT SKIP_INSTALL_ALL)
  install(FILES ${libexif_public_hdrs} DESTINATION include/libexif)
endif()

if(NOT SKIP_INSTALL_FILES AND NOT SKIP_INSTALL_ALL)
  # Install pkg-config files
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/exif.pc
          DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
endif()

# Create an export file that CMake users can include() to import our targets.
if(NOT SKIP_INSTALL_EXPORT AND NOT SKIP_INSTALL_ALL)
  install(EXPORT libexif DESTINATION lib/libexif FILE libexif.cmake)
endif()

