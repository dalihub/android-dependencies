LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS    :=
LOCAL_MODULE    := libharfbuzz
include $(LOCAL_PATH)/src/Makefile.sources
include $(LOCAL_PATH)/src/hb-ucdn/Makefile.sources

LOCAL_SRC_FILES += $(HB_BASE_sources) \
        $(HB_UCDN_sources) \
        $(HB_FT_sources) \

LOCAL_SRC_FILES := $(addprefix $(LOCAL_PATH)/src/, $(LOCAL_SRC_FILES))

LIBHB_UCDN_SRC_FILES = $(LIBHB_UCDN_sources)
LIBHB_UCDN_SRC_FILES := $(addprefix $(LOCAL_PATH)/src/hb-ucdn/, $(LIBHB_UCDN_SRC_FILES))
LOCAL_SRC_FILES += $(LIBHB_UCDN_SRC_FILES)

LOCAL_CFLAGS += \
        -DHAVE_UCDN=1 \

LOCAL_C_INCLUDES += \
        $(LOCAL_PATH)/src/hb-ucdn \
        $(LOCAL_PATH)/src \
        $(LOCAL_PATH)/. \

LOCAL_CFLAGS += -I$(LOCAL_PATH)/.
LOCAL_CFLAGS += -I$(LOCAL_PATH)/../libfreetype/include
LOCAL_CFLAGS += -I$(LOCAL_PATH)/../libfreetype/include/freetype
LOCAL_CFLAGS += -I$(LOCAL_PATH)/../libfreetype/include/freetype/config

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/.

#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)
