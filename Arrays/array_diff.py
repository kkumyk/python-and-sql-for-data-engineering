# https://www.codewars.com/kata/523f5d21c841566fde000009/

# using list comprehensions to retrieve elements in array a without any elements found in array b and keep the original order 

def array_diff(a,b):
    diff = []
    
    return [el for el in a if el not in b]

print(array_diff([1,2,2,2,3],[2])) # [1,3]
