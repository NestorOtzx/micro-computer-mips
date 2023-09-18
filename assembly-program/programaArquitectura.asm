#-------------------------------------DEFINICIONES PARA PRUEBAS-------------------------
.data
	mensajeDePrueba: .asciiz "Print"
	mensajeDeFin: .asciiz "Fin del programa"
	endline: .asciiz "\n"
.text	
	
# Nota: todo lo que esta a partir de la siguiente linea debe ser codigo nativo de assembly
# que nuestra arquitectura pueda soportar, cuando se vaya a poner en la tarjeta, borrar todas
# las funciones que no estan soportadas para ella, ej: endl, printDebug, etc.
#-------------------------------------CODIGO DEL PROYECTO-------------------------
	main:
		# Guardar en la pila la direccion actual
		sw $ra, 0($sp) 
		
		# Definiciones previas
		# dir inicial de los arreglos
		lui $s4, 0x1000
		ori $s4, $s4, 0x8000
		
		# ARREGLOS
		jal defArrA 	 #definir el arreglo A = [5, 4, 1]
		
		# Dir inicial del arreglo B
		addi $s4, $s4, 4  #avanzar una posicion para no sobre escribir el ultimo elemento del arreglo anterior con el primer elemento del nuevo arreglo
		add $s5, $0, $s4
		
		jal defArrB      #definir el arreglo B = [4, 1, 1]
		
		addi $s7, $0, 2  # X = 2
		addi $s6, $0, 6  # n = 6
		addi $t1, $0, 1  # i = 1 del for arreglo A
		addi $t2, $0, 0  # i = 0 del for arreglo B
		addi $t3, $0, 3  # Longitud del arreglo A [5, 4, 1]
		addi $t4, $0, 3  # Longitud del arreglo B [4, 1, 1]
		addi $s1, $s1, 0 # calSumX ans = 0
		addi $s2, $s2, 0 # calSumY ans = 0
		
		# Dir inicial del arreglo A
		lui $s4, 0x1000
		ori $s4, $s4, 0x8000
		
		addi $t7, $0, 4
		mult $t1, $t7
		mflo $t6
		add $s4, $s4, $t6
		
		# Dir inicial del arr B
		addi $t7, $0, 4
		mult $t2, $t7
		mflo $t6
		add $s5, $s5, $t6
		
		j y
		
	y:
		slti $t0, $s6, 1 #n < 1  = 1, n >= 1, 0
		
		bne $t0, $0, yBase
	
		jal calcSumY
		jal calcSumX
		
		addi $s3, $0, 0 #ans = 0
		
		sub $s1, $0, $s1
		
		add $s3, $s1, $s2
		
		add $a0, $0, $s3
		jal printNum
		jal endl
		
		j fin
	yBase:
		addi $s3, $0, 1 #ans = 1
		jal printNum
		jal endl
		
		j fin
		
		
	calcSumY: #return 
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# Ciclo for ($t1 = 0) in range($t3)
		beq $t1, $t3, calcSumYFin
		
		# Obtener arr[i]
		lw $a0, 0($s4)
		
		# Calcular ans += arr[i]*y(n-i)
		add $s1, $s1, $a0
		
		# imprimir arr[i]*x*(n-i) y un \n
		# jal printNum
		# jal endl

		# i++
		addi $t1, $t1, 1
		addi $s4, $s4, 4
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		j calcSumY
	
		
	calcSumYFin:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		
	calcSumX: #return 
		#guardamos el ra
			addi $sp, $sp, -4
			sw $ra, 0($sp)

		# Ciclo for ($t2 = 0) in range($t4)
		beq $t2, $t4, calcSumXFin
		
		# Obtener arr[i]
		lw $a0, 0($s5)
		
		# imprimir arr[i] y un \n
		# jal printNum
		# jal endl
		
		# Calcular arr[i]*x
		mult $a0, $s7 
		mflo $a0
		
		# Calcular (n-i)
		sub $t9, $s6, $t2
		
		# Calcular (arr[i]*x*(n-i))
		mult $a0, $t9
		mflo $a0
		
		# Calcular ans += arr[i]*x*(n-i)
		add $s2, $s2, $a0

		# i++
		addi $t2, $t2, 1
		addi $s5, $s5, 4
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		j calcSumX
		
	calcSumXFin:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	

	fin:
		#imprimir resultado A
		add $a0, $0, $s1
		jal printNum
		jal endl
		
		#resultado B
		add $a0, $0, $s2
		jal printNum
		
		#imprimir final
		jal endl
		jal printFin
	
		lw $ra, 0($sp) #carga el ra inicial
		jr $ra
#------------------------------------OTRO CODIGO----------------------------------

		#finalizar qtspim
		addi $t1, $0, 1	
		li $v0,10
		syscall
	
	#Cosas para imprimir y debugear
	printDebug:
		li $v0, 4
		add $a1, $a0, $0
		la $a0, mensajeDePrueba
		syscall
		add $a0, $a1, $0
		jr $ra
	printFin:
		li $v0, 4
		add $a1, $a0, $0
		la $a0, mensajeDeFin
		syscall
		add $a0, $a1, $0
		jr $ra
	printNum:
		li $v0, 1
		#hacer print del numero en $a0
		syscall
		jr $ra
	endl:
		li $v0, 4
		add $a1, $a0, $0
		la $a0, endline
		syscall
		add $a0, $a1, $0
		jr $ra
	# arr A [4, 1, 1]
	# arr B [4, 1, 1]
	defArrB:
		addi $sp, $sp, -4
		
		sw $ra, 0($sp)
		
		lw $t1, 0($s4)
		addi $t1, $0, 4 #4
		sw $t1, 0($s4)
		
		addi $s4, $s4, 4
		
		lw $t1, 0($s4)
		addi $t1, $0, 1 #1
		sw $t1, 0($s4)
		
		addi $s4, $s4, 4
		
		lw $t1, 0($s4)
		addi $t1, $0, 1 #1
		sw $t1, 0($s4)
		
		lw $ra, 0($sp) #carga el ra inicial
		addi $sp, $sp, 4
		jr $ra
		
	defArrA:
		addi $sp, $sp, -4
		
		sw $ra, 0($sp)
		
		lw $t1, 0($s4)
		addi $t1, $0, 5 #5
		sw $t1, 0($s4)
		
		addi $s4, $s4, 4
		
		lw $t1, 0($s4)
		addi $t1, $0, 4 #4
		sw $t1, 0($s4)
		
		addi $s4, $s4, 4
		
		lw $t1, 0($s4)
		addi $t1, $0, 1 #1
		sw $t1, 0($s4)
		
		lw $ra, 0($sp) #carga el ra inicial
		addi $sp, $sp, 4
		jr $ra