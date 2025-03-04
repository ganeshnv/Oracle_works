#!/usr/bin/env python3
'''
f = open('textfile', 'r')
data = f.read()
data
print(data)
f.close()

f = open('textfile', 'r')
for line in f:
    print(line)
f.close()

total = 0.0
with open('textfile1', 'r') as f:
    headers = next(f) # skip a single of line
    #d = f.read()
    #print(data)
    #data = d.strip() # remove white space 
    #data = d.strip('"')  # remove "
    #data[2] = int(data[2])
    #data[3] = float(data[3])
    #print(data)
    #print(data.replace('"',"'"))
    #print(data.split(','))
    for line in f:
        line = line.strip() #strip whitespace
        line = line.split(',')
        line[0] = line[0].strip('"')
        line[1] = line[1].strip('"')
        line[2] = int(line[2])
        line[3] = float(line[3])
        #print(line)
        total += line[2]*line[3]
print(total)
f.close()

import csv
total = 0.0
with open('textfile2', 'r') as f:
    rows = csv.reader(f)
    headers = next(rows)
    for row in rows:
        row[2] = int(row[2])
        row[3] = float(row[3])
        total += row[2] * row[3]
print('Total cost: ', total)


import csv
def portfolio_cost(filename):
    total = 0.0
    with open(filename, 'r') as f:
        rows = csv.reader(f)
        headers = next(rows)
        for row in rows:
            row[2] = int(row[2])
            row[3] = float(row[3])
            total += row[2] * row[3]
    return total
total = portfolio_cost('textfile2')
print(total)


import glob
files = glob.glob('textfile*') ## recursion
#print(files)
for file in files:
    print(file, portfolio_cost(file))


import csv
#def portfolio_cost(filename):
def portfolio_cost(filename, *, errors='warn'): # optional argument, * indicates force to give key value style while calling function
    total = 0.0
    if errors not in {'warn', 'silent', 'raise'}:
        raise ValueError("errors must be one of 'warn', 'silent', 'raise'")
    with open(filename, 'r') as f:
        rows = csv.reader(f)
        headers = next(rows)
        for rowno, row in enumerate(rows, start=1): 
            # (or)
#       rowno = 0
#       for row in rows:
#           rowno += 1
            try:
                row[2] = int(row[2])
                row[3] = float(row[3])
            except ValueError as err:
#           except Exception as err: # catches all errors(dangerous)
                if errors == 'warn':
                    print('Rowno: ', rowno, 'Bad row: ', row)
                    print('Rowno: ', rowno, 'Reason: ', err)
                elif errors == 'raise':
                    raise # Reraises the last exception
                else:
                    pass
                continue # skip to next row
            total += row[2] * row[3]
    return total
print(portfolio_cost('missing', errors='silent'))
##print(portfolio_cost('missing', errors='silent'))
###print(portfolio_cost('missing', errors='raise'))



import csv
def read_portfolio(filename):
#    total = 0.0
    portfolio = []
    with open(filename, 'r') as f:
        rows = csv.reader(f)
        headers = next(rows)
        for rowno, row in enumerate(rows, start=1):
            try:
                row[2] = int(row[2])
                row[3] = float(row[3])
            except ValueError as err:
                print('row:', rowno, 'Bad row:', row)
                print('row:', rowno, 'Reason: ', err)
                continue
#            record = tuple(row)
            record = {'name': row[0], 'date': row[1], 'share': row[2], 'price': row[3]} # if we want to ass recore as dictionary
            portfolio.append(record)
#            total += row[2] * row[3]
#    return total
    return portfolio
portfolio = read_portfolio('textfile2')

total = 0.0
for i in portfolio:
#    total += i[2] * i[3]
    total += i['share'] * i['price'] # for dictionary record    
#for name, date, share, price in portfolio:
#    total += share * price
print(total)

#########
#total = sum([item['share']*item['price'] for item in portfolio])
#print(total)
#########



import json
data = json.dumps(portfolio)
print(data)
print(len(data))


names = []
for item in portfolio:
    names.append(item['name'])
print(names)

##########
names = [item['name'] for item in portfolio]
print(names)
##########


more100 = []
for item in portfolio:
    if item['share'] > 100:
        more100.append(item)
print(more100)

############
more100 = [item for item in portfolio if item['share'] > 100]
print(more100)
############

###########
print([item['share']*item['price'] for item in portfolio])
###########

names = { item['name'] for item in portfolio }
namestr = ','.join(names)
#print(namestr)

import urllib.request
u = urllib.request.urlopen('http://finance.yahoo.com/d/quotes.csv?s={}&f=l1'.format(namestr))  #url is not valid
pricedata = u.read()
print(pricedata)

pricedata = [b'76.3',b'57.8']
print(names)
print(pricedata)
#for name, price in zip(names, pricedata):
#    print(name, '=', price)

prices = dict(zip(names, pricedata))
print(prices)

##############
prices = { name: float(price) for name, price in zip(names, pricedata)}
print(prices)
##############
'''


'''
current_value = 0.0
for item in portfolio:
    current_value += item['share'] * prices[item['name']]
print(current_value)

###########
current_value = sum([item['share']*prices[item['name']] for item in portfolio])
print(current_value)
###########
'''

'''
def item_name(item):
    return item['name']
print(item['name'])

#print(item_name(portfolio[0])) == O/P: AA 
portfolio.sort(key=item_name)

#   ( or)

portfolio.sort(key=lambda item: item['item'])
for item in portfolio:
    print(item)
'''

'''
mimi = min(portfolio, key=lambda item: item['price'])
print(mimi)

maxx =max(portfolio, key=lambda item: item['price'])
print(maxx)

a = lambda x: 10*x
print(a(10))

b = lambda x,y: x + y
print(b(5,6))
'''

'''
import itertools

for name, items in itertools.groupby(portfolio, key=lambda item: item['name']):
    print('Name:', name)
    for it in items:
        print('  ', it)
    
by_name = {name: list(items) for name, items in itertools.groupby(portfolio, key=lambda item: item['name']) }

print(by_name['IBM'])
'''
















