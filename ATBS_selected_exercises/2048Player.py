# 2048 Player
# by Tim Lupien
# originally written c. 11/2021

from selenium import webdriver
from selenium.webdriver.common.keys import Keys

# the way I set this up goes a little beyond the assingment, playing
# gamesNum games and returning the average performance for the sample.

gamesNum = int(input('How many games should be in this sample? '))

B = webdriver.Firefox()
B.get('https://play2048.co/')
game = B.find_element_by_tag_name('body')

scoreList = []
gameCounter = 0

while gameCounter < gamesNum:
	game.send_keys(Keys.UP)
	game.send_keys(Keys.RIGHT)
	game.send_keys(Keys.DOWN)
	game.send_keys(Keys.LEFT)
	try:
		B.find_element_by_class_name('game-over')
		score = B.find_element_by_class_name('score-container').text
		scoreList += [int(score)]
		newGame = B.find_element_by_class_name('restart-button')
		newGame.click()
		gameCounter += 1
	except:
		continue
B.quit()

avgScore = sum(scoreList)/len(scoreList)

#result
print(f'The average score acheived by the up-right-down-left algorithm\
 in this sample of {gamesNum} games was: {avgScore}')