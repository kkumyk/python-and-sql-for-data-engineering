'''
https://www.codewars.com/kata/52efefcbcdf57161d4000091/train/python

- count all the occurring characters in a string
- if you have a string like aba, then the result should be {'a': 2, 'b': 1}
- if the string is empty, the result should be empty object literal, {}.
'''

def count(s):
    map = {}
    
    if len(s) == 0:
        return {}
    
    for char in s:
        if char not in map:
            map[char] = 1
        else:
            map[char] += 1

    return map

'''
The solution below uses a dictionary comprehension to count how ofter a character appears in the string s.
This is a compact way to create dictionaries in Python.
Using s.count(i) can be inefficient for large strings.
A more efficient way to create counter is to use collections.Counter.

'''
def count(s):
    return {i:s.count(i) for i in s}

from collections import Counter

def count(s):
    return dict(Counter(s))

print(count('aabb'))


