
# take in a string and clean out all numeric characters, and return a string with spacing and special characters ~#$%^&!@*():;"'.,?
import re

def string_clean(s):
    import re
    return ''.join(re.findall('\D',s))


'''
Return True if all bytes in the sequence are ASCII decimal digits and the sequence is not empty, False otherwise.
ASCII decimal digits are those byte values in the sequence b'0123456789
https://docs.python.org/3/library/stdtypes.html#str.isdigit
'''

def string_clean(s):    
    return ''.join([i for i in s if not i.isdigit()])


