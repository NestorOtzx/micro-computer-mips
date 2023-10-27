import math, linecache
from collections import deque

MAXOFFSET = 8
MAXINDEX = 8
MAXTAG = 63

arrVias = None
arrColas = None

class Conjunto:
    validez = 0
    dirty = 0
    tag = 0
    data = []

    def __init__(self):
        self.validez = 0
        self.dirty = 0
        self.tag = 0
        self.data = [None for _ in range(8)]

    def __str__(self):
        return f"|{self.validez}|{self.tag}|{self.data}|"


class Via:
    conjuntos = None
    
    def __init__(self):
        self.conjuntos = [Conjunto() for _ in range(8)]

    def __str__(self):
        ans = ""
        for v in self.conjuntos:
            ans += str(v) + "\n"
            # print(v)
        return ans



def calcularOffSet(a):
    return a % MAXOFFSET

def calcularIndex(a):
    b = math.floor(a // MAXOFFSET)
    b = b % MAXINDEX
    return b
    
def calcularTag(a):
    return a // MAXTAG    

def decoDir(dir):
    offSet = calcularOffSet(dir)
    index = calcularIndex(dir)
    tag = calcularTag(dir)

    return tag, index, offSet

def hit(dir):
    print("Hit en la dir:", dir)

def findDirtys(index):
    i = 0
    flag = False
    writeBlock = -1
    while((i < 4) and (not flag)):
        if(arrVias[i].conjuntos[index].dirty == 0):
            flag = True
            writeBlock = i
            arrVias[i].conjuntos[index].dirty = 1
        
        i += 1

    if(flag == False):
        firstBlock = arrColas[index].popleft()
        arrVias[firstBlock].conjuntos[index].dirty = 0
        #ESCRIBIR EN LA MEMORIA
        tag = arrVias[firstBlock].conjuntos[index].tag
        # tag = tag * 64
        direction = (index * 8) + (tag * 64)

        for i in range(8):
            escribirDisco(direction + i, arrVias[firstBlock].conjuntos[index].data[i])

        writeBlock = findDirtys(index)
    return writeBlock



def write(dir):
    global arrColas
    tag, index, offSet = decoDir(dir)
    writeBlock = findDirtys(index)
    arrVias[writeBlock].conjuntos[index].data[offSet] = leerDisco(dir)
    arrColas[index].append(writeBlock)

def read(dir):
    global arrVias
    for i in range(4):
        print(arrVias[i])

def writeMem(dir):
    datoTxt = leerDisco(dir)
    write(dir, datoTxt)

def leerDisco(dir):
    # print(linecache.getline("mem.txt", dir + 1))    
    return linecache.getline("mem.txt", dir + 1).strip()

def escribirDisco(dir, dato):
    lines = open('mem.txt', 'r').readlines()
    lines[dir] = str(dato) + "\n"

    out = open('mem.txt', 'w')
    out.writelines(lines)
    out.close()

def main():
    global arrVias, arrColas
    arrVias = [Via() for _ in range(4)]
    arrColas = [deque() for _ in range(8)]
    write(0)
    write(0)
    write(0)
    write(0)
    read(0)
    write(0)
    write(0)
    write(0)
    write(0)
    read(0)
    escribirDisco(1, -1)

main()