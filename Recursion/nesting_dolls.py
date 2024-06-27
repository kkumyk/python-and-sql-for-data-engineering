class Doll:
    def __init__(self, size, smaller_doll=None):
        self.size = size
        self.smaller_doll = smaller_doll  # the next smaller doll inside

    def __call__(self):
        return self.smaller_doll  # return the smaller doll

# creating a nested doll structure
smallest_doll = Doll(1.5)  # the smallest doll has size 1 and no smaller doll inside
middle_doll = Doll(2, smallest_doll)  # a bigger doll with size 2 containing the smallest doll
largest_doll = Doll(3, middle_doll)  # the biggest doll with size 3 containing the middle doll

def smallest_doll_size(doll):
    while doll:
        size = doll.size  # get the size of the current doll
        doll = doll()  # get the next smaller doll inside
    return size

print(smallest_doll_size(largest_doll))  # returns 1.5 as the size of the smallest doll

