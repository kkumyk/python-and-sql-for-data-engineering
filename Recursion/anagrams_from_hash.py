# https://www.codewars.com/kata/543e926d38603441590021dd

def get_words(hash_of_letters):
    # combine all elements from the values array into a single string:
    def get_values(dic: dict) -> str:
        array_of_stings = ["".join(v*k) for v,k in dic.items()] # ['aa', 'bc']
        letters = "".join(map(str, array_of_stings)) # aabc
        return letters
    all_letters = get_values(hash_of_letters)
    
    # return all variation of the letter combinations found in all_letters using recursion:
    def rec(string: str) -> list:
        base = 1
        if len(string) <= base:
            return string
        else:
            vars = []
            for var in rec(string[1:]):
                for i in range(len(string)):
                    vars.append(var[:i] + string[0:1] + var[i:])
                    
            return sorted(set(vars))
    
    return rec(all_letters) # ['aabc', 'aacb', 'abac', 'abca', 'acab', 'acba', 'baac', 'baca', 'bcaa', 'caab', 'caba', 'cbaa']


print(get_words({2:["a"], 1:["b", "c"]})) 
