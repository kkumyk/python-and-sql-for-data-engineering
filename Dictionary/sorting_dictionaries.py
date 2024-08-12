# https://www.codewars.com/kata/53da6a7e112bd15cbc000012/train/python

# sort a dictionary by value - largest to smallest

def sort_dict(d):    
    sorted_dic = []

    sorted_values = sorted(d.values())[::-1]

    for v in sorted_values:
        for k in d.keys():
            if d[k] == v:
                sorted_dic.append((k,v))

    return sorted_dic

print(sort_dict({1:2, 2:9, 3:6}))
