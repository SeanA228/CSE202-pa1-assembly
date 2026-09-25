.global secondMax
# v1 in %di, v2 in %si, v3 in %dx, v4 in %cx  (signed 16-bit); result in %ax
secondMax:
  cmpw %di, %si         # %si - %di // v2 - v1
  jg .L2                # jump if v2>v1
  movw %di, %r8w        # %r8w = v1 = first
  movw %si, %r9w        # %r9w = v2 = second
  jmp .L3               # jumps to .L3

.L2: 
  movw %si, %r8w         # %r8w = first = v2
  movw %di, %r9w         # %r9w = second = v1

.L3:
  cmpw %dx, %r8w         # first - v3
  jl .L4                 # jumps to .L4 if %dx>%r8w // v3 > first
  cmpw %dx, %r9w         # second - v3
  jl .L5                 # jump to .L5 if %dx>%r9w // v3 > second
  jmp .L6                # jump to .L6

.L4:
  movw %r8w, %r9w        # second = first
  movw %dx, %r8w         # first = v3
  jmp .L6                # jumps to .L6

.L5:
  movw %dx, %r9w         # second = v3

.L6:
  cmpw %cx, %r8w         # first - v4
  jl .L7                 # jump to .L7 if %cx>%r8w // v4 > first
  cmpw %cx, %r9w         # second - v4
  jl .L8                 # jump to .L8 if %cx>%r9w // v4 > second
  jmp .L9                # jumps to .L9

.L7:
  movw %r8w, %r9w        # second = first
  movw %cx, %r8w         # first = v4
  jmp .L9                # jumps to .L9

.L8:
  movw %cx, %r9w         # second = v4

.L9:
  movw %r9w, %ax         # %ax = second
  retq                   # return second


# short secondMax(short v1, short v2, short v3, short v4){
#     short first, second;
#     if(v1 >= v2){ first = v1; second = v2; }
#     else        { first = v2; second = v1; }
#     if(v3 > first)       { second = first; first = v3; }
#     else if(v3 > second) { second = v3; }
#     if(v4 > first)       { second = first; first = v4; }
#     else if(v4 > second) { second = v4; }
#     return second;
# }
