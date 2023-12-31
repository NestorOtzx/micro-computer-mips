import math, linecache
import shutil #para reemplzar mem.txt por la copia
from collections import deque

MAXOFFSET, MAXINDEX, MAXTAG= 8, 8, 63

arrVias, arrColas = None, None

contadorHitsW, contadorMissW, contadorHitsR, contadorMissR, contadorQueues = 0, 0, 0, 0, 0

class Conjunto:
    def __init__(self):
        self.validez = 0
        self.dirty = 0
        self.tag = 0
        self.data = [0 for _ in range(8)]

    def __str__(self):
        return f"|{self.validez}|{self.dirty}|{self.tag}|{self.data}|"

class Via:
    def __init__(self, nVia = -1):
        self.conjuntos = [Conjunto() for _ in range(8)]
        self.nVia = nVia

    def __str__(self):
        ans = f"Via #{self.nVia+1}\n|V|D|t|         datos          |\n"
        for v in self.conjuntos:
            ans += str(v) + "\n"
            # print(v)
        return ans
    
    def getDirty(self, index): return self.conjuntos[index].dirty
    def setDirty(self, index, dirty): self.conjuntos[index].dirty = dirty
    
    def write(self, tag, index, offSet, data):
        self.conjuntos[index].data[offSet] = data
        self.conjuntos[index].tag = tag
        self.conjuntos[index].validez = 1

def hitW(): global contadorHitsW; contadorHitsW+=1

def missW(): global contadorMissW; contadorMissW += 1

def hitR(): global contadorHitsR; contadorHitsR+=1

def missR(): global contadorMissR; contadorMissR += 1

def queue(): global contadorQueues; contadorQueues += 1

def calcularOffSet(a): return a % MAXOFFSET

def calcularIndex(a): return math.floor(a // MAXOFFSET) % MAXINDEX
    
def calcularTag(a): return a // MAXTAG    

def printCache():
    for i in range(4): print(arrVias[i])

def printEstadisticas():
    print("-.-.             ESTADISTICAS                -.-.")
    print("Miss Lectura:", contadorMissR, "                Miss Escritura:", contadorMissW)
    print("Hit Lectura:", contadorHitsR, "                  Hit Escritura:", contadorHitsW)
    print("QUEUES:", contadorQueues)
    print(f"PORCENTAJE DE MISS: {((contadorMissW+contadorMissR)/contadorQueues):.2f}")
    print(f"PORCENTAJE DE HIT: {((contadorHitsW+contadorHitsR)/contadorQueues):.2f}")

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
        hitW()
        firstBlock = arrColas[index].popleft()
        arrVias[firstBlock].setDirty(index, 0)

        tag = arrVias[firstBlock].conjuntos[index].tag
        direction = (index * 8) + (tag * 64) #reconstruye la direccion en memoria en base al index y tag
        
        for i in range(8):
            escribirDisco(direction + i, arrVias[firstBlock].conjuntos[index].data[i])
        
        writeRoad = getWriteRoad(index)
        arrVias[firstBlock].setDirty(index, 1) #para evitar que cuente el miss de escritura

    return writeRoad

def write(dir, dato):
    global arrColas
    queue()
    tag, index, offSet = decoDir(dir)
    writeRoad = getWriteRoad(index)
    if (arrVias[writeRoad].getDirty(index) == 0):
        missW()
    arrVias[writeRoad].write(tag, index, offSet, dato)
    arrVias[writeRoad].setDirty(index, 1)
    arrColas[index].append(writeRoad)

def read(dir):
    global arrColas
    queue()
    tag, index, offSet = decoDir(dir)

    readRoad = 0
    flagTag = False
    it = 0
    while not flagTag and it < 4:
        if arrVias[it].getDirty(index) == 1 and arrVias[it].conjuntos[index].tag == tag:
            readRoad = it
            flagTag = True
        it += 1

    if flagTag == True:
        print(f"Cache | {arrVias[readRoad].conjuntos[index].data[offSet]}")
        hitR() 
    else: #SI NO ESTA EN CACHE, BUSCARLO EN LA MEMORIA
        print("El dato no esta presente en cache")
        writeRoad = 0
        flag = False
        it = 0
        while not flag and it < 4:
            if arrVias[it].getDirty(index) == 0:
                writeRoad = it
                flag = True
            it += 1
        if not flag:
            writeRoad = arrColas[index].popleft()

        dirIni = dir-offSet
        for i in range(8): #Write back
            disc = leerDisco(dirIni+i)
            cache = arrVias[writeRoad].conjuntos[index].data[i]
            escribirDisco(dirIni + i, cache)
            arrVias[writeRoad].write(tag, index, i, disc)
        arrVias[writeRoad].setDirty(index, 1)
        arrColas[index].append(writeRoad)
        print(f"Memoria | {leerDisco(dir)}")
        missR()
        



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
    resetMemory()
    
    ejemplo1()

    printEstadisticas()

"""
Ejemplos para ver el comportamiento de la memoria
"""
def ejemplo1():
    read(0)
    write(0, 20)
    read(65)
    read(256)
    write(0, 11)
    write(0, 12)
    printCache()

main()
