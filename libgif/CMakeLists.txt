# CMakeLists.txt

# Copyright (C) 2019 Samsung

cmake_minimum_required(VERSION 3.1)
cmake_policy(VERSION 3.1)

project(libgif C ASM)

execute_process ( COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/getversion  
                  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/ OUTPUT_VARIABLE GIFLIB_VERSION) 

include(GNUInstallDirs)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

set(libgif_public_hdrs
  gif_lib.h
)

set(libgif_private_hdrs
  getarg.h
  gif_hash.h
  gif_lib_private.h
)

set(libgif_sources
  ${libgif_public_hdrs}
  ${libgif_private_hdrs}
  openbsd-reallocarray.c
  gif_font.c
  getarg.c
  egif_lib.c
  gif_hash.c
  qprintf.c
  quantize.c
  gifalloc.c
  gifhisto.c
  dgif_lib.c
  gif_err.c
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

unset(GIF_LIB_TARGETS)

if(GIF_SHARED)
  add_library(gif SHARED ${libgif_sources})
  set(GIF_LIB_TARGETS gif)
endif()

if(GIF_STATIC)
  add_library(gif_static STATIC ${libgif_sources})
  set_target_properties(gif_static PROPERTIES OUTPUT_NAME "gif")
  list(APPEND GIF_LIB_TARGETS gif_static)
endif()

if(NOT GIF_LIB_TARGETS)
  message(SEND_ERROR
    "No library variant selected to build. "
    "Please enable at least one of the following options: "
    "GIF_STATIC, GIF_SHARED")
endif()

# libgif is a library so default to 'lib'
if(NOT DEFINED CMAKE_INSTALL_LIBDIR)
  set(CMAKE_INSTALL_LIBDIR lib)
endif()

set(prefix      ${CMAKE_INSTALL_PREFIX})
set(exec_prefix ${CMAKE_INSTALL_PREFIX})
set(libdir      ${CMAKE_INSTALL_FULL_LIBDIR})
set(includedir  ${CMAKE_INSTALL_FULL_INCLUDEDIR})
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/libgif.pc.in
    ${CMAKE_CURRENT_BINARY_DIR}/libgif.pc @ONLY)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/libgif-config.in
    ${CMAKE_CURRENT_BINARY_DIR}/libgif-config @ONLY)

# INSTALL
if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
  install(TARGETS ${GIF_LIB_TARGETS}
          EXPORT libgif
          RUNTIME DESTINATION bin
          LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
          ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
          FRAMEWORK DESTINATION ${CMAKE_INSTALL_LIBDIR})
endif()

if(NOT SKIP_INSTALL_HEADERS AND NOT SKIP_INSTALL_ALL)
  install(FILES ${libgif_public_hdrs} DESTINATION include)
endif()

if(NOT SKIP_INSTALL_EXECUTABLES AND NOT SKIP_INSTALL_ALL)
  install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/libgif-config DESTINATION bin)
endif()

if(NOT SKIP_INSTALL_FILES AND NOT SKIP_INSTALL_ALL)
  # Install pkg-config files
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libgif.pc
          DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
  install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/libgif-config
          DESTINATION bin)
endif()

# Create an export file that CMake users can include() to import our targets.
if(NOT SKIP_INSTALL_EXPORT AND NOT SKIP_INSTALL_ALL)
  install(EXPORT libgif DESTINATION lib/libgif FILE libgif.cmake)
endif()

