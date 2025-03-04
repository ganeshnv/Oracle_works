#!/usr/bin/env python3
'''
import simple

print(simple.x)
print(simple.spam())
print(simple.call())
'''

'''
from simple import call

call()
'''
'''
## modules stored on sys modules cache
import simple
import sys
sys.modules['simple']

## To find the default module directory
sys.path
## To update the module directory for my custom module
sys.path.append('/User/gavadive/')
## To temporarly set the path environment
#env PYTHONPATH=/User/gavadive python

## To delete modules from cache

del sys.modules['simple']
'''






