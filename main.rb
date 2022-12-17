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
    end
end