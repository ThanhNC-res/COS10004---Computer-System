SETUP_LED:
 GPIO_OFFSET = $200000
 orr r0,GPIO_OFFSET
 mov r1,#1
 lsl r1,#24
 str r1,[r0,#4]
bx lr

FLASH:
mov r2,r0
orr r0,GPIO_OFFSET
mov r7,r1
loop$:
  mov r1,#1
  lsl r1,#18
  str r1,[r0,#28]

 mov r1,#1
 lsl r1,#18
 str r1,[r0,#40]

  push {r0,r1,r7,lr}
  mov r0,BASE
  mov r1,$0F0000
  bl TIMER
  pop {r0,r1,r7,lr}

  sub r7,#1
  cmp r7,#0
  bne loop$

bx lr