
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
ifeq ($(MTKCAM_PLATFORM_DIR), $(filter $(MTKCAM_PLATFORM_DIR), mt6768 mt6771 mt6785 mt6853 mt6885 mt6873 mt6765 mt6855 mt6789 common))
ifeq ($(MTK_CAM_GENIEZONE_SUPPORT), yes)
LOCAL_MODULE := libimgsensorca
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true
LOCAL_WHOLE_STATIC_LIBRARIES += libimgsensorca_mtee
LOCAL_SHARED_LIBRARIES += liblog
LOCAL_SHARED_LIBRARIES += libcutils
LOCAL_SHARED_LIBRARIES += libgz_uree
include $(BUILD_SHARED_LIBRARY)

endif
endif

