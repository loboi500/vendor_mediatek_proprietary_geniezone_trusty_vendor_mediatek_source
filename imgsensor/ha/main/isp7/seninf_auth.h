/*
 * Copyright (C) 2018 MediaTek Inc.
 * All rights reserved
 *
 * The present software is the confidential and proprietary information of
 * Mediatek Inc. You shall not disclose the present software and shall
 * use it only in accordance with the terms of the license agreement you
 * entered into with MediaTek Inc. This software may be subject to
 * export or import laws in certain countries.
 */

#ifndef __SENINF_AUTH_H__
#define __SENINF_AUTH_H__
#include "seninf_tee_reg.h"

#include <tz_private/log.h>
#include <tz_private/sys_ipc.h>
#include <tz_private/ta_sys_mem.h>
#include "tz_private/sys_mem.h"
#include <tz_cross/ta_mem.h>

SENINF_RETURN seninf_auth(SENINF_TEE_REG *preg,uint32_t chunk_hsfhandle);


typedef struct {
        uint32_t SecTG;
        uint32_t Sec_status;
} SecMgr_CamInfo;

#endif

