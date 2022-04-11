# File Name Gaps
# by: Tim Lupien
# originally written c. 11/2021

import os, shutil, re
from pathlib import Path

# these first two functions are from:
# https://www.tutorialspoint.com/How-to-correctly-sort-a-string-with-a-number-inside-in-Python
# I did rename the first one because "atoi" meant nothing to me

def grabInteger(text):
	if text.isdigit():
		return int(text)

def natural_keys(text):
    return [ grabInteger(c) for c in re.split('(\d+)',text) ]

def fillGaps(folder, prefix):
	'''A function that goes through a folder, finding all files with the
	given prefix and adjusting the suffix number such that all suffixes
	are counting integers in unbroken order.'''

	files = os.listdir(folder)

	newlist = []

	# Find files with prefix in the name
	for i in range(len(files)):

		prefixRegex = re.compile(f'{prefix}')

		prefixRegexSearch = prefixRegex.search(files[i])

		if prefixRegexSearch != None:
			newlist += [files[i]]

	# Sort the list specifically by the suffix numbers
	newlist.sort(key = natural_keys)

	# Rename files to match their index in the sorted list
	for i in range(len(newlist)):

		indexMatchRegex = re.compile(f'{prefix}{i + 1}[-6]*')
		indexMatchRegexSearch = indexMatchRegex.search(newlist[i])

		# moving in order to rename with correct suffix
		if indexMatchRegexSearch == None:
			shutil.move(folder / newlist[i], folder / f'{prefix}{i + 1}.txt')

def addAtGap(folder, prefix, position):
	'''A function to insert a gap at a given position in a group of
	files with a certain prefix whose suffixes are an unbroken line of
	counting integers.'''

	# find files with the prefix in the name
	files = os.listdir(folder)
	newlist = []

	for i in range(len(files)):
		prefixRegex = re.compile(f'{prefix}')
		prefixRegexSearch = prefixRegex.search(files[i])
		if prefixRegexSearch != None:
			newlist += [files[i]]

	# Sort the list specifically by the suffix numbers
	newlist.sort(key = natural_keys)

	prefixAndIndexRegex = re.compile(f'{prefix}{position}.*')

	j = 0 # why is this like this, past Tim? - 03/2022 Tim

	for i in range(len(newlist)):
		# Find the one at the given position
		prefixAndIndexRegexSearch = prefixAndIndexRegex.search(newlist[i])
		j += 1

		if prefixAndIndexRegexSearch != None:
			
			# adds the gap and moves the documents aboe it to match
			for k in range(len(newlist)-1, j-2,-1):

				shutil.move(folder / newlist[k], folder / f'{prefix}{k + 2}.txt')

			break


# This folder contained 35 files named "answerkey1.txt" through 
# "answerkey35.txt" which were generator as part of a guided project
# earlier in this textbook.
folder = Path(r'/home/tim/Documents/NameGapsTest')
prefix = 'answerkey'

#test
fillGaps(folder,prefix)
addAtGap(folder,prefix,16)