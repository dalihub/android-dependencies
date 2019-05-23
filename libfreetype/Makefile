#
# FreeType 2 build system -- top-level Makefile
#


# Copyright (C) 1996-2019 by
# David Turner, Robert Wilhelm, and Werner Lemberg.
#
# This file is part of the FreeType project, and may only be used, modified,
# and distributed under the terms of the FreeType project license,
# LICENSE.TXT.  By continuing to use, modify, or distribute this file you
# indicate that you have read the license and understand and accept it
# fully.


# Project names
#
PROJECT       := freetype
PROJECT_TITLE := FreeType

# The variable TOP_DIR holds the path to the topmost directory in the project
# engine source hierarchy.  If it is not defined, default it to `.'.
#
TOP_DIR ?= .

MODULE_NAME=libfreetype
NDK_PROJECT_PATH = null
NDK_OUT = ./obj
NDK_LIBS_OUT = ./lib
NDK_APPLICATION_MK = ./Application.mk
include $(ANDROID_NDK)/build/core/build-local.mk

# EOF
