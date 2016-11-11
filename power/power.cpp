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

#include <hardware/hardware.h>
#include <hardware/power.h>

#include "powerhal_utils.h"
#include "powerhal.h"
#include <inttypes.h>



static struct input_dev_map input_devs[] = {
        {-1, "raydium_ts\n"},
        {-1, "Vendor_0457_Product_0817\n"},
        {-1, "cm3217-ls\n"}
       };
static struct powerhal_info *pInfo;

//FIXME auto detect
static int interactive_freq_on = 1912500; 
static int interactive_freq_off = 204000; 
static int interactive_mincpu_on = 2; 
static int max_cpu = 4; 
static int boost_time = ms2ns(1000); 
static int hint_interval = ms2ns(90); 

static void set_min_freq(int val, int timens)
{
   pInfo->mTimeoutPoker->requestPmQosTimed("/dev/cpu_freq_min",val, timens);
}

static void set_min_online_cpu(int val, int timens)
{
   if(timens == -1) 
   	close(pInfo->mTimeoutPoker->requestPmQos("/dev/min_online_cpus",val));
   else
   	pInfo->mTimeoutPoker->requestPmQosTimed("/dev/min_online_cpus",val, timens);
}

static int main_power_open(const hw_module_t *module, const char *name,
                            hw_device_t **device)
{
    return 0;
}


static void main_power_init(struct power_module *module)
{
ALOGI("main_power_init ");
    if (!pInfo)
        pInfo = (powerhal_info*)calloc(1, sizeof(powerhal_info));

    pInfo->input_devs = input_devs;
    pInfo->input_cnt = sizeof(input_devs)/sizeof(struct input_dev_map);

   pInfo->hint_interval[POWER_HINT_INTERACTION] = hint_interval; // less than boot time
   pInfo->hint_interval[POWER_HINT_VSYNC] = s2ns(10);

    // Initialize timeout poker
    Barrier readyToRun;
    pInfo->mTimeoutPoker = new TimeoutPoker(&readyToRun);
    readyToRun.wait();

  // Boost to max frequency on initialization to decrease boot time
    set_min_freq(interactive_freq_on, s2ns(15));
    set_min_online_cpu(max_cpu, s2ns(15));
}



static void main_power_set_interactive(struct power_module *module, int on /*screen on */ )
{
ALOGI("main_power_set_interactive");
    common_power_set_interactive(module, pInfo, on);

    const char* state = (0 == on)?"0":"1";
    sysfs_write("/sys/devices/platform/host1x/nvavp/boost_sclk", state);

    set_min_online_cpu(on==1?interactive_mincpu_on:0, -1);
//    if(!on) set_min_freq(interactive_freq_off);
}

static int check_hint(struct powerhal_info *pInfo, power_hint_t hint, uint64_t *t)
{
    struct timespec ts;
    uint64_t time;

    if (hint >= POWER_HINT_COUNT)
        return -1;

    clock_gettime(CLOCK_MONOTONIC, &ts);
    time = ts.tv_sec * 1000000 + ts.tv_nsec / 1000;

//ALOGI("check_hint: %"PRIu64 ",%"PRIu64 ",%"PRIu64, pInfo->hint_time[hint], pInfo->hint_interval[hint], time - pInfo->hint_time[hint]);

    if (pInfo->hint_time[hint] || pInfo->hint_interval[hint] ||
        (time - pInfo->hint_time[hint] < pInfo->hint_interval[hint]))
        return -1;

    *t = time;

    return 0;
}


static void no_power_hint(struct power_module *module, power_hint_t hint, void *data)
{
}

static void main_power_hint(struct power_module *module, power_hint_t hint, void *data)
{
  uint64_t t;
int fd = -1;

    if (!pInfo) return;
    if (check_hint(pInfo, hint, &t) < 0) return;
//ALOGI("main_power_hint:%d ", hint);

    switch (hint) {
    case POWER_HINT_INTERACTION:
        // Boost to max lp frequency
	set_min_freq(interactive_freq_on,  boost_time);
	set_min_online_cpu(interactive_mincpu_on, boost_time);
        break;

    default:
        //set_min_freq(interactive_freq_off);

        break;
    }

    pInfo->hint_time[hint] = t;
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
    powerHint: no_power_hint,
};
