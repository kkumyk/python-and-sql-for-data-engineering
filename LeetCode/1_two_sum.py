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
        return []

nums = [3,3]
target = 6
output = Solution(nums, target)
print(output.twoSum(nums, target))