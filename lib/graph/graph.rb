require 'json'
require 'ruby-graphviz'
require 'model/model_builder'

# abstraction of a graph
class Graph
  attr_accessor :graph, :adj_matrix

  def initialize
    @graph = Hash.new { |hash, key| hash[key] = [] }
    @adj_matrix = {}
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
    @graph.each_key do |iterator|
      find_paths(source, iterator, []) { |path| all_paths.push(path) }
    end
    all_paths.uniq
  end

  # definitions will be the algorithm page, which includes
  def traverse_graph(start_node_name, definitions, file_name)
    json_result = []
    all_paths = find_all_paths_from_node(start_node_name)
    all_paths = remove_subarrays(all_paths)

    all_paths.each do |path|
      p "path: #{path}"
      next if path.length < 2

      (0..path.length - 1).each do |i|
        break if i == path.length - 1
        break if @adj_matrix[path[i]].eql? nil
        break if @adj_matrix[path[i]][path[i + 1]].eql? nil

        @adj_matrix.fetch(path[i]).fetch(path[i + 1]).fetch('function')
        begin
          definitions.send(@adj_matrix.fetch(path[i]).fetch(path[i + 1]).fetch('function'))
          @adj_matrix[path[i]][path[i + 1]]['value'] = true
        rescue RuntimeError => e
          puts "ERROR going from #{path[i]} to #{path[i + 1]}"
          puts e.message.to_s
          # unless @adj_matrix[path[i]][path[i + 1]]['value'] = false
          #   appended_error = @adj_matrix[path[i]][path[i + 1]]['label'].concat(" \nError: #{e.message}")
          #   @adj_matrix[path[i]][path[i + 1]]['label'] = appended_error
          # end
          @adj_matrix[path[i]][path[i + 1]]['value'] = false
        end

        temp = {}
        temp['source'] = path[i]
        temp['destination'] = path[i + 1]
        temp['label'] = @adj_matrix[path[i]][path[i + 1]]['label']
        temp['value'] = @adj_matrix[path[i]][path[i + 1]]['value']
        json_result.push(temp)
      end
    end
    build_model(json_result, file_name)
  end

  def build_model(json_model, file_name)
    json_model = json_model.uniq
    model_result = ModelBuilder.new
    json_model.each do |x|
      next if x['value'].eql? nil
      model_result.add_edge(x['source'], x['destination'], x['value'], x['label'])
    end
    model_result.output_png("output/img/#{file_name}.png")
    File.write("output/json/#{file_name}.json", JSON.pretty_generate(json_model))
  end

  def print_all_nodes
    @graph.keys
  end

  private

  def find_paths(source, destination, result, &bl)
    result += [source] # !! copy and add a
    yield(result) if source == destination
    @graph[source].each do |v|
      find_paths(v, destination, result, &bl) unless result.include?(v)
    end
  end

  def is_subarray(array1, array2)
    @temp_array1 = array1.join('').gsub(/\s+/, '')
    @temp_array2 = array2.join('').gsub(/\s+/, '')

    return false if @temp_array1.eql? @temp_array2
    @temp_array1.include? @temp_array2
  end

  def remove_subarrays(all_paths)
    all_paths = all_paths.uniq
    temp_array = Array.new(all_paths.length, 0)
    all_paths.each do |path|
      (0..all_paths.length - 1).each do |i|
        temp_array[i] = 1 if is_subarray(path, all_paths[i])
      end
    end

    new_temp_array = []

    (0..temp_array.length - 1).each do |i|
      if temp_array[i].eql? 0
        new_temp_array.push(all_paths[i])
        next
      end
    end
    new_temp_array
  end
end
