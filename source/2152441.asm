#-----------------------------------------------------------#
#		PROJECT COMPUTER ARCHITECTURE		    #
#		      GAME: 4 IN A ROW			    #
#		     Author: Vu Nam Binh		    #
#		      Stu. ID: 21252441			    #
#		      Date: 27/03/2023			    #
#-----------------------------------------------------------#
.data
	board: .ascii"+---+---+---+---+---+---+---+"
	       .ascii"|   |   |   |   |   |   |   |"
	       .ascii"+---+---+---+---+---+---+---+"
	       .ascii"|   |   |   |   |   |   |   |"
	       .ascii"+---+---+---+---+---+---+---+"
	       .ascii"|   |   |   |   |   |   |   |"
	       .ascii"+---+---+---+---+---+---+---+"
	       .ascii"|   |   |   |   |   |   |   |"
	       .ascii"+---+---+---+---+---+---+---+"
	       .ascii"|   |   |   |   |   |   |   |"
	       .ascii"+---+---+---+---+---+---+---+"
	       .ascii"|   |   |   |   |   |   |   |"
	       .ascii"+---+---+---+---+---+---+---+"
	X: .ascii"X"
	O: .ascii"O"
	yourpiece: .asciiz"Your piece: "
	X1: .asciiz"X. \n"
	O1: .asciiz"O. \n"
	name1: .space 20
	name2: .space 20
	winner: .asciiz"Congratulation!!! The winner of this game is: "
	numberofpiece: .asciiz"The number of pieces: "
	is: .asciiz" is: "
	choosename: .asciiz"Please choose a name: \n"
	printboard1sttime: .asciiz"This is the board, where you'll play: \n"
	endline: .asciiz"\n"
	space: .ascii" "
	chance: .word 0, 0
	prechance: .word 0, 0
	recentdrop: .space 8
	player1: .word 3, 3, 0, 1, 1
	player2: .word 3, 3, 0, 1, 1
	.eqv colSize 29		#constant size of column
	.eqv rowSize 13		#constant size of row
	.eqv colmax 7
	.eqv rowmax 6
	
	hello: .asciiz"Hello! Welcome to 4 in a row!!!\n"
	letsstart: .asciiz"Now, let's start our game!!!\n"
	choice: .asciiz"Please choose what you want here, "
	dauhaicham: .asciiz": "
	
	choice1: .asciiz"Enter 1 to drop the piece.\n"
	choice2: .asciiz"Enter 2 to remove one arbitrary piece of your opponent.\n"
	choice3: .asciiz"You have to choose 1 or 2!!! \n"
	choosecolumn: .asciiz"Please choose a column: \n"
	
	warning_1stdrop: .asciiz"Violation!!! You must choose the center column for yout first drop!!!\n"
	dropoutboard: .asciiz"Violation! You dropped out of board!!!\n"
	dropfullcolumn: .asciiz"Violation! You dropped piece into a full column!!!\n"
	
	askundo: .asciiz"Do you want to undo your move? Enter 1 for Yes, 0 for No!\n"
	violation1stmove: .asciiz"Violation! This is your first move, you can not undo!!!\n"
	undo3times: .asciiz"Violation! You used undo 3 times, you are not allowed to use this function!!!\n"
	reaskforundo: .asciiz"You have to choose 1 for Yes or 0 for No!!! Please choose again: \n"
	
	invalidremove: .asciiz"Violation! You can only remove your opponent's piece when your opponent has at least 1 piece on board.\n"
	alreadyremove: .asciiz"Violation! You removed your opponent's piece one time before!\n"
	choose_remove: .asciiz"Please choose a piece that you want to remove following this way: \n"
	way_remove: .asciiz"Enter the position of your opponent's piece that you want to remove. \n"
	example_remove: .asciiz"For example if you want to remove a piece at row 4, column 5, please input 4, press enter to newline and continue inputting 5. \n"
	remove_space: .asciiz"Violation! This is just an empty position!!!\n"
	self_remove: .asciiz"Violation! This cell contains your piece, not your opponent!!!\n"
	remove_outboard: .asciiz"You chose a position outside of the board! Please choose again: \n"
	
	askblock: .asciiz"Do you want to block your opponent's next move? Enter 1 for Yes, 0 for No! \n"
	opponenthaschance: .asciiz"Violation! Your opponent is having a chance to win this game. You can not use block function!!! \n"
	alreadyblock: .asciiz"Violation! You blocked your opponent one time before!!! \n"

	result1: .asciiz"1) The number of remaining violation: "
	result2: .asciiz"2) The number of remaining undo: "
	result3: .asciiz"3) Player's name: "
	
	violate3times: .asciiz"You violated more than 3 times, "
	dauchamthan: .asciiz"!!!\n"
	
	Final_board: .asciiz"Final board: \n"
	TIEGAME: .asciiz"TIE GAME!!!\n"
	GOODBYE: .asciiz"Hope that both of you had a great time enjoying this game! See you next match!!!\n"
