A =  [5, 4, 1]
B =  [4, 1, 1]
x = 2

def calcSumX(arr, n, low = 0):
  global x 
  ans = 0
  for i in range(low, len(arr), 1):
    ans += arr[i]*x*(n-i)
  return ans

def calcSumY(arr, n, low = 0):
  ans = 0
  for i in range(low, len(arr), 1):
    ans += arr[i]*y(n-i)
  return ans

def y(n):
  global B, A
  ans = 0
  if (n < 1):
    ans = 1
  else:
    ans = -calcSumY(A, n, 1)+calcSumX(B, n, 0)
  return ans

def main():
  print(y(6))

main()


