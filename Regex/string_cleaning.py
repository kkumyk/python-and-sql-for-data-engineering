
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


'''
Raw String Literal
- "r" is used as a prefix to indicate that the given string is a raw string literal in Python;
- with the "r" prefix Python will treat backslashes "\" as a literal character and not as escape character;
- without using "r", you will need double backslashes for the "\d" (so "\\d" instead of "\d") to be interpreted correctly;

\d
- matches any Unicode decimal digit including [0-9]
- opposite of \D which matches any character which is not a decimal digit;

re.sub(pattern, replacement*, string)
- * pattern can be a string of a function
- returns the string by replacing the left most occurrences of pattern in string by the provided replacement;

The function below searches the provided string for all occurrences of digits and replaces them with an empty string;
'''

def string_clean(s):
    return re.sub(r'\d','',s)


print(string_clean('This looks5 grea8t!'))
print(string_clean('! !'))
print(string_clean('12345*6789'))
