# https://www.codewars.com/kata/517abf86da9663f1d2000003/

def to_camel_case(text):
    
    words = text.replace("-",".").replace("_",".").split(".")
    caps = [w[0:1].title() + w[1:] for w in words]
    
    res = words[0] + "".join(caps[1:])
    return res 

print(to_camel_case('the_stealth_warrior'))