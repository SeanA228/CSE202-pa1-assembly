.global area
# a in %edi, b in %esi, c in %edx; result in %eax
area:
    movl %edi, %r8d             # %r8d = a
    addl %esi, %r8d             # %r8d = a + b
    addl %edx, %r8d             # %r8d = a + b + c
    shrl $1, %r8d               # %r8d = (a + b + c) / 2 = p
    movl %r8d, %r9d             # %r9d = p
    movl %r8d, %r10d            # %r10d = p
    movl %r8d, %r11d            # %r11d = p
    subl %edi, %r9d             # %r9d = p-a
    subl %esi, %r10d            # %r10d = p-b
    subl %edx, %r11d            # %r11d = p-c
    imul %r10d, %r11d           # %r11d = (p-c) * (p-b)
    imul %r9d, %r11d            # %r11d = (p-c) * (p-b) * (p-a)
    imul %r8d, %r11d            # %r11d = (p-c) * (p-b) * (p-a) * p
    movl %r11d, %eax            # %eax = (p-c) * (p-b) * (p-a) * p
    call r_sqrt                 # calls r_sqrt
    retq

r_sqrt:
    movl %eax, %r13d            # %r13d = x
    cmpl $0, %eax               # x - 0
    js .L1                      # jumps to .L1 if x<0
    cmpl $2, %eax               # x-2 
    js .L2                      # jumps to .L2 if x<2
    push %r13                   # push x
    shrl $2, %eax               # x = x>>2
    call r_sqrt                 # recursive call to r_sqrt
    shll $1, %eax               # rsqrt(x>>2)<<1
    movl %eax, %r12d            # %r12d = rsqrt(x>>2)<<1 = small_cand
    movl %r12d, %r14d           # %r14d = small_cand 
    inc %r12d                   # large_cand = small_cand + 1
    imul %r12d, %r12d           # large_cand = large_cand * large_cand
    pop %r13                    # pop x
    cmp %r12d, %r13d            # %r13d - %r12d
    js .L3                      # jumps to .L3 if x>large_cand* large_cand
    movl %r14d, %eax            # %eax = small_cand
    inc %eax                    # large_cand
    ret                         # return large_cand

.L1:
    movl $-1, %eax              # %eax = -1
    ret                         # return -1

.L2:
    ret                         # return x

.L3:
    movl %r14d, %eax            # %eax = small_cand
    ret                         # return small_cand 

# int area(int a, int b, int c){
#     int p = (a + b + c)/2;
#     p = p * (p-a) * (p-b) * (p-c);
#     return sqrt(p);
# }
# calculate recursively the square root of an int (in C)
# int r_sqrt(int x){
#    if(x < 0)
#        return -1;
#    if (x < 2)
#        return x;
#   /* recursive call */
#    int small_cand = r_sqrt(x >> 2) << 1;
#    int large_cand = small_cand + 1;
#    if (large_cand * large_cand > x)
#        return small_cand;
#    else
#        return large_cand;
# }
