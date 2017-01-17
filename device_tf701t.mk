# Copyright (C) 2011 The Android Open Source Project
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/asus/tf701t/tf701t-vendor.mk)

ifneq ($(TARGET_KERNEL_BUILT_FROM_SOURCE), true)
# Use prebuilt kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/asus/tf701t/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif
endif


DEVICE_PACKAGE_OVERLAYS += \
    device/asus/tf701t/overlay

# Root
PRODUCT_COPY_FILES += \
    device/asus/tf701t/fstab.macallan:root/fstab.macallan \
    device/asus/tf701t/ueventd.macallan.rc:root/ueventd.macallan.rc

# Init
PRODUCT_COPY_FILES += \
    device/asus/tf701t/init/init.macallan.rc:root/init.macallan.rc \
    device/asus/tf701t/init/init.hdcp.rc:root/init.hdcp.rc \
    device/asus/tf701t/init/init.macallan.usb.rc:root/init.macallan.usb.rc \
    device/asus/tf701t/init/init.tf.rc:root/init.tf.rc

# Media
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    device/asus/tf701t/media/media_profiles.xml:system/etc/media_profiles.xml \
    device/asus/tf701t/media/media_codecs.xml:system/etc/media_codecs.xml \
    device/asus/tf701t/media/enctune.conf:system/etc/enctune.conf

# GPS
PRODUCT_COPY_FILES += \
    device/asus/tf701t/gps/gpsconfig.xml:system/etc/gpsconfig.xml \
    device/asus/tf701t/gps/libgps.conf:system/etc/libgps.conf \
    device/asus/tf701t/gps/gps.conf:system/etc/gps.conf

# Audio
PRODUCT_COPY_FILES += \
    device/asus/tf701t/audio/asound.conf:system/etc/asound.conf \
    device/asus/tf701t/audio/audioConfig_qvoice_icera_pc400.xml:system/etc/audioConfig_qvoice_icera_pc400.xml \
    device/asus/tf701t/audio/audio_policy.conf:system/etc/audio_policy.conf \
    device/asus/tf701t/audio/nvaudio_conf_haydn.xml:system/etc/nvaudio_conf_haydn.xml \
    device/asus/tf701t/audio/nvaudio_conf_mozart.xml:system/etc/nvaudio_conf_mozart.xml

# Audio override
PRODUCT_COPY_FILES_OVERRIDES := \
    system/etc/audio_effects.conf

# Wifi
PRODUCT_COPY_FILES += \
    device/asus/tf701t/wifi/nvram_4324.txt:system/etc/nvram_4324.txt \
    device/asus/tf701t/wifi/nvram_43341.txt:system/etc/nvram_43341.txt \
    device/asus/tf701t/wifi/bcm43241.hcd:system/etc/firmware/bcm43241.hcd \
    device/asus/tf701t/wifi/bcm43341.hcd:system/etc/firmware/bcm43341.hcd \
    device/asus/tf701t/wifi/firmware/bcm4324/fw_bcmdhd_apsta.bin:system/vendor/firmware/bcm4324/fw_bcmdhd_apsta.bin \
    device/asus/tf701t/wifi/firmware/bcm4324/fw_bcmdhd.bin:system/vendor/firmware/bcm4324/fw_bcmdhd.bin \
    device/asus/tf701t/wifi/firmware/bcm4324/fw_bcmdhd_p2p.bin:system/vendor/firmware/bcm4324/fw_bcmdhd_p2p.bin \
    device/asus/tf701t/wifi/firmware/bcm43341/fw_bcmdhd_apsta.bin:system/vendor/firmware/bcm43341/fw_bcmdhd_apsta.bin \
    device/asus/tf701t/wifi/firmware/bcm43341/fw_bcmdhd.bin:system/vendor/firmware/bcm43341/fw_bcmdhd.bin \
    device/asus/tf701t/wifi/firmware/bcm43341/fw_bcmdhd_p2p.bin:system/vendor/firmware/bcm43341/fw_bcmdhd_p2p.bin \
    device/asus/tf701t/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    device/asus/tf701t/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf

# Power
PRODUCT_COPY_FILES += \
    device/asus/tf701t/power.macallan.rc:system/etc/power.macallan.rc

# Camera
PRODUCT_COPY_FILES += \
    device/asus/tf701t/camera/nvcamera.conf:system/etc/nvcamera.conf \
    device/asus/tf701t/camera/model_frontal.xml:system/etc/model_frontal.xml

# Bluetooth
PRODUCT_COPY_FILES += \
    device/asus/tf701t/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# IDC
PRODUCT_COPY_FILES += \
    device/asus/tf701t/idc/asuspec.idc:system/usr/idc/asuspec.idc \
    device/asus/tf701t/idc/ASUS_TransKeyboard.idc:system/usr/idc/ASUS_TransKeyboard.idc \
    device/asus/tf701t/idc/raydium_ts.idc:system/usr/idc/raydium_ts.idc \
    device/asus/tf701t/idc/sensor00fn11.idc:system/usr/idc/sensor00fn11.idc \
    device/asus/tf701t/idc/Vendor_0457_Product_0817.idc:system/usr/idc/Vendor_0457_Product_0817.idc \
    device/asus/tf701t/idc/Vendor_0b05_Product_17fc.idc:system/usr/idc/Vendor_0b05_Product_17fc.idc \
    device/asus/tf701t/idc/elantech_touchscreen.idc:system/usr/idc/elantech_touchscreen.idc

