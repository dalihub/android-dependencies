# CMakeLists.txt

# Copyright (C) 2019 Samsung

cmake_minimum_required(VERSION 3.1)
cmake_policy(VERSION 3.1)

project(libcairo C)

add_definitions(-DHAVE_CONFIG_H=1)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -fno-builtin -Wno-enum-conversion -Wno-parentheses-equality")
set(VERSION "1.17.3")

include(GNUInstallDirs)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

set(libcairo_public_headers
  src/cairo.h
  src/cairo-features.h
  src/cairo-version.h
  src/cairo-deprecated.h
)

set(libcairo_private_headers
  src/cairoint.h
  src/cairo-analysis-surface-private.h
  src/cairo-arc-private.h
  src/cairo-array-private.h
  src/cairo-atomic-private.h
  src/cairo-backend-private.h
  src/cairo-box-inline.h
  src/cairo-boxes-private.h
  src/cairo-cache-private.h
  src/cairo-clip-inline.h
  src/cairo-clip-private.h
  src/cairo-combsort-inline.h
  src/cairo-compiler-private.h
  src/cairo-composite-rectangles-private.h
  src/cairo-compositor-private.h
  src/cairo-contour-inline.h
  src/cairo-contour-private.h
  src/cairo-damage-private.h
  src/cairo-default-context-private.h
  src/cairo-device-private.h
  src/cairo-error-inline.h
  src/cairo-error-private.h
  src/cairo-fixed-private.h
  src/cairo-fixed-type-private.h
  src/cairo-fontconfig-private.h
  src/cairo-freed-pool-private.h
  src/cairo-freelist-private.h
  src/cairo-freelist-type-private.h
  src/cairo-gstate-private.h
  src/cairo-hash-private.h
  src/cairo-image-info-private.h
  src/cairo-image-surface-inline.h
  src/cairo-image-surface-private.h
  src/cairo-line-inline.h
  src/cairo-line-private.h
  src/cairo-list-inline.h
  src/cairo-list-private.h
  src/cairo-malloc-private.h
  src/cairo-mempool-private.h
  src/cairo-mutex-impl-private.h
  src/cairo-mutex-list-private.h
  src/cairo-mutex-private.h
  src/cairo-mutex-type-private.h
  src/cairo-output-stream-private.h
  src/cairo-paginated-private.h
  src/cairo-paginated-surface-private.h
  src/cairo-path-fixed-private.h
  src/cairo-path-private.h
  src/cairo-pattern-inline.h
  src/cairo-pattern-private.h
  src/cairo-pixman-private.h
  src/cairo-private.h
  src/cairo-recording-surface-inline.h
  src/cairo-recording-surface-private.h
  src/cairo-reference-count-private.h
  src/cairo-region-private.h
  src/cairo-rtree-private.h
  src/cairo-scaled-font-private.h
  src/cairo-slope-private.h
  src/cairo-spans-compositor-private.h
  src/cairo-spans-private.h
  src/cairo-stroke-dash-private.h
  src/cairo-surface-backend-private.h
  src/cairo-surface-clipper-private.h
  src/cairo-surface-fallback-private.h
  src/cairo-surface-inline.h
  src/cairo-surface-observer-inline.h
  src/cairo-surface-observer-private.h
  src/cairo-surface-offset-private.h
  src/cairo-surface-private.h
  src/cairo-surface-snapshot-inline.h
  src/cairo-surface-snapshot-private.h
  src/cairo-surface-subsurface-inline.h
  src/cairo-surface-subsurface-private.h
  src/cairo-surface-wrapper-private.h
  src/cairo-time-private.h
  src/cairo-traps-private.h
  src/cairo-tristrip-private.h
  src/cairo-types-private.h
  src/cairo-user-font-private.h
  src/cairo-wideint-private.h
  src/cairo-wideint-type-private.h
)

set(libcairo_private_font_subset_headers
  src/cairo-scaled-font-subsets-private.h
  src/cairo-truetype-subset-private.h
  src/cairo-type1-private.h
  src/cairo-type3-glyph-surface-private.h
)

set(libcairo_font_subset_sources
  src/cairo-cff-subset.c
  src/cairo-scaled-font-subsets.c
  src/cairo-truetype-subset.c
  src/cairo-type1-fallback.c
  src/cairo-type1-glyph-names.c
  src/cairo-type1-subset.c
  src/cairo-type3-glyph-surface.c
)

set(libcairo_svg_headers
  src/cairo-svg.h
)

