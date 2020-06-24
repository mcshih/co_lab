###bubble_sort###

.data
argument: .word 10
arr: .word 5, 3, 6, 7, 31, 23, 43, 12, 45, 1
str1: .string "Array: "
str2: .string "Sorted: "
space: .string " "
new_line: .string "\n"

.text
main:
        addi     sp, sp, -64
        sw       ra, 60(sp)
        sw       s0, 56(sp)
        addi     s0, sp, 64
		
		la       t0, arr
		addi     t2, s0, -48
		addi     t3, zero, 0
		lw       t4, argument
load:
		bge      t3, t4, conti
		lw       t1, 0(t0)
		mv       a0, t1
		sw       a0, 0(t2)
		
		addi     t0, t0, 4
		addi     t2, t2, 4
		addi     t3, t3, 1
		j        load
conti:		
		la       a1, str1
        li       a0, 4
        ecall
		la       a1, new_line
        li       a0, 4
        ecall
		
		addi     t2, s0, -48
		addi     t3, zero, 0
		jal      ra, printArray
		
		mv       a0, zero # inti i
        sw       a0, -52(s0)
		
		# sorting
outerloop:
        lw       a0, -52(s0) # i = 0
        lw       a1, argument
		addi     a1, a1, -1       
        blt      a1, a0, exit1 # go to exit1 if 9 < i
		
        addi    a0, a0, -1 # j = i - 1
        sw      a0, -56(s0)
		
inner_loop:
        lw      a0, -56(s0) # j
        mv      a1, zero
        blt     a0, a1, exit2 # j < 0
        
		# if(data[j] > data[j+1])
		lw      a0, -56(s0)
        slli    a0, a0, 2
        addi    a1, s0, -48
        add     a0, a0, a1
        lw      a1, 0(a0) # reg a1 = data[j]
        lw      a0, 4(a0) # reg a0 = data[j+1]
        bge     a0, a1, update_j
		
		# swap function
		lw      a0, -56(s0) # iter j
        slli    a0, a0, 2
        addi    a1, s0, -48 # data
		add     t1, a0, a1 # reg t1 = data[j]
		
        lw      t0, 0(t1) # reg t0 (temp) = data[j]
        lw      t2, 4(t1) # reg t2 = data[j+1]
        sw      t2, 0(t1) # data[j] = data[j+1]
        sw      t0, 4(t1) # data[j+1] = temp
		
update_j:
        lw      a0, -56(s0)
        addi    a0, a0, -1 # j--
        sw      a0, -56(s0)
        j       inner_loop
		
exit2:
		lw      a0, -52(s0)
        addi    a0, a0, 1 # i++
        sw      a0, -52(s0)
        j       outerloop
		
exit1:
        la       a1, str2
        li       a0, 4
        ecall
		la       a1, new_line
        li       a0, 4
        ecall
		
		addi     t2, s0, -48
		addi     t3, zero, 0
		jal      ra, printArray
		
		# End program
		li       a0, 10
        ecall
		
printArray:
		lw      t4, argument
		bge     t3, t4, printNextLine
		lw      t0, 0(t2)
		li      a0, 1
		mv      a1, t0
		ecall
		la       a1, space
        li       a0, 4
        ecall
		
		addi    t2, t2, 4
		addi    t3, t3, 1
		j       printArray
		
printNextLine:
		la       a1, new_line
        li       a0, 4
        ecall
		
		ret