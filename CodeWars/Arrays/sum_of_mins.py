'''
- 2D ( nested ) list ( non-empty list containing positive values) of size m * n
- find the sum of the minimum values in each row.

[ [ 1, 2, 3, 4, 5 ]        #  minimum value of row is 1
, [ 5, 6, 7, 8, 9 ]        #  minimum value of row is 5
, [ 20, 21, 34, 56, 100 ]  #  minimum value of row is 20
]
output: 1 + 5 + 20 = 26
'''

def sum_mins(numbers):
    
    sum = 0
    
    for array in numbers:
        sum += min(array)
    return sum
    

def sum_mins(numbers):
    return sum(map(min, numbers))

print(sum_mins([[ 7,9,8,6,2 ], [6,3,5,4,3], [5,8,7,4,5] ])) #9