# Keylayout
PRODUCT_COPY_FILES += \
    device/asus/tf701t/keylayout/asuspec.kl:system/usr/keylayout/asuspec.kl \
    device/asus/tf701t/keylayout/ASUS_TransKeyboard.kl:system/usr/keylayout/ASUS_TransKeyboard.kl \
    device/asus/tf701t/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/asus/tf701t/keylayout/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
    device/asus/tf701t/keylayout/Vendor_044f_Product_d007.kl:system/usr/keylayout/Vendor_044f_Product_d007.kl \
    device/asus/tf701t/keylayout/Vendor_045e_Product_0719.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl \
    device/asus/tf701t/keylayout/Vendor_046d_Product_c21d.kl:system/usr/keylayout/Vendor_046d_Product_c21d.kl \
    device/asus/tf701t/keylayout/Vendor_046d_Product_c21e.kl:system/usr/keylayout/Vendor_046d_Product_c21e.kl \
    device/asus/tf701t/keylayout/Vendor_054c_Product_05c4.kl:system/usr/keylayout/Vendor_054c_Product_05c4.kl \
    device/asus/tf701t/keylayout/Vendor_0b05_Product_17fc.kl:system/usr/keylayout/Vendor_0b05_Product_17fc.kl

# Keylayout overrides
PRODUCT_COPY_FILES_OVERRIDES += \
    system/usr/keylayout/AVRCP.kl \
    system/usr/keylayout/Generic.kl \
    system/usr/keylayout/Vendor_0079_Product_0011.kl \
    system/usr/keylayout/Vendor_045e_Product_028e.kl \
    system/usr/keylayout/Vendor_046d_Product_c216.kl \
    system/usr/keylayout/Vendor_046d_Product_c219.kl \
    system/usr/keylayout/Vendor_046d_Product_c21f.kl \
    system/usr/keylayout/Vendor_054c_Product_0268.kl \
    system/usr/keylayout/Vendor_1038_Product_1412.kl \
    system/usr/keylayout/Vendor_12bd_Product_d015.kl \
    system/usr/keylayout/Vendor_2378_Product_100a.kl

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# ASUS
PRODUCT_COPY_FILES += \
    device/asus/tf701t/permissions/com.nvidia.nvsi.xml:system/etc/permissions/com.nvidia.nvsi.xml \
    device/asus/tf701t/permissions/asus.hardware.battery.dock.xml:system/etc/permissions/asus.hardware.battery.dock.xml \
    device/asus/tf701t/permissions/asus.hardware.display.high_brightness.xml:system/etc/permissions/asus.hardware.display.high_brightness.xml \
    device/asus/tf701t/permissions/asus.hardware.display.splendid.reading_mode.xml:system/etc/permissions/asus.hardware.display.splendid.reading_mode.xml \
    device/asus/tf701t/permissions/asus.hardware.display.splendid.xml:system/etc/permissions/asus.hardware.display.splendid.xml \
    device/asus/tf701t/permissions/asus.hardware.dock.xml:system/etc/permissions/asus.hardware.dock.xml \
    device/asus/tf701t/permissions/asus.hardware.fw.dock_ec.xml:system/etc/permissions/asus.hardware.fw.dock_ec.xml \
    device/asus/tf701t/permissions/asus.hardware.fw.pad_ec.xml:system/etc/permissions/asus.hardware.fw.pad_ec.xml \
    device/asus/tf701t/permissions/asus.hardware.hall_sensor.xml:system/etc/permissions/asus.hardware.hall_sensor.xml \
    device/asus/tf701t/permissions/asus.hardware.keyboard.xml:system/etc/permissions/asus.hardware.keyboard.xml \
    device/asus/tf701t/permissions/asus.hardware.sound.maxxaudio.xml:system/etc/permissions/asus.hardware.sound.maxxaudio.xml \

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    ap.interface=wlan1 \
    ro.carrier=wifi-only \
    ro.sf.override_null_lcd_density = 1 \
    debug.hwui.render_dirty_regions=false \
    persist.tegra.nvmmlite = 1 \
    drm.service.enabled=true \
    tf.enable=y

# Audio
PRODUCT_PACKAGES += \
        audio.a2dp.default \
        audio.usb.default \
        audio.r_submix.default \
        libaudioutils

# Power
PRODUCT_PACKAGES += power.macallan

# Misc
PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory \
    libnetcmdiface \
    WiFiDirectDemo \
    AutoParts_tfp

# Filesystem management tools
PRODUCT_PACKAGES += \
       make_ext4fs \
       setup_fs

PRODUCT_PACKAGES += \
    libwpa_client \
    hostapd \
    dhcpcd.conf \
    wpa_supplicant \
    wpa_supplicant.conf



PRODUCT_COPY_FILES += \
    device/asus/tf701t/libstlport/libstlport.so:system/lib/libstlport.so

PRODUCT_PACKAGES += libkaticu




PRODUCT_CHARACTERISTICS := tablet

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_AAPT_CONFIG := xlarge hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0


BOOTANIMATION_RESOLUTION := KatKiss
$(call inherit-product-if-exists, vendor/kat/common.mk)

