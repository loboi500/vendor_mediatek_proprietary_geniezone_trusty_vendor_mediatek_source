/*
 * Copyright (C) 2014-2015 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <err.h>
#include <list.h>
#include <assert.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <trusty_std.h>

#define LOG_TAG "MTEE_SENINF"

#include <app/sc_ex/common.h>
#include <app/sc_ex/uuids.h>

#include "mtee_server.h"

//#include <mtee_mem_srv.h>
//#include <tz_private/ta_sys_mem.h>
#include <tz_private/log.h>
#include <tz_cross/ta_mem.h>

#include "seninf_ta.h"
#include "seninf_auth.h"
#include "seninf_dapc.h"
#include "seninf_sec_drv.h"

//#include <tz_cross/ta_system.h>
//#include <tz_cross/ta_DL.h> //for dynamic loading

//#include <tz_private/profile.h>

//#include <lib/mtee/mtee_sys.h>

#define SENINF_LOGE DBG_LOG


#define IPC_PORT_ALLOW_ALL  (  IPC_PORT_ALLOW_NS_CONNECT | \
                IPC_PORT_ALLOW_TA_CONNECT )

#define SRV_NAME(name)   SRV_PATH_BASE ".srv." name

// init handler
static int imgsensor_ha_init (tipc_srv_t *srv)
{
    SENINF_LOGE("[%s] <%s> secure camera service init\n", __func__, srv->name);
    return 0;
}

static int imgsensor_ha_disconnect (uint32_t chan, tipc_srv_t *srv)
{
    if (seninf_dapc_unlock()) {
        SENINF_LOGE("[%s] unlock error!\n", __func__);
    }

    SENINF_LOGE("[%s] <%s> secure camera disconnected (channel = %d)\n", __func__, srv->name, chan);
    return 0;
}




/************************************************************************/
/*
/* Services
/*
/************************************************************************/

static SENINF_RETURN seninf_sync_to_va(void *preg)
{
    SENINF_LOGE("[%s] +\n", __func__);
    SENINF_RETURN ret = SENINF_RETURN_SUCCESS;

    ret = seninf_ta_drv_sync_to_va(preg);


    SENINF_LOGE("[%s] ret = %d\n", __func__, ret);

    return ret;
}


static SENINF_RETURN seninf_checkpipe()
{
    SENINF_LOGE("[%s] +\n", __func__);

    SENINF_TEE_REG preg_va = {0};

    SENINF_RETURN ret = seninf_sync_to_va(&preg_va);

    if(ret != SENINF_RETURN_SUCCESS) {
        SENINF_LOGE("[%s] seninf_sync_to_va error! status = %d\n", __func__, ret);
        return SENINF_RETURN_ERROR;
    }

    /*check authority by va*/
    ret = seninf_auth(&preg_va);

    ret |= seninf_ta_drv_checkpipe(ret);

    SENINF_LOGE("[%s] -\n", __func__);

    return SENINF_RETURN_SUCCESS;
}

static SENINF_RETURN seninf_free()
{
    SENINF_LOGE("[%s]+ , close secure seninf_mux first!\n", __func__);

    SENINF_RETURN ret = SENINF_RETURN_SUCCESS;


    ret |= seninf_ta_drv_free(NULL);


    /*unlock after seninf_mux_en = 0*/
    ret |= seninf_dapc_unlock();

    SENINF_LOGE("[%s]- , unlocked seninf devapc.\n", __func__);

    return ret;
}


// system service
static int imgsensor_ha_handler (int session, int command, uint32_t paramTypes, MTEEC_PARAM *param)
{
    SENINF_RETURN ret = 0;

    SENINF_LOGE("[%s] session=0x%x, command=0x%x, paramTypes=0x%x\n", __func__, session, command, paramTypes);

    switch (command) {
        case SENINF_TEE_CMD_CHECKPIPE:
            ret = seninf_checkpipe();
            break;
        case SENINF_TEE_CMD_FREE:
            ret = seninf_free();
            break;

        default:
            SENINF_LOGE("[%s]WARN: unknown sCamera service cmd\n", __func__);
            return TZ_RESULT_ERROR_GENERIC;
    }
    param[0].value.a = ret;

    return TZ_RESULT_SUCCESS;
}






/************************************************************************/
/*
/* Server Main
/*
/************************************************************************/
// services register table
static const struct tipc_srv _services[] =
{
    /* sCamera example */
    {
        .name = SRV_NAME("imgsensor"),
        .msg_num = 8,
        .msg_size = MAX_PORT_BUF_SIZE,
        .port_flags = IPC_PORT_ALLOW_ALL,
        .init_handler = imgsensor_ha_init,
        .disc_handler = imgsensor_ha_disconnect,
        .service_handler = imgsensor_ha_handler
    }
};



// IPC message buffer
static uint8_t scamera_msg_buf[MAX_PORT_BUF_SIZE];

// service states
static struct tipc_srv_state _srv_states[countof(_services)] = {
    [0 ... (countof(_services) - 1)] = {
        .port = INVALID_IPC_HANDLE,
    },
};

static bool stopped = false;

// Main
int main(void)
{
    int rc;
    uevent_t event;

    SENINF_LOGE("[%s] start imgsensor service main\n", __func__);

    /* Initialize service */
    rc = init_services(_services, countof(_services), _srv_states);
    if (rc != NO_ERROR ) {
        SENINF_LOGE("[%s]Failed (%d) to init service", __func__, rc);
        kill_services(&_services, countof(_services), _srv_states);
        return -1;
    }

    /* handle events */
    while (!stopped) {
        event.handle = INVALID_IPC_HANDLE;
        event.event  = 0;
        event.cookie = NULL;
        rc = wait_any(&event, -1);
        if (rc < 0) {
            SENINF_LOGE("[%s] wait_any failed (%d)", __func__, rc);
            continue;
        }
        if (rc == NO_ERROR) { /* got an event */
            dispatch_event(&event, scamera_msg_buf, sizeof (scamera_msg_buf));
        }
    }

    kill_services(_services, countof(_services), _srv_states);
    return 0;
}

