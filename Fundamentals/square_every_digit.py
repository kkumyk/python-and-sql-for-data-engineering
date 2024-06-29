'''
square every digit of a number and concatenate them:
Input: 9119
Output: 811181
The function accepts an integer and returns an integer.
'''

def square_digits(num):
    return int("".join(str(n) for n in [int(n)**2 for n in str(num)]))

print(square_digits(9119)) # 811181


# def square_every_digits(num):
#     result = ""
#     for n in str(num):
#         result += str(int(n) **2)
#     return int(result)

# print(square_every_digits(9119))