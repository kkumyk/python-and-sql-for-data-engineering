'''
Sort the given array of strings in alphabetical order, case insensitive. For example:

["Hello", "there", "I'm", "fine"]  -->  ["fine", "Hello", "I'm", "there"]
["C", "d", "a", "B"])              -->  ["a", "B", "C", "d"]

https://docs.python.org/3/library/functions.html#sorted
- the sorted function returns a new sorted list from the items in iterable
- it has two optional arguments which must be specified as keyword arguments
- key specifies a function of one argument that is used to extract a comparison key for each element in iterable
- the key parameter is a function that is applied to each element before comparison with str.lower;
- each element will be temporarily converted to lowercase
- the key function ensures that the comparison is ignoring case
- str.casefold - converts to lower case and returns a new copy of it; will find more matches than lower
- str.casefold is used for caseless matching, e.g.: 'ß'.casefold() returns 'ss'
'''

def sortme(words):
    return sorted(words, key=str.lower)