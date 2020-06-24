#gcd

.data
argument1: .word 512
argument2: .word 480
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
		lw       t0, argument1 # reg t0 = m
		lw       t1, argument2 # reg t1 = n
		jal      ra, gcd # jump to gcd
		
        li       a0, 10
        ecall
		
gcd:
		beq      t1, zero, printResult
		
		rem      t3, t0, t1 # reg t3 = r
		mv       t0, t1
		mv       t1, t3
		j        gcd
		
printResult:

        la       a1, str1
        li       a0, 4
        ecall

        lw       a1, argument1
        li       a0, 1
        ecall

        la       a1, str2
        li       a0, 4
        ecall
		
        lw       a1, argument2
        li       a0, 1
        ecall
		
        la       a1, str3
        li       a0, 4
        ecall
		
		mv       a1, t0
        li       a0, 1
        ecall

        ret