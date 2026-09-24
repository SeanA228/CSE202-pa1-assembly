.global gcd
# a in %edi, b in %esi; result in %eax
gcd:
    cmp $0, %esi        # b - 0
    je .L2              # jump to .L2 if b ==0
    movl %edi, %ebx     # %ebx = a
    movl %esi, %ecx     # %ecx = b
    movl %edi, %eax     # %eax = a // Quotient
    movl $0, %edx       # %edx = 0 // Remainder
    idivl %ecx          # %eax = a/b  and %edx = a % b
    movl %esi, %edi     # %edi = b 
    movl %edx, %esi     # b = a % b
    call gcd            # recursive call gcd
    ret
    
.L2:
    movl %edi, %eax # %eax = a
    ret


# greatest common divisor via Euclid's algorithm (recursive)
# int gcd(int a, int b){
#     if(b == 0)
#         return a;
#     /* recursive call */
#     return gcd(b, a % b);
# }
