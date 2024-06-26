'''
- Write a function that takes in an array of integers from 0-9, and returns a new array:
    Numbers with no identical numbers preceding or following it returns a 1: 2, 4, 9  => 1, 1, 1
    Sequential groups of identical numbers return their count: 6, 6, 6, 6 => 4
    
[0, 4, 6, 8, 8, 8, 5, 5, 7] => [1, 1, 1, 3, 2, 1]
- repeat the process on the resulting array, and on the resulting array of that, until it returns a single integer:
[0, 4, 6, 8, 8, 8, 5, 5, 7] =>  [1, 1, 1, 3, 2, 1] => [3, 1, 1, 1] => [1, 3] => [1, 1] => [2]
When function is reduced the array to a single integer, return that integer, not an array with 1 element: [2] => 2
Rules and assertions
    All test arrays will be 2+ in length
    All integers in the test arrays will be positive numbers from 0 - 9
'''

def set_reducer(numbers):
    res = [] # will be used to store the counts of consecutive equal elements in the initial numbers array
    # a counter to use to go over the initial numbers array
    # it will be used in the while loop to iterate over each element in the initial array as long as the idx_counter < than len(numbers)
    idx = 0
    while idx < len(numbers): # MAIN LOOP
        val_counter = 1 # tracks how many times the current element is repeated consecutively
        
        # INNER LOOP TO COUNT ELEMENTS
        # check if the adjusted index still less than len(numbers) and the current element is equal to the next one
        while idx + 1 < len(numbers) and numbers[idx] == numbers[idx+1]: # will continue to run UNTIL the consecutive elements are the same
            val_counter += 1 # if so, increase the val_counter by 1
            idx += 1 # move index by 1 to get to the next element in the initial array
        res.append(val_counter if val_counter > 1 else 1) # after in inner while loop reached the unequal element it stops running; append the val_result to res
        idx += 1 # move to the next new element in the initial array
    if len(res) == 1: # base case check
        return res[0]
    else:
        return set_reducer(res) # the recursive call continues reducing the list until result has only one element, which is then returned;

print(set_reducer([0, 4, 6, 8, 8, 8, 5, 5, 7])) # 2


## Turtle representation drawing of the set_reducer function

# import turtle

# def draw_box(t, x, y, text):
#     t.penup()
#     t.goto(x, y)
#     t.pendown()
#     t.forward(60)
#     t.right(90)
#     t.forward(40)
#     t.right(90)
#     t.forward(60)
#     t.right(90)
#     t.forward(40)
#     t.right(90)
#     t.penup()
#     t.goto(x + 30, y - 20)
#     t.write(text, align="center", font=("Arial", 12, "normal"))
#     t.goto(x, y)

# def draw_arrow(t, start_x, start_y, end_x, end_y):
#     t.penup()
#     t.goto(start_x, start_y)
#     t.pendown()
#     t.goto(end_x, end_y)
#     t.penup()

# def draw_set_reducer_turtle():
#     # Set up the screen
#     screen = turtle.Screen()
#     screen.title("Set Reducer Function Visualization")
    
#     # Set up the turtle
#     t = turtle.Turtle()
#     t.speed(1)
    
#     # Initial input list
#     initial_list = [3, 3, 2, 2, 2, 1]
#     steps = [
#         (initial_list, [2, 3, 1]),
#         ([2, 3, 1], [1, 1, 1]),
#         ([1, 1, 1], [3]),
#     ]
    
#     y_positions = [200, 100, 0]
#     x_start = -200
    
#     # Draw the initial input list
#     t.penup()
#     t.goto(x_start + 150, 250)
#     t.write('Initial List: ' + str(initial_list), align="center", font=("Arial", 16, "normal"))
    
#     for (inp, result), y in zip(steps, y_positions):
#         x = x_start
        
#         for val in inp:
#             draw_box(t, x, y, str(val))
#             x += 70
        
#         arrow_start_x = x
#         arrow_start_y = y - 20
#         arrow_end_x = x + 50
#         arrow_end_y = y - 20
#         draw_arrow(t, arrow_start_x, arrow_start_y, arrow_end_x, arrow_end_y)
        
#         x = arrow_end_x + 20
#         for val in result:
#             draw_box(t, x, y, str(val))
#             x += 70
    
#     # Draw final result
#     final_result = 3
#     t.penup()
#     t.goto(x_start + 350, -100)
#     t.write('Final Result: ' + str(final_result), align="center", font=("Arial", 16, "normal"))
    
#     # Hide the turtle and display the result
#     t.hideturtle()
#     turtle.done()

# draw_set_reducer_turtle()
