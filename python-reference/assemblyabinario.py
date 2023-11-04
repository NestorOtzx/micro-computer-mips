from sys import stdin

opcodes={"add": 0x0,
         "addi": 0x8,
         "addiu": 0x9,
         "addu": 0x0,
         "and": 0x0,
         "andi": 0xC,
         "beq": 0x4,
         "bne": 0x5,
         "j": 0x2,
         "jal": 0x3,
         "jr": 0x0,
         "lbu": 0x24,
         "lhu": 0x25,
         "ll": 0x30,
         "lui": 0xF,
         "lw": 0x23,
         "nor": 0x0,
         "or": 0x0,
         "ori": 0xD,
         "slt": 0x0,
         "slti": 0xA,
         "sltiu": 0xB,
         "sltu": 0x0,
         "sll": 0x0,
         "srl": 0x0,
         "sb": 0x28,
         "sc": 0x38,
         "sh": 0x29,
         "sw": 0x2B,
         "sub": 0x0,
         "subu": 0x0,
#ARITHMETIC CORE INSTRUCTION SET
         "div": 0x0,
         "divu": 0x0,
         "mfhi": 0x0,
         "mflo": 0x0,
         "mfc0": 0x10,
         "mult": 0x0,
         "multu": 0x0,
         "sra": 0x0,
         }
opcodeFuncs={"add": 0x20,
         "addu": 0x21,
         "and": 0x24,
         "jr": 0x8,
         "nor": 0x27,
         "or": 0x25,
         "slt": 0x2a,
         "sltu": 0xa,
         "sll": 0x0,
         "srl": 0x2,
         "sub": 0x22,
         "subu": 0x23,
#ARITHMETIC CORE INSTRUCTION SET
         "div": 0x1a,
         "divu": 0x1b,
         "mfhi": 0x10,
         "mflo": 0x12,
         "mfc0": 0x0,
         "mult": 0x18,
         "multu": 0x19,
         "sra": 0x3
         }

registros={
          "$zero": 0,
          "$0": 0,
          "$at": 1,
          "$v0": 2,
          "$v1": 3,
          "$a0": 4,
          "$a1": 5,
          "$a2": 6,
          "$a3": 7,
          "$t0": 8,
          "$t1": 9,
          "$t2": 10,
          "$t3": 11,
          "$t4": 12,
          "$t5": 13,
          "$t6": 14,
          "$t7": 15,
          "$s0": 16,
          "$s1": 17,
          "$s2": 18,
          "$s3": 19,
          "$s4": 20,
          "$s5": 21,
          "$s6": 22,
          "$s7": 23,
          "$t8": 24,
          "$t9": 25,
          "$k0": 26,
          "$k1": 27,
          "$gp": 28,
          "$sp": 29,
          "$fp": 30,
          "$ra": 31
}
tipos={  "add": "R",
         "addi": "I",
         "addiu": "I",
         "addu": "R",
         "and": "R",
         "andi": "I",
         "beq": "I",
         "bne": "I",
         "j": "J",
         "jal": "J",
         "jr": "R",
         "lbu": "I",
         "lhu": "I",
         "ll": "I",
         "lui": "I",
         "lw": "I",
         "nor": "R",
         "or": "R",
         "ori": "I",
         "slt": "R",
         "slti": "I",
         "sltiu": "I",
         "sltu": "R",
         "sll": "R",
         "srl": "R",
         "sb": "R",
         "sc": "I",
         "sh": "I",
         "sw": "I",
         "sub": "I",
         "subu": "R",
#ARITHMETIC CORE INSTRUCTION SET
         "div": "R",
         "divu": "R",
         "mfhi": "R",
         "mflo": "R",
         "mfc0": "R",
         "mult": "R",
         "multu": "R",
         "sra": "R",
         }
etiquetas = {}

def main():
    print("Pulse CTRL+D para salir :D")

    indexDeLineas = 0x00400000
    comandos = []
    for linea in stdin:
        linea = linea.lower()
        linea = linea.replace(",", "") #quitar comas
        linea = linea.replace("\n", "") #quitar \n

        if ("#" in linea): #manejar comentarios
            division = linea.split("#")
            if (len(division[0]) > 0): #si estan despues de una linea
                linea = division[0]
            else: #si estan en una linea vacia
                continue
        
        if ":" in linea: #si es una etiqueta
            etiquetas[linea.replace(":", "")] = indexDeLineas+4
        elif len(linea)>0:
            comandos.append(linea.split())
            indexDeLineas+=4
            
    for i in range(0, len(comandos)):
        convertir(comandos[i], i*4+0x00400000)
    
