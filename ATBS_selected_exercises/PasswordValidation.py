# Password Validation
# by: Tim Lupien
# originally written c. 11/2021

import re

lengthRE = re.compile(r'.{8,}')
lowercaseRE = re.compile(r'[a-z]')
uppercaseRE = re.compile(r'[A-Z]')
numberRE = re.compile(r'\d')

goodPassword = 'G00dPassw0rd'
tooShort = 'Sh0rt'
noLower = 'UPP3RCASE'
noUpper = 'l0wercase'
noNum = 'BadPassword'

def passcheck(password):
   '''checks password against multiple regexes'''
   pstrength = 0
   if lengthRE.search(password) != None:
       pstrength += 1
   if uppercaseRE.search(password) != None:
       pstrength += 1
   if lowercaseRE.search(password) != None:
       pstrength += 1
   if numberRE.search(password) != None:
       pstrength += 1
   if pstrength == 4:
       return 'Good Password!'
   if pstrength <4:
       return 'Bad Password!'

# test
print(goodPassword, "...", passcheck(goodPassword))
print(tooShort, "...", passcheck(tooShort))
print(noLower, "...", passcheck(noLower))
print(noUpper, "...", passcheck(noUpper))
print(noNum, "...", passcheck(noNum))