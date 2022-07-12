PROJ_NAME    := arduino-core
PROJ_TYPE    := lib
PROJ_VERSION := 1.8.5

HOST ?= arduino-avr-uno

INCLUDE_DIRS += cores variants/$(ARDUINO_VARIANT)
SRC_DIRS += cores/arduino
SRC_DIRS += libraries

CORE_HEADERS += $(shell find cores/arduino -type f -name *.h -and -not -name *_private.h)
CORE_HEADERS += variants/$(ARDUINO_VARIANT)/pins_arduino.h

EXTRA_DIST_FILES += $(foreach coreHeader,$(CORE_HEADERS),$(coreHeader):include/$(notdir $(coreHeader)))

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

EXTRA_DIST_FILES += $(foreach libHeader,$(LIB_HEADERS),$(libHeader):include/$(notdir $(libHeader)))

include builder/arduino-builder/layers.mk
include builder/cpp-project-builder/builder.mk
