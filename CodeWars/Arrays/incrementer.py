'''
- return the array with each digit incremented by its position in the array:
- the first digit will be incremented by 1, the second digit by 2, etc.
- make sure to start counting your positions from 1 ( and not 0 ).
- result can only contain single digit numbers
- if adding a digit with its position gives you a multiple-digit number, only the last digit of the number should be returned:
[1, 2, 3]  -->  [2, 4, 6]   #  [1+1, 2+2, 3+3]
[4, 6, 9, 1, 3]  -->  [5, 8, 2, 5, 8]  #  [4+1, 6+2, 9+3 --> 2, 1+4, 3+5]
'''

def increment(int_list):
    result = []

    for val, i in enumerate(int_list, start=1):
        
        result.append(int(str(val+i)[-1] ))
    return result

print(increment([4, 6, 9, 1, 3])) # [5, 8, 2, 5, 8]


'''
Notes:

s1 = "1"
s2 = "12"

print(s[-1]) will return "1" for s1 and "2" for s2 




'''