PROJ_NAME    := arduino-core
PROJ_TYPE    := lib
PROJ_VERSION := 1.8.6

HOST ?= arduino-avr-uno

INCLUDE_DIRS += cores variants/$(ARDUINO_VARIANT)
SRC_DIRS += cores/arduino
SRC_DIRS += libraries

CORE_HEADERS += $(shell find cores/arduino -type f -name *.h -and -not -name *_private.h)
CORE_HEADERS += variants/$(ARDUINO_VARIANT)/pins_arduino.h

DIST_FILES += $(foreach coreHeader,$(CORE_HEADERS),$(coreHeader):include/$(notdir $(coreHeader)))

LIB_HEADERS += libraries/EEPROM/src/EEPROM.h
INCLUDE_DIRS += libraries/EEPROM/src

LIB_HEADERS += libraries/HID/src/HID.h
INCLUDE_DIRS += libraries/HID/src

LIB_HEADERS += libraries/SoftwareSerial/src/SoftwareSerial.h
INCLUDE_DIRS += libraries/SoftwareSerial/src

LIB_HEADERS += libraries/SPI/src/SPI.h
INCLUDE_DIRS += libraries/SPI/src

LIB_HEADERS += libraries/Wire/src/Wire.h
INCLUDE_DIRS += libraries/Wire/src

DIST_FILES += $(foreach libHeader,$(LIB_HEADERS),$(libHeader):include/$(notdir $(libHeader)))

ARDUINO_BUILDER     ?= make/arduino-builder
CPP_PROJECT_BUILDER ?= make/cpp-project-builder-core

include $(ARDUINO_BUILDER)/layers.mk
include $(CPP_PROJECT_BUILDER)/builder.mk
