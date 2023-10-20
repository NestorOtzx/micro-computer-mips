
class Conjunto:
    validez = "1"
    tag = ["0" for _ in range(25)]
    data = None


class Bloque:
    conjuntos = None
    
    def __init__(self):
        self.conjuntos = [Conjunto for _ in range(32)]





def main():
    with open("mem.txt", mode = "rt") as archivo:
        content = archivo.readlines()
        a = 5
        print(content[a])
        # for linea in archivo:
        #     print(linea)
        # print(archivo.read())

    
main()