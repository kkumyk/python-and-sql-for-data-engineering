'''
Complete the method which accepts an array of integers, and returns one of the following:
    "yes, ascending" - if the numbers in the array are sorted in an ascending order
    "yes, descending" - if the numbers in the array are sorted in a descending order
    "no" - otherwise
'''

def is_sorted_and_how(arr):
    
    res = ""
    if arr == sorted(arr):
        res += 'yes, ascending'
    elif arr == sorted(arr)[::-1]:
        res += 'yes, descending'
    else:
        res += 'no'
    
    return res

print(is_sorted_and_how([15, 7, 3, -8])) # 'yes, descending'