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

  xorl  $0,%ebx #initialize dividend to zero for loop
  cmpl $256,%ebx
  jl .loop_1

.loop_1:

  movq %rbx,%r10  # remainder = dividend
  movq $8, %rcx  # bit = 8

  jmp .loop_2 #move to loop to for modulo to bit
  

  movb %al,(%r11,%r9,1) #assign remainder to dividend index


  ret

.loop_2:

  movq %r10,%r12  #holds remainder value
  salb $1,%r12b  # just shift << 1 
  andb $0x80,%r12b #see if the remainder is = 0
  jne .poly_jump  # if result is > 0 jump to poly 

  decq %rcx  # --bit
  cmpq $0,%rcx
  jg .loop_2

  movq %r12,%r10
  incl %ebx
  cmpl $256,%ebx
  jmp .loop_1 # end of loop 2
  

.poly_jump:

  xorb $0xD5,%r12b # then ^ POLYNOMIAL
  decq %rcx # --bit

  jmp .loop_2

crcFast:
  
  #byte = %r13
  #remainder = %r14
  #data = %r15

  xorq $0,%r13 #byte = 0
  xorb $0,%r14b #set remainder to 0
  xorb $0,%r15b #data to 0

  cmpq %rsi,%r13

  jl .fast_loop


.fast_loop:

  movb (%rdi,%r13,1),%r15b #assign data
  xorb %r14b,%r15b #data = msg[byte]^rmndr
  movb (%r11,%r15,1),%r14b

  incq %r13
  cmpq %rsi,%r13

  jl .fast_loop
  jmp .to_end

.to_end:

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

   












