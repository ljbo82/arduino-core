PROJ_NAME := blink
PROJ_TYPE := app

SRC_DIRS += .
HOST ?= arduino-avr-uno

LIBS += arduino-core1:../..

ARDUINO_BUILDER          ?= ../../make/arduino-builder
CPP_PROJECT_BUILDER_CORE ?= ../../make/cpp-project-builder-core

include $(ARDUINO_BUILDER)/layers.mk
include $(CPP_PROJECT_BUILDER_CORE)/builder.mk
