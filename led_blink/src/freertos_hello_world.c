/*
    Copyright (C) 2017 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
    Copyright (c) 2012 - 2022 Xilinx, Inc. All Rights Reserved.
	SPDX-License-Identifier: MIT


    http://www.FreeRTOS.org
    http://aws.amazon.com/freertos


    1 tab == 4 spaces!
*/

/* FreeRTOS includes. */
#include <sys/_stdint.h>
#include <stdbool.h>
#include "FreeRTOS.h"
#include "task.h"

/* Xilinx includes. */
#include "xil_printf.h"
#include "xparameters.h"
#include "xgpiops.h"

#define NUMBER_OF_LEDS 8U
#define GPIO_DIR_OUT 1U
#define GPIO_OP_EN 1U
#define EMIO_BASE_NUM 78U

static XGpioPs* gpioInstPtr_pst;

static void led_ctrl(bool isOn_b, uint32_t ledNum_u32)
{
  uint32_t ledNumCorrect_u32 = (ledNum_u32 % NUMBER_OF_LEDS) + EMIO_BASE_NUM;
  uint32_t isOn_u32 = isOn_b ? TRUE, 1U : 0U;

  XGpioPs_SetOutputEnablePin(gpioInstPtr_pst, ledNumCorrect_u32, GPIO_OP_EN);
  XGpioPs_SetDirectionPin(gpioInstPtr_pst, ledNumCorrect_u32, GPIO_DIR_OUT);
  XGpioPs_WritePin(gpioInstPtr_pst, ledNumCorrect_u32, isOn_u32);
}

static void led_task(void* params)
{
  while (1)
  {
    xil_printf("LED ON \r\n");
    led_ctrl(TRUE, 0U);
    vTaskDelay(pdMS_TO_TICKS(500));

    xil_printf("LED OFF\r\n");
    led_ctrl(FALSE, 0U);
    vTaskDelay(pdMS_TO_TICKS(500));
  }
}

int main(void)
{
  // Create a task
  xTaskCreate(led_task, "LED Task", 256, NULL, tskIDLE_PRIORITY + 1, NULL);

  // Start scheduler
  vTaskStartScheduler();

  // Should never reach here
  while (1)
    ;
}
