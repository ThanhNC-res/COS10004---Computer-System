macro delay: ?

local .wait
mov r2,$3F0000

.wait:
sub r2,#1
cmp r2,#0
bne .wait

BASE = $FE000000 ; Use $3F000000 for 2B, 3B, 3B+
GPIO_OFFSET = $200000

mov r0,BASE
orr r0,GPIO_OFFSET ;Base address of GPIO

TIMER_OFFSET = $3000
;TIMER_MICROSECONDS = 524288 ; $0080000 ;0.524288 s
mov r3,BASE
orr r3,TIMER_OFFSET ;store base address of timer (r3)
mov r4,$70000
orr r4,$0A100
orr r4,$00020   ;TIMER_MICROSECONDS = 500,000

ldr r1,[r0,#4] ;read function register for GPIO 10 - 19
;clear the 3 bits for GPIO10 
bic r1,r1,#7  ;bit clear 
str r1,[r0,#4]

;output set up GPIO 12 18
mov r8,#1
lsl r8,#24
str r8,[r0,#8]

mov r10,#1
lsl r10,#6
str r10,[r0,#8]

loop$:
;Turn on and off LED base on cont
mov r8,#1
lsl r8,#18
str r8,[r0,#28]

mov r10,#1
lsl r10,#12
str r10,[r0,#29]

bl TIMER

mov r8,#1
lsl r8,#18
str r8,[r0,#40]

mov r10,#1
lsl r10,#12
str r10,[r0,#41]
delay

ldr r9,[r0,#52] ;read gpios 0-31
tst r9,#1024  ;use tst to check bit 10 
beq cont ;if bit 10 set goto LED 2
;else set LED 1 (below)
ldr r9,[r0,#52] ;read gpios 0-31
tst r9,#1024  ;use tst to check bit 10 
beq loop$ ;if bit 10 set goto LED 2
cont:
mov r8,#1
lsl r8,#18
str r8,[r0,#28]
bl TIMER
mov r8,#1
lsl r8,#18
str r8,[r0,#40]
delay
mov r10,#1
lsl r10,#12
str r10,[r0,#29]
bl TIMER
mov r10,#1
lsl r10,#12
str r10,[r0,#41]
delay
b cont  ;end of if

b loop$


include "Timer.asm"





