'''
Define a method that accepts 2 strings as parameters. The method returns the first string sorted by the second.

sort_string("foos", "of")       == "oofs"
sort_string("string", "gnirts") == "gnirts"
sort_string("banana", "abn")    == "aaabnn"

- the second string defines the ordering
- it is possible that in the second string characters repeat
- so you should remove repeating characters, leaving only the first occurrence.
- any character in the first string that does not appear in the second string should be sorted to the end 
of the result in original order.
'''

def sort_string(s, ordering):
    
    result = ""
    
    for o in ordering:
        result += o * s.count(o)
        s = s.replace(o, "")

    return result + s

print(sort_string("bungholio", "aacbuoldiiaoh")) # buoolihng

