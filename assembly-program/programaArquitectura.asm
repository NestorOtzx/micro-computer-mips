#-------------------------------------DEFINICIONES PARA PRUEBAS-------------------------
.data
	mensajeN: .asciiz "Ingrese un N: "
	mensajeA: .asciiz "Ingresando A: "
	mensajeB: .asciiz "Ingresando B: "
	mensajeX: .asciiz "Ingresando X: "
	endline: .asciiz "\n"
.text	

# Nota: todo lo que esta a partir de la siguiente linea debe ser codigo de assembly MIPS
# que nuestra arquitectura pueda soportar, cuando se vaya a poner en la tarjeta, borrar todos los
# llamados a las funciones que no estan soportadas para ella, ej: endl, printDebug, etc.
#-------------------------------------CODIGO DEL PROYECTO-------------------------
	main:
		addi 	$sp, $sp, -4
		sw 		$ra, 0($sp)
	
		jal 	getinput
		
		jal calc
		
		addi $s0, $0, 25
		
		la $a0, endline
		jal print
		la $a0, endline
		jal print	
		
		memoria:
			beq $s0, $0, end_memoria
			lw $a0, 0($gp)
			jal printInt
			la $a0, endline
			jal print
			addi $gp, $gp, 4
			addi $s0, $s0, -1
			j memoria
		end_memoria:

	
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		jr $ra
		
#------------------------------------OTRO CODIGO----------------------------------
	calc:
		addi 	$sp, $sp, -4
		sw 		$ra, 0($sp)

		addi 	$s0, $0, 1		#digamos que Y(0) = 1
		lw 		$s1, 16($gp) 	#cargar primera posicion de Y
		sw 		$s0, 0($s1)
		
		
		addi 	$s6, $0, 1 		#i = 1
		
		lw $s7, 0($gp) 			#cargar N
		addi $s7, $s7, 1		#N+1

		for_calc: 
			beq $s7, $s6, end_for_calc
			add $a0, $0, $s6
			jal Y
			
			sll 	$t0, $s6, 2
			lw 		$t1, 16($gp) 	#cargar primera posicion de Y
			add $t0, $t1, $t0
			sw $v0, 0($t0) 		#escribir el valor retornado en memoria

			addi $s6, $s6, 1	#i++
			j for_calc
		end_for_calc:
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	calcSumX:
		addi 	$v0, $0, 0 		#ans =  0
		addi 	$s0, $0, 0 		# k  =  0
		addi 	$a0, $a0, 1 	# m  +  1
		
		for_k_in_B:
			beq 	$a0, $s0, end_for_k_in_B
			
			sll $t1, $s0, 2
			lw 		$t0, 8($gp) 	#cargar pos B[k]
			add $t0, $t0, $t1
			
			#aqui multiplicar por X
			
			lw $t1, 0($t0) 
			add 	$v0, $v0, $t1	#ans += b[k]*x
			addi 	$s0, $s0, 1
			j 		for_k_in_B
			
		end_for_k_in_B:
		
		jr $ra
	
	Y:
		addi 	$sp, $sp, -4
		sw 		$ra, 0($sp)
		
		addi 	$s2, $0, 1 		# i  =  1
		addi 	$s3, $a0, 1 	# n  +  1
		addi 	$s1, $0, 0 		#ans =  0
		addi 	$a1, $a0, 0		# n
		
		for_i_in_A:
			beq 	$s3, $s2, end_for_i_in_A

			sub 	$t0, $a1, $s2 	#calcular n-i
			
			sll 	$t0, $t0, 2		#calcular (n-i)*4 para memoria
			
			lw 		$s0, 16($gp) 		#cargar la primera posicion de Y
			add 	$s0, $t0, $s0
			lw 		$s4, 0($s0) 			#obtener Y[n-i] y dejarlo en val 

			lw $s0, 4($gp) 			#cargar A[i]
			addi $t3, $s2, 0		
			sll $t3, $t3, 2
			add $s0, $t3, $s0
			lw $s5, 0($s0)
			
			mult $s4, $s5			#calcular a[i]*val
			mflo $s4
			
			sub $s4, $0, $s4		#calcular -a[i]*val	
			
			addi $a0, $s2, 0	 	#calcuar sumX de i
			jal 	calcSumX
			
					
			add $s1, $s1, $v0		#sumar calcSumX con -a[i]*val
			add $s1, $s1, $s4		
						
			addi 	$s2, $s2, 1		#i++
			j 		for_i_in_A
			
		end_for_i_in_A:
		
		addi $v0, $s1, 0
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	resetGP: 	#reinicia global pointer
		lui $gp, 0x1000
		ori $gp, $gp, 0x8000	
		jr $ra
	
	getinput: 	#Recibe los siguientes valores del usuario: N, arreglo a, arreglo b y guarda las posiciones iniciales de los arreglos en registros
		addi	$sp, $sp, -4
		sw 		$ra, 0($sp)
		
	
		
		la     	$a0, mensajeN	#Imprime "ingrese N"
		jal    	print
		
		jal    	getint 			#lee N
		add    	$s0, $0, $v0
		sw 		$s0, 0($gp)
		
		addi $gp, $gp, 16 #reserva espacio para las direcciones de los 4 arreglos
		
		la     	$a0, mensajeA	#Imprime mensaje A
		jal    	print
		
		addi $gp, $gp, 4
		addi $t0, $0, -1 		#A[0] = -1 ya que este valor no se usa en el algoritmo
		sw $t0, 0($gp)

		addi $s1, $0, 0 #i = 0
		
		addi $s7, $gp, 0 #guardar la posicion inicial de A en s7
		for_arrA:
			beq 	$s0, $s1, end_for_arrA
			
			jal    	getint 			#lee A[i]
			add    	$t0, $0, $v0
			
			addi 	$gp, $gp, 4		#avanzar el global pointer
			sw 		$t0, 0($gp)		#guarda A[i]
			addi 	$s1, $s1, 1 	#i++
			j for_arrA
		end_for_arrA:
		
		la     	$a0, mensajeB	#Imprime mensaje B
		jal    	print
		
		addi $s6, $gp, 4 #guardar la posicion inicial de B en s6
		addi $s1, $0, -1 #i = -1 ESTO ES PARA INGRESAR UN VALOR MAS EN EL B, YA QUE M = N+1 Y NO QUEREMOS MODIFICAR $S0
		for_arrB:
			beq 	$s0, $s1, end_for_arrB
			
			jal    	getint 			#lee B[i]
			add    	$t0, $0, $v0
			
			addi 	$gp, $gp, 4		#avanzar el global pointer
			sw 		$t0, 0($gp)		#guarda B[i]
			addi 	$s1, $s1, 1 	#i++
			j for_arrB
		end_for_arrB:
		
		addi $s5, $gp, 4 #pos de los X
		addi $s4, $gp, 8 #pos de los Y
		
		jal 	resetGP
		
		sw $s7, 4($gp) #primer elemento de A
		sw $s6, 8($gp) #primer elemento de B
		sw $s5, 12($gp) #primer elemento de X
		sw $s4, 16($gp)#primer elemento de Y
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	printInt:
		li $v0, 1
		syscall
		jr $ra
	
	print:
		li $v0, 4
		syscall
		jr $ra
		
	getint:
		li $v0,5
		syscall
		jr $ra