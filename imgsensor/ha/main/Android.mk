# Copyright Statement:
#
# This software/firmware and related documentation ("MediaTek Software") are
# protected under relevant copyright laws. The information contained herein
# is confidential and proprietary to MediaTek Inc. and/or its licensors.
# Without the prior written permission of MediaTek inc. and/or its licensors,
# any reproduction, modification, use or disclosure of MediaTek Software,
# and information contained herein, in whole or in part, shall be strictly prohibited.

# MediaTek Inc. (C) 2018. All rights reserved.
#
# BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
# THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
# RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO RECEIVER ON
# AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
# NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
# SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
# SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
# THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
# THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
# CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
# SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
# STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
# CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
# AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
# OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
# MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
#
# The following software/firmware and/or related documentation ("MediaTek Software")
# have been modified by MediaTek Inc. All revisions are subject to any receiver's
# applicable license agreements with MediaTek Inc.


LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)



###############################################################################
include $(CLEAR_VARS)
# OUTPUT_NAME
LOCAL_MODULE    := imgsensor.elf
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(GZ_APP_OUT)
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_OWNER := mtk

##############################################################

IMGSENSOR_COMMON_VER = v1
IMGSENSOR_COMMON_SRC = ../../$(IMGSENSOR_COMMON_VER)

ifeq ($(MTK_PROJECT), $(filter $(MTK_PROJECT), mt6983 ,mt6879, mt6895))
CAMERA_SENSOR_ISP7=y
endif

ifeq ($(MTK_PLATFORM_DIR), $(filter $(MTK_PLATFORM_DIR), mt6855 mt6789))
CAMERA_SENSOR_ISP7=n
endif

#-----------------------------------------------------------
LOCAL_SRC_FILES += manifest.c

ifneq ("$(CAMERA_SENSOR_ISP7)", "y")
LOCAL_SRC_FILES += isp6/main.c
else
LOCAL_SRC_FILES += isp7/main.c
endif

#	cfg_setting_imgsensor.cpp
#	$(IMGSENSOR_COMMON_SRC)/main/main.c \
#	$(IMGSENSOR_COMMON_SRC)/main/manifest.c \
#	$(IMGSENSOR_COMMON_SRC)/main/sensor_cfg_sec.cpp \


#IMGSENSOR_CUSTOM_PATH := ../../../../../../../../custom
#ifeq ($(wildcard $(IMGSENSOR_CUSTOM_PATH)/$(MTK_PROJECT)/hal/imgsensor_src),)
	#LOCAL_SRC_FILES += $(IMGSENSOR_CUSTOM_PATH)/$(TARGET_BOARD_PLATFORM)/hal/imgsensor_src/cfg_setting_imgsensor.cpp
#else
	#LOCAL_SRC_FILES += $(IMGSENSOR_CUSTOM_PATH)/$(MTK_PROJECT)/hal/imgsensor_src/cfg_setting_imgsensor.cpp
#endif

#-----------------------------------------------------------



SENINF_BASE_PLATFORM := $(MTK_PLATFORM_DIR)
ifeq ($(SENINF_BASE_PLATFORM), $(filter $(MTK_PLATFORM_DIR), mt6853 mt6885 mt6855 mt6789))
SENINF_BASE_PLATFORM = seninf_6s
endif

SENINF_PLATFORM := $(MTK_PLATFORM_DIR)
ifeq ($(TARGET_BOARD_PLATFORM), mt6781)
SENINF_PLATFORM = mt6781
SENINF_BASE_PLATFORM = seninf_6s
endif

