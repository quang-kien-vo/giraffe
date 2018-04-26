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

g2 = Graph.new
g2.add_edge('a', 'e')
g2.add_edge('e', 'b')
g2.add_edge('e', 'f')
g2.add_edge('f', 'b')
g2.add_edge('a', 'c')
g2.add_edge('c', 'b')
p g2.graph
g2.find_paths('a', 'b', []) { |path|
  puts "path : #{path.join(", ")} / len=#{path.size}"
}