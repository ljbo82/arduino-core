/*
   Copyright (c) 2015, Arduino LLC
   Original code (pre-library): Copyright (c) 2011, Peter Barrett

   Permission to use, copy, modify, and/or distribute this software for
   any purpose with or without fee is hereby granted, provided that the
   above copyright notice and this permission notice appear in all copies.

   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR
   BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES
   OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
   SOFTWARE.
 */

#include "PluggableUSB.h"
#include "HID.h"

#if defined(USBCON)

HID_ HID;

int HID_::getInterface(uint8_t* interfaceNum)
{
	*interfaceNum += 1; // uses 1
	HIDDescriptor hidInterface = {
		D_INTERFACE(interface(), 1, 3, 0, 0),
		D_HIDREPORT(descriptorSize),
		D_ENDPOINT(USB_ENDPOINT_IN(endpoint()), USB_ENDPOINT_TYPE_INTERRUPT, USB_EP_SIZE, 0x01)
	};
	return USB_SendControl(0, &hidInterface, sizeof(hidInterface));
}

int HID_::getDescriptor(int8_t type)
{
	if (HID_REPORT_DESCRIPTOR_TYPE == type) {
		int total = 0;
		HIDDescriptorListNode* node;
		for (node = rootNode; node; node = node->next) {
			int res = USB_SendControl(TRANSFER_PGM, node->data, node->length);
			if (res == -1)
				return -1;
			total += res;
		}
		return total;
	}

	// Ignored
	return 0;
}

void HID_::AppendDescriptor(HIDDescriptorListNode *node)
{
	if (!rootNode) {
		rootNode = node;
	} else {
		HIDDescriptorListNode *current = rootNode;
		while (current->next) {
			current = current->next;
		}
		current->next = node;
	}
	descriptorSize += node->length;
}

void HID_::SendReport(uint8_t id, const void* data, int len)
{
	USB_Send(endpoint(), &id, 1);
	USB_Send(endpoint() | TRANSFER_RELEASE, data, len);
}

bool HID_::setup(USBSetup& setup, uint8_t interfaceNum)
{
	if (interface() != interfaceNum) {
		return false;
	}

	uint8_t request = setup.bRequest;
	uint8_t requestType = setup.bmRequestType;

	if (requestType == REQUEST_DEVICETOHOST_CLASS_INTERFACE)
	{
		if (request == HID_GET_REPORT) {
			// TODO: HID_GetReport();
			return true;
		}
		if (request == HID_GET_PROTOCOL) {
			// TODO: Send8(protocol);
			return true;
		}
	}

	if (requestType == REQUEST_HOSTTODEVICE_CLASS_INTERFACE)
	{
		if (request == HID_SET_PROTOCOL) {
			protocol = setup.wValueL;
			return true;
		}
		if (request == HID_SET_IDLE) {
			idle = setup.wValueL;
			return true;
		}
	}

	return false;
}

HID_::HID_(void) : PUSBListNode(1, 1, epType),
                   rootNode(NULL), descriptorSize(0),
                   protocol(1), idle(1)
{
	epType[0] = EP_TYPE_INTERRUPT_IN;
	PluggableUSB.plug(this);
}

int HID_::begin(void)
{
	return 0;
}

#endif /* if defined(USBCON) */
