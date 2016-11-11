/*
 * Copyright (C) 2012 The Android Open Source Project
 * Copyright (c) 2013-2014, NVIDIA CORPORATION.  All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "powerhal.h"

static struct input_dev_map input_devs[] = {
        {-1, "raydium_ts\n"},
        {-1, "Vendor_0457_Product_0817\n"},
        {-1, "cm3217-ls\n"}
       };
static struct powerhal_info *pInfo;

static void main_power_init(struct power_module *module)
{
    if (!pInfo)
        pInfo = (powerhal_info*)calloc(1, sizeof(powerhal_info));

    pInfo->input_devs = input_devs;
    pInfo->input_cnt = sizeof(input_devs)/sizeof(struct input_dev_map);
    common_power_init(module, pInfo);
}

static void main_power_set_interactive(struct power_module *module, int on)
{
    common_power_set_interactive(module, pInfo, on);
}

static void main_power_hint(struct power_module *module, power_hint_t hint,
                            void *data)
{
    common_power_hint(module, pInfo, hint, data);
}

static int main_power_open(const hw_module_t *module, const char *name,
                            hw_device_t **device)
{
    if (strcmp(name, POWER_HARDWARE_MODULE_ID))
        return -EINVAL;

    if (!pInfo) {
        pInfo = (powerhal_info*)calloc(1, sizeof(powerhal_info));

        common_power_open(pInfo);
    }

    return 0;
}

static struct hw_module_methods_t power_module_methods = {
    open: main_power_open,
};

struct power_module HAL_MODULE_INFO_SYM = {
    common: {
        tag: HARDWARE_MODULE_TAG,
        module_api_version: POWER_MODULE_API_VERSION_0_2,
        hal_api_version: HARDWARE_HAL_API_VERSION,
        id: POWER_HARDWARE_MODULE_ID,
        name: "Tegra4 Power HAL",
        author: "NVIDIA",
        methods: &power_module_methods,
        dso: NULL,
        reserved: {0},
    },

    init: main_power_init,
    setInteractive: main_power_set_interactive,
    powerHint: main_power_hint,
};
