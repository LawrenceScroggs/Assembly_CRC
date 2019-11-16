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
  #%rax will hold remainder
  #%rbx will hold divedend
  #%rcx will hold bit

  xorq  $0,%rbx #initialize dividend to zero for loop
  jmp .loop_1

.loop_1:

  movq %rbx,%rax  # remainder = dividend
  movb $8, %cl  # intialize bit to 8 for loop

  jmp .loop_2 #move to loop to for modulo to bit
  
  incq %rbx
  cmpq $256,%rbx

  movq %rax,(%r11,%rbx,1) #assign remainder to dividend index


  jl .loop_1

  ret

.loop_2:

  test $0x80,%rax #see if the remainder is = 0
  jne .poly_jump  # if result is = 0 jump to poly 
  shlq $1,%rax  # else just shift << 1

  inc %cl
  cmp %cl,8
  jl .loop_2
  
  ret

.poly_jump:

  shlq $1,%rax  # shift << 1
  xorq $0xD5,%rax # then ^ POLYNOMIAL

  ret

crcFast:
  
  #byte = %rbp
  #remainder = %r14
  #data = %r15

  xorq $0,%r14 #set remainder to 0
  xorq $0,%rbp #byte = 0

  cmpq %rbp,%rax

  jle .fast_loop

.fast_loop:

  xorq (%rax,%rbp),%r14 #data = msg[byte]^rmndr
  movq (%rax,%rbp),%r15
  movq (%r11,%r15),%r14

  incq %rbp
  cmpq %rbp,%rax

  jle .fast_loop

  ret


  



##########################################################
.data                                                    #
##########################################################

crcTable:
    .rept 256
    .byte 0
    .endr

###############################################################

   












