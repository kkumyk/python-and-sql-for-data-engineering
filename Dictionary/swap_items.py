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