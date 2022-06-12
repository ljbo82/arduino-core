#include <arduino/Arduino.h>

void setup() {
	pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
	static bool ledStatus = false;

	digitalWrite(LED_BUILTIN, ledStatus ? HIGH : LOW);
	ledStatus = !ledStatus;
	delay(1000);
}