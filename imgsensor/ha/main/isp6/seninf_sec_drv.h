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

#ifndef __SENINF_SEC_DRV_H__
#define __SENINF_SEC_DRV_H__

#include "seninf_ta.h"

typedef enum {
    SENINF_DRV_RETURN_SUCCESS,
    SENINF_DRV_RETURN_ERROR,
    SENINF_DRV_RETURN_MAP_USER_ERROR,
    SENINF_DRV_RETURN_MAP_REGION_ERROR
} SENINF_DRV_RETURN;

extern SENINF_RETURN seninf_drv_sync_to_pa(void* args);
extern SENINF_RETURN seninf_ta_drv_sync_to_va(void* args) ;
extern SENINF_RETURN seninf_ta_drv_free(void* args);
extern SENINF_RETURN seninf_ta_drv_checkpipe(SENINF_RETURN auth_reuslt);
#endif