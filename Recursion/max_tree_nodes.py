class TreeNode:
    def __init__(self, value, left=None, right=None):
        self.left = left
        self.right = right
        self.value = value

def find_max(root): # root is not None
    max_value = root.value # initialise with the root value
    
    # recursively check the left sub-tree
    if root.left != None:
        left_value = find_max(root.left)
        max_value = max(max_value, left_value)
    
    # recursively check the right sub-tree
    if root.right != None:
        right_max = find_max(root.right)
        max_value = max(max_value,right_max)

    return max_value

all_negatives = TreeNode(-5, TreeNode(-4, TreeNode(-6), TreeNode(-2)), TreeNode(-9, TreeNode(-45, None, TreeNode(-1)))) 
print(find_max(all_negatives)) # -1


# class TreeNode:
#     def __init__(self, value, left=None, right=None):
#         self.left = left
#         self.right = right
#         self.value = value
        
# def find_max(root):
#     v = root.value
#     if root.left: v = max(v, find_max(root.left))
#     if root.right: v = max(v, find_max(root.right))
#     return v
    
# tree_with_left = TreeNode(2, TreeNode(1))
# print(find_max(tree_with_left)) # 2