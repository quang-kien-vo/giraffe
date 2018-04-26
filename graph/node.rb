class Node
  attr_accessor :value, :children, :name, :visited

  def initialize(options={})
    @value = options[:value]
    @name = options[:name]
    @children = []
    @visited = false
  end

  def add_child(node)
    @children.push(node)
  end

  def mark
    @visited = true
  end
end

root = Node.new({:value => 1, :name => 'root'})
child_1 = Node.new({:value => 2, :name => 'child_1'})
child_2 = Node.new({:value => 3, :name => 'child_2'})
child_3 = Node.new({:value => 4, :name => 'child_3'})
grand_child_1 = Node.new({:value => 5, :name => 'grand_child_1'})
grand_child_2 = Node.new({:value => 6, :name => 'grand_child_2'})
grand_grand_child_1 = Node.new({:value => 7, :name => 'grand_grand_child_1'})

root.add_child(child_1)
root.add_child(child_2)
root.add_child(child_3)
child_1.add_child(grand_child_1)
child_1.add_child(grand_child_2)
grand_child_2.add_child(grand_grand_child_1)
grand_child_2.add_child(root)
#
#           (1)
#          / | \
#        (2)(3)(4)
#       /  \
#     (5) (6)
#           \
#          (7)
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

# bfs(root)

puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~'


# version ignores back edges
def dfs(node)
  puts node.value
  node.children.each do |child|
    node.mark
    # p child.value if child.visited == true
    dfs(child) if child.visited == false
  end
end

dfs(root)