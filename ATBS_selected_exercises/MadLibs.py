# MadLibs
# by: Tim Lupien
# originally written c. 11/2021

# Madlibs for this purpose should be stored in a .txt file and have the
# format: 

# The ADJECTIVE panda walked to the NOUN and then VERB. A nearby NOUN 
# was unaffected by these events.

# as described by the original problem statement.

import re, pyinputplus as pyip

# validates filepath input
textFilePath = pyip.inputFilepath(
    'Please paste the absolute filepath to your madlibs text document',
    mustExist = True)

#read the empty madlib
textFile = open(textFilePath)
content = textFile.read()
textFile.close()

tRE = re.compile(r'noun|verb|adjective|adverb',re.IGNORECASE)

tSearch = tRE.search(content)

# iterate through the document, making replacements such that each
# search call returns the next non-filled instance of "noun", "verb",
# "adjective", or "adverb"
while tSearch != None:
    tNext = str(tSearch.group()).lower()
    if tNext == 'noun':
        s = input('Enter a noun: ')
    elif tNext == 'verb':
        s = input('Enter a verb: ')
    elif tNext == 'adjective':
        s = input('Enter an adjective: ')
    else:
        s = input('Enter an adverb: ')
    content = tRE.sub(s,content,1)
    tSearch = tRE.search(content)

# overwrite the madlib with the filled version
textFile = open(textFilePath,'w')
textFile.write(content)
textFile.close()