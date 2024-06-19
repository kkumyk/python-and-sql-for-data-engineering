def square_every_digits(num):
    result = ""
    
    for n in str(num):
        result += str(int(n) **2)
        
    return int(result)


print(square_every_digits(9119))