'''
https://www.codewars.com/kata/56a946cd7bd95ccab2000055/train/python

"abc" ===> 3
"abcABC123" ===> 3
"abcABC123!@€£#$%^&*()_-+=}{[]|\':;?/>.<,~" ===> 3

str.isalnum() returns True if at least one char in a string alphanumeric
str.islower() returns True if at least one character ina string is lowercase
'''

import re

def lowercase_count(string):
    return len(re.findall('[a-z]', string))


def lowercase_count(string):
    return len(''.join([i for i in string if i.isalnum() and not i.isdigit() and i==i.lower()]))


def lowercase_count(string):
    return sum(i.islower() for i in string)


print(lowercase_count("abcABC123!@€£#$%^&*()_-+=}{[]|\':;?/>.<,~")) 
print(lowercase_count("abcdefghijklmnopqrstuvwxyz"))