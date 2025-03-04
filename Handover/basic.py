#!/usr/bin/env python3

## Tuples are immutable, we can change or append the values, once set it fixed
## python tuple object, a bunch of various values packed together
t = ('AA', '1992-06-12', 100, 32.2)
t[1]
print(t[1])


## List are mutable, we can change/append the values
## All value should be same type('string' or int or float)

l = [ 'AAA', 'IBM', 'YAHOO', 'GOOGLE']
l[1]
l.insert(1, 'BBB')
l[2] = 'RedHat'
print(l)

## set object, use to remove duplicated

names = {'AAA', 'BBB', 'AAA', 'CCC','DDD', 'BBB'}
print(names)
#set(names)
print('AAA' in names)  ## o/p will be true ot false
print('JJ' in names)

## Dictionary object, support key value pair

value = {'Apple': 10, "Mango": 8}
print(value['Apple'])

value['Mango'] = 12

print(value)

prices = {'IBM': {'current': 94.3, 'high': 110, 'low': 88}}
print(prices['IBM'])
print(prices['IBM']['low'])