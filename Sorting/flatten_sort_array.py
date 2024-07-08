'''
Given a two-dimensional array of integers, return the flattened version of the array with all the integers in the sorted (ascending) order.

[[3, 2, 1], [4, 6, 5], [], [9, 7, 8]] >> [1, 2, 3, 4, 5, 6, 7, 8, 9].
'''

def flatten_and_sort(array):
    
    res = []
    
    for sub in array:
        for el in sub:
            res.append(el)
    
    return sorted(res)


print(flatten_and_sort([[3, 2, 1], [4, 6, 5], [], [9, 7, 8]]))