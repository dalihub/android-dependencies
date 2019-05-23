LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS :=

LOCAL_MODULE    := libexif

LOCAL_SRC_FILES :=\
	libexif/exif-entry.c \
	libexif/exif-data.c \
	libexif/exif-ifd.c \
	libexif/exif-tag.c \
	libexif/fuji/mnote-fuji-tag.c \
	libexif/fuji/exif-mnote-data-fuji.c \
	libexif/fuji/mnote-fuji-entry.c \
	libexif/canon/mnote-canon-tag.c \
	libexif/canon/exif-mnote-data-canon.c \
	libexif/canon/mnote-canon-entry.c \
	libexif/exif-loader.c \
	libexif/exif-byte-order.c \
	libexif/exif-log.c \
	libexif/exif-mem.c \
	libexif/exif-content.c \
	libexif/olympus/exif-mnote-data-olympus.c \
	libexif/olympus/mnote-olympus-tag.c \
	libexif/olympus/mnote-olympus-entry.c \
	libexif/exif-format.c \
	libexif/exif-mnote-data.c \
	libexif/pentax/mnote-pentax-tag.c \
	libexif/pentax/mnote-pentax-entry.c \
	libexif/pentax/exif-mnote-data-pentax.c \
	libexif/exif-utils.c

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/.

LOCAL_CFLAGS += -I$(LOCAL_PATH)/.

include $(BUILD_STATIC_LIBRARY)
