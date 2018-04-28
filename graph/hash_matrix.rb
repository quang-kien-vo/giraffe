class Tester
  def func
    p "hello"
  end
end

x = Hash.new
def one

  Tester.new

end



#x[:"Home Page"] = {:"Login" => one}

class Node
  attr_accessor :name
end

node1 = Node.new
node1.name = "Node 1"
node2 = Node.new
node2.name = "Node 2"

test = "Login Page"
x[node1.name]= {node2.name => one}
p x
p x["Node 1"]["Node 2"]
x["Node 1"]["Node 2"] = true
x["Node 1"]["Node 3"] = true
p x
#p x["Home Page"][none]



class Graph

  attr_accessor :adj_matrix

  def initialize
    @adj_matrix = Hash.new
  end

  def add_edge(node1, node2, function)
    @adj_matrix[node1.name] = {node2.name => function}
  end
end

graph = Graph.new
graph.add_edge(node1, node2, one)

graph.adj_matrix[node1.name][node2.name].func



j = Hash.new
p j["Node 1"]
j["Node 1"] = {}
j["Node 1"]["Node 2"] = true
j["Node 1"]["Node 3"] = true
p j