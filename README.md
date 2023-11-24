# Proyecto de Arquitectura
### **Integrantes**
|             Integrantes             |        Rol en el proyecto       |
|-------------------------------------|---------------------------------|
| Nestor Mauricio Ortiz Montenegro  | Investigación y diseño |
| Phanor Castillo | Pruebas e integración |
| Jhon David Ríos Aguirre | Diseño |
| Laura Camila Franco Valencia | Desarrollo y documentación|

___

### **Metodología de trabajo**

#### Modelo de trabajo

**Horarios de reunión:** Comenzamos a reunirnos con una frecuencia que tendía a ser de al menos cada 15 días en la primera parte del proyecto, sin embargo, desde mediados del semestre
aproximadamente las reuniones se hicieron bastante frecuentes a lo largo de la semana, principalmente los días viernes y sábado, pues en estos días además teníamos la facilidad de resolver dudas
con el profesor Oliden, quien fue una parte importante a la hora de desarrollar el proyecto.

**Posibles horas de reunión sujetas a disponibilidad:** 
|          día          |          hora          |
|-----------------------|------------------------|
| miércoles | 17:00 - 20:00|
| viernes | 14:00 - 18:00|
| sábado | 08:00 - 12:00|
| sábado | 13:00 - 17:00|

**Tipo de reunión:** De tipo presencial (con flexibilidad en casos particulares).
> _Además de las reuniones de vital importancia para concretar por escrito el avance histórico del proyecto; mantendremos una línea de conversación mediante un grupo de whatsapp que nos permite agilizar el proceso de comunicación de una manera eficiente y certera._
#### Plan de trabajo
Localizar la información del proyecto en un repositorio creado en gitHub.
> _Refiérase con información a los archivos y la documentación del proyecto_

#### Cronograma
|       Actividad       |    Fecha de inicio    | Fecha de finalización |
|-----------------------|-----------------------|-----------------------|
| Creación repositorio proyecto | 17/08/2023 | 17/08/2023 |
| Creación primera parte del código de traducción de assembly a binario| 15/08/2023 | 17/08/2023 |
| Corrección funciones tipo R y soporte para comentarios y líneas en blanco del código de traducción de assembly a binario  | 24/08/2023 | 28/08/2023 |
| Creación del código en lenguaje de alto nivel del proyecto | 1/09/2023 | 2/09/2023 |
| Reunión investigación de la UART | 4/09/2023 | 4/09/2023 |
| Creación de la ALU Y ALUControl en VHDL | 18/09/2023 | 18/09/2023|
| Corrección del código en lenguaje de alto nivel del proyecto (no recursión) | 27/09/2023 | 29/09/2023|
| Propuesta de programa en assembly de cada integrante del equipo | 29/09/2023 | 29/09/2023 |
| Correcciones código en assembly por re-direccionamiento de a 1 | 3/10/2023 | 3/10/2023|
| Creación algoritmo en alto nivel simulando una memoria caché | 20/10/2023 | 01/11/2023 |
| Manejo de entradas con switches, implementación de funciones modificadas, traducción de código de assembly a binario | 04/11/2023 | 11/11/2023 |
| Sustentación Memoria Caché | 14/11/2023 | 14/11/2023 |
| Manejo de entradas con switches, implementación de funciones modificadas, traducción de código de assembly a binario | 18/11/2023 | 18/11/2023 |
| Creación quitaRebote, enviar y recibir datos de la UART | 19/11/2023 | 19/11/2023 |
| Detección de error al mostrar información en la tarjeta, pruebas en simulador listas | 21/11/2023 | 19/11/2023 |
| Corrección de error, pruebas en simulador y tarjeta listas. Última reunión de planificación | 23/11/2023 | 23/11/2023 |
 >_Durante la última reunión, además de cerrar la documentación con las conclusiones e información; se discutirán los temas que se enseñarán en la demostración del proyecto al realizar la sustentación. Y como se dividirá entre los mismos la información correspondiente._
___

### Algunas consideraciones 
Este apartado lo mantendremos en el repositorio con el fin de aclarar ciertas cosas de la
sustentación.

