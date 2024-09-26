'''
https://www.codewars.com/kata/5a21e090f28b824def00013c/python
You will be given a dictionary, and then you will want to return a dictionary with the old values as the keys,
and list the old keys as values under their original keys.

Input: {'Ice': 'Cream', 'Age': '21', 'Light': 'Cream', 'Double': 'Cream'}
Output: {'Cream': ['Ice', 'Double', 'Light'], '21': ['Age']}
'''

def switch_dict(dic):
        updated_dic = {}
        
        for k, v in dic.items():
            if v in updated_dic:
                updated_dic[v].append(k)
            else:
                updated_dic[v] = [k]


        return updated_dic

print(switch_dict({'Ice': 'Cream', 'Age': '21', 'Light': 'Cream', 'Double': 'Cream'}))



'''
setdefault(key, default=None)
    If key is in the dictionary, return its value. If not, insert key with a value of default and return default.
    default defaults to None.
    https://docs.python.org/3/library/stdtypes.html
'''

def switch_dict(dic):
    result = {}
    for key, value in dic.items():
        result.setdefault(value, []).append(key)
    return result