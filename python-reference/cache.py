import math, linecache
import shutil #para reemplzar mem.txt por la copia
from collections import deque

MAXOFFSET, MAXINDEX, MAXTAG= 8, 8, 8

arrVias, arrColas = None, None

contadorHits, contadorMiss, contadorQueues = 0, 0, 0

class Conjunto:
    def __init__(self):
        self.validez = 0
        self.dirty = 0
        self.tag = 0
        self.data = [0 for _ in range(8)]

    def __str__(self):
        return f"|{self.validez}|{self.tag}|{self.data}|"

class Via:
    def __init__(self, nVia = -1):
        self.conjuntos = [Conjunto() for _ in range(8)]
        self.nVia = nVia

    def __str__(self):
        ans = f"Via #{self.nVia+1}\n"
        for v in self.conjuntos:
            ans += str(v) + "\n"
            # print(v)
        return ans
    
    def getDirty(self, index): return self.conjuntos[index].dirty
    def setDirty(self, index, dirty): self.conjuntos[index].dirty = dirty
    
    def write(self, tag, index, offSet, data):
        self.setDirty(index, 1)
        self.conjuntos[index].data[offSet] = data
        self.conjuntos[index].tag = tag
        self.conjuntos[index].validez = 1

def hit(): global contadorHits; contadorHits+=1

def miss(): global contadorMiss; contadorMiss += 1

def queue(): global contadorQueues; contadorQueues += 1

def calcularOffSet(a): return a % MAXOFFSET

def calcularIndex(a): return math.floor(a // MAXOFFSET) % MAXINDEX
    
def calcularTag(a): return a // MAXTAG    

def printCache():
    for i in range(4): print(arrVias[i])

def printEstadisticas():
    print("-.-.             ESTADISTICAS                -.-.")
    print("| MISS | HIT | QUEUES |")
    print(f"| {contadorMiss} | {contadorHits} | {contadorQueues} |")
    print(f"PORCENTAJE DE MISS: {(contadorMiss/contadorQueues):.2f}")
    print(f"PORCENTAJE DE HIT: {(contadorHits/contadorQueues):.2f}")

def resetCache():  #deja la cache vacia
    global arrColas, arrVias
    del arrColas; del arrVias
    arrVias = [Via(_) for _ in range(4)]
    arrColas = [deque() for _ in range(8)]

def resetMemory(): #copia el archivo mem_copy.txt en mem.txt
    shutil.copyfile('mem_copy.txt', 'mem.txt') 

def decoDir(dir):
    offSet = calcularOffSet(dir)
    index = calcularIndex(dir)
    tag = calcularTag(dir)
    return tag, index, offSet

def getWriteRoad(index):
    i, writeRoad, flag = 0, -1, False

    while((i < 4) and (not flag)):
        if(arrVias[i].getDirty(index) == 0):
            flag = True
            writeRoad = i
        i += 1

    if(flag == False):
        hit()
        firstBlock = arrColas[index].popleft()
        arrVias[firstBlock].setDirty(index, 0)
        #ESCRIBIR EN LA MEMORIA
        tag = arrVias[firstBlock].conjuntos[index].tag

        direction = (index * 8) + (tag * 64) #reconstruye la direccion en memoria en base al index y tag

        for i in range(8):
            escribirDisco(direction + i, arrVias[firstBlock].conjuntos[index].data[i])
        writeRoad = getWriteRoad(index)
        arrVias[writeRoad].setDirty(index, 1)

    return writeRoad

def write(dir):
    global arrColas
    queue()
    tag, index, offSet = decoDir(dir)
    writeRoad = getWriteRoad(index)
    if (arrVias[writeRoad].getDirty(index) == 0):
        miss()

    arrVias[writeRoad].write(tag, index, offSet, leerDisco(dir))
    arrColas[index].append(writeRoad)

def read(dir):
    global arrColas
    queue()
    tag, index, offSet = decoDir(dir)

    readRoad = 0
    #si hay valores la cola para la politica LFU (??????)
    if len(arrColas[index]) > 0 : 
        # ayuda, esto para mi tiene sentido
        readRoad = arrColas[index][-1]

    if arrVias[readRoad].conjuntos[index].tag == tag and arrVias[readRoad].conjuntos[index].validez == 1:
        print(f"Cache | {arrVias[readRoad].conjuntos[index].data[offSet]}")
    else: #SI NO ESTA EN CACHE, BUSCARLO EN LA MEMORIA
        print("El dato no esta presente en cache")
        print(f"Memoria | { leerDisco(dir) }")
        miss()

def writeMem(dir):
    datoTxt = leerDisco(dir)
    write(dir, datoTxt)

def leerDisco(dir):
    ans = None
    if dir >= 2048 or dir < 0:
        print("Error: Esa direccion no cabe en la memoria")
        ans = 0
    else:
        ans = linecache.getline("mem.txt", dir + 1).strip()
    return ans

def escribirDisco(dir, dato):
    if dir >= 2048 or dir < 0:
        print("Error: Esa direccion no cabe en la memoria")
    else:
        lines = open('mem.txt', 'r').readlines()
        lines[dir] = str(dato) + "\n"

        out = open('mem.txt', 'w')
        out.writelines(lines)
        out.close()

def main():
    global arrVias, arrColas
    resetCache()
    ejemplo5()
    printEstadisticas()

"""
Ejemplos para ver el comportamineto de la memoria
"""
def ejemplo1():
    print("Simple escritura de 4 datos en memoria cache")
    write(0)
    write(1)
    write(2)
    write(3)
    printCache()

#Ejemplo de writeback
def ejemplo2():
    print("---Ejemplo write back---")
    write(0)
    write(0)
    write(0)
    write(0)
    
    print("--Cache antes de write back --")
    printCache()    
    write(0)
    write(0)
    write(0)
    write(0)

    print("--Cache despues de write back --")
    printCache()    

#varias lecturas y escrituras
def ejemplo3():
    write(0)
    write(1)
    write(2)
    write(3)
    read(1)
    read(2)
    read(5)
    write(1)
    write(1)
    write(1)
    write(1)
    read(0)
    resetMemory()

def ejemplo4():
    read(3) #lee antes de que el dato haya sido enviado en cache 
    write(0)
    write(1)
    write(2)
    write(3)
    read(3) #lee despues de que el dato haya sido enviado en cache
    printCache()

def ejemplo5():
    write(3048)
    read(3048)

main()