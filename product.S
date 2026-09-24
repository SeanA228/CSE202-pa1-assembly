.global product
# a in %rdi, b in %rsi, c in %rdx, size in %ecx
product:
    movq $0, %rbx                   # %rbx = i = 0
    movslq %ecx, %rcx               # move signed %ecx to %rcx
    jmp .L1                         # jump to .L1
    
.L1:
    cmpq %rcx, %rbx                         # i - size 
    jge .L2                                 # jump to .L1 if i>=size
    movss (%rdi, %rbx, 4), %xmm1            # move A[i] into %xmm1
    vmulss (%rsi, %rbx, 4), %xmm1, %xmm1    # A[i] = A[i] * B[i]
    movss %xmm1, (%rdx, %rbx, 4)            # C[i] = A[i] * B[i]
    inc %rbx                                # i++          
    jmp .L1                                 # jumps to .L1

.L2:
    ret                             # return

# Product of two vectors in C
# void product(float *a, float *b, float *c, unsigned size){
#    for(int i=0; i<size; i++){
#        c[i] = a[i] * b[i];
#    }
# }
