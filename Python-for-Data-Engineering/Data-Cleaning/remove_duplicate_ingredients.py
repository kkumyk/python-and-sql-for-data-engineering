'''
Task: Identify unique values (ingredients) in the CSV file.
'''

import pandas as pd

# read CSV file into Pandas DataFrame
ingredient_pairings = pd.read_csv('ingredient_pairings.csv')

# flaten the DataFrame into a list of all values
all_ingredients = ingredient_pairings.values.flatten()

# remove duplicates with the set method by converting the list to a set
unique_ingredients = set(all_ingredients)

# convert the set back to a DataFrame
unique_ingredients_df = pd.DataFrame(unique_ingredients, columns=['Unique Ingredients']).sort_values(by=['Unique Ingredients'])

print(unique_ingredients_df.head(5))

unique_ingredients_df.to_csv('unique_ingredients.csv', index=False)

