#  the list [3, 4, 3, 6] , the function should return 10.

# def sum_no_duplicates(l):
#     result = 0
#     for n in l:
#         if l.count(n) == 1:
#             result += n
#     return result


def sum_no_duplicates(l):
    return sum(n for n in set(l) if l.count(n) == 1)

print(sum_no_duplicates([3,4,3,6])) # 10