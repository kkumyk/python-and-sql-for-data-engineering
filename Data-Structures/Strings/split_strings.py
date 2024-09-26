'''
- split the string into pairs of two characters
- if the string contains an odd number of characters then it should replace the missing second character of the final pair with an underscore ('_').

* 'abc' =>  ['ab', 'c_']
* 'abcdef' => ['ab', 'cd', 'ef']
'''

'''
def solution(s):
    list_1 = []
    list_2 = []
    
    if len(s) % 2 == 0:
        s_list = list(s)
        for i, v in enumerate(s_list):
            if i % 2 == 0:
                list_1.append(v)
            else:
                list_2.append(v)
                
        return ["".join((a,b)) for a,b in list(zip(list_1, list_2))]
    else:
        s_even = s[:-1]
        end_char = s[-1]+"_"
        even_list = solution(s_even)
        even_list.append(end_char)
        return even_list
    
        # Previous version:
        # s_even = list(s)[:-1]
        # end_char =list(s).pop()+"_"    if len(s) == 0:
        return []
    elif len(s) == 1:
        return [s + "_"]
    else:
        return [s[:2]] + solution(s[2:])

        # # the solution  function expects a string as input =>
        # # convert list to a single string before passing it to the function:
        # even_list = solution("".join(s_even))
        # even_list.append(end_char)
        # return even_list
'''


# def solution(s):
    
#     if len(s) == 0:
#         return []
#     elif len(s) == 1:
#         return [s + "_"]
#     else:
#         return [s[:2]] + solution(s[2:])

# print(solution('abcfs'))





def solution(s):
    s+='_'
    return[s[x:x+2] for x in range(0,len(s)-1,2)]

print(solution('asdfadsf'))