**Código en assembly**
``` 
addi $sp, $0, 0x01ff   #definiciones basicas
addi $gp, $0, 0x0100   #definiciones basicas
main:
    jal     leer_uart
    addi    $a0, $v0, 0
    jal     output
    jal     enviar_uart
    jal     getinput
    addi $t0, $0, 6         # IMPRIMIR EN LEDS
    sw $t0, 0x600($0)       # IMPRIMIR EN LEDS
    jal     calc
    addi $t0, $0, 7         # IMPRIMIR EN LEDS
    sw $t0, 0x600($0)       # IMPRIMIR EN LEDS
    addi $a0, $0, 0x0100
    addi $a1, $0, 0x0120
    jal     printMemoria
    addi $t0, $0, 8         # IMPRIMIR EN LEDS
    sw $t0, 0x600($0)       # IMPRIMIR EN LEDS
    lw 		$s0, 4($gp)       # dir Y[0] --IMPRIMIR RESULTADO--
    lw 		$s1, 0($gp)      	# N
    add     $s1, $s1, $s0
    lw      $a0, 0($s1)
bucle:
    addi $t0, $0, 10         # IMPRIMIR EN LEDS
    sw $t0, 0x600($0)        # IMPRIMIR EN LEDS
    jal     output
    j       bucle
leer_uart:
    addi $sp, $sp, -1
    sw $ra, 0($sp)
    jal input           #recibe un enter
    lw $v0, 0x400($0)   #lee lo que hay en la uart despues del enter
    lw $ra, 0($sp)
    addi $sp, $sp, 1
    jr $ra
enviar_uart:
    addi $sp, $sp, -1
    sw $ra, 0($sp)
    jal input            # recibe un enter
    addi $v0, $v0, 0x100 # para activar el send word con el bit 9
    sw $v0, 0x400($gp)   # envia a la uart la informacion de los switches
    lw $ra, 0($sp)
    addi $sp, $sp, 1
    jr $ra
printMemoria: #imprime la memoria desde una posicion a0 hasta una posicion a1
    addi $t0, $a0, 0
    addi $t1, $a1, 0
    for_pMemoria:
        beq $t0, $t1, break_pMemoria
        lw $t2, 0($t0)
        sw $t2, 0x200($0)
        addi $t0, $t0, 1
        j for_pMemoria
    break_pMemoria:
        jr $ra
input:
	addiu $t0, 0x7fff
	addi $t4, $zero, 1
    while_input:
        addi $t3, $0, 10         # guardar 10 en una variable
        lw $t2, 0x600($0)        # Leer enter
        add $t3, $t3, $t2        # calcular 10+enter, para depurar
        sw $t3, 0x600($0)        # IMPRIMIR 10+enter EN LEDS   
        lw $t1, 0x200($0)        # Leer switches
        sw $t1, 0x200($0)        # MOSTRAR EL DATO EN 7 segmentos
        beq $t2, $t4, salir_input
        j while_input
    salir_input:
        addi $t6, $0, 15        # IMPRIMIR 15 EN LEDS
        sw $t6, 0x600($0)       # IMPRIMIR 15 EN LEDS   
        lw $t1, 0x200($0)       # Leer switches
	    sw $t1, 0x200($0)         # MOSTRAR DATOS DE SWITCHES
        lw $t2, 0x600($0)       
        beq $t2, $t4, salir_input  #repetir mientras el enter este presionado
        addi $v0, $t1, 0
        sw $0, 0x200($0) 
        jr $ra
output:
    addiu $t0, 0x7fff            # Imprime y espera por enter para continuar
	addi $t4, $zero, 0x1
    sw $a0, 0x200($0)
    while_output:
        addi $t6, $0, 10         # IMPRIMIR EN LEDS
        sw $t6, 0x600($0)        # IMPRIMIR EN LEDS    
        lw $t1, 0x200($0)
        slt $t3, $t0, $t1
        beq $t3, $t4, salir_output
        j while_output
    salir_output:
        addi $t6, $0, 15         # IMPRIMIR EN LEDS
        sw $t6, 0x600($0)        # IMPRIMIR EN LEDS
        lw $t1, 0x200($0)
        slt $t3, $t0, $t1
        beq $t3, $t4, salir_output  #repetir mientras el enter este presionado
        sw $0, 0x200($0) 
        jr $ra
resetGP: 	
    addi $gp, $0, 0x0100	
    jr $ra
getinput: 
  addi $t6, $0, 1         # IMPRIMIR EN LEDS
  sw $t6, 0x600($0)       # IMPRIMIR EN LEDS
	addi	$sp, $sp, -1
	sw 		$ra, 0($sp)
	jal    	input 			      #lee N
  addi $t6, $0, 2         # IMPRIMIR EN LEDS
  sw $t6, 0x600($0)       # IMPRIMIR EN LEDS
	add    	$s0, $0, $v0
	sw 		  $s0, 0($gp)		      #guarda N
  sw      $s0, 0x200($0)
	addi	$gp, $gp, 4 	      #reserva espacio para las direcciones de los 4 arreglos
	addi 	$gp, $gp, 1
	addi 	$t0, $0, -1 	#A[0] = -1 ya que este valor no se usa en el algoritmo
	sw 		$t0, 0($gp)
	addi $s1, $0, 0 		#i = 0
	addi $s7, $gp, 0 		#guardar la posicion inicial de A en s7
	for_arrA:
		beq 	$s0, $s1, end_for_arrA
		jal    	input 			#lee A[i]
    sw      $v0, 0x200($0)  #imprime A[i]
    add    	$t0, $0, $v0
		addi 	$gp, $gp, 1		#avanzar el global pointer
		sw 		$t0, 0($gp)		#guarda A[i]
		addi 	$s1, $s1, 1 	#i++
		j for_arrA
  end_for_arrA:
    addi $t6, $0, 3         # IMPRIMIR EN LEDS
    sw $t6, 0x600($0)       # IMPRIMIR EN LEDS
    addi 	$s6, $gp, 1       #guardar la posicion inicial de B en s6
	  addi 	$s1, $0, -1       #i = -1 ESTO ES PARA INGRESAR UN VALOR MAS EN EL B, YA QUE M = N+1 Y NO QUEREMOS MODIFICAR $S0
	for_arrB:
		beq 	$s0, $s1, end_for_arrB
		jal    	input 			        #lee B[i]
    sw      $v0, 0x200($0)      #imprime B[i]
		add    	$t0, $0, $v0
		addi 	$gp, $gp, 1		#avanzar el global pointer
		sw 		$t0, 0($gp)		#guarda B[i]
		addi 	$s1, $s1, 1 	#i++
		j for_arrB
	end_for_arrB:
    addi $t6, $0, 4         # IMPRIMIR EN LEDS
    sw $t6, 0x600($0)       # IMPRIMIR EN LEDS
    addi 	$s5, $gp, 1 	  	#guardar la posicion inicial de B en s6
    addi 	$s1, $0, -1 		  #i = -1 ESTO ES PARA INGRESAR UN VALOR MAS EN EL B, YA QUE M = N+1 Y NO QUEREMOS MODIFICAR $S0
    for_arrX:
        beq 	$s0, $s1, end_for_arrX
        jal    	input 			    #lee B[i]
        sw      $v0, 0x200($0)  #imprime X[i]
        add    	$t0, $0, $v0
        addi 	$gp, $gp, 1		#avanzar el global pointer
        sw 		$t0, 0($gp)		#guarda B[i]
        addi 	$s1, $s1, 1 	#i++
        j for_arrX
    end_for_arrX:
      addi $t6, $0, 5         # IMPRIMIR EN LEDS
      sw $t6, 0x600($0)       # IMPRIMIR EN LEDS
      addi 	$s4, $gp, 1 		#guardar direccion del arreglo Y
      jal 	resetGP 
      sw 		$s7, 1($gp) 		#primer elemento de A
      sw 		$s6, 2($gp) 		#primer elemento de B
      sw 		$s5, 3($gp) 		#primer elemento de X
      sw 		$s4, 4($gp)		   #primer elemento de Y
      lw $ra, 0($sp)
      addi $sp, $sp, 1
      jr $ra
calc:
    addi 	$sp, $sp, -1      # Calcula el caso base Y(0) = B0*X(0)
    sw 		$ra, 0($sp)
    lw 		$t0, 2($gp)	      # Posicion inicial de B		
    lw 		$t1, 0($t0)       # Carga el B0
    lw 		$t2, 3($gp)       # Posicion inicial de X
    lw 		$t3, 0($t2)       # Carga el valor inicial de X
    mul     $s0, $t3, $t1   # X[0]*B[0]
    lw 		$s1, 4($gp) 	# Cargar primera posicion de Y
    sw 		$s0, 0($s1)		# Y(0) = B0*X(0) 
    lw 		$s7, 0($gp) 	# cargar N
    addi 	$s7, $s7, 1		# N+1
    addi 	$s6, $0, 1 		# i = 1
    for_calc: 
        beq 	$s7, $s6, end_for_calc
        add 	$a0, $0, $s6        # 
        sw      $s6, 0x200($0)
        sw      $s7, 0x200($0)
        jal 	Y					# calcular Y(i)
        lw 		$t1, 4($gp) 		# cargar primera posicion de Y
        add 	$t0, $t1, $s6		# i+dir(y)
        sw 		$v0, 0($t0) 		# escribir y(i) en memoria
        sw      $v0, 0x200($0)
        addi 	$s6, $s6, 1			# i++
        j 		for_calc
    end_for_calc:
        lw 		$ra, 0($sp)
        addi 	$sp, $sp, 1
        jr 		$ra
calcSumX:
    addi 	$v0, $0, 0 	#ans =  0
    addi 	$s0, $0, 0 	# k  =  0
    addi 	$a2, $a0, 0 	# m
    addi 	$a0, $a0, 1 	# m  +  1
    for_k_in_B:
        beq 	$a0, $s0, end_for_k_in_B
        sub 	$t5, $a2, $s0	#m-i
        lw 	$t1, 2($gp) 	#cargar pos B[0]
        lw 	$t2, 3($gp)	#cargar pos X[0]
        add 	$t1, $s0, $t1 	#cargar dir B[i]
        add 	$t2, $t5, $t2 	#cargar dir X[n-i]
        lw 	$t3, 0($t1) 	#t3 = B[i]
        lw 	$t4, 0($t2) 	#t4 = X[n-i]
        mul 	$t3, $t4, $t3	#B[i]*X[n-i]
        add 	$v0, $v0, $t3 	#ans += b[k]*x
        addi 	$s0, $s0, 1	#i++
        j 	for_k_in_B
    end_for_k_in_B:
	    jr $ra
Y:
    addi 	$sp, $sp, -1
    sw 		$ra, 0($sp)
    addi 	$s2, $0, 1 		# i  =  1
    addi 	$s3, $a0, 1 	# n  +  1
    addi 	$s1, $0, 0 		# ans =  0
    addi 	$a1, $a0, 0		# n
    for_i_in_A:
        beq 	$s3, $s2, end_for_i_in_A
        sub 	$t0, $a1, $s2 		#calcular n-i
        lw 		$s0, 4($gp) 		#cargar la primera posicion de Y
        add 	$s0, $t0, $s0       #calcular la posicion Y[n-i]
        lw 		$s4, 0($s0) 		#obtener Y[n-i] y dejarlo en s4 
        lw 		$s0, 1($gp) 		#cargar primera posicion de A
        add 	$s0, $s2, $s0       #calcular posicion A[i]
        lw 		$s5, 0($s0)         #obtener A[i]
        mul     $s4, $s4, $s5       #calcular A[i]*Y[n-1]
        sub 	$s4, $0, $s4		#calcular -A[i]*Y[n-i]
        addi 	$a0, $s2, 0	 		#calcuar calcSumX(i)
        jal 	calcSumX
        add 	$s1, $s1, $v0		#calcular calcSumX(i) - a[i]*Y[n-i]
        add 	$s1, $s1, $s4	
        addi 	$s2, $s2, 1			#i++
        j 		for_i_in_A
    end_for_i_in_A:
        addi 	$v0, $s1, 0				#return ans
		lw 		$ra, 0($sp)
		addi 	$sp, $sp, 1
		jr 		$ra
fin:
```

