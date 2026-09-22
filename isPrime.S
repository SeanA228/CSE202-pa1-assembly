.global isPrime
# n in %edi; result in %eax (1 = prime, 0 = not prime)
isPrime:
  movl $1, %eax     # %eax = 1
  cmpl $2, %edi     # n - 2 
  jl .L2            # jump to .L2 if n<2
  testl $1, %edi    # n & 1 // checks if n is even
  je .L3            # jump to .L3 if n%2 == 0 
  movl $3, %esi     # i = 3
  jmp .L4           # jump to .L4 for the for loop 

.L2: 
  movl $0, %eax     # %eax = 0
  ret

.L3:
  cmpl $2, %edi     # n-2 
  jne .L2           # jump to .L2 if n!=2
  movl $1, %eax     # %eax = 1
  ret
  
.L4:
  movl %esi, %ebx   # %ebx = i
  imul %ebx, %ebx   # i = i*i
  cmpl %edi, %ebx   # i*i-n 
  jg .L5            # jump to .L5 i*i>n
  movl %edi, %eax   # %eax = n // Quotient
  movl $0, %edx     # %edx = 0 // Remainder 
  idivl %esi        # %eax = n/i  and %edx = n % i
  cmpl $0, %edx     # %edx -0 
  je .L2            # jumps to .L2 if %edx = 0 
  addl $2, %esi     # i = i+2
  jmp .L4 # jumps to .L4 to continue the for loop 

.L5:
  movl $1, %eax # %eax = 1
  ret

# int isPrime(int n){
#     if(n < 2)
#         return 0;
#     if(n % 2 == 0)
#         return n == 2;
#     /* only test odd divisors i while i*i <= n */
#     for(int i = 3; i * i <= n; i += 2){
#         if(n % i == 0)
#             return 0;
#     }
#     return 1;
# }