.text
main:
	#print hello
	li $v0,4
	la $a0,hello
	syscall
	#Player 1 choose name
	la $a0,choosename
	syscall
	li $v0,8
	la $a0,name1
	li $a1,20
	syscall
	#Player 2 choose name
	li $v0,4
	la $a0,choosename
	syscall
	li $v0,8
	la $a0,name2
	li $a1,20
	syscall
	#Print board
	li $v0,4
	la $a0,printboard1sttime
	syscall
	la $a0,board
	jal drawboard
	li $v0,4
	la $a0,endline
	syscall
	
	li $s0,0	#step
	li $s1,0	#turn=false
	
	while_loop:
	li $t0,42
	beq $s0,$t0,exit
		#Print choose what you want
		li $v0,4
		la $a0,choice
		syscall
		li $t0,1
		beq $s1,$t0,pl2
			li $v0,4
			la $a0,name1
			syscall
			la $a0,yourpiece
			syscall
			la $a0,X1
			syscall
		j exit_pl2
		pl2:
			li $v0,4
			la $a0,name2
			syscall
			la $a0,yourpiece
			syscall
			la $a0,O1
			syscall
		exit_pl2:
		li $v0,4
		la $a0,choice1
		syscall
		la $a0,choice2
		syscall
		li $v0,5	#v0=input
		syscall
		li $t1,0	#violate=false
		li $t2,2	#if input==2
		
		beq $v0,$t2,input2	#if input==2
		li $t2,1
		beq $v0,$t2,input1
		j elseinput
		input1:
			li $v0,4
			la $a0,choosecolumn
			syscall
			li $v0,5
			syscall		#input col
			addi $s3,$v0,0
			addi $t5,$v0,0
			#outcolumn:
			beq $s1,$t0,input1_pl2	#if !turn
				slt $t3,$s3,$t0	#if column<1
				beq $t3,$t0,out_column
				li $t2,7
				sgt $t2,$s3,$t2
				beq $t2,$t0,out_column	#if column>7
				j exit_outcolumn
					out_column:
					li $v0,4
					la $a0,dropoutboard
					syscall
					li $t1,1	#violate==true
					la $t2,player1	#player1[0]--
					lw $t3,0($t2)
					addi $t3,$t3,-1
					sw $t3,0($t2)
					j block
				exit_outcolumn:		#else
				li $t0,0
				li $t2,4
				bne $s0,$t0,validcol
					beq $s3,$t2,validcol
					li $v0,4
					la $a0,warning_1stdrop
					syscall
					li $t1,1
					la $t2,player1
					lw $t3,0($t2)
					addi $t3,$t3,-1
					sw $t3,0($t2)
					j block
				validcol:
					addi $t2,$s3,-1
					li $t3,4
					mul $t2,$t2,$t3
					addi $t2,$t2,2
					la $a0,board	#string board[13][29]
					la $a1,X	#char piece
					addi $a2,$s3,-1
					li $t7,4
					mul $a2,$a2,$t7
					addi $a2,$a2,2	#int incol
					jal drop
					li $s7,-1
					bne $v0,$s7,updaterecentdrop_1	#if v0==-1 => full col => reset turn,violate
						li $v0,4
						la $a0,dropfullcolumn
						syscall
						la $s7,player1
						lw $t7,0($s7)
						addi $t7,$t7,-1
						sw $t7,0($s7)	#player1[0]--
						li $t1,1
						j block
					updaterecentdrop_1:
					la $t0,recentdrop
					sw $v0,0($t0)
					la $a0,board
					jal drawboard
					la $t0,player1	#t0=&player1[0]
					lw $t2,8($t0)	#t2=player1[2]
					addi $t2,$t2,1	#player1[2]--
					sw $t2,8($t0)
					addi $s0,$s0,1
					li $t0,5
					sgt $t2,$s0,$t0
					li $t0,1
					bne $t2,$t0,askforundo
						la $a0,board	#string board[13][29]
						la $a1,X	#string piece
						addi $a2,$s3,-1	#int recentcol
						li $t7,4
						mul $a2,$a2,$t7
						addi $a2,$a2,2
						la $t2,recentdrop
						lw $a3,0($t2)	#int recentrow
						jal checkwin
						li $t6,1
						bne $v0,$t6,askforundo
							li $v0,4
							la $a0,winner
							syscall
							la $a0,name1
							syscall
							la $a0,numberofpiece
							syscall
							la $t6,player1
							lw $a0,8($t6)
							li $v0,1
							syscall
							la $a0,endline
							li $v0,4
							syscall
							j exit_winner
					askforundo:
					la $a0,askundo	#cout<<"Do you want to undo your move?"
					li $v0,4
					syscall
					chooseundoagain_1:
					li $v0,5
					syscall		#cin>>undo
					addi $t6,$v0,0	#t6=undo
					li $t5,1
					bne $t6,$t5,elseundo
						li $t5,0
						bne $s0,$t5,elsestep	#if step!=0
						la $a0,violation1stmove
						li $v0,4
						syscall	
						la $t5,player1
						lw $t6,0($t5)
						addi $t6,$t6,-1
						sw $t6,0($t5)
						j block
						elsestep:
							la $t5,player1
							lw $t6,4($t5)
							li $t4,0
							bne $t6,$t4,elseinnerstep	#if player1[1]!=0
								la $a0,undo3times
								li $v0,4
								syscall
								la $t5,player1
								lw $t6,0($t5)
								addi $t6,$t6,-1
								sw $t6,0($t5)
								j block
							elseinnerstep:
								la $t5,chance
								la $t6,prechance
								lw $t6,0($t6)	#prechance[0]
								sw $t6,0($t5)	#chance[0]=prechance[0]
								la $t4,recentdrop
								lw $t4,0($t4)	#recentdrop1
								mul $t4,$t4,colSize	#rowI * colS
								addi $t7,$s3,-1
								li $t6,4
								mul $t7,$t7,$t6
								addi $t7,$t7,2
								add $t4,$t4,$t7		#rowI * colS + colI
								la $s7,space
								lb $s7,0($s7)
								sb $s7,board($t4)
								addi $s0,$s0,-1		#step--
								la $a0,board
								jal drawboard		#printboard
								la $t5,player1
								lw $t6,4($t5)
								addi $t6,$t6,-1
								sw $t6,4($t5)		#player1[1]--
								j while_loop		#continue
					elseundo:
						li $t7,0
						bne $t6,$t7,reaskundo_1	#if input undo <0,>1
						slti $t7,$s0,4
						li $s7,1
						beq $t7,$s7,block	#if step<4 =>no need to checkchance
						la $a0,board	#board
						la $a1,X	#X
						addi $a2,$s3,-1	#col
						li $t7,4
						mul $a2,$a2,$t7
						addi $a2,$a2,2
						la $a3,recentdrop
						lw $a3,0($a3)
						jal chancetowin
						li $t4,1
						bne $v0,$t4,block
						la $t4,chance
						li $t5,1
						sw $t5,0($t4)
						j block
						reaskundo_1:
							li $v0,4
							la $a0,reaskforundo
							syscall
							j chooseundoagain_1
			input1_pl2:
				slti $t0,$s3,1	#if col<=0
				li $t2,1
				beq $t0,$t2,outcolumn_2
				li $t2,7
				sgt $t2,$s3,$t2	#if col>=8
				li $t3,1
				beq $t2,$t3,outcolumn_2
				j exit_outcolumn_2
					outcolumn_2:
					li $v0,4
					la $a0,dropoutboard
					syscall
					li $t1,1	#violate==true
					la $t2,player2	#player1[0]--
					lw $t3,0($t2)
					addi $t3,$t3,-1
					sw $t3,0($t2)
					j block
				exit_outcolumn_2:
					li $t0,1
					li $t2,4
					bne $s0,$t0,validcol_2
					beq $s3,$t2,validcol_2
						li $v0,4
						la $a0,warning_1stdrop
						syscall
						li $t1,1	#violate=true
						la $t2,player2
						lw $t3,0($t2)
						addi $t3,$t3,-1
						sw $t3,0($t2)	#player2[0]--
						j block
					validcol_2:
					addi $t2,$s3,-1
					li $t3,4
					mul $t2,$t2,$t3
					addi $t2,$t2,2
					la $a0,board	#string board[13][29]
					la $a1,O	#char piece
					addi $a2,$s3,-1
					li $t7,4
					mul $a2,$a2,$t7
					addi $a2,$a2,2	#int incol
					jal drop
					li $s7,-1
					bne $v0,$s7,updaterecentdrop_2
						li $v0,4
						la $a0,dropfullcolumn
						syscall
						la $s7,player2
						lw $t7,0($s7)
						addi $t7,$t7,-1
						sw $t7,0($s7)
						li $t1,1
						j block
					updaterecentdrop_2:
					la $t0,recentdrop
					sw $v0,4($t0)	#recentdrop2
					la $a0,board
					jal drawboard
					la $t0,player2	#t0=&player1[0]
					lw $t2,8($t0)	#t2=player2[2]
					addi $t2,$t2,1	#player1[2]++
					sw $t2,8($t0)
					addi $s0,$s0,1
					li $t0,5
					sgt $t2,$s0,$t0	#if step>=7
					li $t0,1
					bne $t2,$t0,askforundo_2
						la $a0,board	#string board[13][29]
						la $a1,O	#string piece
						addi $a2,$s3,-1	#int recentcol
						li $t7,4
						mul $a2,$a2,$t7
						addi $a2,$a2,2
						la $t2,recentdrop
						lw $a3,4($t2)	#int recentrow
						jal checkwin
						li $t6,1
						bne $v0,$t6,askforundo_2
							li $v0,4
							la $a0,winner
							syscall
							la $a0,name2
							syscall
							la $a0,numberofpiece
							syscall
							la $a0,player2
							lw $a0,8($a0)
							li $v0,1
							syscall
							la $a0,endline
							li $v0,4
							syscall
							j exit_winner
					askforundo_2:
					la $a0,askundo	#cout<<"Do you want to undo your move?"
					li $v0,4
					syscall
					chooseundoagain_2:
					li $v0,5
					syscall		#cin>>undo
					addi $t6,$v0,0	#t6=undo
					li $t5,1
					bne $t6,$t5,elseundo_2
						li $t5,1
						bne $s0,$t5,elsestep_2	#if step!=1
						la $a0,violation1stmove
						li $v0,4
						syscall	
						la $t5,player2
						lw $t6,0($t5)
						addi $t6,$t6,-1
						sw $t6,0($t5)
						j block
						elsestep_2:
							la $t5,player2
							lw $t6,4($t5)
							li $t4,0
							bne $t6,$t4,elseinnerstep_2	#if player1[1]!=0
								la $a0,undo3times
								li $v0,4
								syscall
								la $t5,player2
								lw $t6,0($t5)
								addi $t6,$t6,-1
								sw $t6,0($t5)
								j block
							elseinnerstep_2:
								la $t5,chance
								la $t6,prechance
								lw $t6,4($t6)	#prechance[1]
								sw $t6,4($t5)	#chance[1]=prechance[1]
								la $t4,recentdrop
								lw $t4,4($t4)	#recentdrop2
								mul $t4,$t4,colSize	#rowI * colS
								addi $t7,$s3,-1
								li $t6,4
								mul $t7,$t7,$t6
								addi $t7,$t7,2
								add $t4,$t4,$t7		#rowI * colS + colI
								la $s7,space
								lb $s7,0($s7)
								sb $s7,board($t4)
								addi $s0,$s0,-1		#step--
								la $a0,board
								jal drawboard		#printboard
								la $t5,player2
								lw $t6,4($t5)
								addi $t6,$t6,-1
								sw $t6,4($t5)		#player1[1]--
								j while_loop		#continue
					elseundo_2:
						li $t7,0
						bne $t6,$t7,reaskundo_2
						slti $t7,$s0,4
						li $s7,1
						beq $t7,$s7,block	#if step<4 =>no need to checkchance
						la $a0,board	#board
						la $a1,O	#X
						addi $a2,$s3,-1	#col
						li $t7,4
						mul $a2,$a2,$t7
						addi $a2,$a2,2
						la $a3,recentdrop
						lw $a3,4($a3)
						jal chancetowin
						li $t4,1
						bne $v0,$t4,block
						la $t4,chance
						li $t5,1
						sw $t5,4($t4)
						j block
						reaskundo_2:
							li $v0,4
							la $a0,reaskforundo
							syscall
							j chooseundoagain_2
		input2:
			li $t0,1	#s1=turn	s0=step
			beq $s1,$t0,input2_pl2	#if turn==true
				slti $t0,$s0,1	#if step<1 (step=0)
				li $t2,1
				bne $t0,$t2,validremove	#if step>=1
					la $a0,invalidremove
					li $v0,4
					syscall
					la $t0,player1
					lw $t2,0($t0)
					addi $t2,$t2,-1
					sw $t2,0($t0)	#player1[0]--
					li $t1,1	#violate=true
					j block
				validremove:
					la $t0,player1
					lw $t0,16($t0)
					li $t2,0
					bne $t0,$t2,elsevalidremove
						la $a0,alreadyremove	#cout<<"You removed your opponent's piece..."
						li $v0,4
						syscall
						la $t0,player1
						lw $t2,0($t0)
						addi $t2,$t2,-1
						sw $t2,0($t0)		#violate=true
						li $t1,1
						j block
					elsevalidremove:
					la $a0,choose_remove
					li $v0,4
					syscall
					la $a0, way_remove
					syscall
					la $a0,example_remove
					syscall
					
					li $v0,5
					syscall
					addi $s4,$v0,0	#s4 = rowin
					li $v0,5
					syscall
					addi $s5,$v0,0	#s5 = colin
					
					slti $t7,$s4,1
					li $s7,1
					beq $t7,$s7,errorrowin_1	#if rowin<1
						li $s7,6
						sgt $t7,$s4,$s7
						li $s7,1
						beq $t7,$s7,errorrowin_1	#if rowin>6
							j checkcolin_1	#if 1<=rowin<=6
					errorrowin_1:
						li $v0,4
						la $a0,remove_outboard
						syscall
						j elsevalidremove
					checkcolin_1:
					slti $t7,$s5,1
					li $s7,1
					beq $t7,$s7,errorcolin_1
						li $s7,7
						sgt $t7,$s5,$s7
						li $s7,1
						beq $t7,$s7,errorcolin_1
							j calculaterowincolin_1
					errorcolin_1:
						li $v0,4
						la $a0,remove_outboard
						syscall
						j elsevalidremove
						
					calculaterowincolin_1:
					#calculate rowin
					addi $s4,$s4,-1	#s4 = rowin-1
					li $t2,2
					mul $s4,$s4,$t2	#s4 = (rowin-1)*2
					addi $s4,$s4,1	#s4 = 1 + (rowin-1)*2
					#calculate colin
					addi $s5,$s5,-1	#s5 = colin-1
					li $t2,4
					mul $s5,$s5,$t2	#s5 = (colin-1)*4
					addi $s5,$s5,2	#s5 = 2 + (colin-1)*4
					#Calculate board[rowin][colin]
					mul $t0,$s4,colSize	#rowI*colS
					add $t0,$t0,$s5		#rowI*colS + colI
					la $a0,board
					add $t0,$a0,$t0
					lb $t2,0($t0)
					la $s7,X
					lb $s7,0($s7)
					beq $t2,$s7,ifremoveX	#if board[rowin][colin]==X
					la $s7,space
					lb $s7,0($s7)
					beq $t2,$s7,ifspace	#if board[rowin][colin]==space
						la $a0,board	#board
						addi $a1,$s4,0	#rowin
						addi $a2,$s5,0	#colin
						jal removepiece
						la $a0,board
						jal drawboard
						addi $s0,$s0,-1	#step--
						la $t0,player2
						lw $t2,8($t0)
						addi $t2,$t2,-1
						sw $t2,8($t0)	#player2[2]--
						la $t0,player1
						lw $t2,16($t0)
						addi $t2,$t2,-1
						sw $t2,16($t0)	#player1[4]--
						#checkwin
						mul $s7,$s4,colSize
						add $s7,$s7,$s5
						add $s7,$s7,$a0
						lb $t7,0($s7)
						la $t2,space
						lb $t2,0($t2)
						beq $t7,$t2,askundoremove_1
						la $a0,board	#board
						addi $a1,$s4,0	#rowin
						addi $a2,$s5,0	#colin
						addi $t0,$s4,0
						for_checkwinremove_1:
							la $t2,space
							lb $t2,0($t2)
							addi $t7,$t0,0
							mul $t0,$t0,colSize
							add $t0,$t0,$s5
							add $t0,$a0,$t0
							lb $t5,0($t0)
							beq $t5,$t2,askundoremove_1	#when == space jump to askundoremove
								la $a0,board
								lb $a1,0($t0)
								la $s7,O
								lb $s7,0($s7)
								beq $a1,$s7,assignO_1
									la $a1,X
									j praparecheckwinremove_1
								assignO_1:
									la $a1,O
								praparecheckwinremove_1:
								addi $a3,$t7,0
								addi $a2,$s5,0
								jal checkwin
								li $t6,1
								bne $v0,$t6,increaseundoremove_1	#if still not win increase
									li $v0,4
									la $a0,winner
									syscall
									la $s7,X
									lb $s7,0($s7)
									beq $t5,$s7,inforname1_1
									la $s7,O
									lb $s7,0($s7)
									bne $t5,$s7,increaseundoremove_1
										la $a0,name2
										syscall
										la $a0,numberofpiece
										syscall
										la $a0,player2
										lw $a0,8($a0)
										li $v0,1
										syscall
										la $a0,endline
										li $v0,4
										syscall
										j exit_winner
									inforname1_1:
										la $a0,name1
										syscall
										la $a0,numberofpiece
										syscall
										la $a0,player1
										lw $a0,8($a0)
										li $v0,1
										syscall
										la $a0,endline
										li $v0,4
										syscall
										j exit_winner
						increaseundoremove_1:
						addi $t0,$t7,-2
						j for_checkwinremove_1
							askundoremove_1:
							la $a0,askundo
							li $v0,4
							syscall
							chooseundoremoveagain_1:
							li $v0,5
							syscall
							addi $t6,$v0,0
							slti $s7,$t6,0	#if input<0
							li $t7,1
							beq $t7,$s7,reaskundoremove_1
							li $t7,1
							sgt $s7,$t6,$t7
							li $t7,1
							beq $s7,$t7,reaskundoremove_1
								j inrangeundo_1
							reaskundoremove_1:
								li $v0,4
								la $a0,reaskforundo
								syscall
								j chooseundoremoveagain_1
							inrangeundo_1:
							li $t5,1
							bne $t6,$t5,checkchanceremove_1
								li $t5,0
								bne $s0,$t5,undo_remove_1
									la $a0,violation1stmove
									li $v0,4
									syscall
									la $s7,player1
									lw $t7,0($s7)
									addi $t7,$t7,-1
									sw $t7,0($s7)
									j block
								undo_remove_1:
									la $s7,player1
									lw $t7,4($s7)
									li $t6,0
									bne $t7,$t6,valid_undo_remove_1
										la $a0,undo3times
										li $v0,4
										syscall
										la $s7,player1
										lw $t7,0($s7)
										addi $t7,$t7,-1
										sw $t7,0($s7)
										j block
									valid_undo_remove_1:
									la $s7,prechance
									lw $t7,0($s7)
									la $t5,chance
									sw $t7,0($t5)
									la $a0,board
									la $a1,O
									lb $a1,0($a1)
									addi $a2,$s4,0
									addi $a3,$s5,0
									jal undoremove
									addi $s0,$s0,1
									la $a0,board
									jal drawboard
									la $s7,player1
									lw $t7,4($s7)
									addi $t7,$t7,-1
									sw $t7,4($s7)
									lw $t7,16($s7)
									addi $t7,$t7,1
									sw $t7,16($s7)
									j while_loop
							checkchanceremove_1:
								mul $s7,$s4,colSize
								add $s7,$s7,$s5
								add $s7,$s7,$a0
								lb $t7,0($s7)
								la $t2,space
								lb $t2,0($t2)
								beq $t7,$t2,block	#if remove ontop => no need to check chance
								la $a0,board	#board
								addi $a1,$s4,0	#rowin
								addi $a2,$s5,0	#colin
								addi $t0,$s4,0
								for_checkchanceremove_1:
									la $t2,space
									lb $t2,0($t2)
									addi $t7,$t0,0
									mul $t0,$t0,colSize
									add $t0,$t0,$s5
									add $t0,$a0,$t0
									lb $t5,0($t0)
									beq $t5,$t2,block	#when == space jump to askundoremove
										la $a0,board
										lb $a1,0($t0)
										la $s7,O
										lb $s7,0($s7)
										beq $a1,$s7,assignOcheckchance_1
											la $a1,X
											j praparecheckchanceremove_1
										assignOcheckchance_1:
											la $a1,O
										praparecheckchanceremove_1:
										addi $a3,$t7,0
										addi $a2,$s5,0
										jal chancetowin
										li $t6,1
										bne $v0,$t6,increasecheckchanceremove_1	#if still not win increase
											la $s7,X
											lb $s7,0($s7)
											beq $a1,$s7,Xhaschance
												la $s7,chance
												li $t7,1
												sw $t7,4($s7)
												j block
											Xhaschance:
												la $s7,chance
												li $t7,1
												sw $t7,0($s7)
												j block
								increasecheckchanceremove_1:
								addi $t0,$t7,-2
								j for_checkchanceremove_1						
					ifspace:
						la $a0,remove_space
						li $v0,4
						syscall
						la $t0,player1
						lw $t2,0($t0)
						addi $t2,$t2,-1
						sw $t2,0($t0)	#player1[0]--
						li $t1,1	#violate=true
						j block
					ifremoveX:
						la $a0,self_remove
						li $v0,4
						syscall
						la $t0,player1
						lw $t2,0($t0)
						addi $t2,$t2,-1
						sw $t2,0($t0)	#player1[0]--
						li $t1,1	#violate=true
						j block
			input2_pl2:
			la $t0,player2
			lw $t2,16($t0)
			li $t3,1
			beq $t2,$t3,validremove_2
				la $a0,alreadyremove
				li $v0,4
				syscall
				la $t0,player2
				lw $t2,0($t0)
				addi $t2,$t2,-1
				sw $t2,0($t0)
				li $t1,1
				j block
			validremove_2:
				la $a0,choose_remove
				li $v0,4
				syscall
				la $a0, way_remove
				syscall
				la $a0,example_remove
				syscall
				li $v0,5
				syscall
				addi $s4,$v0,0	#s4 = rowin
				li $v0,5
				syscall
				addi $s5,$v0,0	#s5 = colin
				
				slti $t7,$s4,1
				li $s7,1
				beq $t7,$s7,errorrowin_2	#if rowin<1
					li $s7,6
					sgt $t7,$s4,$s7
					li $s7,1
					beq $t7,$s7,errorrowin_2	#if rowin>6
						j checkcolin_2	#if 1<=rowin<=6
				errorrowin_2:
					li $v0,4
					la $a0,remove_outboard
					syscall
					j validremove_2
				checkcolin_2:
				slti $t7,$s5,1
				li $s7,1
				beq $t7,$s7,errorcolin_2
					li $s7,7
					sgt $t7,$s5,$s7
					li $s7,1
					beq $t7,$s7,errorcolin_2
						j calculaterowincolin_2
				errorcolin_2:
					li $v0,4
					la $a0,remove_outboard
					syscall
					j validremove_2
				
				calculaterowincolin_2:
				#calculate rowin
				addi $s4,$s4,-1	#s4 = rowin-1
				li $t2,2
				mul $s4,$s4,$t2	#s4 = (rowin-1)*2
				addi $s4,$s4,1	#s4 = 1 + (rowin-1)*2
				#calculate colin
				addi $s5,$s5,-1	#s5 = colin-1
				li $t2,4
				mul $s5,$s5,$t2	#s5 = (colin-1)*4
				addi $s5,$s5,2	#s5 = 2 + (colin-1)*4
				#Calculate board[rowin][colin]
				mul $t0,$s4,colSize	#rowI*colS
				add $t0,$t0,$s5		#rowI*colS + colI
				la $a0,board
				add $t0,$a0,$t0
				lb $t2,0($t0)
				la $s7,O
				lb $s7,0($s7)
				beq $t2,$s7,ifremoveO	#if board[rowin][colin]==X
				la $s7,space
				lb $s7,0($s7)
				beq $t2,$s7,ifspace_2	#if board[rowin][colin]==space
						la $a0,board	#board
						addi $a1,$s4,0	#rowin
						addi $a2,$s5,0	#colin
						jal removepiece
						la $a0,board
						jal drawboard
						addi $s0,$s0,-1
						la $t0,player1
						lw $t2,8($t0)
						addi $t2,$t2,-1
						sw $t2,8($t0)	#player1[2]--
						la $t0,player2
						lw $t2,16($t0)
						addi $t2,$t2,-1
						sw $t2,16($t0)	#player2[4]--
						#checkwin
						mul $s7,$s4,colSize
						add $s7,$s7,$s5
						add $s7,$s7,$a0
						lb $t7,0($s7)
						la $t2,space
						lb $t2,0($t2)
						beq $t7,$t2,askundoremove_2
						la $a0,board	#board
						addi $a1,$s4,0	#rowin
						addi $a2,$s5,0	#colin
						addi $t0,$s4,0
						for_checkwinremove_2:
							la $t2,space
							lb $t2,0($t2)
							addi $t7,$t0,0
							mul $t0,$t0,colSize
							add $t0,$t0,$s5
							add $t0,$a0,$t0
							lb $t5,0($t0)
							beq $t5,$t2,askundoremove_2	#when == space jump to askundoremove
								la $a0,board
								lb $a1,0($t0)
								la $s7,O
								lb $s7,0($s7)
								beq $a1,$s7,assignO_2
									la $a1,X
									j praparecheckwinremove_2
								assignO_2:
									la $a1,O
								praparecheckwinremove_2:
								addi $a3,$t7,0
								addi $a2,$s5,0
								jal checkwin
								li $t6,1
								bne $v0,$t6,increaseundoremove_2	#if still not win increase
									li $v0,4
									la $a0,winner
									syscall
									la $s7,X
									lb $s7,0($s7)
									beq $t5,$s7,inforname1_2
									la $s7,O
									lb $s7,0($s7)
									bne $t5,$s7,increaseundoremove_2
										la $a0,name2
										syscall
										la $a0,numberofpiece
										syscall
										la $a0,player2
										lw $a0,8($a0)
										li $v0,1
										syscall
										la $a0,endline
										li $v0,4
										syscall
										j exit_winner
									inforname1_2:
										la $a0,name1
										syscall
										la $a0,numberofpiece
										syscall
										la $a0,player1
										lw $a0,8($a0)
										li $v0,1
										syscall
										la $a0,endline
										li $v0,4
										syscall
										j exit_winner
						increaseundoremove_2:
						addi $t0,$t7,-2
						j for_checkwinremove_2
							askundoremove_2:
							la $a0,askundo
							li $v0,4
							syscall
							chooseundoremoveagain_2:
							li $v0,5
							syscall
							addi $t6,$v0,0
							slti $s7,$t6,0	#if input<0
							li $t7,1
							beq $t7,$s7,reaskundoremove_2
							li $t7,1
							sgt $s7,$t6,$t7
							li $t7,1
							beq $s7,$t7,reaskundoremove_2
								j inrangeundo_2
							reaskundoremove_2:
								li $v0,4
								la $a0,reaskforundo
								syscall
								j chooseundoremoveagain_2
							inrangeundo_2:
							li $t5,1
							bne $t6,$t5,checkchanceremove_2
								li $t5,1
								bne $s0,$t5,undo_remove_2
									la $a0,violation1stmove
									li $v0,4
									syscall
									la $s7,player2
									lw $t7,0($s7)
									addi $t7,$t7,-1
									sw $t7,0($s7)
									j block
								undo_remove_2:
									la $s7,player2
									lw $t7,4($s7)
									li $t6,0
									bne $t7,$t6,valid_undo_remove_2
										la $a0,undo3times
										li $v0,4
										syscall
										la $s7,player2
										lw $t7,0($s7)
										addi $t7,$t7,-1
										sw $t7,0($s7)
										j block
									valid_undo_remove_2:
									la $s7,prechance
									lw $t7,4($s7)
									la $t5,chance
									sw $t7,4($t5)
									la $a0,board
									la $a1,X
									lb $a1,0($a1)
									addi $a2,$s4,0
									addi $a3,$s5,0
									jal undoremove
									addi $s0,$s0,1
									la $a0,board
									jal drawboard
									la $s7,player2
									lw $t7,4($s7)
									addi $t7,$t7,-1
									sw $t7,4($s7)
									lw $t7,16($s7)
									addi $t7,$t7,1
									sw $t7,16($s7)
									j while_loop
							checkchanceremove_2:
								mul $s7,$s4,colSize
								add $s7,$s7,$s5
								add $s7,$s7,$a0
								lb $t7,0($s7)
								la $t2,space
								lb $t2,0($t2)
								beq $t7,$t2,block	#if remove ontop => no need to check chance
								la $a0,board	#board
								addi $a1,$s4,0	#rowin
								addi $a2,$s5,0	#colin
								addi $t0,$s4,0
								for_checkchanceremove_2:
									la $t2,space
									lb $t2,0($t2)
									addi $t7,$t0,0
									mul $t0,$t0,colSize
									add $t0,$t0,$s5
									add $t0,$a0,$t0
									lb $t5,0($t0)
									beq $t5,$t2,block	#when == space jump to askundoremove
										la $a0,board
										lb $a1,0($t0)
										la $s7,O
										lb $s7,0($s7)
										beq $a1,$s7,assignOcheckchance_2
											la $a1,X
											j praparecheckchanceremove_2
										assignOcheckchance_2:
											la $a1,O
										praparecheckchanceremove_2:
										addi $a3,$t7,0
										addi $a2,$s5,0
										jal chancetowin
										li $t6,1
										bne $v0,$t6,increasecheckchanceremove_2	#if still not win increase
											la $s7,X
											lb $s7,0($s7)
											beq $a1,$s7,Xhaschance_2
												la $s7,chance
												li $t7,1
												sw $t7,4($s7)
												j block
											Xhaschance_2:
												la $s7,chance
												li $t7,1
												sw $t7,0($s7)
												j block
								increasecheckchanceremove_2:
								addi $t0,$t7,-2
								j for_checkchanceremove_2
					ifspace_2:
						la $a0,remove_space
						li $v0,4
						syscall
						la $t0,player2
						lw $t2,0($t0)
						addi $t2,$t2,-1
						sw $t2,0($t0)	#player2[0]--
						li $t1,1	#violate=true
						j block
					ifremoveO:
						la $a0,self_remove
						li $v0,4
						syscall
						la $t0,player2
						lw $t2,0($t0)
						addi $t2,$t2,-1
						sw $t2,0($t0)	#player2[0]--
						li $t1,1	#violate=true
						j block
		elseinput:
			la $a0,choice3
			li $v0,4
			syscall
			j while_loop
		block:
			li $s7,0
			bne $t1,$s7,blockturn	#ifviolate==1
				la $a0,askblock
				li $v0,4
				syscall
				li $v0,5
				syscall
				addi $s6,$v0,0	#s6=block
		blockturn:
			li $t0,1
			beq $s1,$t0,blockturn_pl2	#if turn==true
				bne $s6,$t0,elseblockturn	#if block==0
					la $s7,chance
					lw $s7,4($s7)
					bne $s7,$t0,validblock
						la $a0,opponenthaschance
						li $v0,4
						syscall
						la $s7,player1
						lw $t2,0($s7)
						addi $t2,$t2,-1
						sw $t2,0($s7)		#player1[0]--
						li $s1,1		#turn=true
						j checkviolate
					validblock:
						la $s7,player1
						lw $t2,12($s7)
						li $t3,0
						bne $t2,$t3,canblock	#if player1[3]==1
							la $a0,alreadyblock
							li $v0,4
							syscall
							la $s7,player1
							lw $t2,0($s7)
							addi $t2,$t2,-1
							sw $t2,0($s7)
							li $s1,1
							j checkviolate
						canblock:
							la $s7,player1
							lw $t2,12($s7)
							addi $t2,$t2,-1
							sw $t2,12($s7)
							j checkviolate
				elseblockturn:
					li $s1,1
				checkviolate:
					li $t0,1
					beq $t1,$t0,ifviolate
						j printresult
					ifviolate:
						li $s1,0
				printresult:
					la $a0,result1
					li $v0,4
					syscall
					la $s7,player1
					lw $a0,0($s7)
					li $v0,1
					syscall
					la $a0,endline
					li $v0,4
					syscall
					
					la $a0,result2
					li $v0,4
					syscall
					la $s7,player1
					lw $a0,4($s7)
					li $v0,1
					syscall
					la $a0,endline
					li $v0,4
					syscall
					
					la $a0,result3
					li $v0,4
					syscall
					la $a0,name1
					li $v0,4
					syscall
					la $a0,endline
					li $v0,4
					syscall
					j check_remaining_violation
		blockturn_pl2:
			li $t0,1
			bne $s6,$t0,elseblockturn_2	#if block==0
				la $s7,chance
				lw $s7,0($s7)
				bne $s7,$t0,valid_block_2
					la $a0,opponenthaschance
					li $v0,4
					syscall
					la $s7,player2
					lw $t2,0($s7)
					addi $t2,$t2,-1
					sw $t2,0($s7)		#player1[0]--
					li $s1,0		#turn=true
					j checkviolate_2
				valid_block_2:
					la $s7,player2
					lw $t2,12($s7)
					li $t0,0
					bne $t2,$t0,can_block_2
						la $a0,alreadyblock
						li $v0,4
						syscall
						la $s7,player2
						lw $t2,0($s7)
						addi $t2,$t2,-1
						sw $t2,0($s7)	#player2[0]--
						li $s1,0	#turn=false
						j checkviolate_2
					can_block_2:
						la $s7,player2
						lw $t2,12($s7)
						addi $t2,$t2,-1
						sw $t2,12($s7)
						j checkviolate_2
			elseblockturn_2:
				li $s1,0
			checkviolate_2:
				li $t0,1
				beq $t1,$t0,ifviolate_2
					j printresult_2
				ifviolate_2:
					li $s1,1
			printresult_2:
				la $a0,result1
				li $v0,4
				syscall
				la $s7,player2
				lw $a0,0($s7)
				li $v0,1
				syscall
				la $a0,endline
				li $v0,4
				syscall
				
				la $a0,result2
				li $v0,4
				syscall
				la $s7,player2
				lw $a0,4($s7)
				li $v0,1
				syscall
				la $a0,endline
				li $v0,4
				syscall
				
				la $a0,result3
				li $v0,4
				syscall
				la $a0,name2
				li $v0,4
				syscall
				la $a0,endline
				li $v0,4
				syscall
	check_remaining_violation:
		#check player 1
		la $s7,player1
		lw $s7,0($s7)
		slti $s7,$s7,0
		li $t0,0
		beq $s7,$t0,check_player_2	#if player1[0]>=0
			la $a0,violate3times
			li $v0,4
			syscall
			la $a0,name1
			syscall
			la $a0,dauchamthan
			syscall
			
			la $a0,winner
			syscall
			la $a0,name2
			syscall
			
			la $a0,numberofpiece
			syscall
			
			la $a0,player2
			lw $a0,8($a0)
			li $v0,1
			syscall
			la $a0,endline
			li $v0,4
			syscall
			la $a0,board
			jal drawboard
			j exit_winner
		check_player_2:
			la $s7,player2
			lw $s7,0($s7)
			slti $s7,$s7,0
			li $t0,0
			beq $s7,$t0,updatechance
				la $a0,violate3times
				li $v0,4
				syscall
				la $a0,name2
				syscall
				la $a0,dauchamthan
				syscall
				
				la $a0,winner
				syscall
				la $a0,name1
				syscall
				
				la $a0,numberofpiece
				syscall
				
				la $a0,player1
				lw $a0,8($a0)
				li $v0,1
				syscall
				la $a0,endline
				li $v0,4
				syscall
				la $a0,board
				jal drawboard
				j exit_winner
		updatechance:
			la $s6,prechance
			la $s7,chance
			lw $t0,0($s7)
			sw $t0,0($s6)	#prechance[0]=chance[0]
			lw $t0,4($s7)
			sw $t0,4($s6)	#prechance[1]=chance[1]
			la $a0,endline
			li $v0,4
			syscall
	j while_loop
	exit_winner:
		la $a0,GOODBYE
		li $v0,4
		syscall
		li $v0,10
		syscall
	exit:
	li $t0,42
	beq $s0,$t0,tiegame
	li $v0,10
	syscall
	tiegame:
	la $a0,TIEGAME
	li $v0,4
	syscall
	la $a0,Final_board
	syscall
	la $a0,board
	jal drawboard
	la $a0,GOODBYE
	syscall
	li $v0,10
	syscall
		
