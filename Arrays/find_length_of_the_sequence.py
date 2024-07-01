'''
- find the length of the sub-array that begins and ends with the specified number
[0, -3, 7, 4, 0, 3, 7, 9], finding the length of the sub-array that begins and ends with 7s would return 5.

- there will only be numbers (positive or negative) in the supplied array
If there are less or more than two occurrences of the number to search for, return 0.
'''

def length_of_sequence(arr,n):
    res = []
    occ = arr.count(n)
    
    if occ == 2:    
        for inx, num in enumerate(arr):
            if num == n:
                res.append(inx)
        return len(arr[res[0]:res[1]+1])
    else:
        return 0
    

print(length_of_sequence([0, -3, 7, 4, 0, 3, 7, 9], 7)) # 5 for n=7