'''
Problem Requirements:
- function accepts linked lists
- the linked list nodes have a "data" property: Node(1, Node(2, Node(3)))
- each node points to the next node using the "next" property
- the output string should represent a list in a specific format, ending with None. 

Edge Cases:
- list could be empty
- function should work for lists with a single node

IN:  Node(1, Node(2, Node(3)))
OUT: "1 -> 2 -> 3 -> None"
'''

class Node():
    def __init__(self, data, next_node=None):
        self.data = data
        self.next = next_node

def stringify(node):
    result = []
    current = node
    while current:
        result.append(str(current.data))
        result.append(" -> ")
        current = current.next # move to the next node in the sequence
    result.append("None")
    return "".join(result)

test_list1 = Node(1, Node(2, Node(3)))
empty_list = None
single_element_list = Node(1)

print(stringify(empty_list)) # "None"
print(stringify(single_element_list)) # "1 -> None"
print(stringify(test_list1)) # Output: "1 -> 2 -> 3 -> None"