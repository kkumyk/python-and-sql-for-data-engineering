'''
https://www.codewars.com/kata/596f72bbe7cd7296d1000029
You are given an array. Complete the function that returns the number of ALL elements
within an array, including any nested arrays.
[]                   -->  0
[1, 2, 3]            -->  3
["x", "y", ["z"]]    -->  4
[1, 2, [3, 4, [5]]]  -->  7
'''

def deep_count(a):
    count = 0
    
    for el in a:
        count += 1
        if isinstance(el, list):
            count += deep_count(el)
        print(count)
    return count

# def deep_count(a):
#   n = 0
  
#   for x in a:
#     n += 1
#     if type(x) == list:
#       n += deep_count(x)
      
#   return n

test_array = [[[[[[[[[]]]]]]]]]
print(deep_count(test_array)) 

        # isinstance(el, str|int):
        #     count += 1
        # elif isinstance(el, list):