import unittest
from reverse_list import reverse_list

'''
https://docs.python.org/3/library/unittest.html#test-cases
to run the test:
python -m unittest test_reverse_list.py

'''

class TestReverseList(unittest.TestCase):
    
    def test_reverse_list(self):
        self.assertEqual(reverse_list([4,3,2]),[2, 3, 4])
        self.assertEqual(reverse_list([]),[])
        self.assertEqual(reverse_list([2,4,5,6]),[6,5,4,2])
        
        
        
if __name__ == '__main__':
    unittest.main()