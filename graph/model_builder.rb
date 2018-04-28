require 'graphviz'

class ModelBuilder
  attr_accessor :graph

  def initialize
    @graph = GraphViz.new(:G, type: :digraph)
  end

  def add_node(node_name, shape = 'oval')
    @graph.add_node(node_name, shape: shape)
  end

  def add_edge(first_node, second_node, condition, label = '')
    sentinel = try_condition(condition)

    if sentinel.eql? true
      @graph.add_edge(first_node, second_node, label: label, color: 'green')
    elsif sentinel.eql? false
      @graph.add_edge(first_node, second_node, label: label, color: 'red')
    else
      @graph.add_edge(first_node, second_node, label: label)
    end
  end

  def output_png(file_name)
    @graph.output(png: file_name)
  end

  def try_condition(condition)
    condition
  rescue RuntimeError => e
    false
  end
end
