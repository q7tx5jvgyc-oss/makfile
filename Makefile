ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MyAutoClicker
MyAutoClicker_FILES = Tweak.xm
MyAutoClicker_LIBRARIES = ZSFakeTouch
MyAutoClicker_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
