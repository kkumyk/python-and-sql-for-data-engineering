'''
given an array of values and an amount of beggars, return an array with the sum of what each beggar brings home,
assuming they all take regular turns, from the first to the last.

2 beggars: [1,2,3,4,5] > result of [9,6], as the first one takes [1,3,5], the second collects [2,4].
3 beggars: [5,7,3] > [1,4], [2,5] and [3].

the length of the array is not necessarily a multiple of n; length can be even shorter,
in which case the last beggars will of course take nothing (0).
'''

def beggars(values, n):
    return [sum(values[i::n]) for i in range(n)]

# def beggars(coins, num_beggars):
#     beggars(coins, num_beggars, 0, [])
    
# def beggars(coins, num_beggars, current_beggar, current_income):
#     if len(coins) == 0:
#         return current_income
    
#     # TODO updated_income = ???
#     # TODO what else?
    
#     return beggars(coins, num_beggars, (current_beggar + 1) % num_beggars, updated_income )
    


values = [1,2,3,4,5]
n = 2
print(beggars(values, n)) # [9,6]