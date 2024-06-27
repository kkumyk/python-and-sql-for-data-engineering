
# def find_average(l):
#     if len(l) > 0:
#         return sum(l)/len(l)
#     return 0


def find_average(l):
    return sum(l)/len(l) if l else 0

print(find_average([1,1,5]))