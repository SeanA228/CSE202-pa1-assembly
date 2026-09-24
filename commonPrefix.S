.global commonPrefix
# a in %rdi, b in %rsi; result (prefix length) in %eax
commonPrefix:
  movl $0, %eax     # n=0

.L1:
  movb (%rdi, %rax, 1), %cl       # %cl = a[n]
  andb %cl, %cl                   # a[n] = a[n] && a[n]
  setne %dl                       # sets %dl to 1 if a[n] && a[n]
  movb (%rsi, %rax, 1), %r8b      # %r8b = b[n]
  cmpb $0, %dl                    # %dl - 0
  je .L2                          # jumps to .L2 if %dl=0, there is a null terminator
  cmpb %cl, %r8b                  # %r8b - %cl
  jne .L2                         # jumps to .L2 if %r8b != %cl (a[n]!=b[n])
  inc %eax                        # n++
  jmp .L1                         # jumps to .L1
  
.L2:
  retq


# length of the longest common prefix of two null-terminated strings
# int commonPrefix(char *a, char *b){
#     int n = 0;
#     while(a[n] && a[n] == b[n])
#         n++;
#     return n;
# }
