'''
https://www.codewars.com/kata/51f41fe7e8f176e70d0002b9

Sort the given array of strings in alphabetical order, case insensitive. For example:

["Hello", "there", "I'm", "fine"]  -->  ["fine", "Hello", "I'm", "there"]
["C", "d", "a", "B"])              -->  ["a", "B", "C", "d"]

https://docs.python.org/3/library/functions.html#sorted

sorted(iterable, /, *, key=None, reverse=False)
- the sorted function returns a new sorted list
- it has two optional arguments which must be specified as keyword arguments
- key specifies a function of one argument that is used to extract a comparison key for each element
- the key parameter is a function that is applied to each element before comparison with str.lower;
- each element will be temporarily converted to lowercase
- the key function ensures that the comparison is ignoring case
'''

def sortme(words):
    return sorted(words, key=str.lower)

'''
- str.casefold converts to lower case and returns a new copy of it;
- it will find more matches than str.lower
- str.casefold is used for caseless matching, e.g.: 'ß'.casefold() returns 'ss'
'''

def sortme(words):
    return sorted(words, key=str.casefold)


# Below is a solution without using using the key argument in the built-in sorted function

def sortme(words):
    
    sorted_array = []
    case_mapping = {}
    
    for i in words:
        if i == i.lower():
            case_mapping[i] = i
        else:
            case_mapping[i.lower()] = i

    for letter in sorted([ i.lower() for i in words]):
        sorted_array.append(case_mapping[letter])
    
    return sorted_array

print(sortme(["C", "d", "a", "B"]))