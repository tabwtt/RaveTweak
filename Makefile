TARGET := iphone:clang:14.5:14.0
ARCHS := arm64 arm64e
LIBRARY_NAME = RaveSpyPayload
RaveSpyPayload_FILES = RaveSpyPayload.m
RaveSpyPayload_FRAMEWORKS = Foundation CoreLocation
include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/library.mk
