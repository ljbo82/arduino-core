PROJ_NAME := blink
PROJ_TYPE := app

SRC_DIRS += .
HOST ?= arduino-avr-uno

O ?= output
INCLUDE_DIRS += $(O)/libs/dist/include
LDFLAGS      += -L$(O)/libs/dist/lib

# arduino-core-avr dependency --------------------------------------------------
ARDUINO_CORE_DIR := ../..
PRE_BUILD_DEPS += $(O)/libs/arduino-core.marker
LDFLAGS        += -larduino-core1

--arduino-core:
	$(O_VERBOSE)$(MAKE) -C $(ARDUINO_CORE_DIR) O=$(call FN_REL_DIR,$(ARDUINO_CORE_DIR),$(O)/libs) BUILD_SUBDIR=arduino-core DIST_MARKER=arduino-core.marker

$(O)/libs/arduino-core.marker: --arduino-core ;
# ------------------------------------------------------------------------------

ARDUINO_BUILDER          ?= ../../make/arduino-builder
CPP_PROJECT_BUILDER_CORE ?= ../../make/cpp-project-builder-core

include $(ARDUINO_BUILDER)/layers.mk
include $(CPP_PROJECT_BUILDER_CORE)/builder.mk
