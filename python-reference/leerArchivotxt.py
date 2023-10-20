import math, linecache

MAXOFFSET = 4
MAXINDEX = 8
MAXTAG = 31

arrBloques = None
content = None

class Conjunto:
    validez = "0"
    tag = None
    data = None

    def __init__(self):
        self.validez = "0"
        self.tag = None
        self.data = None


class Bloque:
    conjuntos = None
    
    def __init__(self):
        self.conjuntos = [Conjunto() for _ in range(8)]

def calcularOffSet(a):
    return a % MAXOFFSET

def calcularIndex(a):
    b = math.floor(a // MAXOFFSET)
    b = b % MAXINDEX
    return b
    
def calcularTag(a):
    return a // MAXTAG    

def calcularDireccion(dir):
    offSet = calcularOffSet(dir)
    index = calcularIndex(dir)
    tag = calcularTag(dir)

    return tag, index, offSet

def hit(dir):
    print("Hit en la dir:", dir)


def write(dir, data):
    global arrBloques
    flag = True
    tag, index, offSet = calcularDireccion(dir)
    i = 0
    while((flag == True) and (i < 4)):
        print("Bloque:", i)
        if(arrBloques[i].conjuntos[index].data == None):
            arrBloques[i].conjuntos[index].data = data
            arrBloques[i].conjuntos[index].tag = tag
            arrBloques[i].conjuntos[index].validez = "1"
            flag = False
            for j in range(len(arrBloques[i].conjuntos)):
                print(arrBloques[i].conjuntos[j].data)
            print()
        elif((arrBloques[i].conjuntos[index].validez == "1") and (arrBloques[i].conjuntos[index].tag == tag)):
            hit(dir)
        i += 1

def read(dir):
    global arrBloques
    tag, index, offSet = calcularDireccion(dir)
    return arrBloques[offSet].conjuntos[index].data

def writeMem(dir):
    datoTxt = leerDisco(dir)
    write(dir, datoTxt)

def leerDisco(dir):
    # print(linecache.getline("mem.txt", dir))
    return linecache.getline("mem.txt", dir).strip()

def main():
    global arrBloques

    arrBloques = [Bloque() for _ in range(4)]
    writeMem(1)
    writeMem(5)
    writeMem(275)
    writeMem(2048)
    print("Leer dato de la posición 271", read(2048))
    
main()