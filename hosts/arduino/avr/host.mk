# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>

coreDir := hosts/arduino/avr/lib

SRC_DIRS += $(coreDir)/cores/arduino
SRC_DIRS += $(coreDir)/libraries

INCLUDE_DIRS += $(coreDir)/variants/$(ARDUINO_VARIANT)

CORE_HEADERS += $(shell find $(coreDir)/cores/arduino -type f -name *.h -and -not -name *_private.h)
CORE_HEADERS += $(coreDir)/variants/$(ARDUINO_VARIANT)/pins_arduino.h
DIST_FILES += $(foreach coreHeader,$(CORE_HEADERS),$(coreHeader):include/$(notdir $(coreHeader)))

LIB_HEADERS += $(coreDir)/libraries/EEPROM/src/EEPROM.h
INCLUDE_DIRS += $(coreDir)/libraries/EEPROM/src

LIB_HEADERS += $(coreDir)/libraries/HID/src/HID.h
INCLUDE_DIRS += $(coreDir)/libraries/HID/src

LIB_HEADERS += $(coreDir)/libraries/SoftwareSerial/src/SoftwareSerial.h
INCLUDE_DIRS += $(coreDir)/libraries/SoftwareSerial/src

LIB_HEADERS += $(coreDir)/libraries/SPI/src/SPI.h
INCLUDE_DIRS += $(coreDir)/libraries/SPI/src

LIB_HEADERS += $(coreDir)/libraries/Wire/src/Wire.h
INCLUDE_DIRS += $(coreDir)/libraries/Wire/src

DIST_FILES += $(foreach libHeader,$(LIB_HEADERS),$(libHeader):include/$(notdir $(libHeader)))
