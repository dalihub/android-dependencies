LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS :=
LOCAL_CFLAGS += \
        -DFONTCONFIG_PATH=\"/data/data/com.sec.dali_demo/files/fonts/\" \
        -DFC_DEFAULT_FONTS=\"/data/data/com.sec.dali_demo/files/fonts/\" \

LOCAL_MODULE    := libfontconfig
LOCAL_SRC_FILES :=\
        src/fcatomic.c \
        src/fcblanks.c \
        src/fccache.c \
        src/fccfg.c \
        src/fccharset.c \
        src/fcdbg.c \
        src/fcdefault.c \
        src/fcdir.c \
        src/fcfreetype.c \
        src/fcfs.c \
        src/fcinit.c \
        src/fclang.c \
        src/fclist.c \
        src/fcmatch.c \
        src/fcmatrix.c \
        src/fcname.c \
        src/fcpat.c \
        src/fcstr.c \
        src/fcxml.c \

LOCAL_CFLAGS += \
        -DVERSION="2.2.6" \
        -DSOVERSION="2" \
        -DXML_CONTEXT_BYTES=1024 \
        -DXML_DTD=1 \
        -DXML_NS=1 \
        -DXML_POOR_ENTROPY=1 \
        -DXML_ENABLE_VISIBILITY=1 \
        -DXML_BUILDING_EXPAT=1 \

LOCAL_SRC_FILES +=\
        ../libexpat/expat/lib/loadlibrary.c \
        ../libexpat/expat/lib/xmlparse.c \
        ../libexpat/expat/lib/xmlrole.c \
        ../libexpat/expat/lib/xmltok.c \
        ../libexpat/expat/lib/xmltok_impl.c \
        ../libexpat/expat/lib/xmltok_ns.c \

LOCAL_C_INCLUDES += \
        $(LOCAL_PATH)/src \
        $(LOCAL_PATH)/. \

LOCAL_CFLAGS += -I$(LOCAL_PATH)/.
LOCAL_CFLAGS += -I$(LOCAL_PATH)/../libfreetype/include
LOCAL_CFLAGS += -I$(LOCAL_PATH)/../libfreetype/include/freetype
LOCAL_CFLAGS += -I$(LOCAL_PATH)/../libfreetype/include/freetype/config
LOCAL_CFLAGS += -I$(LOCAL_PATH)/../libexpat/expat/lib

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/.

#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)
