'''
https://www.codewars.com/kata/582887f7d04efdaae3000090/
'''

def find_senior(lst):
    seniors = []
    
    # the the ages available
    ages_array = sorted([dev["age"] for dev in lst])
    
    # go over the original array and return object containing the age key == ages_array[-1]
    for dev in lst:
        if dev["age"] == ages_array[-1]:
            seniors.append(dev)    
    
    return seniors


def find_senior(lst):
    
    max_age = max(dev["age"] for dev in lst)
    return [dev for dev in lst if dev["age"] == max_age]


print(find_senior([
  { 'firstName': 'Gabriel', 'lastName': 'X.', 'country': 'Monaco', 'continent': 'Europe', 'age': 49, 'language': 'PHP' },
  { 'firstName': 'Odval', 'lastName': 'F.', 'country': 'Mongolia', 'continent': 'Asia', 'age': 38, 'language': 'Python' },
  { 'firstName': 'Emilija', 'lastName': 'S.', 'country': 'Lithuania', 'continent': 'Europe', 'age': 19, 'language': 'Python' },
  { 'firstName': 'Sou', 'lastName': 'B.', 'country': 'Japan', 'continent': 'Asia', 'age': 49, 'language': 'PHP' },
]))