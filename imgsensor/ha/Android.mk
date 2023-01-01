LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
ifeq ($(MTK_PLATFORM_DIR), $(filter $(MTK_PLATFORM_DIR), mt6853 mt6768 mt6771 mt6785 mt6885 mt6873 mt6765 mt6983 mt6879 mt6895 mt6855 mt6789))
include $(call all-makefiles-under, $(LOCAL_PATH))
endif