#drawboard is to draw the board
drawboard:
	addi $s2,$a0,0	#base address
	li $t6,0	#row index i
	li $t7,0	#column index j
	#### addr = base + (rowIndex * colSize + colIndex)*dataSize
	for_outter:
	beq $t6,rowSize,exit_outter
		for_inner:
		beq $t7,colSize,exit_inner
		
		mul $t2,$t6,colSize	#t2=rowIndex * colSize
		add $t2,$t2,$t7		#t2=(rowIndex * colSize + colIndex)*dataSize
		add $t2,$t2,$s2		#t2=base + (rowIndex * colSize + colIndex)*dataSize
		
		lb $a0,0($t2)
		li $v0,11
		syscall			#print element
		
		addi $t3,$zero,colSize
		addi $t3,$t3,-1
		
		bne $t7,$t3,no_endline	#check if the end of line => enter to new line
			la $a0,endline
			li $v0,4
			syscall
		no_endline:
		
		addi $t7,$t7,1
		j for_inner
		exit_inner:
	li $t7,0
	addi $t6,$t6,1
	j for_outter
	exit_outter:
	jr $ra

drop:
li $t0,1
mul $t0,$t0,colSize
add $t0,$t0,$a2
add $t0,$t0,$a0
lb $t0,0($t0)
la $s7,space
lb $s7,0($s7)
beq $t0,$s7,notfull
	li $v0,-1
	jr $ra
