ARDUINO_BUILDER ?= ../../arduino-builder
ifeq ($(ARDUINO_BUILDER),)
    $(error [ARDUINO_BUILDER] Missing value)
endif

PROJ_NAME := blink
PROJ_TYPE := app

SRC_DIRS += .

INCLUDE_DIRS += $(O_DIST_DIR)/include
LDFLAGS      += -L$(O_DIST_DIR)/lib -larduino-core1

# Forces build of mylib before application build
PRE_BUILD_DEPS += arduino-core

# Library source directory
ARDUINO_CORE_DIR ?= ../..

# ==============================================================================
.PHONY: arduino-core
arduino-core:
    # NOTE: Uses a custom BUILD_DIR in order to isolate library object files from application ones.
	$(O_VERBOSE)$(MAKE) -C $(ARDUINO_CORE_DIR) BUILD_DIR=build/lib/arduino-core O=$(shell realpath -m --relative-to=$(ARDUINO_CORE_DIR) $(O))
# ==============================================================================

include $(ARDUINO_BUILDER)/builder.mk