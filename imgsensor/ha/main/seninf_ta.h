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

#ifndef __SENINF_TA_H__
#define __SENINF_TA_H__

typedef enum {
	SENINF_RETURN_SUCCESS = 0,
	SENINF_RETURN_ERROR = -1,
	SENINF_RETURN_ERROR_MAPPING_FAIL = -2,
} SENINF_RETURN;

typedef enum {
    SENINF_TEE_CMD_SYNC_TO_PA = 0x10,
    SENINF_TEE_CMD_SYNC_TO_VA,
    SENINF_TEE_CMD_CHECKPIPE,
    SENINF_TEE_CMD_FREE,
} SENINF_TEE_CMD;

typedef enum {
    SENINF_TA_DRV_SYNC_TO_PA = 0x10,
    SENINF_TA_DRV_SYNC_TO_VA,
    SENINF_TA_DRV_CHECKPIPE,
    SENINF_TA_DRV_FREE,
} SENINF_TA_DRV_CMD;

#endif

