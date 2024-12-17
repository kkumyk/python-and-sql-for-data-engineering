# Write a function to return an order-preserving list containing only the unique elements of the given list.

# Solution 1:
def uniques_order_preserved(lst):
    uniques = []
    for i, el in enumerate(lst):
        if el not in uniques:
            uniques.append(el)
        i+=1
    return uniques

# Solution 2:
'''
To preserve order, a list comprehension is used to check if the 
'''
def uniques_order_preserved2(lst):
    seen = set()
    return [x for x in lst if x not in seen and not seen.add(x)]


print(uniques_order_preserved([5,3,3,26,7,1,3,4,1,1]))
print(uniques_order_preserved2([5,3,3,26,7,1,3,4,1,1]))