'''
Given two sentences, construct an array that has the words that appear in one sentence and not the other.

Solution 1
    set()
        - constructor that turns a list into a set
    symmetric_diffrence()
        - set method that returns the set of elements that are in either of the two sets, but not in both
        - returns the difference between the two sets, excluding the common elements

Solution 2
    union of differences: the union | of the two sets gives the symmetric difference
'''

def word_diff_1(sentence1, sentence2):
    set1 = set(sentence1.split()) # ['this', 'is', 'a', 'test']
    set2 = set(sentence2.split())
    return list(set1.symmetric_difference(set2))

def word_diff_2(sentence1, sentence2):
    set1 = set(sentence1.split())
    set2 = set(sentence2.split())
    
    return list((set1 - set2) | (set2 - set1))





print(word_diff_1("this is a test", "this is another test"))  # Output: ['a', 'another']














