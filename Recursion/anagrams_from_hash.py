def get_words(hash_of_letters):
    
    def get_values(dic):
        array_of_stings = ["".join(v*k) for v,k in dic.items()]
        letters = "".join(map(str, array_of_stings))
        return letters

    all_letters = get_values(hash_of_letters)
    
    def rec(string):
        base = 1
        if len(string) <= base:
            return string
        else:
            vars = []
            for var in rec(string[1:]):
                for i in range(len(string)):
                    vars.append(var[:i] + string[0:1] + var[i:])
            return sorted(set(vars))
    
    return rec(all_letters)
    

print(get_words({2:["a"], 1:["b", "c"]}))