/*
 * Copyright (c) 2019 MediaTek Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files
 * (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#ifndef __SECURE_PORT_H__
#define __SECURE_PORT_H__


#define Secure_csi_port CUSTOM_CFG_CSI_PORT_0

typedef enum {
    CUSTOM_CFG_CSI_PORT_0 = 0x0,// 4D1C
    CUSTOM_CFG_CSI_PORT_1,		 // 4D1C
    CUSTOM_CFG_CSI_PORT_2,		 // 4D1C
    CUSTOM_CFG_CSI_PORT_3,		 // 4D1C
    CUSTOM_CFG_CSI_PORT_0A, 	 // 2D1C or 2Trio
    CUSTOM_CFG_CSI_PORT_0B, 	 // 2D1C or 2Trio
    CUSTOM_CFG_CSI_PORT_1A, 	 // 2D1C or 2Trio
    CUSTOM_CFG_CSI_PORT_1B, 	 // 2D1C or 2Trio
    CUSTOM_CFG_CSI_PORT_2A,
    CUSTOM_CFG_CSI_PORT_2B,
    CUSTOM_CFG_CSI_PORT_3A,
    CUSTOM_CFG_CSI_PORT_3B,
    CUSTOM_CFG_CSI_PORT_MAX_NUM,
    CUSTOM_CFG_CSI_PORT_NONE     //for non-MIPI sensor
} CUSTOM_CFG_CSI_PORT;

#endif
