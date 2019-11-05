# CMakeLists.txt

# Copyright (C) 2019 Samsung

cmake_minimum_required(VERSION 3.1)
cmake_policy(VERSION 3.1)

project(libpixman C ASM)

set(PACKAGE pixman)
set(PACKAGE_VERSION "0.38.5")
add_definitions(-DHAVE_CONFIG_H=1)

include(GNUInstallDirs)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/pixman)

if(ANDROID)

include_directories(${ANDROID_NDK})
include_directories(${ANDROID_NDK}/sources)
include_directories(${ANDROID_NDK}/sources/android)
include_directories(${ANDROID_NDK}/sources/android/cpufeatures)
add_library(cpufeatures STATIC
    ${ANDROID_NDK}/sources/android/cpufeatures/cpu-features.c)

endif()

# TODO
# set definitions and sources for arm
#if(CMAKE_SYSTEM_PROCESSOR MATCHES "^arm" OR
#  CMAKE_SYSTEM_PROCESSOR MATCHES "^aarch64")
#  set(USE_ARM_NEON_POSSIBLE_VALUES check on off)
#  set(USE_ARM_NEON "check" CACHE STRING "Enable ARM NEON optimizations:
#     check: (default) use internal checking code;
#     off: disable the optimizations;
#     on: turn on unconditionally.")
#  set_property(CACHE USE_ARM_NEON PROPERTY STRINGS
#     ${USE_ARM_NEON_POSSIBLE_VALUES})
#  list(FIND USE_ARM_NEON_POSSIBLE_VALUES ${USE_ARM_NEON} index)
#  if(index EQUAL -1)
#    message(FATAL_ERROR
#      "USE_ARM_NEON must be one of [${USE_ARM_NEON_POSSIBLE_VALUES}]")
#  elseif(NOT ${USE_ARM_NEON} STREQUAL "off")
#    add_definitions(-DUSE_ARM_NEON=1)
#    set(libpixman_arm_neon_hdrs
#       pixman/pixman-arm-asm.h
#       pixman/pixman-arm-common.h
#       pixman/pixman-arm-neon-asm.h
#    )
#    set(libpixman_arm_neon_sources
#       pixman/pixman-arm-neon.c
#       pixman/pixman-arm-neon-asm.S
#       pixman/pixman-arm-neon-asm-bilinear.S
#    )
#  else()
#    add_definitions(-DUSE_ARM_NEON=0)
#  endif()
#endif()

# set definitions and sources for intel
if(CMAKE_SYSTEM_PROCESSOR MATCHES "^i?86" OR
   CMAKE_SYSTEM_PROCESSOR MATCHES "^x86_64*")
  set(USE_SSSE3_POSSIBLE_VALUES on off)
  set(USE_SSSE3 "on" CACHE STRING "Enable INTEL_SSE optimizations:
     off: disable the optimizations")
  set_property(CACHE PNG_INTEL_SSE PROPERTY STRINGS
     ${USE_SSSE3_POSSIBLE_VALUES})
  list(FIND USE_SSSE3_POSSIBLE_VALUES ${USE_SSSE3} index)
  if(index EQUAL -1)
    message(FATAL_ERROR
      "USE_SSSE3 must be one of [${USE_SSSE3_POSSIBLE_VALUES}]")
  elseif(NOT ${USE_SSSE3} STREQUAL "off")
    add_definitions(-DUSE_SSSE3=1)
    set(libpixman_ssse3_sources
       pixman/pixman-ssse3.c
    )
  else()
    add_definitions(-DUSE_SSSE3=0)
  endif()
endif()

set(libpixman_public_hdrs
  pixman/pixman.h
  pixman/pixman-version.h
)

set(libpixman_private_hdrs
  pixman/pixman-accessor.h
  pixman/pixman-combine32.h
  pixman/pixman-compiler.h
  pixman/pixman-edge-imp.h
  pixman/pixman-inlines.h
  pixman/pixman-private.h
  config.h
)

set(libpixman_sources
  ${libpixman_public_hdrs}
  ${libpixman_private_hdrs}
  ${libpixman_arm_neon_hdrs}
  pixman/pixman.c
  pixman/pixman-access.c
  pixman/pixman-access-accessors.c
  pixman/pixman-bits-image.c
  pixman/pixman-combine32.c
  pixman/pixman-combine-float.c
  pixman/pixman-conical-gradient.c
  pixman/pixman-filter.c
  pixman/pixman-x86.c
  pixman/pixman-mips.c
  pixman/pixman-arm.c
  pixman/pixman-ppc.c
  pixman/pixman-edge.c
  pixman/pixman-edge-accessors.c
  pixman/pixman-fast-path.c
  pixman/pixman-glyph.c
  pixman/pixman-general.c
  pixman/pixman-gradient-walker.c
  pixman/pixman-image.c
  pixman/pixman-implementation.c
  pixman/pixman-linear-gradient.c
  pixman/pixman-matrix.c
  pixman/pixman-noop.c
  pixman/pixman-radial-gradient.c
  pixman/pixman-region16.c
  pixman/pixman-region32.c
  pixman/pixman-solid-fill.c
  pixman/pixman-timer.c
  pixman/pixman-trap.c
  pixman/pixman-utils.c
  ${libpixman_arm_neon_sources}
)

unset(PIXMAN_LIB_TARGETS)

if(PIXMAN_SHARED)
  add_library(pixman-1 SHARED ${libpixman_sources})
  set(PIXMAN_LIB_TARGETS pixman-1)
endif()

if(PIXMAN_STATIC)
  add_library(pixman_static STATIC ${libpixman_sources})
  set_target_properties(pixman_static PROPERTIES OUTPUT_NAME "pixman-1")
  list(APPEND PIXMAN_LIB_TARGETS pixman_static)
endif()

if(ANDROID)
  target_link_libraries(${PIXMAN_LIB_TARGETS} android cpufeatures)
endif()

if(NOT PIXMAN_LIB_TARGETS)
  message(SEND_ERROR
    "No library variant selected to build. "
    "Please enable at least one of the following options: "
    "PIXMAN_STATIC, PIXMAN_SHARED")
endif()

# libpixman is a library so default to 'lib'
if(NOT DEFINED CMAKE_INSTALL_LIBDIR)
  set(CMAKE_INSTALL_LIBDIR lib)
endif()

set(prefix      ${CMAKE_INSTALL_PREFIX})
set(exec_prefix ${CMAKE_INSTALL_PREFIX})
set(libdir      ${CMAKE_INSTALL_FULL_LIBDIR})
set(includedir  ${CMAKE_INSTALL_FULL_INCLUDEDIR})
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/pixman-1.pc.in
    ${CMAKE_CURRENT_BINARY_DIR}/pixman-1.pc @ONLY)

# INSTALL
if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
  install(TARGETS ${PIXMAN_LIB_TARGETS}
    EXPORT libpixman-1
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    FRAMEWORK DESTINATION ${CMAKE_INSTALL_LIBDIR})
endif()

if(NOT SKIP_INSTALL_HEADERS AND NOT SKIP_INSTALL_ALL)
  install(FILES ${libpixman_public_hdrs} DESTINATION include/pixman-1)
endif()

if(NOT SKIP_INSTALL_FILES AND NOT SKIP_INSTALL_ALL)
  # Install pkg-config files
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/pixman-1.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
endif()

# Create an export file that CMake users can include() to import our targets.
if(NOT SKIP_INSTALL_EXPORT AND NOT SKIP_INSTALL_ALL)
  install(EXPORT libpixman DESTINATION lib/libpixman FILE libpixman.cmake)
endif()

