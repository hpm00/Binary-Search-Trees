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
end