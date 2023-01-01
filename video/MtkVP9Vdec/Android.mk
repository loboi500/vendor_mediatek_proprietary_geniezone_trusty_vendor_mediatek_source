
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
ifneq (,$(filter $(TARGET_BOARD_PLATFORM) $(MTK_GENERIC_HAL),mt6873 mt6853 mt6833 mt6885 mt6781 mt6893 mt6889 mt6877 yes))
LOCAL_MODULE := VP9SecureVdecCA
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

LOCAL_WHOLE_STATIC_LIBRARIES += VP9SecureVdecCA_mtee

LOCAL_SHARED_LIBRARIES += liblog
LOCAL_SHARED_LIBRARIES += libion libion_mtk
LOCAL_SHARED_LIBRARIES += libcutils
LOCAL_SHARED_LIBRARIES += libgz_uree
LOCAL_SHARED_LIBRARIES += libgz_gp_client
LOCAL_SHARED_LIBRARIES += libdmabufheap
include $(BUILD_SHARED_LIBRARY)
endif