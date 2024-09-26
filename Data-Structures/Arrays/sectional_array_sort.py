'''
https://www.codewars.com/kata/58ef87dc4db9b24c6c000092/train/python
sort from a specific position of the array (in ascending order) and optionally you're given the number of items to sort
'''

def sect_sort(array, start, length=0):
    
    '''
    questions:
    what is the sub array in cases when the length is not given or when the length exceeds the length of the input array
    what is the length of the segment to sort
    '''
    if length == 0:
        cut = len(array)
    else:
        cut = min(start+length, len(array)) # min handles the case when length > len of array
        
    sorter_segment = sorted(array[start:cut])
    
    return array[:start] + sorter_segment  + array[cut:]

print(sect_sort( [1, 2, 5, 7, 4, 6, 3, 9, 8], 8, 3 )) # [1, 2, 5, 7, 4, 6, 3, 9, 8]