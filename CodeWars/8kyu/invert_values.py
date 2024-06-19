# expected result:
# [1, 2, 3, 4, 5] --> [-1, -2, -3, -4, -5]
# [1, -2, 3, -4, 5] --> [-1, 2, -3, 4, -5]
# [] --> []

# def invert_values(l):
#     result = []
#     for el in l:
#         result.append(-el)
#     return result


def invert_values(l):
    return [-el for el in l]

print(invert_values([1, 2, 3, -4, 5, -7]))