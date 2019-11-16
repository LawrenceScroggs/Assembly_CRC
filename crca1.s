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


.text##########################################################
crcInit:

  #%rax will hold remainder
  #%rbx will hold divedend
  #%rcx will hold bit

  xorq  0,%rbx #initialize dividend to zero for loop
  jmp .loop_1

.loop_1:

  movq %rbx,%rax  # remainder = dividend
  movq 8, %rcx  # intialize bit to 8 for loop

  jmp .loop_2
  
  incq %rbx
  cmpq %rbx, 256
  jl .loop_1:

  ret

.loop_2:



.data##########################################################

crcTable:
    .rept 256
    .byte 0
    .endr

###############################################################

   












