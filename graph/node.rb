$stack = []

class Node
  attr_accessor :name, :children

  def initialize(name)
    @name = name
    @children = []
    @visited = 0
    #@stack = []
  end

  def mark
    @visited = @visited + 1
  end

  def check_children
    $stack.push(self.name)
    # p 'current stack'
    # p $stack
    if @visited > 0
      p 'reached backedge'
      p $stack
      $stack.pop
      $stack.pop
      return
    end
    if @children.empty?
      p 'reached leaf'
      p $stack
      $stack.pop
      return
    end
    @children.each do |child|
      child.check_children
    end
    mark
  end

  def add_child(node)
    @children.push(node)
  end
end


node1 = Node.new('node1')
node2 = Node.new('node2')
node3 = Node.new('node3')
node4 = Node.new('node4')
node5 = Node.new('node5')
node6 = Node.new('node6')
node7 = Node.new('node7')


node1.add_child(node2)
node1.add_child(node3)
node2.add_child(node4)
node2.add_child(node7)
node3.add_child(node5)
node5.add_child(node6)



node1.check_children