set(libcairo_svg_private_headers
  src/cairo-svg-surface-private.h
)

set(libcairo_svg_svg_sources
  src/cairo-svg-surface.c
)

set(libcairo_ft_headers
  src/cairo-ft.h
)

set(libcairo_ft_private_headers
  src/cairo-ft-private.h
)

set(libcairo_ft_sources
  src/cairo-ft-font.c
)

set(libcairo_script_headers
  src/cairo-script.h
)

set(libcairo_script_private_headers
  src/cairo-script-private.h
)

set(libcairo_script_sources
  src/cairo-script-surface.c
)

set(libcairo_deflate_stream_sources
  src/cairo-deflate-stream.c
)

find_package(PkgConfig)

pkg_check_modules(PIXMAN pixman-1)
if (NOT PIXMAN_FOUND)
  include (FindPixman)
  if (NOT PIXMAN_FOUND)
    message(FATAL_ERROR "Failed to find pixman-1.")
  endif ()
endif ()

include_directories(AFTER ${PIXMAN_INCLUDE_DIRS})

pkg_check_modules(FREETYPE freetype2)
if (NOT FREETYPE_FOUND)
  include (FindFreetype)
  if (NOT FREETYPE_FOUND)
    message(FATAL_ERROR "Failed to find freetype.")
  endif ()
endif ()

include_directories(AFTER ${FREETYPE_INCLUDE_DIRS})

pkg_check_modules(FONTCONFIG fontconfig)
if (NOT FONTCONFIG_FOUND)
  include (FindFontconfig)
  if (NOT FONTCONFIG_FOUND)
    message(FATAL_ERROR "Failed to find fontconfig.")
  endif ()
endif ()

include_directories(AFTER ${FONTCONFIG_INCLUDE_DIRS})

set(libcairo_png_sources
)

pkg_check_modules(PNG libpng)
if (NOT PNG_FOUND)
  include (FindPng)
endif ()

if (PNG_FOUND)
list(APPEND libcairo_png_sources
  src/cairo-png.c
)
include_directories(AFTER ${PNG_INCLUDE_DIRS})
endif()

