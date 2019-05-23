LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS :=

LOCAL_MODULE    := libpng
LOCAL_SRC_FILES :=\
	png.c \
	pngerror.c \
	pngget.c \
	pngmem.c \
	pngpread.c \
	pngread.c \
	pngrio.c \
	pngrtran.c \
	pngrutil.c \
	pngset.c \
	pngtest.c \
	pngtrans.c \
	pngwio.c \
	pngwrite.c \
	pngwtran.c \
	pngwutil.c \
	arm/arm_init.c \
	arm/filter_neon.S \
	arm/filter_neon_intrinsics.c \
        arm/palette_neon_intrinsics.c \

LOCAL_CFLAGS += \
        -DVERSION="1.6.36" \
        -DPNGLIB_MAJOR="1" \
        -DPNGLIB_MINOR="6" \
        -DPNGLIB_RELEASE="36" \
        -DPNGLIB_VERSION="1.6.36" \

LOCAL_C_INCLUDES += \
        $(LOCAL_PATH)/. \

LOCAL_EXPORT_LDLIBS := -lz

LOCAL_CFLAGS += -I$(LOCAL_PATH)/.

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/.

#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)
