'''
Remove duplicate words
https://www.codewars.com/kata/5b39e3772ae7545f650000fc/train/python
- remove all duplicate words from a string, leaving only single (first) words entries
'''

# without regex
def remove_duplicate_words(s):
    uniques = []
    for w in s.split(" "):
        if w not in uniques:
            uniques.append(w)

    return " ".join(uniques)


# with regex
# \w matches any alphanumeric character; equal to [a-zA-Z0-9_]
# \w+ matches 1 or more word character
import re

def remove_duplicate_words(s):
    uniques = []
    for w in re.findall(r'\w+', s):
        if w not in uniques:
            uniques.append(w)

    return " ".join(uniques)


print(remove_duplicate_words('alpha beta beta gamma gamma gamma delta alpha beta beta gamma gamma gamma delta'))
# 'alpha beta gamma delta'


