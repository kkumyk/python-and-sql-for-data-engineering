'''
write a function to calculate the sum of the numerical values in a nested list:
sum_nested([1, [2, [3, [4]]]]) -> 10
'''

# def sum_nested(lst):
#     sum = 0
    
#     for el in lst:
#         if isinstance(el, list):
#             sum += sum_nested(el)
#         else:
#             sum += el
#     return sum
        

# print(sum_nested([1, [2, [3, [4]]]]))


'''
- Write a function that takes in an array of integers from 0-9, and returns a new array:
    Numbers with no identical numbers preceding or following it returns a 1: 2, 4, 9  => 1, 1, 1
    Sequential groups of identical numbers return their count: 6, 6, 6, 6 => 4
[0, 4, 6, 8, 8, 8, 5, 5, 7] => [1, 1, 1, 3, 2, 1]
- repeat the process on the resulting array, and on the resulting array of that, until it returns a single integer:
[0, 4, 6, 8, 8, 8, 5, 5, 7] =>  [1, 1, 1, 3, 2, 1] => [3, 1, 1, 1] => [1, 3] => [1, 1] => [2]
When function is reduced the array to a single integer, return that integer, not an array with 1 element: [2] => 2
Rules and assertions
    All test arrays will be 2+ in length
    All integers in the test arrays will be positive numbers from 0 - 9
'''
# [0, 4, 6, 8, 8, 8, 5, 5, 7] =>  [1, 1, 1, 3, 2, 1] => [3, 1, 1, 1] => [1, 3] => [1, 1] => [2]

# def set_reducer(array):
#     res = []
#     ind = 0 # a counter to go over the initial array
    
#     while ind < len(array):
#         counter = 1
        
#         while ind+1 < len(array) and array[ind] == array[ind+1]:
#             counter += 1
#             ind += 1
#         res.append(counter if counter > 1 else 1)
#         ind += 1
#     if len(res) == 1:
#         return res[0]
#     else:
#         return set_reducer(res)
        
# print(set_reducer([0, 4, 6, 8, 8, 8, 5, 5, 7]))


# def set_reducer(array):
#     res = []
#     ind = 0 # a counter to go over the initial array
    
#     while ind < len(array):
#         val_counter = 1 # counter to track how many times the value is repeated
        
#         while ind+1 < len(array) and array[ind] == array[ind+1]:
#             val_counter += 1
#             ind += 1
#         res.append(val_counter if val_counter > 1 else 1)
#         ind += 1
            
#     if len(res) == 1:
#         return res[0]
#     else:
#         return set_reducer(res)

# print(set_reducer([0, 4, 6, 8, 8, 8, 5, 5, 7]))


'''
p0 - population at the beginning of the year
percent - population increase %
aug - the number of people coming or leaving each year
p - goal population to equal or surpass
--------------------------------------------
how many years to reach the goal population?
'''

# def nb_year(p0, percent, aug, p):
#     pop_change = p0
#     years = 0
    
#     while pop_change < p:
#         pop_change = int(pop_change + pop_change * percent/100 + aug)
#         print(pop_change)
#         years += 1
        
#     return years
    
# print(nb_year(1500, 5, 100, 5000))

