LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS :=
LOCAL_CFLAGS += \
        -DVERSION_MAJOR="2" \
        -DVERSION_MINOR="10" \
        -DVERSION_PATCH="0" \
        -DLIBRARY_VERSION="6.16.0" \
        -DLIBRARY_SOVERSION="6" \
        -DFT2_BUILD_LIBRARY=1 \

LOCAL_MODULE    := libfreetype
LOCAL_SRC_FILES :=\
        src/autofit/autofit.c \
        src/base/ftbase.c \
        src/base/ftbbox.c \
        src/base/ftbdf.c \
        src/base/ftbitmap.c \
        src/base/ftcid.c \
        src/base/ftdebug.c \
        src/base/ftfstype.c \
        src/base/ftgasp.c \
        src/base/ftglyph.c \
        src/base/ftgxval.c \
        src/base/ftinit.c \
        src/base/ftmm.c \
        src/base/ftotval.c \
        src/base/ftpatent.c \
        src/base/ftpfr.c \
        src/base/ftstroke.c \
        src/base/ftsynth.c \
        src/base/ftsystem.c \
        src/base/fttype1.c \
        src/base/ftwinfnt.c \
        src/bdf/bdf.c \
        src/bzip2/ftbzip2.c \
        src/cache/ftcache.c \
        src/cff/cff.c \
        src/cid/type1cid.c \
        src/gzip/ftgzip.c \
        src/lzw/ftlzw.c \
        src/pcf/pcf.c \
        src/pfr/pfr.c \
        src/psaux/psaux.c \
        src/pshinter/pshinter.c \
        src/psnames/psnames.c \
        src/raster/raster.c \
        src/sfnt/sfnt.c \
        src/smooth/smooth.c \
        src/truetype/truetype.c \
        src/type1/type1.c \
        src/type42/type42.c \
        src/winfonts/winfnt.c

LOCAL_C_INCLUDES += \
  $(LOCAL_PATH)/include \
  $(LOCAL_PATH)/include/freetype \
  $(LOCAL_PATH)/include/freetype/config \
  $(LOCAL_PATH)/include/freetype/internal \
  $(LOCAL_PATH) \

#LOCAL_SHARED_LIBRARIES := -lz
#LOCAL_EXPORT_LDLIBS := -lz

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/.

#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)
