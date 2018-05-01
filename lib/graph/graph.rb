require 'json'
require 'graphviz'
require 'model/model_builder'

class Graph
  attr_accessor :graph, :adj_matrix, :model

  def initialize
    @graph = Hash.new {|hash, key| hash[key] = []}
    @adj_matrix = Hash.new
    @model = GraphViz.new(:G, type: :digraph)
  end

  def add_edge(source, destination, function, label = nil)

    @graph[source] << destination
    @graph[destination] << source

    @adj_matrix[source] = {} if @adj_matrix[source].eql? nil
    @adj_matrix[source][destination] = {} if @adj_matrix[source][destination].eql? nil
    @adj_matrix[source][destination]['function'] = function
    @adj_matrix[source][destination]['label'] = label

    sentinel = function

    if sentinel.eql? true
      @model.add_edge(source, destination, label: label, color: 'green')
    elsif sentinel.eql? false
      @model.add_edge(source, destination, label: label, color: 'red')
    else
      @model.add_edge(source, destination, label: label)
    end
  end

  def find_all_paths_from_node(source)
    all_paths = []
    @graph.keys.each do |iterator|
      find_paths(source, iterator, []) {|path| all_paths.push(path)}
    end
    all_paths.uniq
  end

  # definitions will be the algorithm page, which includes
  def traverse_graph(definitions, result_name)
    json_result = []
    all_paths = find_all_paths_from_node('start')

    all_paths.each do |path|
      p "path: #{path}"
      next if path.length < 2

      (0..path.length-1).each do |i|
        break if i == path.length-1
        break if @adj_matrix[path[i]].eql? nil
        break if @adj_matrix[path[i]][path[i+1]].eql? nil

        @adj_matrix.fetch(path[i]).fetch(path[i+1]).fetch('function')
        @adj_matrix[path[i]][path[i+1]]['value'] = definitions.send(@adj_matrix.fetch(path[i]).fetch(path[i+1]).fetch('function'))

        temp = {}
        temp["source"] = path[i]
        temp["destination"] = path[i+1]
        temp["label"] = @adj_matrix[path[i]][path[i+1]]['label']
        temp["value"] = @adj_matrix[path[i]][path[i+1]]['value']
        json_result.push(temp)
      end
    end
    json_result = json_result.uniq
    model_result = ModelBuilder.new
    json_result.each do |x|
      next if x['value'].eql? nil
      model_result.add_edge(x['source'], x['destination'], x['value'], x['label'])
    end
    model_result.output_png("output/img/#{result_name}.png")
    File.write("output/json/#{result_name}.json", JSON.pretty_generate(json_result))
  end

  def print_all_nodes
    @graph.keys
  end

  def output_model(file_name)
    @model.output(png: file_name)
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





