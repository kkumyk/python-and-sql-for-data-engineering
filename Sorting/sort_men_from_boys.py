'''
Given an array/list [] of n integers , Separate The even numbers from the odds , or Separate the men from the boys
- Men are the Even numbers
- Boys are the odd
'''

def men_from_boys(arr):

    evens = sorted([n for n in arr if n%2 == 0])

    odds = sorted([n for n in arr if n%2 != 0])[::-1]

    return evens + odds




print(men_from_boys([2,43,95,90,37])) # [2,90,95,43,37]: even numbers first , then the odds in descending order