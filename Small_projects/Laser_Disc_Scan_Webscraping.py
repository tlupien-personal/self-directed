# Laser Disc Scanning / Web Scraping Data Collection tool

# This program, run at the command line, will accept UPC codes as
# strings and, if they are laser discs, look them up in the laser disc
# database, adding a row containing all relevant information to a csv
# file. It will beep once if you scan a duplicate, so you can set it
# aside, and beep twice if you scan something not in the database.

# It can be tested by manually entering a UPC code. UPC codes of laser
# discs can be found by searching the title of popular 80s movies on
# https://www.lddb.com

# The program is exited by keyboard interrupt. Since the audience of the
# program (my Dad) has high technical literacy, I didn't deem it
# necessary to implement a nicer way of exiting.

# By: Tim Lupien
# Originally written c. 12/2021

# import statements
import requests
import bs4
import sys
import uuid
import time 
from os.path import exists
import pandas as pd
import numpy as np

# the big scanning loop
while True:
    # get the link to the more in-depth page from the scan
    current_scan = input()
    res = requests.get(f'https://www.lddb.com/search.php?UPC={current_scan}')
    soup_1 = bs4.BeautifulSoup(res.text, 'html.parser')
    tr = soup_1.find(class_='contents_0')

    try: 
        a = tr.select('a')[0]
        detail_link = a.get('href')

        # get the table data and headers from the page
        res = requests.get(detail_link)
        soup_2 = bs4.BeautifulSoup(res.text, 'html.parser')
        cols_raw = soup_2.find_all(class_='field')
        data_raw = soup_2.find_all(class_='data')

        # the title was a heading, rather than a "field" or "data"-
        # classed element. So its scraped separately and used to start
        # each list
        title = soup_2.select('h2')[0].text.replace(chr(160),'')

        # there were weird non-standard space-like characters in the
        # table (chr(160)), so some of the steps are removing them

        cols = ['Title']
        for field in cols_raw:
            col = field.text.replace(chr(160),'')
            if col in cols:
                col += '_' # sometimes two columns had the same name
            cols.append(col)

        data = [str(title)]
        for field in data_raw:
            data.append(str(field.text.replace(chr(160),'')))

    # beep twice if not found
    except:
        print('\a') # a beep
        time.sleep(.25)
        print('\a')
        print('''There were no search results for that UPC. An empty row\n
                with title "UPC Not Found" has been entered.''')
        cols = ['Title','UPC']
        data = ['UPC Not Found',str(current_scan)]

# Create a tiny dataframe from the single scan. This is done so that it
# can be joined with the main dataframe without issues arising from the
# different number of columns. Any entry that has fewer than the
# maximum number of columns on the website will have its missing
# information filled with nulls.

    pk = uuid.uuid4().hex
    row = pd.DataFrame(np.array([data]),
                       columns=cols,
                       index=[pk],
                       dtype='string')
    row.index.name = 'pk'

    # if there's already a dataframe, tack the row onto it
    if exists('./LD_collection.csv'):
        df = pd.read_csv('./LD_collection.csv', index_col='pk', dtype='string')

        if row.loc[pk,'UPC'] in list(df['UPC'].values):
            print('\a')
            print('This is a duplicate UPC code!')

        # intentionally not in an "else" because the data still gets
        # merged if it's a duplicate
        df = df.append(row)
        print('Data Merged Successfully.')

    # if not, the row gets to be the full dataframe
    else:    
        df = row

    df.to_csv('./LD_collection.csv')

