class Node
  attr_accessor :value, :children, :name

  def initialize(options={})
    @value = options[:value]
    @name = options[:name]
    @children = []
  end

  def add_child(node)
    @children.push(node)
  end
end

root = Node.new({:value => 1, :name => 'root'})
child_1 = Node.new({:value => 2, :name => 'child_1'})
child_2 = Node.new({:value => 3, :name => 'child_2'})
grand_child_2 = Node.new({:value => 6, :name => 'grand_child_2'})
grand_child_1 = Node.new({:value => 4, :name => 'grand_child_1'})
grand_grand_child_1 = Node.new({:value => 5, :name => 'grand_grand_child_1'})

root.add_child(child_1)
root.add_child(child_2)
child_1.add_child(grand_child_2)
child_1.add_child(grand_child_1)
grand_child_1.add_child(grand_grand_child_1)

#
#           (1)
#          /   \
#        (2)  (3)
#       /  \
#     (6) (4)
#           \
#          (5)
#

def bfs(node)
  queue = []
  queue.push(node)

  while(queue.size != 0)
    n = queue.shift
    puts n.value
    n.children.each do |child|
      queue.push(child)
    end
  end
end

bfs(root)

puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~'

def dfs(node)
  puts node.value
  node.children.each do |child|
    dfs(child)
  end
end

dfs(root)