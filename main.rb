class Node 
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data 
    @left = left
    @right = right 
  end 
  
end 

class Tree
    attr_accessor :root

    def initialize(array)
        @root = build_tree(array)
    end 

    # sorts array & removes duplicates; transforms array > balanced binary search tree (bst) 
    def build_tree(array)
        return if array.empty?
        return Node.new(array[0]) if array.length <= 1

        sorted = array.sort.uniq
        mid = sorted.length / 2

        root = Node.new(sorted[mid])
        root.left = build_tree(sorted[0...mid])
        root.right = build_tree(sorted[mid + 1..-1])

        root
    end

    # returns nil if value exists in bst; otherwise, inserts value into bst
    def insert(value, node = @root)
        return if value == node.data 
        if value < node.data
            node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
        else 
            node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
        end 
    end 

    # deletes node if in bst
    # consider three cases: node has no children, 1 child, or 2 children
    def delete(value, node = @root)
        return node if node.nil?
        if value < node 
            node.left = delete(value, node.left)
        elsif value > node
            node.right = delete(value, node.right)
        else 
            # node has no child or 1 
            return node.right if node.left.nil?
            return node.left if node.right.nil? 
            # node has two children
            left_node = most_left(node.right)
            node.data = left_node.data 
            node.right = delete(left_node.data, node.right)
        end
        node
    end

    # method used in delete() above
    def most_left(node)
        node = node.left until node.left.nil?
        node
    end

    # returns the node with the given value, returns nil if node is not found
    def find(value, node = @root)
        return node if node.nil? || node.data == value
        value < node.data ? find(value, node.left) : find(value, node.right)
    end

    # prints an array of values traversing the tree breadth-first
    def level_order(node = @root, queue = [])
        print "#{node.data} " if !block_given?
        yield(node.data) if block_given? # ?
    
        queue << node.left unless node.left.nil? 
        queue << node.right unless node.right.nil?
        return if queue.empty?
    
        level_order(queue.shift, queue)
    end

    # depth-first order
    def inorder(node = @root , output = [])
        return if node.nil?
    
        inorder(node.left, output)
        output.push(node.data)
        inorder(node.right, output)

        output
    end 

    # depth-first order
    def preorder(node = @root)
        return if node.nil?
    
        print "#{node.data} " if !block_given?
    
        preorder(node.left)
        preorder(node.right)
    end 

    # depth-first order
    def postorder(node = @root)
        return if node.nil?
    
        postorder(node.left)
        postorder(node.right)
    
        print "#{node.data} " if !block_given? 
    end 

    # height: number of edges from a node to the lowest leaf in its subtree
    # accepts a node and returns its height
    def height(node = @root, counter = 0)
        return counter if node.nil?
        counter += 1 unless node.left.nil? && node.right.nil?
        [height(node.left, counter), height(node.right, counter)].max
    end

    # depth: number of edges from the root to the given node
    # accepts a node and returns its depth
    def depth(target, node = @root, counter = 0)
        return counter if node.nil? || node.data == target
        counter += 1
        if target < node.data
          depth(target, node.left, counter)
        else 
          depth(target, node.right, counter)
        end
    end

    # checks if tree is balanced
    # balanced tree: delta(height(left subtree) - height(right subtree)) = 0, +/- 1
    def balanced?
        (height(@root.left) - height(@root.right)).between?(-1, 1)
    end 

    #balances an unbalanced tree
    def rebalance
        nodes = inorder
        @root = build_tree(nodes)
    end

    # visualization of bst (method provided by theOdinProject lesson)
    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

end

# driver script (check methods)
array = (Array.new(15) { rand(1..100) })
tree = Tree.new(array)

#Confirm that the tree is balanced by calling #balanced?
#Print out all elements in level, pre, post, and in order
#Unbalance the tree by adding several numbers > 100
#Confirm that the tree is unbalanced by calling #balanced?
#Balance the tree by calling #rebalance
#Confirm that the tree is balanced by calling #balanced?
#Print out all elements in level, pre, post, and in order