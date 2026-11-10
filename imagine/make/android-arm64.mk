include $(IMAGINE_PATH)/make/config.mk
include $(buildSysPath)/setAndroidNDKPath.mk
ARCH := aarch64
SUBARCH = arm64
CHOST := aarch64-linux-android
android_abi := arm64-v8a
android_ndkSDK ?= 21
android_ndkArch := arm64
clangTarget := aarch64-none-linux-android21

CFLAGS_CODEGEN += -fPIC
CFLAGS_CODEGEN += -O2 -march=armv8-a
CFLAGS_CODEGEN += -ffunction-sections -fdata-sections
CFLAGS_CODEGEN += -fstack-protector-strong

LDFLAGS_SYSTEM += -Wl,-z,max-page-size=16384
LDFLAGS_SYSTEM += -Wl,--gc-sections
LDFLAGS_SYSTEM += -Wl,-z,relro,-z,now

include $(buildSysPath)/android-gcc.mk
