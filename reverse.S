.global reverse
# list in %rdi (array of char*), n in %esi
reverse:
  movl $0, %edx         # %edx = i = 0
  movl %esi, %ebx       # %ebx = n
  sarl $1, %ebx         # %ebx = n/2
  jmp .L2               # jumps to .L2

.L2:
  cmpl %ebx, %edx                   # i-(n/2)
  jge .L3                           # jumps to .L3 if i>=(n/2)
  movq (%rdi, %rdx, 8), %rcx        # %rcx = *temp = list[i]
  movq %rsi, %r9                    # %r9 = n
  subq %rdx, %r9                    # %r9 = n-i
  dec %r9                           # %r9 = n-i-1           
  movq (%rdi, %r9, 8), %r8          # %r8 = list[n-i-1]
  movq %r8 ,(%rdi, %rdx, 8)         # list[i] = %r8 = list[n-i-1]
  movq %rcx, (%rdi, %r9, 8)         # list[n-i-1] = temp 
  inc %rdx                          # i++
  jmp .L2                           # jumps to .L2

.L3: 
  ret                               # return


# void reverse(char **list, unsigned n){
#     unsigned i = 0;
#     while (i < n/2){
#      char *temp = list[i];
#      list[i] = list[n-i-1];
#      list[n-i-1] = temp;
#      i++;
#     }
# }
