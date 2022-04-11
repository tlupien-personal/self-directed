# Image Site Downloader
# by: Tim Lupien
# originally written c. 11/2021

# NOTICE: if you change the directory in line 22 to be an actual local
# directory on your computer, this program WILL DOWNLOAD the first 60
# images resulting from your search term on Imgur to that directory. I
# am NOT RESPONSIBLE for ANY consequence of you choosing to do this,
# including but not limited to consequences like downloading
# inappropriate or offensive material (accidentally or intentionally) 
# or consequences stemming from use of your internet connection or the
# storage space on your device.

import os, requests, bs4
from pathlib import Path

UserSearch = input('Enter your search term here: ')

url = f'https://imgur.com/search/score?q={UserSearch}'

res = requests.get(url)

Soup = bs4.BeautifulSoup(res.text, 'html.parser')

images = Soup.select('a[class = "image-list-link"] img')

for a in range(len(images)):
    image = images[a].get('src')
    res2 = requests.get(f'https:{image}')
    file = open(Path('/home/tim/Downloads/ImageTestFolder')\
         / f'Image{a+1}.jpg', 'wb')

    # This is like this because it's a way to write images.     
    for c in res2.iter_content(100000):
        file.write(c)
    file.close