def convertir(linea, idLinea):
  comandos = linea
  
  tipo = tipos[comandos[0]]

  if (tipo == "I"): #TIPO I
    opcode = getOpcode(comandos[0]) 

    registroRS = 0 #rs
    registroRT = getRegistro(comandos[1]) #rt
    strInmediato = "" #inmediato pero en string

    if (len(comandos) > 3): 
        registroRS = getRegistro(comandos[2]) #obtiene el numero del registro en el segundo parametro
        if (opcode == 4): #si es un beq el opcode es 4
            pcsalto = etiquetas[comandos[3]]
            pc = idLinea
            y = (pcsalto-pc-4)/4
            strInmediato = str(int(y))
        else: #si no es un beq            
            strInmediato = comandos[3]
    else:
        if "(" in comandos[2]: #tiene ofset
            dirOfset = comandos[2].replace(")", "").split("(")
            strInmediato = dirOfset[0]
            registroRS=getRegistro(dirOfset[1])
        elif "$" in comandos[2]:    #es un registro
            registroRS = 0
            strInmediato = str(getRegistro(comandos[2]))
        else:                       #es un numero
            registroRS = 0
            strInmediato = comandos[2]
    
    inmediate = 0
    valsInm = strInmediato.split("0x")
    if (len(valsInm) > 1): #si esta en hexadecimal, se convierte de string hexadecimal a decimal
      inmediate = int(strInmediato, 16)
    else:
      inmediate = int(strInmediato) 

    #imprime todo en binario
    print(f"{decimalAbinario(opcode, 6)}{decimalAbinario(registroRS, 5)}{decimalAbinario(registroRT, 5)}{decimalAbinario(inmediate, 16, True)}")

    
  elif (tipo == "R"):#TIPO R
    opcode = getOpcode(comandos[0])
    registroRS = getRegistro(comandos[1])
    registroRT = 0
    registroRD = 0
    strShamt = "0"
    funct = getOpcodeFuncs(comandos[0])

    if (opcode == 0 and (funct == 2 or funct == 0)): #sll o srl
        registroRS = 0
        registroRD = getRegistro(comandos[1])
        registroRT = getRegistro(comandos[2])
        strShamt = comandos[3]

    else: #Los demás tipo R
        n_comandos = len(comandos)

        if (opcode == 0 and funct == 3): #sra
            print("sra")
            registroRD = getRegistro(comandos[1])
            registroRT = getRegistro(comandos[2])
            registroRS = 0
            strShamt = comandos[3]
        if (opcode == 0 and funct == 8): #jr
            registroRS = getRegistro(comandos[1])
            registroRT = 0
            registroRD = 0
        elif (opcode == 0x10): #mfc0
            registroRD = getRegistro(comandos[1])
            registroRS = getRegistro(comandos[2])
        elif (n_comandos > 3):
            registroRD = getRegistro(comandos[1])
            registroRS = getRegistro(comandos[2])
            registroRT = getRegistro(comandos[3])
            if (n_comandos > 4):
                strShamt = comandos[4]
        elif (n_comandos > 2):
            registroRS = getRegistro(comandos[1])
            registroRT = getRegistro(comandos[2])
        elif (n_comandos > 1):
            registroRD = getRegistro(comandos[1])
            registroRS = 0
            
            
    shamt=0
    valsShamt = strShamt.split("0x")
    if (len(valsShamt) > 1):
        shamt = int(strShamt, 16)
    else:
        shamt = int(strShamt)

    #imprime todo en binario
    print(f"{decimalAbinario(opcode, 6)}{decimalAbinario(registroRS, 5)}{decimalAbinario(registroRT, 5)}{decimalAbinario(registroRD, 5)}{decimalAbinario(shamt, 5)}{decimalAbinario(funct, 6)}")

  else: #TIPO J
    opcode = getOpcode(comandos[0])
    valsInm = comandos[1].split("0x")
    
    if (len(valsInm) > 1): #si esta en hexadecimal, se convierte de string hexadecimal a decimal
      inmediate = int(comandos[1], 16)
    else:
      inmediate = etiquetas[comandos[1]]>>2 #traducir etiqueta 
    
    print(f"{decimalAbinario(opcode, 6)}{decimalAbinario(inmediate, 26)}")
 


def getOpcode(opcode):
  return opcodes[opcode.lower()]

def getOpcodeFuncs(opcode):
  return opcodeFuncs[opcode.lower()]

def getRegistro(registro):
  return registros[registro]

def decimalAbinario(n, maxBits, signo = False):
    strNumero = ""
    num = abs(n)
 
    while(num>=1):
        strNumero += str(num % 2)
        maxBits-=1
        num=num//2
    
    if maxBits > 0:
        for b in range(0, maxBits):
            strNumero+="0"

    strNumero = ''.join(reversed(strNumero))

    if (signo and n < 0): #aplicar complemento a2 si es negativo y es necesario
        strNumero = complementoa2(strNumero)
            
    return strNumero

def complementoa2(b):
    n = len(b) 
    ones = ""
    twos = ""
      
    for i in range(n):
        ones += neg(b[i]) 

    ones = list(ones.strip(""))
    twos = list(ones)
    for i in range(n - 1, -1, -1):
      
        if (ones[i] == '1'):
            twos[i] = '0'
        else:         
            twos[i] = '1'
            break
  
    i -= 1    
    if (i == -1):
        twos.insert(0, '1') 

    stringBin = ""
    for s in twos:
        stringBin+=s
    
    return stringBin


def neg(c): #NOT
    return '1' if (c == '0') else '0'


main()

"""
Codigo de prueba:

lui $s0, 0x1000

ori $s0, $s0, 0x8000


addi $s1, $0, 3
addi $s2, $0, 200 #comentario de prueba
add $s1, $s1, $s2


Bucle:
    lw $t1, 0($s0)    
    addi $t1, $t1, 1
    sw $t1, 0($s0)
    addi $s0, $s0, 4
    addi $t0, $t0, 1
    beq $t0, $s2, Repetir
    j Bucle
Repetir:
    addi $s1, $s1, -1
    beq $s1, $0, End
    addi $t0, $0, 0
    lui $s0, 0x1000
    ori $s0, $s0, 0x8000
    j Bucle
End:
    jr $ra

----Otro codigo----
add $s0, $s1, $t1

"""

