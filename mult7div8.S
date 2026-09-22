.global mult7div8
# a in %dil (signed char), overflow pointer in %rsi; result in %eax
mult7div8:
  movl %dil, %eax     # %eax = a 
  imul 7, %eax        # %eax = a*7


  movl $0, (%rsi)     # *overflow = 0
  jmp .L3             # jump to .L3

.L2  
  movl $1, (%rsi)     # *overflow = 1

.L3:
  idivl $8            # %eax = %eax / 8 
  ret


# char mult7div8(char a, char *overflow){
#     char mult = (7 * a);
#     if(a > 0 && mult < 0 || a < 0 && mult > 0)
#       *overflow = 1;
#     else
#       *overflow = 0;
#     return mult/8;
# }