LOCAL_CFLAGS += \
	-I./bionic/libc/kernel/uapi \
	-I./bionic/libc/kernel/uapi/asm-arm \
	-I./vendor/mediatek/proprietary/hardware/mtkcam/drv/src/sensor/$(TARGET_BOARD_PLATFORM)/secure \
	-I./vendor/mediatek/proprietary/hardware/mtkcam/drv/src/sensor/$(SENINF_PLATFORM)/secure \
	-I./vendor/mediatek/proprietary/hardware/mtkcam/drv/src/sensor/$(SENINF_BASE_PLATFORM)/secure \
	-I./device/mediatek/common/kernel-headers \
	-I$(LOCAL_PATH)/../main \
	-I$(LOCAL_PATH)/../include \
	-I$(MTK_PATH_SOURCE)/hardware/mtkcam/include \
	-I$(LOCAL_PATH)/isp7/$(TARGET_BOARD_PLATFORM)/ \
	-I$(LOCAL_PATH)/isp7/$(MTK_PROJECT)/ \
	-I$(LOCAL_PATH)/isp7/common/ \
	-I./device/mediatek/common/kernel-headers/ \
	-I./vendor/mediatek/proprietary/hardware/mtkcam/drv/src/sensor/$(TARGET_BOARD_PLATFORM) \
	-I./vendor/mediatek/proprietary/hardware/mtkcam/drv/src/sensor/$(SENINF_PLATFORM) \
	-I./vendor/mediatek/proprietary/hardware/mtkcam/drv/src/sensor/$(SENINF_BASE_PLATFORM) \
	-I./vendor/mediatek/proprietary/custom/$(TARGET_BOARD_PLATFORM)/hal/inc \
	-I./vendor/mediatek/proprietary/custom/$(SENINF_PLATFORM)/hal/inc \
	-I./vendor/mediatek/proprietary/custom/common/hal/inc/$(SENINF_BASE_PLATFORM) \
	-I$(MTK_PATH_CUSTOM)/hal/inc \
	-I$(MTK_PATH_SOURCE)/hardware/mtkcam/include \
	-I./vendor/mediatek/proprietary/geniezone/trusty/vendor/mediatek/secure/imgsensor/libimgsensor/isp7/src/$(MTK_PROJECT) \
	-I./vendor/mediatek/proprietary/geniezone/trusty/vendor/mediatek/secure/imgsensor/libimgsensor/isp7/src/$(TARGET_BOARD_PLATFORM) \
	-I./vendor/mediatek/proprietary/geniezone/trusty/vendor/mediatek/secure/imgsensor/libimgsensor/isp7/src/common \

ifneq ("$(CAMERA_SENSOR_ISP7)", "y")
LOCAL_STATIC_LIBRARIES := libc-trusty \
			libc.mod \
			libmtee_serv \
			libmtee_api \
			libimgsensor \
			libcutils \
			libimgsensorcfg

else
LOCAL_STATIC_LIBRARIES := libc-trusty \
			libc.mod \
			libmtee_serv \
			libmtee_api \
			libimgsensor \
			libcutils \

endif

LOCAL_MULTILIB := first

include $(GZ_EXECUTABLE)

############################################################################

#################

include $(CLEAR_VARS)
LOCAL_MODULE    := libimgsensorcfg

SENINF_BASE_PLATFORM := $(MTK_PLATFORM_DIR)
ifeq ($(SENINF_BASE_PLATFORM), $(filter $(MTK_PLATFORM_DIR), mt6853 mt6885 mt6855 mt6789))
SENINF_BASE_PLATFORM = seninf_6s
endif

IMGSENSOR_CUSTOM_PATH := ../../../../../../../../custom

prj_path := ./vendor/mediatek/proprietary/custom/$(MTK_PROJECT)/hal/imgsensor_src
platform_path := ./vendor/mediatek/proprietary/custom/$(TARGET_BOARD_PLATFORM)/hal/imgsensor_src

ifneq ($(wildcard $(prj_path)),)
  LOCAL_SRC_FILES := $(IMGSENSOR_CUSTOM_PATH)/$(MTK_PROJECT)/hal/imgsensor_src/cfg_setting_imgsensor.cpp
else ifneq ($(wildcard $(platform_path)),)
  ifeq ($(SENINF_BASE_PLATFORM), seninf_6s)
    LOCAL_SRC_FILES := $(IMGSENSOR_CUSTOM_PATH)/common/hal/imgsensor_src/seninf_6s/cfg_setting_imgsensor.cpp
  else
    LOCAL_SRC_FILES := $(IMGSENSOR_CUSTOM_PATH)/$(TARGET_BOARD_PLATFORM)/hal/imgsensor_src/cfg_setting_imgsensor.cpp
  endif
else
  LOCAL_SRC_FILES := $(IMGSENSOR_CUSTOM_PATH)/common/hal/imgsensor_src/seninf_6s/cfg_setting_imgsensor.cpp
endif

LOCAL_CFLAGS += \
	-I./device/mediatek/common/kernel-headers \
	-I./vendor/mediatek/proprietary/custom/$(TARGET_BOARD_PLATFORM)/hal/inc \
	-I./vendor/mediatek/proprietary/custom/$(MTK_PLATFORM_DIR)/hal/inc \
	-I./vendor/mediatek/proprietary/custom/common/hal/inc/seninf_6s \
	-I$(MTK_PATH_CUSTOM)/hal/inc \
	-I$(MTK_PATH_SOURCE)/hardware/mtkcam/include \

LOCAL_CFLAGS += -DCONFIG_MTK_CAM_SECURE=1

LOCAL_CFLAGS += -fno-stack-protector

LOCAL_MODULE_SUFFIX := .a
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MULTILIB := first


include $(GZ_BUILD_SYSTEM)/static_library.mk
