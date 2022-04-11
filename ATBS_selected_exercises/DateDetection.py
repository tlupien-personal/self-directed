# Date Detection
# by: Tim Lupien
# originally written c. 11/2021

import re

reDate = re.compile(r'([0-2][0-9]|3[0-1])/(0[1-9]|1[0-2])/([1-2][0-9][0-9][0-9])')

#test
text = '''
asfweo fabwefi uawaidf awf asdfia
aw ofaefwiu sd f
awehaer
wa iawio fwaawlifadafgj122935kjsdh93 djsa 2 4 20/04/1969 awofja
wafi abaiew 03/11/2081 awoifa wuwi jawiufahegirads 32/09/2813 ase 
aweopf ia aiu beigaiao q 29/13/1887 asowi 
aw oawiub awli
'''

print(reDate.findall(text))