
# take in a string and clean out all numeric characters, and return a string with spacing and special characters ~#$%^&!@*():;"'.,?
# https://www.codewars.com/kata/57e1e61ba396b3727c000251

'''
str.join(iterable)
Returns a string made from the elements of an iterable (list, string, dict, tuple).

isdigit()
Return True if all bytes in the sequence are ASCII decimal digits and the sequence is not empty, False otherwise.
ASCII decimal digits are those byte values in the sequence b'0123456789
https://docs.python.org/3/library/stdtypes.html#str.isdigit
'''

def string_clean(s):    
    return ''.join([i for i in s if not i.isdigit()])

def string_clean(s):
     return "".join([char for char in s if char != char.isdigit()])

# \D matches any non-digit character and the same as the class [^0-9]

import re

def string_clean(s):
    return ''.join(re.findall('\D', s))


print(string_clean('This looks5 grea8t!'))
print(string_clean('! !'))
print(string_clean('12345*6789'))
