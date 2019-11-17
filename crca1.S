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
  #%r10 will hold remainder - char
  #%rbx will hold dividend - int
  #%rcx will hold bit - char

  movq  $0,%rbx #initialize dividend to zero for loop
  cmpq $256,%rbx   # is dividend = 256?
  jl .loop_1

.loop_1:

  movq %rbx,%r10  # remainder = dividend
  movq $8,%rcx  # bit = 8

  cmpl $256,%ebx
  jl .loop_2 #move to loop to for modulo to bit

  jmp .end_init # @ end of function

.loop_2:

  movq %r10,%r12 #holds remainder value
  salb $1,%r10b  # just shift remainder << 1 
  andb $0x80,%r12b #see if the remainder is = 0
  cmpb $0,%r12b
  jne .poly_jump  # if result is > 0 jump to polynomial 

  decq %rcx  #decrement loop2
  cmpb $0,%cl  # is bit > 0
  jg .loop_2  # end of loop2 -- goto assign value
  jmp .add_array

.poly_jump:

  xorb $0xD5,%r10b # then ^ POLYNOMIAL
  decq %rcx #decrement loop2

  cmpb $0,%cl 
  jg .loop_2  # end of loop 2 add to the array
  jmp .add_array

.add_array:

  movb %r10b,(%r11,%rbx,1) #assign remainder to dividend index
  incq %rbx #increment loop1
  cmpl $256,%ebx
  jmp .loop_1 

.end_init:
  ret
  
crcFast:
  #byte = %r13
  #remainder = %rax since I will be returning remainder
  #data = %r15
  #crcTable = %r11
  
  lea crcTable(%rip),%r11 #sets array to a register
  xorq $0,%r13 #byte = 0
  xorq $0,%rax #set remainder to 0
  xorq $0,%r15 #data to 0
 
  jl .fast_loop # jump if less 

.fast_loop:
  cmpq %rsi,%r13  # compare bytes to Nbytes
  jge .to_end  # go to end if reach condition
  movb (%rdi,%r13),%r15b #assign data
  xorb %al,%r15b #msg[byte]^rmndr
  movb (%r11,%r15),%al #assign remainder

  incq %r13  #increment
  cmpq %rsi,%r13

  jl .fast_loop
  jmp .to_end

.to_end:
  ret

##########################################################
.data                                                    #
##########################################################

crcTable:
    .rept 256
    .byte 0
    .endr

###############################################################

   












