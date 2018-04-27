require 'set'

class Graph
  attr_accessor :graph

  def initialize
    @graph = Hash.new {|hash, key| hash[key] = []}
  end

  def add_edge(source, destination)
    @graph[source] << destination
    @graph[destination] << source
  end


  def find_paths(source, destination, result, &bl)
    result = result+[source] # !! copy and add a

    #p result
    bl.call(result) if source == destination
    @graph[source].each do |v|
      find_paths(v, destination, result, &bl) if !result.include?(v)
    end
  end

  def print_all_nodes
    @graph.keys
  end

end

#
#           (a)
#          / | \
#        (b)(c)(d)
#       /  \
#     (e) (f)
#           \
#          (g)
#

g2 = Graph.new
g2.add_edge('a', 'b')
g2.add_edge('a', 'c')
g2.add_edge('a', 'd')
g2.add_edge('b', 'e')
g2.add_edge('b', 'f')
g2.add_edge('f', 'g')
g2.add_edge('c', 'f')
g2.add_edge('d', 'f')

all_paths = []

g2.find_paths('a', 'g', []) {|path| all_paths.push(path)}
p all_paths

p "--------------------------"

def find_all_paths_from_root(graph)
  graph.graph.keys.each do |iterator|

    all_paths = []
    graph.find_paths('a', iterator, []) {|path| all_paths.push(path)}
    p all_paths
  end
end

find_all_paths_from_root(g2)