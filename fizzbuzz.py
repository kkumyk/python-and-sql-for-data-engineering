
def fizzBuzz(n):
    result = []
    
    for i in range(1, n+1):
        s = ""
        
        if i % 3 == 0:
            s = s + "Fizz"
        if i % 5 ==0:
            s = s + "Buzz"
        if s == "":
            s = s + str(i)
        
        result.append(s)
        
    return result


print(fizzBuzz(15))


# def fizzBuzz(n):
#     result = []
    
#     for i in range(1, n+1):
#         if i % 3 == 0 and i % 5 == 0:
#             result.append("FizzBuzz")
#         elif i % 3 == 0:
#             result.append("Fizz")
#         elif i % 5 == 0:
#             result.append("Buzz")
#         else:
#             result.append(str(i))
    
#     return result

# Further reading: https://www.enjoyalgorithms.com/blog/fizz-buzz-problem


# numbers = [45, 22, 14, 65, 97, 72]

# for i, num in enumerate(numbers):
#     if num % 3 == 0 and num % 5 == 0:
#         numbers[i] = "FizzBuzz"
#     elif num % 3 == 0:
#         numbers[i] = "Fizz"
#     elif num % 5 == 0:
#         numbers[i] = "Buzz"

# for i in range(len(numbers)):
#     if numbers[i] % 3 == 0 and numbers[i] % 5 == 0:
#         numbers[i] = "FizzBuzz"
#     elif numbers[i] % 3 == 0:
#         numbers[i] = "Fizz"
#     elif numbers[i] % 5 == 0:
#         numbers[i] = "Buzz"

# print(numbers)
