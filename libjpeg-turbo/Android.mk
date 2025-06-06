LOCAL_PATH := $(abspath $(call my-dir))
include $(CLEAR_VARS)

LOCAL_MODULE := libjpeg-turbo

SOURCE_PATH := $(LOCAL_PATH)

ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard x86),)
LOCAL_ARM_NEON := true
LOCAL_CFLAGS += -D__ARM_HAVE_NEON
endif

LOCAL_ASMFLAGS += -DELF

ifeq ($(TARGET_ARCH_ABI),x86_64)
LOCAL_SRC_FILES += \
	$(SOURCE_PATH)/simd/x86_64/jsimd.c \
	$(SOURCE_PATH)/simd/x86_64/jfdctflt-sse.asm \
	$(SOURCE_PATH)/simd/x86_64/jfdctfst-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jfdctint-avx2.asm \
	$(SOURCE_PATH)/simd/x86_64/jfdctint-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jidctflt-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jidctfst-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jidctint-avx2.asm \
	$(SOURCE_PATH)/simd/x86_64/jidctint-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jidctred-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jccolor-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jccolor-avx2.asm \
	$(SOURCE_PATH)/simd/x86_64/jcgray-avx2.asm \
	$(SOURCE_PATH)/simd/x86_64/jcgray-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jcsample-avx2.asm \
	$(SOURCE_PATH)/simd/x86_64/jcsample-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jdcolor-avx2.asm \
	$(SOURCE_PATH)/simd/x86_64/jdcolor-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jdmerge-avx2.asm \
	$(SOURCE_PATH)/simd/x86_64/jdmerge-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jdsample-avx2.asm \
	$(SOURCE_PATH)/simd/x86_64/jdsample-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jquantf-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jquanti-avx2.asm \
	$(SOURCE_PATH)/simd/x86_64/jquanti-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jsimdcpu.asm \
	$(SOURCE_PATH)/simd/x86_64/jchuff-sse2.asm \
	$(SOURCE_PATH)/simd/x86_64/jcphuff-sse2.asm \


LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=8 \

LOCAL_ASMFLAGS += -D__x86_64__

else ifeq ($(TARGET_ARCH_ABI),x86)
LOCAL_SRC_FILES += \
	$(SOURCE_PATH)/simd/i386/jsimd.c \
	$(SOURCE_PATH)/simd/i386/jsimdcpu.asm \
	$(SOURCE_PATH)/simd/i386/jccolor-avx2.asm \
	$(SOURCE_PATH)/simd/i386/jccolor-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jccolor-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jcgray-avx2.asm \
	$(SOURCE_PATH)/simd/i386/jcgray-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jcgray-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jchuff-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jcphuff-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jcsample-avx2.asm \
	$(SOURCE_PATH)/simd/i386/jcsample-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jcsample-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jdcolor-avx2.asm \
	$(SOURCE_PATH)/simd/i386/jdcolor-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jdcolor-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jdmerge-avx2.asm \
	$(SOURCE_PATH)/simd/i386/jdmerge-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jdmerge-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jdsample-avx2.asm \
	$(SOURCE_PATH)/simd/i386/jdsample-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jdsample-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jfdctflt-3dn.asm \
	$(SOURCE_PATH)/simd/i386/jfdctflt-sse.asm \
	$(SOURCE_PATH)/simd/i386/jfdctfst-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jfdctfst-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jfdctint-avx2.asm \
	$(SOURCE_PATH)/simd/i386/jfdctint-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jfdctint-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jidctflt-3dn.asm \
	$(SOURCE_PATH)/simd/i386/jidctflt-sse.asm \
	$(SOURCE_PATH)/simd/i386/jidctflt-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jidctfst-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jidctfst-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jidctint-avx2.asm \
	$(SOURCE_PATH)/simd/i386/jidctint-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jidctint-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jidctred-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jidctred-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jquant-3dn.asm \
	$(SOURCE_PATH)/simd/i386/jquant-mmx.asm \
	$(SOURCE_PATH)/simd/i386/jquant-sse.asm \
	$(SOURCE_PATH)/simd/i386/jquantf-sse2.asm \
	$(SOURCE_PATH)/simd/i386/jquanti-avx2.asm \
	$(SOURCE_PATH)/simd/i386/jquanti-sse2.asm \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=4 \

LOCAL_ASMFLAGS += -DPIC

else ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard),)
LOCAL_SRC_FILES += \
	$(SOURCE_PATH)/simd/arm/jsimd.c \
	$(SOURCE_PATH)/simd/arm/jsimd_neon.S \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=4 \

else ifeq ($(TARGET_ARCH_ABI),armeabi)
LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=4 \

else ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
LOCAL_SRC_FILES += \
	$(SOURCE_PATH)/simd/arm64/jsimd.c \
	$(SOURCE_PATH)/simd/arm64/jsimd_neon.S \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=8 \

endif

# libjpeg_la_SOURCES from Makefile.am
LOCAL_SRC_FILES += \
	$(SOURCE_PATH)/jcapimin.c \
	$(SOURCE_PATH)/jcapistd.c \
	$(SOURCE_PATH)/jccoefct.c \
	$(SOURCE_PATH)/jccolor.c \
	$(SOURCE_PATH)/jcdctmgr.c \
	$(SOURCE_PATH)/jchuff.c \
	$(SOURCE_PATH)/jcinit.c \
	$(SOURCE_PATH)/jcmainct.c \
	$(SOURCE_PATH)/jcmarker.c \
	$(SOURCE_PATH)/jcmaster.c \
	$(SOURCE_PATH)/jcomapi.c \
	$(SOURCE_PATH)/jcparam.c \
	$(SOURCE_PATH)/jcphuff.c \
	$(SOURCE_PATH)/jcprepct.c \
	$(SOURCE_PATH)/jcsample.c \
	$(SOURCE_PATH)/jctrans.c \
	$(SOURCE_PATH)/jdapimin.c \
	$(SOURCE_PATH)/jdapistd.c \
	$(SOURCE_PATH)/jdatadst.c \
	$(SOURCE_PATH)/jdatasrc.c \
	$(SOURCE_PATH)/jdcoefct.c \
	$(SOURCE_PATH)/jdcolor.c \
	$(SOURCE_PATH)/jddctmgr.c \
	$(SOURCE_PATH)/jdhuff.c \
	$(SOURCE_PATH)/jdinput.c \
	$(SOURCE_PATH)/jdmainct.c \
	$(SOURCE_PATH)/jdmarker.c \
	$(SOURCE_PATH)/jdmaster.c \
	$(SOURCE_PATH)/jdmerge.c \
	$(SOURCE_PATH)/jdphuff.c \
	$(SOURCE_PATH)/jdpostct.c \
	$(SOURCE_PATH)/jdsample.c \
	$(SOURCE_PATH)/jdtrans.c \
	$(SOURCE_PATH)/jerror.c \
	$(SOURCE_PATH)/jfdctflt.c \
	$(SOURCE_PATH)/jfdctfst.c \
	$(SOURCE_PATH)/jfdctint.c \
	$(SOURCE_PATH)/jidctflt.c \
	$(SOURCE_PATH)/jidctfst.c \
	$(SOURCE_PATH)/jidctint.c \
	$(SOURCE_PATH)/jidctred.c \
	$(SOURCE_PATH)/jquant1.c \
	$(SOURCE_PATH)/jquant2.c \
	$(SOURCE_PATH)/jutils.c \
	$(SOURCE_PATH)/jmemmgr.c \
	$(SOURCE_PATH)/jmemnobs.c \

# if WITH_ARITH_ENC from Makefile.am
LOCAL_SRC_FILES += \
	$(SOURCE_PATH)/jaricom.c \
	$(SOURCE_PATH)/jcarith.c \
	$(SOURCE_PATH)/jdarith.c \

# libturbojpeg_la_SOURCES from Makefile.am
LOCAL_SRC_FILES += \
	$(SOURCE_PATH)/turbojpeg.c \
	$(SOURCE_PATH)/transupp.c \
	$(SOURCE_PATH)/jdatadst-tj.c \
	$(SOURCE_PATH)/jdatasrc-tj.c \
        $(SOURCE_PATH)/rdbmp.c \
        $(SOURCE_PATH)/rdppm.c \

LOCAL_C_INCLUDES += \
        $(SOURCE_PATH)/simd \
	$(SOURCE_PATH)/simd/nasm \
	$(SOURCE_PATH)/simd/loongson \
	$(SOURCE_PATH)/simd/mips \
	$(SOURCE_PATH)/simd/powerpc \
	$(SOURCE_PATH) \

LOCAL_EXPORT_C_INCLUDES := \
	$(SOURCE_PATH) \

include $(BUILD_STATIC_LIBRARY)
