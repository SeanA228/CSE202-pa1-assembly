.global binsearch
# arr in %rdi, n in %esi, target in %edx
binsearch:
  movq $-1, %rax        # %rax = -1 
  movq $0, %rcx         # %rcx = low = 0
  movslq %esi, %r9      # %r9 = n 
  dec %r9               # n-- == high

.L1:
  movq %r9, %r8              # %r8 = high
  cmpq %rcx, %r8             # %r8 - %rcx // compare high and low
  js .L2                     # jump to .L2 if low>high
  sub %rcx, %r9              # %r9 = high - low
  shrq $1, %r9               # %r9 = high / 2 
  addq %rcx, %r9             # %r9 = high + low = mid
  cmpl (%rdi, %r9, 4), %edx  # target - arr[mid]
  jg .L3                     # jump to .L3 if arr[mid]<target
  jl .L4                     # jump to .L4 if arr[mid]>target
  movq %r9, %rax             # %rax = mid 
  ret                        # return

.L2:
  ret                        # return

.L3:
  inc %r9                    # mid++
  movq %r9, %rcx             # low = mid
  movq %r8, %r9              # %r9 = high
  jmp .L1

.L4: 
  dec %r9                    # mid-- 
  jmp .L1


# binary search over a sorted int array; returns the index of target, or -1
# int binsearch(int *arr, unsigned n, int target){
#     int lo = 0;
#     int hi = (int)n - 1;
#     while(lo <= hi){
#         int mid = lo + (hi - lo) / 2;
#         if(arr[mid] == target)
#             return mid;
#         else if(arr[mid] < target)
#             lo = mid + 1;
#         else
#             hi = mid - 1;
#     }
#     return -1;
# }
