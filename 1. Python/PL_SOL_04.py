class Node:
    def __init__(self,data):
        self.left = None
        self.right = None
        self.data = data

class Tree:
    def Preorder(self, root):
        if root:
            print(root.data)
            self.Preorder(root.left)
            self.Preorder(root.right)
    def Inorder(self, root):
        if root:
            self.Inorder(root.left)
            print(root.data)
            self.Inorder(root.right)
    def Postorder(self, root):
        if root:
            self.Postorder(root.left)
            self.Postorder(root.right)
            print(root.data)

root = Node(15)
root.left = Node(1)
root.right = Node(37)
root.left.left = Node(61)
root.left.right = Node(26)
root.right.left = Node(59)
root.right.right = Node(48)

tree = Tree()

print('Preorder Traverse')
print(tree.Preorder(root))
print('Inorder Traverse')
print(tree.Inorder(root))
print('Postorder Traverse')
print(tree.Postorder(root))