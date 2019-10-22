cmake_minimum_required(VERSION 3.4.1)

find_package(ZLIB REQUIRED)

string(REGEX MATCH "^(.+/)" dummy ${ZLIB_LIBRARIES})
set(ZLIB_LIBRARIES_DIR ${CMAKE_MATCH_1})
string(REGEX MATCH "(.+)/$" dummy ${ZLIB_LIBRARIES_DIR})
set(ZLIB_LIBRARIES_DIR ${CMAKE_MATCH_1})

file(READ ${PROJECT_SOURCE_DIR}/zlib_pc.in ZLIB_PC_IN)

string(REPLACE ";" ", " PKG_CONFIG_REQUIRED_PRIVATE "${PKG_CONFIG_REQUIRED_PRIVATE}")

string(REPLACE "%prefix%" ${ZLIB_LIBRARIES_DIR}
       ZLIB_PC_IN ${ZLIB_PC_IN})
string(REPLACE "%exec_prefix%" ${ZLIB_LIBRARIES_DIR}
       ZLIB_PC_IN ${ZLIB_PC_IN})
string(REPLACE "%libdir%" ${ZLIB_LIBRARIES_DIR}
       ZLIB_PC_IN ${ZLIB_PC_IN})
string(REPLACE "%includedir%" ${ZLIB_INCLUDE_DIRS}
       ZLIB_PC_IN ${ZLIB_PC_IN})
string(REPLACE "%version%" ${ZLIB_VERSION_STRING}
       ZLIB_PC_IN ${ZLIB_PC_IN})
string(REPLACE "%REQUIRES_PRIVATE%" "${PKG_CONFIG_REQUIRED_PRIVATE}"
       ZLIB_PC_IN ${ZLIB_PC_IN})
string(REPLACE "%LIBS_PRIVATE%" ""  # All libs support pkg-config
       ZLIB_PC_IN ${ZLIB_PC_IN})

file(WRITE ${PROJECT_BINARY_DIR}/zlib.pc ${ZLIB_PC_IN})

install(
    FILES ${PROJECT_BINARY_DIR}/zlib.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
    COMPONENT pkgconfig)
