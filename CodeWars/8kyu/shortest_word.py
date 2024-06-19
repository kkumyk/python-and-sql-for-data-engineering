# Given a string of words, return the length of the shortest word(s).
# String will never be empty and you do not need to account for different data types.

def shortest_word(string):
    return min(len(w) for w in string.split())

print(shortest_word("abracadabra is a real word"))