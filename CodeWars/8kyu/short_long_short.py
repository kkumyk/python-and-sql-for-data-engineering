# Expected result: ("1", "22") --> "1221"

def solution(a, b):
    
    if len(a) < len(b):
        return a + b + a
    else:
        return b + a + b

print(solution("A", "BB"))