notfull:
li $t0,11	#i

forloop_drop:
li $t2,0
slt $t3,$t0,$t2	#if i<0 exit
li $t2,1
beq $t3,$t2,exit_drop
	mul $t3,$t0,colSize
	add $t3,$t3,$a2
	add $t5,$t3,$a0		#t5 is the address of cell
	
	lb $t4,0($t5)		#load value from address t3 to t4
	la $s7,space
	lb $s7,0($s7)
	bne $t4,$s7,elsedrop	#if board[i][incol]!=" "
		lb $s7,0($a1)
		sb $s7,board($t3)		#store board[i][incol]=piece $a1
		j exit_drop		#break
elsedrop:
addi $t0,$t0,-2	#i-=2
j forloop_drop
exit_drop:
addi $v0,$t0,0
jr $ra

checkwin:
checkhorizontal:
li $t0,0	#count=0
addi $t2,$a2,0	#j=recentcol
#### addr = base + (rowIndex * colSize + colIndex)*dataSize
while_1_horizontal:
li $t3,1
slt $t4,$t2,$t3	#ifj<1
beq $t4,$t3,exit_while_1_horizontal
mul $t3,$a3,colSize	#rowI * colS
add $t3,$t3,$t2		#rowI * colS + colI
add $t3,$a0,$t3		#base + (rowI * colS + colI)
lb $t3,0($t3)
lb $s7,0($a1)
bne $t3,$s7,exit_while_1_horizontal	#if board[recentrow][j]!=piece
	addi $t0,$t0,1	#count++
	addi $t2,$t2,-4	#j-=4
