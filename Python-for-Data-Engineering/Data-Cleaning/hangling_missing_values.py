import pandas as pd

# Use mean and median for missing values 

data = {'Name': ['John', 'Anna', 'Mike', None],
        'Age': [28, None, 32, 40],
        'Salary': [50000, 60000, None, 45000]}
df = pd.DataFrame(data)

# Task: Handle missing values by filling NaN values in 'Age' with the mean and 'Salary' with the median

df['Age'].fillna(df['Age'].mean(), inplace=True)
df['Salary'].fillna(df['Salary'].median(), inplace=True)
df.dropna(subset=['Name'], inplace=True)  # Drop rows where 'Name' is missing

print(df)






'''
Sources:
https://realpython.com/python-data-cleaning-numpy-pandas/
https://www.datacamp.com/tutorial/guide-to-data-cleaning-in-python
https://www.kdnuggets.com/2023/04/exploring-data-cleaning-techniques-python.html
https://medium.com/@dossieranalysis/python-for-data-cleaning-best-practices-and-efficient-techniques-3072ed3935af
https://dataheadhunters.com/academy/scripting-for-data-cleaning-using-python-and-r-for-efficient-cleaning/
https://dataheadhunters.com/academy/scripting-for-data-cleaning-using-python-and-r-for-efficient-cleaning/
https://medium.com/@LearnPythonProgramming/data-cleaning-techniques-with-python-2debc7c0eb10
https://towardsdatascience.com/how-to-clean-your-data-in-python-8f178638b98d
https://www.w3schools.com/python/pandas/pandas_cleaning_empty_cells.asp
'''