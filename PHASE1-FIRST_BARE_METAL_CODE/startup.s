.syntax unified
.cpu cortex-m3
.thumb

.global _estack
.global Reset_Handler

.section .isr_vector, "a", %progbits
.word _estack
.word Reset_Handler

.section .text
Reset_Handler:
    /* Copy .data from Flash to RAM */
    ldr r0, =_sdata
    ldr r1, =_edata
    ldr r2, =_etext

CopyData:
    cmp r0, r1
    ittt lt
    ldrlt r3, [r2], #4
    strlt r3, [r0], #4
    blt CopyData

    /* Zero .bss */
    ldr r0, =_sbss
    ldr r1, =_ebss
    movs r2, #0

ZeroBss:
    cmp r0, r1
    it lt
    strlt r2, [r0], #4
    blt ZeroBss

    /* Call main */
    bl main

Hang:
    b Hang
