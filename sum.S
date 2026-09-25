.global sum
# pointer to list head in %rdi; result in %rax
# struct ll { char *name; long value; struct ll *next; }
#   offset 0  : name
#   offset 8  : value
#   offset 16 : next
sum:
    movq $0, %rax                  # %rax = 0
    movq %rdi, %rbx                # ptr = list
    
.L1:
    test %rbx, %rbx                # %rbx & rbx // test for null
    je .L2                         # jumps to .L2 if %rbx==0 
    addq 8(%rbx), %rax             # total = total + ptr->value
    movq 16(%rbx), %rbx            # ptr = ptr->next
    jmp .L1                        # jumps to .L1

.L2:
    ret                             #return 


# sum of the elements of a linkedlist in C
# long sum(struct ll *list){
#    long total = 0;
#    struct ll *ptr = list;
#    while(ptr){
#        total += ptr->value;
#        ptr = ptr->next;
#    }
#    return total;
# }
