# Override NDK_PROJECT_PATH to enable using ndk-build whilst removing
# jni folder from tree. Importing a module requires the Android.mk to be
# in the top folder.

MODULE_NAME=libexif
NDK_PROJECT_PATH = null
NDK_OUT = ./obj
NDK_LIBS_OUT = ./lib
NDK_APPLICATION_MK = ./Application.mk
include $(ANDROID_NDK)/build/core/build-local.mk