**Código del proyecto en lenguaje de alto nivel**

```python
N = 0
a =  []
b =  []
Xarr =  []

"""
N = 4
a =  [-1, 4, 2, 1, 1]
b =  [4, 1, 1, 1, 1]
Xarr =  [1, 1, 1, 1, 1]
"""
Y = [] #Y EN MEMORIA

def calcSumX(m):
  global B, Xarr
  ans = 0
  for k in range(m+1):
    x = Xarr[m-k] #input del usuario
    ans += b[k]*x
  return ans

def y(n):
  global a, Y
  ans = 0
  for i in range(1, n+1):
    val = Y[n-i] #leer Y de la memoria *
    ans += -a[i]*val + calcSumX(i) #calcular la sumatoria
    # print(f"calcX: {calcSumX(i)}")
  return ans

def calc():
  global N, Y, b, Xarr
  Y.append(b[0]*Xarr[0])
  for i in range (1,N+1):
    Y.append(y(i)) # guardar en memoria el valor de Y(i)
  return Y[-1]

def getinput():
    global a, b, Xarr, N
    N = 3
    a = [-1, 3, 3, 3]
    b = [3, 3, 3, 3]
    Xarr =  [3, 3, 3, 3]
    
def main():
  global N, Y,a,b,Xarr
  getinput()
  calc()
  print("N:", N)
  print("A:", a)
  print("B:", b)
  print("X:", Xarr)
  print("Resultado: ", hex(Y[-1]))  
main()

```
