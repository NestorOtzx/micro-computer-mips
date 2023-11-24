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
    N = 4
    a = [-1, 3, 2, 1, 1]
    b = [1, 2, 3, 4, 5]
    Xarr =  [2, 2, 2, 2, 2]
    
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


