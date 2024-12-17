import pytest

from word_diff import word_diff_1

def test_basic_test():
    sentence_1 = "this is a test"
    sentence_2 = "this is another test"
    expected = ['a', 'another']
    result = word_diff_1(sentence_1, sentence_2)
    assert sorted(result) == sorted(expected), f"expected {expected}, but got {result}"