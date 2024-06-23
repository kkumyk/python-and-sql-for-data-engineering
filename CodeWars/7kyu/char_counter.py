'''
- make sure that each character in that word has the exact same number of occurrences
- return true or false
- A = a
'''

def validate_word(word):
    word = word.lower()
    
    # return True if the length of the set is 1
    return len(set(word.count(c) for c in word)) == 1 

print(validate_word("abcabc"))