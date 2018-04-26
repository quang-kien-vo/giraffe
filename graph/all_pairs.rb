class Graph
  attr_accessor :graph

  def initialize
    @graph = Hash.new { |hash, key| hash[key] = [] }
  end

  def add_edge(a, b)
    @graph[a] << b
    @graph[b] << a
  end


  def find_paths(a, b, result, &bl)
    result = result+[a] # !! copy and add a

    bl.call(result) if a == b
    @graph[a].each do |v|
      find_paths(v, b, result, &bl) if ! result.include?(v)
    end
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
p g2.graph
g2.find_paths('a', 'f', []) { |path|
  puts "path : #{path.join(", ")} / len=#{path.size}"
}