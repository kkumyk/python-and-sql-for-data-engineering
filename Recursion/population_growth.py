'''
p0 = 1000 - town population at the beginning of a year | positive integer (> 0)
per year:
2% population increase
+50 new inhabitants
How many years does the town need to see its population >= to p = 1200 inhabitants?
It will need 3 entire years: 
1000 + 1000 * 0.02 + 50 => 1070 
1070 + 1070 * 0.02 + 50 => 1141
1141 + 1141 * 0.02 + 50 => 1213

percent - a positive or null floating number
aug - inhabitants coming or leaving each year | an integer
p - population to equal or surpass |  - positive integer (> 0)

Return n number of entire years needed to get a population greater or equal to p:
nb_year(1500, 5, 100, 5000) -> 15
nb_year(1500000, 2.5, 10000, 2000000) -> 10

convert the percent parameter as a percentage in the body of your function:
if the parameter percent is 2 you have to convert it to 0.02.
'''
    
# Solution with Recursion

def nb_years(p0, percent, aug, p, years = 0):
    
    while p0 < p:
        return nb_years((p0 + int(p0 * percent/100) + aug), percent, aug, p, years + 1)
    
    return years

print(nb_years(1500, 5, 100, 5000)) #15


# def nb_years(p0, percent, aug, p):

#     per =  percent/100
#     pop_num = p0
#     years = 0

#     while pop_num < p:
#         years += 1
#         pop_num = int(pop_num + pop_num * per + aug)
    
#     return years