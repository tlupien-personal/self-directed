# Coin Flip Streaks
# by: Tim Lupien
# originally written c. 11/2021

import random

StreaksInExperiment = []
g = [i for i in range(6,100)] # why?
# The initial prompt was for counting streaks of 6 of the same (6 heads
# or 6 tails) in a row.

for experimentNumber in range(10000):

    experimentList = [] # as in, the list used in a single experiment

    # 100 "coin flips"
    for i in range(100):
        r = random.randint(0,1)
        if r == 0:
            experimentList.append('tails')
        else:
            experimentList.append('heads')

    # count how many streaks (of 6) in a single experiment and add it to
    # the list to results of all experiments

    numberOfStreaks = 0

    for i, j in enumerate(g):
        if experimentList[i:j] == ['heads'] * 6\
        or experimentList[i:j] == ['tails'] * 6:
            numberOfStreaks += 1

    StreaksInExperiment.append(numberOfStreaks)

# now this part is for reporting the results
for i in range(0,max(StreaksInExperiment)):

    # count how many times a certain number of streaks of 6 occurred
    # in each experiment
    count = 0

    for j in range(len(StreaksInExperiment)):

        if StreaksInExperiment[j] == i:
            count += 1

    # use these counts to report the probability
    if i == 0:
        print('Chance of no streaks: %s%%' % (count / 100))
        # this next line, chance of any streaks, is the actual answer.
        # the rest of this is just a more detailed breakdown I found
        # interesting.
        print('Chance of any streaks: %s%%' % (100 - (count / 100)))
    elif i == 1:
        print('Chance of ' + str(i) + ' streak: %s%%' % (count / 100))
    else:
        print('Chance of ' + str(i) + ' streaks: %s%%' % (count / 100))
