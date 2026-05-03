TARGET := iphone:clang:latest:14.0
ARCHS := arm64 arm64e

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = RaveSpyPayload
RaveSpyPayload_FILES = RaveSpyPayload.m
RaveSpyPayload_FRAMEWORKS = Foundation CoreLocation UIKit

include $(THEOS_MAKE_PATH)/library.mk
