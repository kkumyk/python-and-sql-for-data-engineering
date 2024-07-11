'''
https://www.codewars.com/kata/58ef87dc4db9b24c6c000092/train/python
sort from a specific position of the array (in ascending order) and optionally you're given the number of items to sort
'''

def sect_sort(array, start, length=0):
    
    cut = start + length if length else len(array)
    
    

print(sect_sort( [1, 2, 5, 7, 4, 6, 3, 9, 8], 8, 3 )) #   [1, 2, 5, 7, 4, 6, 3, 9, 8]