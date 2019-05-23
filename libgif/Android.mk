LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS :=

LOCAL_MODULE    := libgif
LOCAL_SRC_FILES :=\
	gif2rgb.c \
	openbsd-reallocarray.c \
	gif_font.c \
	giftool.c \
	getarg.c \
	gifecho.c \
	egif_lib.c \
	giftext.c \
	gif_hash.c \
	giffilter.c \
	gifinto.c \
	qprintf.c \
	gifcolor.c \
	quantize.c \
	gifwedge.c \
	gifalloc.c \
	gifhisto.c \
	giffix.c \
	dgif_lib.c \
	gif_err.c \
	gifsponge.c \
	gifbg.c \
	gifbuild.c \
	gifclrmp.c

VERSION:=$(shell ./getversion)
LIBMAJOR=7
LIBMINOR=1
LIBPOINT=0
LIBVER=$(LIBMAJOR).$(LIBMINOR).$(LIBPOINT)

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/.
LOCAL_CFLAGS += -I$(SRC_PATH)/.

#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)
