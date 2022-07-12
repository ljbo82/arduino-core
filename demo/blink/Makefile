PROJ_NAME := blink
PROJ_TYPE := app

SRC_DIRS += .

LIB_PROJECTS += ../..:arduino-core1

HOST ?= arduino-avr-uno

ARDUINO_BUILDER     ?= ../../builder/arduino-builder
CPP_PROJECT_BUILDER ?= ../../builder/cpp-project-builder

include $(ARDUINO_BUILDER)/layers.mk
include $(CPP_PROJECT_BUILDER)/builder.mk