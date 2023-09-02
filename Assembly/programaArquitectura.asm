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
		jal defArrB      #definir el arreglo B = [4, 1, 1]
		
		addi $s7, $0, 2  # X = 2
		addi $s6, $0, 6  # n = 6
		addi $t0, $0, 0  # i = 0 del for
		addi $t1, $0, 3  # Longitud del arreglo [4, 1, 1]
		addi $s1, $s1, 0 # calSumX ans = 0
		
		# Direccion del primer elemento del arreglo B
		lui $s0, 0x1000
		ori $s0, $s0, 0x8000
		
		# j calcSumX
		j fin
		
	calcSumX: #return 
		
		# Ciclo for ($t0 = 0) in range($t1)
		beq $t0, $t1, fin 
		
		# Obtener arr[i]
		lw $a0, 0($s0)
		
		# Calcular arr[i]*x
		mult $a0, $s7 
		mflo $a0
		
		# Calcular (n-i)
		sub $t9, $s6, $t0
		
		# Calcular (arr[i]*x*(n-i))
		mult $a0, $t9
		mflo $a0
		
		# Calcular ans += arr[i]*x*(n-i)
		add $s1, $s1, $a0
		
		# imprimir arr[i]*x*(n-i) y un \n
		# jal printNum
		# jal endl

		# i++
		addi $t0, $t0, 1
		addi $s0, $s0, 4
		j calcSumX
		
	fin:
		#imprimir resultado
		add $a0, $0, $s1
		jal printNum
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
		la $a0, mensajeDePrueba
		syscall
		jr $ra
	printFin:
		li $v0, 4
		la $a0, mensajeDeFin
		syscall
		jr $ra
	printNum:
		li $v0, 1
		#hacer print del numero en $a0
		syscall
		jr $ra
	endl:
		li $v0, 4
		la $a0, endline
		syscall
		jr $ra
	# arr A [4, 1, 1]
	# arr B [4, 1, 1]
	defArrB:
		addi $sp, $sp, -4
		
		sw $ra, 0($sp)

		lui $s0, 0x1000
		ori $s0, $s0, 0x8000
		
		lw $t1, 0($s0)
		addi $t1, $0, 4 #4
		sw $t1, 0($s0)
		
		addi $s0, $s0, 4
		
		lw $t1, 0($s0)
		addi $t1, $0, 1 #1
		sw $t1, 0($s0)
		
		addi $s0, $s0, 4
		
		lw $t1, 0($s0)
		addi $t1, $0, 1 #1
		sw $t1, 0($s0)
		
		lw $ra, 0($sp) #carga el ra inicial
		addi $sp, $sp, 4
		jr $ra