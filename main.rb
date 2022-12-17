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

    def insert(value, node = @root)
        return if value == node.data 
        if value < node.data
            node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
        else 
            node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
        end 
    end 

    def delete(value, node = @root)
        return node if node.nil?
        if value < node 
            node.left = delete(value, node.left)
        elsif value > node
            node.right = delete(value, node.right)
        else 
            return node.right if node.left.nil?
            return node.left if node.right.nil? 

            left_node = most_left(node.right)
            node.data = left_node.data 
            node.right = delete(left_node.data, node.right)
        end
        node
    end

    def most_left(node)
        node = node.left until node.left.nil?
        node
    end


    def find(value, node = @root)
        return node if node.nil? || node.data == value
        value < node.data ? find(value, node.left) : find(value, node.right)
    end

    def level_order(node = @root, queue = [])
        print "#{node.data} " if !block_given?
        yield(node.data) if block_given?
    
        queue << node.left unless node.left.nil? 
        queue << node.right unless node.right.nil?
        return if queue.empty?
    
        level_order(queue.shift, queue)
    end



    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

end