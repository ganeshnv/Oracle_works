#!/us/bin/env python3

class parent(object):
    def __init__(self, value):
        self.value = value

    def spam(self):
        print('parent.spam', self.value)

    def grok(self):
        print('parent.grok')
        self.spam()



d = parent(42)

#print(d.value)

print(d.spam())

#print(d.grok())

class child1(parent):
    def yow(self):
        print('printing')

    def spam(self):
        print('child_spam', self.value)

c = child1(42)
print(c.value)
print(c.spam())
