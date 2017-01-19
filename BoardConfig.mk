#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PACKAGE_OVERLAYS += device/asus/tf701t/overlay

# This variable is set first, so it can be overridden
# by BoardConfigVendor.mk
USE_CAMERA_STUB := false
BOARD_USES_GENERIC_AUDIO := false
BOARD_AUDIORECORD_SKIP_GET_CAPTURE_POSITION := true

# Use the non-open-source parts, if they're present
-include vendor/asus/tf701t/BoardConfigVendor.mk
#include vendor/nvidia/build/definitions.mk

TARGET_HAS_LEGACY_CAMERA_HAL1 := true


TARGET_SPECIFIC_HEADER_PATH := device/asus/tf701t/include

TARGET_NO_BOOTLOADER := true

# Architecture
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a15
TARGET_CPU_SMP := true
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon

TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true

TARGET_NO_RADIOIMAGE := true
TARGET_BOARD_PLATFORM := tegra
TARGET_BOOTLOADER_BOARD_NAME := macallan

# Kernel
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_CMDLINE := androidboot.selinux=permissive
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01000000 --tags_offset 0x00000100

# Try to build the kernel
TARGET_PREBUILT_KERNEL := device/asus/tf300t/kernel

#TARGET_KERNEL_SOURCE := kernel/asus/tf701t
#TARGET_KERNEL_CONFIG := katkernel_defconfig

# Video
#BOARD_EGL_CFG := device/asus/tf701t/egl.cfg
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

BOARD_USE_SKIA_LCDTEXT := true

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_RECOVERY_INITRC := device/asus/tf701t/recovery/init.rc
#TARGET_NO_RECOVERY := true
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"
RECOVERY_FSTAB_VERSION := 2
TARGET_RECOVERY_LCD_BACKLIGHT_PATH := \"/sys/class/backlight/pwm-backlight/brightness\"
#COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD

TARGET_RELEASETOOLS_EXTENSIONS := device/asus/tf701t

# Partition
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608 # 8M
#BOARD_RECOVERYIMAGE_PARTITION_SIZE := 8388608 # 8M
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648 # 2G
#BOARD_USERDATAIMAGE_PARTITION_SIZE := 27562866722 # 25.6G
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 918552576 # 876M
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_PARTITION_SIZE := 8283750 # 7.9M

# Wifi related defines
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE := bcmdhd

WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/bcm43341/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/bcm43341/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P     := "/vendor/firmware/bcm43341/fw_bcmdhd_p2p.bin"

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR ?= device/asus/tf701t/bluetooth

# SELINUX Defines
BOARD_SEPOLICY_DIRS += \
    device/asus/tf701t/sepolicy


TARGET_BOOTANIMATION_PRELOAD := true

BOARD_HAL_STATIC_LIBRARIES := libhealthd.macallan
TARGET_ENABLE_NON_PIE_SUPPORT := true

#BOARD_NEEDS_VECTORIMPL_SYMBOLS := true
SENSORS_NEED_SETRATE_ON_ENABLE := true

ARCH_ARM_HIGH_OPTIMIZATION := true
#DEBUG_NO_STDCXX11 := yes
#TARGET_BOARD_CANT_REALLOCATE_OMX_BUFFERS := true
CLANG_O3 := true
#STRICT_ALIASING := true
#GRAPHITE_OPTS := true
#ENABLE_GCCONLY := true
#USE_PIPE := true
#ENABLE_SANITIZE := true
#ENABLE_GOMP := true
#TARGET_GCC_VERSION_EXP := 5.4
#TARGET_GCC_VERSION_ARM := 5.4

ENABLE_CPUSETS := true

#TARGET_POWERHAL_VARIANT := tegra
#BOARD_USES_POWERHAL := true
#NV_ANDROID_FRAMEWORK_ENHANCEMENTS := TRUE
