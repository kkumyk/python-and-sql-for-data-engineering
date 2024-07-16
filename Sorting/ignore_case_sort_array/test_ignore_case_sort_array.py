import unittest
from ignore_case_sort_array import sortme


class TestSortMe(unittest.TestCase):
    
    def test_sortme(self):
        self.assertAlmostEqual(sortme(["Hello", "there", "I'm", "fine"]), ["fine", "Hello", "I'm", "there"])
        self.assertAlmostEqual(sortme(["C", "d", "a", "B"]), ["a", "B", "C", "d"])
        self.assertAlmostEqual(sortme(["CodeWars"]), ["CodeWars"])
        self.assertAlmostEqual(sortme([]), [])
        self.assertAlmostEqual(sortme(['New', 'by', 'A', 'Right', 'give', 'last', 'That', 'group', 'Be', 'try', 'Do']), 
                                      ['A', 'Be', 'by', 'Do', 'give', 'group', 'last', 'New', 'Right', 'That', 'try'])


if __name__ == '__main__':
    unittest.main