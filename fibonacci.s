.data
argument: .word 10
str: .string "th number in the Fibonacci sequence is "

.text
main:
		li       t0, 0
		li       t1, 1
  
		lw       t3, argument # reg t3 = 10
		# prints t3
		li       a0, 1
		mv       a1, t3
		ecall
		
		# fibonnaci loop
fib:
		beq      t3, zero, End
		add      t2, t1, t0
		mv       t0, t1
		mv       t1, t2
		addi     t3, t3, -1
		j fib
		
End:
		# prints str
        la       a1, str
        li       a0, 4
        ecall
		# prints the result in t0
		li a0, 1
		mv a1, t0
		ecall
		
		# ends the program
		li a0, 10
		ecall