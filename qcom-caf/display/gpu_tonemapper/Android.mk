LOCAL_PATH := $(call my-dir)
include $(LOCAL_PATH)/../common.mk

ifeq ($(BUILD_BROKEN_USES_BUILD_COPY_HEADERS),true)
include $(CLEAR_VARS)
LOCAL_VENDOR_MODULE       := true
LOCAL_COPY_HEADERS_TO     := $(common_header_export_path)
LOCAL_COPY_HEADERS        := TonemapFactory.h Tonemapper.h
include $(BUILD_COPY_HEADERS)
endif

include $(CLEAR_VARS)
LOCAL_MODULE              := libgpu_tonemapper
LOCAL_VENDOR_MODULE       := true
LOCAL_MODULE_TAGS         := optional
LOCAL_HEADER_LIBRARIES    := display_headers
LOCAL_C_INCLUDES          := $(TARGET_OUT_HEADERS)/qcom/display/
LOCAL_C_INCLUDES          += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_SHARED_LIBRARIES    := libEGL libGLESv2 libGLESv3 libui libutils liblog
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps) $(kernel_deps)
LOCAL_ADDITIONAL_DEPENDENCIES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_CFLAGS              := $(version_flag) -Wno-missing-field-initializers -Wall \
                             -Wno-unused-parameter -Wno-unreachable-code-loop-increment -DLOG_TAG=\"GPU_TONEMAPPER\"
LOCAL_SRC_FILES           := TonemapFactory.cpp \
                             glengine.cpp \
                             EGLImageBuffer.cpp \
                             EGLImageWrapper.cpp \
                             Tonemapper.cpp

include $(BUILD_SHARED_LIBRARY)
