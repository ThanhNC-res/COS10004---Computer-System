TIMER:
  ldrd r6,r7,[r3,#4]
  mov r5,r6 ;store starttime (r5)(=currenttime (r6))
  timerloop:
  ldrd r6,r7,[r3,#4] ;read currenttime (r6)
  sub r8,r6,r5  ;remainingtime (8)= currenttime (r6) - starttime (r5)
  cmp  r8,r4  ;compare remainingtime (r8), delay (r4)
  bls timerloop
bx lr
