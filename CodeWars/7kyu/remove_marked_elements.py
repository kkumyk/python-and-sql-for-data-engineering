
'''
Remove All The Marked Elements of a List

Define a method/function that removes from a given array of integers all the values contained in a second array.
[1, 1, 2, 3, 1, 2, 3, 4], [1, 3] -> [2, 2, 4]

'''
class List(object):
    def remove_(self, integer_list, values_list):
        
        return [i for i in integer_list if i not in values_list]
    
print(List.remove_(object, [1, 1, 2, 3, 1, 2, 3, 4], [1, 3]))


# def remove_marked(integer_list, values_list):
#     result = []
#     for integer in integer_list:
#         if integer not in values_list:
#             result.append(integer)
#     return result

# output = remove_marked([1, 1, 2, 3, 1, 2, 3, 4], [1, 3])
# print(output)