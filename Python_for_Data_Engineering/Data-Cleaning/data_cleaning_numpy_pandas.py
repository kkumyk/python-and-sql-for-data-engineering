import numpy as np
import pandas as pd

# Dropping Columns in a DataFrame
df = pd.read_csv('datasets/books.csv')

print(df.head())



'''
Pandas - PANel DAta - Features:
    - powerful data structure
    - fast/efficient data wrangling
    - easy data aggregation and transformation
    - tools for reading and writing data
    - intelligent and automated data alignment
    - high performance merging and joining of data sets

Pandas Data Structures:
    - Series:
        - one-dimensional labeled array
        - supports multiple data types
    - Data Frame:
        - two-dimensional labeled array
        - supports multiple data types
        - input can be a series
        - input can be another data frame
    - Panel:
        - three-dimensional labeled array
        - supports multiple data types
        - items axis -> 0
        - major axis -> rows
        - minor axis -> columns
'''

'''
Pandas Series
    - very similar to NumPy array
    - difference: a Series can have axis labels >> it can be indexed by a label instead just a number location
    - create a Series with pd.Series() function
    - can be created from list, numpy array or a dictionary
'''

# creating a pandas series from a list

my_list = [10, 20, 30]
series = pd.Series(my_list)

# 0    10
# 1    20
# 2    30

# creating a series from numPy Array
index = ['a', 'b', 'c']
arr = np.array([1,2,3])
series = pd.Series(data=arr, index=index)

# a    1
# b    2
# c    3

# creating a series from dictionary
d = {'a':10, 'b':20, 'c':30}
pd.Series(d)
# a    10
# b    20
# c    30
print(series)
print(series.index)
print(series.values)


'''
Using Index in a Series

- Pandas use custom index names and numbers of a Series as fast lookups (similar to hashmaps/dictionaries)
'''
ser1 = pd.Series([1,2,3,4], index=['USA', 'Germany','USSR', 'Japan']) 
ser2 = pd.Series([1,2,5,4], index=['USA', 'Germany','Italy', 'Japan'])  

# print(ser1)
# USA        1
# Germany    2
# USSR       3
# Japan      4
# dtype: int64

# print(ser2)
# USA        1
# Germany    2
# Italy      5
# Japan      4
# dtype: int64

# print(ser1 + ser2)
# Germany    4.0
# Italy      NaN
# Japan      8.0
# USA        2.0
# USSR       NaN
# dtype: float64


'''
Sources:
https://github.com/darshilparmar/python-for-data-engineering/blob/main/4.%20Python%20Advance/Pandas%20Basics.ipynb
https://pandas.pydata.org/pandas-docs/stable/user_guide/dsintro.html
https://realpython.com/python-data-cleaning-numpy-pandas/
https://github.com/darshilparmar/python-for-data-engineering/blob/main/3.%20Python%20Intermediate/Intermediate%20-%20Functions%20and%20OOPS.ipynb
'''


