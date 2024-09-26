'''
There is an array with some numbers. All numbers are equal except for one. Try to find it!
find_uniq([ 1, 1, 1, 2, 1, 1 ]) == 2
find_uniq([ 0, 0, 0.55, 0, 0 ]) == 0.55
It’s guaranteed that array contains at least 3 numbers.
'''

def find_uniq(arr):
    
    sorted_array = sorted(arr)
    count = arr.count(sorted(arr)[::-1][0])
    
    if count == 1:
        return sorted(sorted_array)[::-1][0]
    else:
        return sorted(sorted_array)[::1][0]

print(find_uniq([ 0, 0, 0.55, 0, 0 ]))