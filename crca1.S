# Lawrence Scroggs Homework 2 CS201 10/30/19##############
#                                                        #
# In this program I am taking the functions written in C #
# and converting them into two different Assembly code   #
# programs.  A practice example where I learn the basics #
# of Assembly and then an Optimized version of the same  #
# code to learn how to write the code in a more efficient#
# way.                                                   #
#                                                        #
##########################################################

.globl crcTable, crcInit, crcFast

##########################################################
.text                                                    #
##########################################################
crcInit:

  lea crcTable(%rip),%r11 #sets array to a register
  #%r10 will hold remainder
  #%rbx will hold divedend
  #%rcx will hold bit

  xorq  $0,%rbx #initialize dividend to zero for loop
  cmpq $256,%rbx
  jl .loop_1

.loop_1:

  movq %r10,%rbx  # remainder = dividend
  movq $8, %rcx  # bit = 8

  jmp .loop_2 #move to loop to for modulo to bit
  

  movq %rax,(%r11,%r9,1) #assign remainder to dividend index

  incq %r9
  cmpq $256,%r9

  jl .loop_1

  ret

.loop_2:

  test $0x80,%r10 #see if the remainder is = 0
  jne .poly_jump  # if result is > 0 jump to poly 
  shlq $1,%r10  # else just shift << 1

  decq %rcx
  cmpq $0,%rcx
  jg .loop_2

  movq %r10,%rax
  
  ret

.poly_jump:

  shlq $1,%r10  # shift << 1
  xorq $0xD5,%r10 # then ^ POLYNOMIAL

  movq %r10,%rax

  ret

crcFast:
  
  #byte = %r13
  #remainder = %r14
  #data = %r15

  xorq $0,%r13 #byte = 0
  xorq $0,%r14 #set remainder to 0

  cmpq %rsi,%r13

  jl .fast_loop

  movq %r14,%rax

  ret

.fast_loop:

  movq (%rdi,%r13,1),%r15
  xorq %r14,%r15 #data = msg[byte]^rmndr
  movq (%r11,%r15,1),%r14

  incq %r13
  cmpq %rsi,%r13

  jl .fast_loop

  movq %r14,%rax

  ret


##########################################################
.data                                                    #
##########################################################

crcTable:
    .rept 256
    .byte 0
    .endr

###############################################################

   












