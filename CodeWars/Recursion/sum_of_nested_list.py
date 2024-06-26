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

def sum_nested(lst):
    return sum(sum_nested(el) if isinstance(el, list) else el for el in lst)

print(sum_nested([1, [2, [3, [4]]]]))