j while_1_horizontal
exit_while_1_horizontal:
addi $t2,$a2,4		#j=recentcol+4

while_2_horizontal:
li $t3,26
sgt $t3,$t2,$t3		#if j>26
li $t4,1
beq $t3,$t4,exit_while_2_horizontal
mul $t3,$a3,colSize	#rowI * colS
add $t3,$t3,$t2		#rowI * colS + colI
add $t3,$t3,$a0		#base + rowI * colS + colI
lb $t3,0($t3)
lb $s7,0($a1)
bne $t3,$s7,exit_while_2_horizontal
	addi $t0,$t0,1
	addi $t2,$t2,4
j while_2_horizontal
exit_while_2_horizontal:
slti $t0,$t0,4		#if count<4
li $t2,1
beq $t0,$t2,checkvertical	# => continue checking vertical
li $v0,1	#return true	#else return true
jr $ra

checkvertical:
li $t0,0	#count=0
addi $t2,$a3,0	#i=recentrow
while_1_vertical:
slti $t3,$t2,1
li $t4,1
beq $t3,$t4,exit_while_1_vertical
mul $t3,$t2,colSize	#rowI * colS
add $t3,$t3,$a2		#rowI * colS + colI
add $t3,$t3,$a0
lb $t3,0($t3)
lb $s7,0($a1)
bne $t3,$s7,exit_while_1_vertical
	addi $t0,$t0,1
	addi $t2,$t2,-2
