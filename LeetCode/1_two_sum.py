class Solution(object):
    
    def __init__(self, nums, target):
        self.nums = nums
        self.target = target
    
    def twoSum(self, nums, target):
        valIndMap = {}
        
        for i, num in enumerate(nums):
            diff = target - num
            
            if diff in valIndMap:
                return [valIndMap[diff], i]
            
            valIndMap[num] = i
        return # since we know that the solution exists we don't need to return anything

nums = [3,3]
target = 6
output = Solution(nums, target)
print(output.twoSum(nums, target))


'''
Task:
- given an array of integers and a target,return indices of the two numbers such that they add up to a specific target:
- |2|1|5|3| and target=4
- expected output: [1,3]

I. A Brute Force Approach

- the most intuitive way to solve the problem is to check every combination and see if they sum up to the target
- we start at 2 and check every combination and scam through the remainder of the array and check if any of these numbers added to two sum up to the target 4
- in this case none of them do;  
- next, we need to repeat this process starting the 1 and we find that 1 + 3 sums up to the target 4
- NOTICE that we did not have to check the 2 that came before 1 because we have already checked the combination 2 + 1 in the first iteration!
- so we only have to check numbers that came after 1
- the runtime of the above algorithm is not super efficient; worst case time complexity will be O(n2)

II. Hash Map Approach - iterate the array in one pass

- make a hash map for every value in our input array so that we instantly check if the value 3 exists
- in the hash map we will be mapping each values ot the index of each value: {value:index}
- |0|1|2|3|
- |2|1|5|3|

- we start with the empty hash map and we want to look for the difference between the target and each integers
- first: 4-2=2 and as our hashmap is empty we don't find the difference result of 2 in it
- after we have done visiting the element 2, we can add it to the hashmap and move to the next element
    HASH MAP
    |v|i|
    -----
    |2|0|
    
- when checking 1 we see that 4-1 is 3 and it is not in the hashmap and as we don't find the 3 in our hashmap, we add it {1:1}
    HASH MAP
    |v|i|
    -----
    |2|0|
    |1|1|

- we move to the next element 5 and see that 4-5=-1 which does not exist in our hashmap and we add it to it {5:2}
    HASH MAP
    |v|i|
    -----
    |2|0|
    |1|1|
    |5|2|
    
- we check the last value and see that 4-3=1
- we NOTICE that the value of 1 does already exist in our array and its index is 1
- now that we found the two values that doe sum up to the target we need to return their indices which are [1,3]

| Time Complexity | Memory Complexity |
---------------------------------------
| O(n)            | O(n)              |
---------------------------------------

Since the solution is found in one pass, we don't need to worry about the edge cases and comparisons.

'''