
# Given an array of integers, remove the smallest value. Do not mutate the original array/list. 

def remove_smallest(numbers):
    
    a = numbers[:]
    
    if a :
        a.remove(min(a))
    
    return a

print(remove_smallest([3242,33,1,98769869]))