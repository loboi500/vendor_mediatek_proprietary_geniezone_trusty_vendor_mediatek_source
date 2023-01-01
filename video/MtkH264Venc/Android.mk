ifneq (,$(filter $(TARGET_BOARD_PLATFORM),mt6873 mt6853 mt6833 mt6885 mt6781 mt6893 mt6889 mt6877))
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := libAVCSecureVencCA
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true
LOCAL_WHOLE_STATIC_LIBRARIES += libAVCSecureVencCA_mtee

LOCAL_SHARED_LIBRARIES += liblog
LOCAL_SHARED_LIBRARIES += libion libion_mtk
LOCAL_SHARED_LIBRARIES += libcutils
LOCAL_SHARED_LIBRARIES += libutils
LOCAL_SHARED_LIBRARIES += libgz_uree libgz_gp_client
LOCAL_SHARED_LIBRARIES += libdmabufheap
include $(BUILD_SHARED_LIBRARY)
endif

ifeq ($(MTK_GENERIC_HAL), yes)
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := libAVCSecureVencCA
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true
LOCAL_WHOLE_STATIC_LIBRARIES += libAVCSecureVencCA_mtee

LOCAL_SHARED_LIBRARIES += liblog
LOCAL_SHARED_LIBRARIES += libion libion_mtk
LOCAL_SHARED_LIBRARIES += libcutils
LOCAL_SHARED_LIBRARIES += libutils
LOCAL_SHARED_LIBRARIES += libgz_uree libgz_gp_client
LOCAL_SHARED_LIBRARIES += libdmabufheap
include $(BUILD_SHARED_LIBRARY)
endif