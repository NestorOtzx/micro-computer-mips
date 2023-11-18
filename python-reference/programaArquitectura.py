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
    # N = int(input("Ingrese un N: "))

    # print("Ingresando A:")
    # a.append(-1)
    # for v in range(N):
    #   val = int(input())
    #   a.append(val)

    # print("Ingresando B:")
    # for v in range(N+1):
    #   val = int(input())
    #   b.append(val)
    a = [0, 7, 10]
    b = [8, 11, 1]
    Xarr =  [47, 31, 95]
    N = 2
    
def main():
  global N, Y
  getinput()
  calc()
  for x in Y:
    print(x, end = ", ")
  
main()


