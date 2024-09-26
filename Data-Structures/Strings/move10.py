'''
https://www.codewars.com/kata/57cf50a7eca2603de0000090/train/python
Move every letter in the provided string forward 10 letters through the alphabet.
If it goes past 'z', start again at 'a'.
Input will be a string with length > 0.
'''
import string

def move_ten(st):
    alphabet = string.ascii_lowercase * 2
    
    result = "".join([alphabet[alphabet.index(l) + 10 ] for l in st])
    
    return result


print(move_ten("testcase")) # "docdmkco"
