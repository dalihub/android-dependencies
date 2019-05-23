LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS :=
LOCAL_CFLAGS += \
        -DVERSION="2.2.6" \
        -DSOVERSION="2" \
        -DXML_CONTEXT_BYTES=1024 \
        -DXML_DTD=1 \
        -DXML_NS=1 \
        -DXML_POOR_ENTROPY=1 \
        -DXML_ENABLE_VISIBILITY=1 \
        -DXML_BUILDING_EXPAT=1 \

LOCAL_MODULE    := libexpat
LOCAL_SRC_FILES :=\
         expat/lib/loadlibrary.c \
         expat/lib/xmlparse.c \
         expat/lib/xmlrole.c \
         expat/lib/xmltok.c \
         expat/lib/xmltok_impl.c \
         expat/lib/xmltok_ns.c

LOCAL_C_INCLUDES += \
         $(LOCAL_PATH)/expat/lib \

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/expat/lib

#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)
