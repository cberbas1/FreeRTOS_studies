# FreeRTOS_studies
FreeRTOS studies overall, it is intended to cover 

## 🔹 Phase 1: Understand the Basics
#### 1. **What is an RTOS?**
- Learn what an RTOS does: task scheduling, priority-based execution, deterministic timing.
- Study core FreeRTOS concepts:
    - Tasks and priorities
    - Task switching
    - Preemption vs cooperative scheduling
    - Delays (`vTaskDelay`)
    - Tick rate and time slicing

✅ Resources:
- FreeRTOS Kernel Basics
- YouTube: "FreeRTOS in 10 Minutes"

## 🔹 Phase 2: Set Up the Environment for KR260
#### 1. **Install Tools**
- Vitis IDE (from Xilinx)
- PetaLinux SDK (optional but useful)
- FreeRTOS source (from FreeRTOS.org or [GitHub](https://github.com/FreeRTOS/FreeRTOS))

#### 2. **Understand KR260 Hardware Platform**
- Know where to run FreeRTOS: Cortex-R5 is usually the target, not the A53.
- Learn about the **PS (Processing System)** and **PL (Programmable Logic)** split.

✅ Learn:
- Zynq Ultrascale+ MPSoC architecture
- Device Tree (for PetaLinux)
- Boot process: FSBL → U-Boot → OS (or bare-metal / FreeRTOS)

## 🔹 Phase 3: Your First FreeRTOS App on KR260
#### 1. **Simple LED Blinking**
- Set up a FreeRTOS project for the R5 core in Vitis
- Blink an LED using a task and `vTaskDelay`

#### 2. **Use Multiple Tasks**
- Blink LED in one task, print UART in another
- Learn how to create, delete, and manage tasks

✅ Key APIs to learn:
```
xTaskCreate()  
vTaskDelay()  
vTaskDelete()  
vTaskPrioritySet()
```

## 🔹 Phase 4: Deep Dive into RTOS Concepts
1.  **Task Synchronization**
    - Queues
    - Semaphores (Binary, Counting)
    - Mutex (Priority Inversion)
  
2.  **Inter-task Communication**
    - Message Queues
    - Event Groups

3.  **Memory Management**
    - Heap_1 to Heap_5 (FreeRTOS heap schemes)
  
4.  **Software Timers**

✅ Experiment:
- Shared UART between tasks using mutex
- Simulate producer-consumer with queues

## 🔹 Phase 5: FreeRTOS + Hardware Interaction
#### 1. **GPIO Input/Output**
- Read button input, debounce using FreeRTOS

#### 2. **Interrupts + FreeRTOS**
- Set up ISRs and synchronize with tasks using semaphores
  
#### 3. **DMA, SPI, I2C peripherals**
- Start interacting with real hardware, maybe an IMU or temperature sensor

✅ Learn:
- `xSemaphoreGiveFromISR()`
- `BaseType_t xHigherPriorityTaskWoken`

## 🔹 Phase 6: Advanced Concepts
- Idle task hook
- Tick hook
- Software watchdog timers
- Static memory allocation
- Power management (light sleep, suspend)
- Real-time performance tuning

## 🔹 Bonus: Mix FreeRTOS with Bare-Metal or Linux (Hybrid)
- FreeRTOS on Cortex-R5
- Linux on Cortex-A53
- Use RPMsg or OpenAMP to talk between them

💡 This is **super advanced**, but powerful. You could have real-time stuff on R5 and Linux doing AI or networking on A53.
