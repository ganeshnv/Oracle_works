#! /usr/local/bin/python3 python

#YEAR = int(input("your year of birth: "))

#def AGE(YEAR):
#    print("You age is", 2022-YEAR,  "if you born in",YEAR)

#AGE(YEAR)

#text="Python is interesting"
#print(ascii(text))

#data = 1
#while data <= 10:
#     print(data)
#     data = data + 1

#data = [1,2,0,4,5]
#for i in data:
#    if i == 0:
#        continue
#    print(i)

#data = [1,2,5,0,7]
#for i in data:
#    if i == 0:
#        print("find", i)
#        break
#    print(i, 'is not 0' )



#!/usr/bin/env python3

import sys
import urllib.request
from xml.etree.ElementTree import XML

if len(sys.argv) != 3:
    raise SystemExit("Usage: script.py routeid(22) stopid(14787)")

route = sys.argv[1]
stopid = sys.argv[2]

u = urllib.request.urlopen("http://ctabustracker.com/bustime/map/getStopPredictions.jsp?route={}&stop={}".format(route,stopid))
data = u.read()
doc = XML(data)

for pt in doc.findall(".//pt"):
    print(pt.text)