j while_1_vertical
exit_while_1_vertical:
addi $t2,$a3,2	#i=recentrow+2

while_2_vertical:
li $t3,11
sgt $t3,$t2,$t3	#if i>11
li $t4,1
beq $t3,$t4,exit_while_2_vertical
mul $t3,$t2,colSize	#rowI * colS
add $t3,$t3,$a2		#rowI * colS + colI
add $t3,$t3,$a0		#base + rowI * colS + colI
lb $t3,0($t3)
lb $s7,0($a1)
bne $t3,$s7,exit_while_2_vertical
	addi $t0,$t0,1
	addi $t2,$t2,2
j while_2_vertical
exit_while_2_vertical:
slti $t0,$t0,4	#if count<4
li $t2,1
beq $t0,$t2,checkrightdia	# => continue checking rightdia
li $v0,1			#else return true
jr $ra

checkrightdia:
li $t0,0	#count=0
addi $t2,$a3,0	#i=recentrow
addi $t3,$a2,0	#j=recentcol

while_1_rightdia:
slti $t4,$t2,1
li $t5,1
beq $t4,$t5,exit_while_1_rightdia
slti $t4,$t3,2
beq $t4,$t5,exit_while_1_rightdia
mul $t4,$t2,colSize	#rowI * colS
add $t4,$t4,$t3		#rowI * colS + colI
add $t4,$t4,$a0		#base + rowI * colS + colI
lb $t4,0($t4)
lb $s7,0($a1)
bne $t4,$s7,exit_while_1_rightdia
	addi $t0,$t0,1
	addi $t2,$t2,-2
	addi $t3,$t3,-4
