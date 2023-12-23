;******************** (C) Ayden Dauenhauer *******************************************
; @file    HW7 Problem 1
; @author  Ayden Dauenhauer
; @date    2023
;*************************************************************************************

	
			AREA    main, CODE, READONLY
			EXPORT	__main				
			ENTRY			
				
__main	PROC
	
			ldr		r0, =array		; Pointer to array of string pointers
			ldr		r1, =10			; Number of items in array
			bl		mysort			; Call sorting routine
endless		b		endless

		ENDP

mysort		PROC
			push 	{lr}			;Stores the return address
			mov 	r2, r0			;Copies the array address to r2 to be changed later
loop1		sub		r1, r1, #1		;Decrements the count
			mov		r7, r1			;Second counter for iterating the compare
			mov		r3, r2			;Set the start of the range
			mov		r4, r3			;Set to the next address part 1
			add		r4, r4, #4		;Set to the next address part 2
			bl		compare_and_swap
			bx		lr
			ENDP

compare_and_swap	PROC
compareloop	ldr		r5, [r3]		;Loads the first value into r5
			ldr		r6, [r4]		;Loads the next value into r6
			cmp		r5, r6			;Compares r5 and r6
			bgt		nextsmaller		;If r5>r6 then keep r4 and compare to the next number
			add		r4, r4, #4;		;Go to the next value
			sub		r7, r7, #1		;Decrement the count
			cmp		r7, #0			;Check if it's at the end of the list
			bgt		compareloop		;If not, then keep comparing
			;After reaching this line, the smallest value's address should be in r3 and the value in r5
			ldr		r5, [r3]		;Load the smallest number into r5
			ldr		r6, [r2]		;Load the address into r6
			str		r5, [r2]		;Store the address
			str		r6, [r3]		;Store the smallest number
			add		r2, r2, #4		;Go to the next address
			cmp		r1, #1			;Check if it's at the end of the list
			bgt		loop1			;If not then start the whole proccess over
			pop		{pc}			;If done, then return

nextsmaller	mov		r3, r4			;Swap the smallest number address into r3
			b		compareloop		;Go back to the compare function
			
			bx		lr
			ENDP
						
			ALIGN
			AREA mydata, DATA, READONLY

array		DCD 9,2,5,1,8,6,7,0,3,4


		END