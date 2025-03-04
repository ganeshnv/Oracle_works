#!/usr/bin/env python3
'''
class holding(object):
    def __init__(self, name, date, share, price):
        self.name = name
        self.date = date
        self.share = share
        self.price = price

    def cost(self):
        return self.share * self.price

    def sell(self, nshare):
        self.share -= nshare
        return self.share
    
h = holding("AA", "1996-07-07", 100, 32.9)
print(h.name) 
# or
print(getattr(h, 'name'))
h.share = 150
#or
setattr(h, 'share', 150)
print(h.share)
print(h.cost())
print(h.sell(25))
'''

##########
#To reload table module
#import importlib
#importlib.reload(modulename)


class Date(object):
    def __init__(self, year, month, day):
        self.year = year
        self.month = month
        self.day = day

    @classmethod
    def from_string(cls, s):
        part = s.split('-')
        return cls(int(part[0]), int(part[1]), int(part[2]))

    @classmethod
    def today(cls):
        import time
        t = time.localtime()
        return cls(t.tm_year, t.tm_mon, t.tm_mday)

d = Date.from_string('1996-07-07')
print(d.year)
print(d.month)
print(d.day)

f = Date.today()
print(f.year)
print(f.month)
print(f.day)