j while_1_rightdia
exit_while_1_rightdia:
addi $t2,$a3,2		#i=recentrow+2
addi $t3,$a2,4		#j=recentcol+4

while_2_rightdia:
li $t4,11
sgt $t4,$t2,$t4
li $t5,1
beq $t4,$t5,exit_while_2_rightdia
li $t4,26
sgt $t4,$t3,$t4
beq $t4,$t5,exit_while_2_rightdia
mul $t4,$t2,colSize	#rowI * colS
add $t4,$t4,$t3		#rowI * colS + colI
add $t4,$t4,$a0		# base + rowI * colS + colI
lb $t4,0($t4)
lb $s7,0($a1)
bne $t4,$s7,exit_while_2_rightdia
	addi $t0,$t0,1
	addi $t2,$t2,2
	addi $t3,$t3,4
j while_2_rightdia
exit_while_2_rightdia:
slti $t0,$t0,4	#if count<4
li $t2,1
beq $t0,$t2,checkleftdia	# => continue checking leftdia
li $v0,1			#else return true
jr $ra

checkleftdia:
li $t0,0	#count=0
addi $t2,$a3,0	#i=recentrow
addi $t3,$a2,0	#j=recentcol

while_1_leftdia:
slti $t4,$t2,1	#if i<1
li $t5,1
beq $t4,$t5,exit_while_1_leftdia
li $t4,26
sgt $t4,$t3,$t4	#if j>26
beq $t4,$t5,exit_while_1_leftdia
mul $t4,$t2,colSize	#rowI * colS
add $t4,$t4,$t3		#rowI * colS + colI
add $t4,$t4,$a0		#base + rowI * colS + colI
lb $t4,0($t4)
lb $s7,0($a1)
bne $t4,$s7,exit_while_1_leftdia
	addi $t0,$t0,1
	addi $t2,$t2,-2
	addi $t3,$t3,4
j while_1_leftdia
exit_while_1_leftdia:
addi $t2,$a3,2
addi $t3,$a2,-4

while_2_leftdia:
li $t4,11
li $t5,1
sgt $t4,$t2,$t4
beq $t4,$t5,exit_while_2_leftdia
slti $t4,$t3,2
beq $t4,$t5,exit_while_2_leftdia
mul $t4,$t2,colSize	#rowI * colS
add $t4,$t4,$t3		#rowI * colS + colI
add $t4,$a0,$t4		#base + rowI * colS + colI
lb $t4,0($t4)
lb $s7,0($a1)
bne $t4,$s7,exit_while_2_leftdia
	addi $t0,$t0,1
	addi $t2,$t2,2
	addi $t3,$t3,-4
j while_2_leftdia
exit_while_2_leftdia:
slti $t0,$t0,4		#if count<4
li $t2,1
beq $t0,$t2,false	#=>return false
li $v0,1
jr $ra
false:
li $v0,0
jr $ra

chancetowin:
chancehorizontal:
li $t0,0	#count=0
addi $t2,$a2,0	#j=recentcol
#### addr = base + (rowIndex * colSize + colIndex)*dataSize
while_1_chance_horizontal:
li $t3,1
slt $t4,$t2,$t3	#ifj<1
beq $t4,$t3,exit_while_1_chance_horizontal
mul $t3,$a3,colSize	#rowI * colS
add $t3,$t3,$t2		#rowI * colS + colI
add $t3,$a0,$t3		#base + (rowI * colS + colI)
lb $t3,0($t3)
lb $s7,0($a1)
bne $t3,$s7,exit_while_1_chance_horizontal	#if board[recentrow][j]!=piece
	addi $t0,$t0,1	#count++
	addi $t2,$t2,-4	#j-=4
j while_1_chance_horizontal
exit_while_1_chance_horizontal:
addi $t2,$a2,4		#j=recentcol+4

while_2_chance_horizontal:
li $t3,26
sgt $t3,$t2,$t3		#if j>26
li $t4,1
beq $t3,$t4,exit_while_2_chance_horizontal
mul $t3,$a3,colSize	#rowI * colS
add $t3,$t3,$t2		#rowI * colS + colI
add $t3,$t3,$a0		#base + rowI * colS + colI
lb $t3,0($t3)
lb $s7,0($a1)
bne $t3,$s7,exit_while_2_chance_horizontal
	addi $t0,$t0,1
	addi $t2,$t2,-4
