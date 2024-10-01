'''
LISTS

Write a one-liner function to return a list containing only the unique elements of the given list. Order doesn't matter.

To write one-liner an anonymous function - a function that does not require a name - will be used. In Python, an anonymous function will be created using a lambda keyword.
A lambda function can have any number of arguments but only one expression: {lambda arguments: expression}.

'''

unique_elements = lambda lst: list(set(lst))

print(unique_elements([1, 2, 2, 3, 4, 4, 5]))  # [1, 2, 3, 4, 5] 

