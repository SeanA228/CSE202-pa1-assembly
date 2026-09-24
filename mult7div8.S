.global mult7div8
# a in %dil (signed char), overflow pointer in %rsi; result in %eax
mult7div8:
  movsbl %dil, %eax   # %eax = a 
  imul $7, %eax       # %eax = a*7
  cmpb $0, %dil       # a - 0
  setg %r8b           # sets %r8b to 1 if a>0
  setl %r9b           # sets %r9b to 1 if a<0
  cmpl $0, %eax       # mult-0 
  setg %r10b          # sets %r10b to 1 if mult>0
  setl %r11b          # sets %r11b to 1 if mult<0
  andb %r8b, %r11b    # %r11b = %r8b & %r11b (a>0 && mult<0)
  andb %r9b, %r10b    # %r10b = %r9b & %r10b (a<0 && mult>0)
  orb  %r11b, %r10b   # %r10b = %r10b | %r11b {(a<0 && mult>0) | (a>0 && mult<0)}
  testb %r10b, %r10b  # %r10b & %r10b
  jne .L2             # jump to .L2 if %r10b is not 0 (one of the conditions was true)
  movl $0, (%rsi)     # *overflow = 0
  jmp .L3             # jump to .L3

.L2:  
  movl $1, (%rsi)     # *overflow = 1

.L3:
  cltd                # move sign-extended %eax to %edx
  movl $8, %ecx       # %ecx = 8
  idivl %ecx          # %eax = mult / 8 
  ret


# char mult7div8(char a, char *overflow){
#     char mult = (7 * a);
#     if(a > 0 && mult < 0 || a < 0 && mult > 0)
#       *overflow = 1;
#     else
#       *overflow = 0;
#     return mult/8;
# }
