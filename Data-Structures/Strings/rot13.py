'''
- replace letters with the 13th letter after it in the Latin alphabet, not spaces, punctuation, numbers, etc.
"EBG13 rknzcyr." -> "ROT13 example."

To solve this problem, use two builtin functions:

- str.translate(table) returns a copy of the string in which each char has been mapped through the given translation table

- str.maketrans(x,y,z) creates a translation map from char to char mappings in diff formats;
two arguments will be provided: a sorted alphabet string and a same string that will be starting with the 13 letter in Latin alphabet;
the args need to be the same length and the res will be a dict where each char in x will be mapped to the char in the same position in y;
'''

def rot13(message):
    alphabet = "".join(sorted("qwertyuioplkjhgfdsazxcvbnm"))
    alphabet_x = alphabet.upper() + alphabet
    alphabet_y = alphabet.upper()[13:] + alphabet.upper()[:13] + alphabet.lower()[13:] + alphabet.lower()[:13]
    
    return message.translate(message.maketrans(alphabet_x, alphabet_y))


print(rot13("EBG13 rknzcyr.")) #  "ROT13 example."