j while_2_chance_horizontal
exit_while_2_chance_horizontal:
slti $t0,$t0,3		#if count<4
li $t2,1
beq $t0,$t2,chancevertical	# => continue checking vertical
li $v0,1	#return true	#else return true
jr $ra

chancevertical:
li $t0,0	#count=0
addi $t2,$a3,0	#i=recentrow
while_1_chance_vertical:
slti $t3,$t2,1
li $t4,1
beq $t3,$t4,exit_while_1_chance_vertical
mul $t3,$t2,colSize	#rowI * colS
add $t3,$t3,$a2		#rowI * colS + colI
add $t3,$t3,$a0
lb $t3,0($t3)
lb $s7,0($a1)
bne $t3,$s7,exit_while_1_chance_vertical
	addi $t0,$t0,1
	addi $t2,$t2,-2
j while_1_chance_vertical
exit_while_1_chance_vertical:
addi $t2,$a3,2	#i=recentrow+2

while_2_chance_vertical:
li $t3,11
sgt $t3,$t2,$t3	#if i>11
li $t4,1
beq $t3,$t4,exit_while_2_chance_vertical
mul $t3,$t2,colSize	#rowI * colS
add $t3,$t3,$a2		#rowI * colS + colI
add $t3,$t3,$a0		#base + rowI * colS + colI
lb $t3,0($t3)
lb $s7,0($a1)
bne $t3,$s7,exit_while_2_chance_vertical
	addi $t0,$t0,1
	addi $t2,$t2,2
j while_2_chance_vertical
exit_while_2_chance_vertical:
slti $t0,$t0,3	#if count<4
li $t2,1
beq $t0,$t2,chancerightdia	# => continue checking rightdia
li $v0,1			#else return true
jr $ra

chancerightdia:
li $t0,0	#count=0
addi $t2,$a3,0	#i=recentrow
addi $t3,$a2,0	#j=recentcol

while_1_chance_rightdia:
slti $t4,$t2,1
li $t5,1
beq $t4,$t5,exit_while_1_chance_rightdia
slti $t4,$t3,2
beq $t4,$t5,exit_while_1_chance_rightdia
mul $t4,$t2,colSize	#rowI * colS
add $t4,$t4,$t3		#rowI * colS + colI
add $t4,$t4,$a0		#base + rowI * colS + colI
lb $t4,0($t4)
lb $s7,0($a1)
bne $t4,$s7,exit_while_1_chance_rightdia
	addi $t0,$t0,1
	addi $t2,$t2,-2
	addi $t3,$t3,-4
j while_1_chance_rightdia
exit_while_1_chance_rightdia:
addi $t2,$a3,2		#i=recentrow+2
addi $t3,$a2,4		#j=recentcol+4

while_2_chance_rightdia:
li $t4,11
sgt $t4,$t2,$t4
li $t5,1
beq $t4,$t5,exit_while_2_chance_rightdia
li $t4,26
sgt $t4,$t3,$t4
beq $t4,$t5,exit_while_2_chance_rightdia
mul $t4,$t2,colSize	#rowI * colS
add $t4,$t4,$t3		#rowI * colS + colI
add $t4,$t4,$a0		# base + rowI * colS + colI
lb $t4,0($t4)
lb $s7,0($a1)
bne $t4,$s7,exit_while_2_chance_rightdia
	addi $t0,$t0,1
	addi $t2,$t2,2
	addi $t3,$t3,4
j while_2_chance_rightdia
exit_while_2_chance_rightdia:
slti $t0,$t0,3	#if count<4
li $t2,1
beq $t0,$t2,chanceleftdia	# => continue checking leftdia
li $v0,1			#else return true
jr $ra

chanceleftdia:
li $t0,0	#count=0
addi $t2,$a3,0	#i=recentrow
addi $t3,$a2,0	#j=recentcol

while_1_chance_leftdia:
slti $t4,$t2,1	#if i<1
li $t5,1
beq $t4,$t5,exit_while_1_chance_leftdia
li $t4,26
sgt $t4,$t3,$t4	#if j>26
beq $t4,$t5,exit_while_1_chance_leftdia
mul $t4,$t2,colSize	#rowI * colS
add $t4,$t4,$t3		#rowI * colS + colI
add $t4,$t4,$a0		#base + rowI * colS + colI
lb $t4,0($t4)
lb $s7,0($a1)
bne $t4,$s7,exit_while_1_chance_leftdia
	addi $t0,$t0,1
	addi $t2,$t2,-2
	addi $t3,$t3,4
j while_1_chance_leftdia
exit_while_1_chance_leftdia:
addi $t2,$a3,2
addi $t3,$a2,-4

while_2_chance_leftdia:
li $t4,11
li $t5,1
sgt $t4,$t2,$t4
beq $t4,$t5,exit_while_2_chance_leftdia
slti $t4,$t3,2
beq $t4,$t5,exit_while_2_chance_leftdia
mul $t4,$t2,colSize	#rowI * colS
add $t4,$t4,$t3		#rowI * colS + colI
add $t4,$a0,$t4		#base + rowI * colS + colI
lb $t4,0($t4)
lb $s7,0($a1)
bne $t4,$s7,exit_while_2_chance_leftdia
	addi $t0,$t0,1
	addi $t2,$t2,2
	addi $t3,$t3,-4
j while_2_chance_leftdia
exit_while_2_chance_leftdia:
slti $t0,$t0,3		#if count<4
li $t2,1
beq $t0,$t2,falsechance	#=>return false
li $v0,1
jr $ra
falsechance:
li $v0,0
jr $ra

removepiece:
	mul $t0,$a1,colSize
	add $t0,$t0,$a2
	add $t2,$t0,$a0	#t2=board[rowin][colin]
	la $s7,space
	lb $s7,0($s7)
	sb $s7,board($t0)
	addi $t3,$a1,0	#i
	for_remove:
	slti $t4,$t3,3
	li $t5,1
	beq $t4,$t5,exit_for_remove
		mul $t4,$t3,colSize
		add $t4,$t4,$a2
		add $t5,$t4,$a0
		lb $t6,0($t5)	#temp=board[i][colin]
		
		addi $t0,$t3,-2
		mul $t0,$t0,colSize
		add $t0,$t0,$a2
		add $t2,$t0,$a0
		lb $t7,0($t2)
		
		sb $t7,board($t4)
		
		sb $t6,board($t0)
		
	addi $t3,$t3,-2
	j for_remove
	exit_for_remove:
	#mul $t3,$t3,colSize
	#add $t3,$t3,$a2
	#la $s7,space
	#lb $s7,0($s7)
	#sb $s7,board($t3)
jr $ra

undoremove:
li $t0,1 #i=1
for_loop_undo_remove:
slt $t2,$t0,$a2
li $t3,1
beq $t2,$t3,swap
j exit_for_loop_remove
	swap:
	mul $t2,$t0,colSize
	add $t2,$t2,$a3
	
	addi $t3,$t0,2
	mul $t3,$t3,colSize
	add $t3,$t3,$a3
	add $t3,$t3,$a0
	
	lb $t3,0($t3)
	sb $t3,board($t2)
addi $t0,$t0,2
j for_loop_undo_remove
exit_for_loop_remove:
mul $t0,$t0,colSize
add $t0,$t0,$a3
sb $a1,board($t0)
jr $ra
