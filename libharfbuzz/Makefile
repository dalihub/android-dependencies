MODULE_NAME = libharfbuzz
NDK_PROJECT_PATH = null
NDK_OUT = ./obj
NDK_LIBS_OUT = ./lib
NDK_APPLICATION_MK = ./Application.mk
include $(ANDROID_NDK)/build/core/build-local.mk

all:
	mkdir -p ./harfbuzz
	(cd ./src; find . -name "*.h" | xargs cp --parents --update -t ../harfbuzz)

