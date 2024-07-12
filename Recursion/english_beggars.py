'''
given an array of values and an amount of beggars, return an array with the sum of what each beggar brings home,
assuming they all take regular turns, from the first to the last.

2 beggars: [1,2,3,4,5] > result of [9,6], as the first one takes [1,3,5], the second collects [2,4].
3 beggars: [5,7,3] > [1,4], [2,5] and [3].

the length of the array is not necessarily a multiple of n; length can be even shorter,
in which case the last beggars will of course take nothing (0).
'''

# Iterative approach with list comprehensions

# def beggars(coins, beggars):
    
#     # list to hold the sum for each beggar
#     result = [0] * beggars # [0, 0]
    
#     # distribute coins to each beggar
#     for i in range(len(coins)):
#         result[i % beggars] += coins[i]

#     return result


# def beggars(values, n):
#     return [sum(values[i::n]) for i in range(n)]

'''
Recursive approach with state track of recursive calls
- an additional function is used to keep track of the current beggar and the accumulated income 
- it takes additional parameters than in the original function
'''

def beggars(coins, num_beggars):
    # initial income array with 0 income for each beggar
    income = [0] * num_beggars
    return distribute_coins(coins, num_beggars, 0, income)


def distribute_coins(coins, num_beggars, current_beggar, current_income):
    
    # base case
    if len(coins) == 0:
        return current_income
    
    # update the current beggar's income with the first coin
    current_income[current_beggar] += coins[0]
    
    return distribute_coins(coins[1:], num_beggars, (current_beggar + 1) % num_beggars, current_income)


values = [1,2,3,4,5]
n = 2
print(beggars([1, 2, 3, 4, 5], 2))  # Output: [9, 6]





