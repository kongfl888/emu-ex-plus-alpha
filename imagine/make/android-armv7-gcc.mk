include $(IMAGINE_PATH)/make/config.mk
include $(buildSysPath)/setAndroidNDKPath.mk

ARCH := arm
SUBARCH = armv7
CHOST := arm-linux-androideabi
android_abi := armeabi-v7a
android_ndkSDK ?= 9
android_ndkArch := arm

# Must declare min API 21 to compile with NDK r26+ headers
clangTarget := armv7-none-linux-androideabi21

CFLAGS_CODEGEN += -fPIC -O2 -ffunction-sections -fdata-sections

armv7CPUFlags ?= -march=armv7-a -mtune=generic
android_armv7State ?= -mthumb
android_armState := $(android_armv7State)

# hard-fp + neon
android_cpuFlags ?= $(armv7CPUFlags) -mfpu=neon -mfloat-abi=softfp
android_cpuFlags += $(android_armv7State)

LDFLAGS_SYSTEM += -Wl,--gc-sections
LDFLAGS_SYSTEM += -Wl,--fix-cortex-a8

android_cxxSupportLibs := -landroid_support

ASMFLAGS = --noexecstack -EL -mfloat-abi=hard -march=armv7-a

include $(buildSysPath)/android-gcc.mk

# Directly call the GNU assembler until assembly in projects is updated for clang's integrated assembler
ifneq ($(shell which arm-none-linux-gnueabi-as),)
 AS = arm-none-linux-gnueabi-as
else
 AS = arm-linux-gnueabi-as
endif
