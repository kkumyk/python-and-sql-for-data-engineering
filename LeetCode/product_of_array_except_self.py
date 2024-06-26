
class Solution(object):
    
    def productExceptSelf(self, nums):
        
        res = [1] * (len(nums)) # [1, 1, 1, 1]
        
        prefix = 1
        for i in range(len(nums)):
            res[i] = prefix
            prefix *= nums[i] # [1, 1, 2, 6]
        postfix = 1
        for i in range(len(nums) -1, -1, -1):
            res[i] *= postfix
            postfix *= nums[i]
        return res # [24, 12, 8, 6]


print(Solution.productExceptSelf(object, [1,2,3,4]))