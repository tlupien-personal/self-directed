# Collatz Sequence
# by: Tim Lupien
# originally written c. 11/2021

def collatz(x):
   try:
       x = int(x)
   except ValueError:
       print("That wasn't a valid integer.")
       return "err"
   if x % 2 == 0:
       y = x // 2
       print(y)
       return y
   else:
       y = 3 * x + 1
       print(y)
       return y

while True:
   x = input("Please supply a valid integer: ")
   if collatz(x) == "err":
       continue
   else:
       while x != 1:
           x = collatz(x)
       break