set(libcairo_sources
  ${libcairo_public_headers}
  ${libcairo_private_headers}
  ${libcairo_ft_headers}
  ${libcairo_ft_private_headers}
  ${libcairo_ft_sources}
  ${libcairo_private_font_subset_headers}
  ${libcairo_font_subset_sources}
  ${libcairo_script_headers}
  ${libcairo_script_private_headers}
  ${libcairo_script_sources}
  ${libcairo_deflate_stream_sources}
  ${libcairo_png_sources}
  src/cairo-analysis-surface.c
  src/cairo-arc.c
  src/cairo-array.c
  src/cairo-atomic.c
  src/cairo-base64-stream.c
  src/cairo-base85-stream.c
  src/cairo-bentley-ottmann-rectangular.c
  src/cairo-bentley-ottmann-rectilinear.c
  src/cairo-bentley-ottmann.c
  src/cairo-botor-scan-converter.c
  src/cairo-boxes-intersect.c
  src/cairo-boxes.c
  src/cairo-cache.c
  src/cairo-clip-boxes.c
  src/cairo-clip-polygon.c
  src/cairo-clip-region.c
  src/cairo-clip-surface.c
  src/cairo-clip-tor-scan-converter.c
  src/cairo-clip.c
  src/cairo-color.c
  src/cairo-composite-rectangles.c
  src/cairo-compositor.c
  src/cairo-contour.c
  src/cairo-damage.c
  src/cairo-debug.c
  src/cairo-default-context.c
  src/cairo-device.c
  src/cairo-error.c
  src/cairo-fallback-compositor.c
  src/cairo-fixed.c
  src/cairo-font-face-twin-data.c
  src/cairo-font-face-twin.c
  src/cairo-font-face.c
  src/cairo-font-options.c
  src/cairo-freed-pool.c
  src/cairo-freelist.c
  src/cairo-gstate.c
  src/cairo-hash.c
  src/cairo-hull.c
  src/cairo-image-compositor.c
  src/cairo-image-info.c
  src/cairo-image-source.c
  src/cairo-image-surface.c
  src/cairo-line.c
  src/cairo-lzw.c
  src/cairo-mask-compositor.c
  src/cairo-matrix.c
  src/cairo-mempool.c
  src/cairo-mesh-pattern-rasterizer.c
  src/cairo-misc.c
  src/cairo-mono-scan-converter.c
  src/cairo-mutex.c
  src/cairo-no-compositor.c
  src/cairo-observer.c
  src/cairo-output-stream.c
  src/cairo-paginated-surface.c
  src/cairo-path-bounds.c
  src/cairo-path-fill.c
  src/cairo-path-fixed.c
  src/cairo-path-in-fill.c
  src/cairo-path-stroke-boxes.c
  src/cairo-path-stroke-polygon.c
  src/cairo-path-stroke-traps.c
  src/cairo-path-stroke-tristrip.c
  src/cairo-path-stroke.c
  src/cairo-path.c
  src/cairo-pattern.c
  src/cairo-pen.c
  src/cairo-polygon-intersect.c
  src/cairo-polygon-reduce.c
  src/cairo-polygon.c
  src/cairo-raster-source-pattern.c
  src/cairo-recording-surface.c
  src/cairo-rectangle.c
  src/cairo-rectangular-scan-converter.c
  src/cairo-region.c
  src/cairo-rtree.c
  src/cairo-scaled-font.c
  src/cairo-shape-mask-compositor.c
  src/cairo-slope.c
  src/cairo-spans-compositor.c
  src/cairo-spans.c
  src/cairo-spline.c
  src/cairo-stroke-dash.c
  src/cairo-stroke-style.c
  src/cairo-surface-clipper.c
  src/cairo-surface-fallback.c
  src/cairo-surface-observer.c
  src/cairo-surface-offset.c
  src/cairo-surface-snapshot.c
  src/cairo-surface-subsurface.c
  src/cairo-surface-wrapper.c
  src/cairo-surface.c
  src/cairo-time.c
  src/cairo-tor-scan-converter.c
  src/cairo-tor22-scan-converter.c
  src/cairo-toy-font-face.c
  src/cairo-traps-compositor.c
  src/cairo-traps.c
  src/cairo-tristrip.c
  src/cairo-unicode.c
  src/cairo-user-font.c
  src/cairo-version.c
  src/cairo-wideint.c
  src/cairo.c
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

unset(CAIRO_LIB_TARGETS)

if(CAIRO_SHARED)
  add_library(cairo SHARED ${libcairo_sources})
  set(CAIRO_LIB_TARGETS cairo)
endif()

if(CAIRO_STATIC)
  add_library(cairo_static STATIC ${libcairo_sources})
  list(APPEND CAIRO_LIB_TARGETS cairo_static)
endif()

if(NOT CAIRO_LIB_TARGETS)
  message(SEND_ERROR
    "No library variant selected to build. "
    "Please enable at least one of the following options: "
    "CAIRO_STATIC, CAIRO_SHARED")
endif()

target_link_libraries(${CAIRO_LIB_TARGETS} ${PIXMAN_LDFLAGS} ${FREETYPE_LDFLAGS} ${FONTCONFIG_LDFLAGS} ${PNG_LDFLAGS})

# libcairo is a library so default to 'lib'
if(NOT DEFINED CMAKE_INSTALL_LIBDIR)
  set(CMAKE_INSTALL_LIBDIR lib)
endif()

set(prefix      ${CMAKE_INSTALL_PREFIX})
set(exec_prefix ${CMAKE_INSTALL_PREFIX})
set(libdir      ${CMAKE_INSTALL_FULL_LIBDIR})
set(includedir  ${CMAKE_INSTALL_FULL_INCLUDEDIR})
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/src/cairo.pc.in
    ${CMAKE_CURRENT_BINARY_DIR}/cairo.pc @ONLY)

# INSTALL
if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
  install(TARGETS ${CAIRO_LIB_TARGETS}
          EXPORT libcairo
          RUNTIME DESTINATION bin
          LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
          ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
          FRAMEWORK DESTINATION ${CMAKE_INSTALL_LIBDIR})
endif()

if(NOT SKIP_INSTALL_HEADERS AND NOT SKIP_INSTALL_ALL)
  install(FILES ${libcairo_public_headers} DESTINATION include)
  install(FILES ${libcairo_ft_headers} DESTINATION include)
endif()

if(NOT SKIP_INSTALL_FILES AND NOT SKIP_INSTALL_ALL)
  # Install pkg-config files
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/cairo.pc
          DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
endif()

# Create an export file that CMake users can include() to import our targets.
if(NOT SKIP_INSTALL_EXPORT AND NOT SKIP_INSTALL_ALL)
  install(EXPORT libcairo DESTINATION lib/libcairo FILE libcairo.cmake)
endif()

