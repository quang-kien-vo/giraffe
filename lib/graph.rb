require_relative 'node'
require 'graphviz'

class Graph
  attr_accessor :graph, :adj_matrix

  def initialize
    @graph = Hash.new {|hash, key| hash[key] = []}
    @adj_matrix = Hash.new
  end

  def add_edge(source, destination, function, label = nil)

    @graph[source] << destination
    @graph[destination] << source

    @adj_matrix[source] = {} if @adj_matrix[source].eql? nil
    @adj_matrix[source][destination] = {} if @adj_matrix[source][destination].eql? nil
    @adj_matrix[source][destination]['function'] = function
    @adj_matrix[source][destination]['label'] = label
  end

  def find_all_paths_from_node(source)
    all_paths = []
    @graph.keys.each do |iterator|
      find_paths(source, iterator, []) {|path| all_paths.push(path)}
    end
    all_paths
  end

  def print_all_nodes
    @graph.keys
  end

  private

  def find_paths(source, destination, result, &bl)
    result = result+[source] # !! copy and add a
    bl.call(result) if source == destination
    @graph[source].each do |v|
      find_paths(v, destination, result, &bl) unless result.include?(v)
    end
  end
end




