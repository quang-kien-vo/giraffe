require 'rspec'
require_relative '../lib/graph'
require_relative '../page_objects/base_page'

describe '.add_edge' do
  let(:graph) {Graph.new}

  it 'should create the proper hash for adj_matrix' do
    graph.add_edge('a', 'b', true, "clicked on paper")
    expect(graph.adj_matrix).eql?({"a"=>{"b"=>{"function"=>true, "label"=>"clicked on paper"}}})
  end
end

# describe 'creates graph' do
#   #
#   #           (a)
#   #          / | \
#   #        (b)(c)(d)
#   #       /  \ / _/
#   #     (e) (f)
#   #           \
#   #          (g)
#   #
#   let(:graph) {Graph.new}
#
#   it 'should create the proper hash for adj_matrix' do
#     graph.add_edge('a', 'b', true, "clicked on paper")
#     graph.add_edge('a', 'c',true)
#     graph.add_edge('a', 'd',true)
#     graph.add_edge('b', 'e',true)
#     graph.add_edge('b', 'f',true)
#     graph.add_edge('f', 'g',true)
#     graph.add_edge('c', 'f',true)
#     graph.add_edge('d', 'f',true)
#
#     all_paths = graph.find_all_paths_from_node('a')
#     p all_paths
#   end
# end


describe 'creates graph' do
  #           (start)
  #              |
  #           (google)
  #         /    |    \
  #    (frys)(amazon)(slickdeals)
  #              |
  #            (bing)

  let(:graph) {Graph.new}
  let(:base_page) {BasePage.instance}
  # let(:navigate_to_google) {true}
  # let(:navigate_to_amazon) {true}
  # let(:navigate_to_slickdeals) {false}
  # let(:navigate_to_frys) {true}
  # let(:navigate_to_bing) {true}

  it 'should create the proper hash for adj_matrix' do
    graph.add_edge('start', 'google', "navigate_to_google", "navigated to google")
    graph.add_edge('google', 'frys', "navigate_to_frys", "navigated to frys")
    graph.add_edge('google', 'amazon',"navigate_to_amazon", "navigated to amazon")
    graph.add_edge('google', 'slickdeals',"navigate_to_slickdeals", "navigated to slickdeals")
    graph.add_edge('amazon', 'bing', "navigate_to_bing", "navigated to bing")
    # graph.add_edge('google', 'bing', "navigate_to_bing", "navigated to bing")
    # graph.add_edge('frys', 'google', "navigate_to_google", "navigated to google")
    # graph.add_edge('frys', 'amazon',"navigate_to_amazon", "navigated to amazon")
    # graph.add_edge('bing', 'amazon',"navigate_to_amazon", "navigated to amazon")
    # graph.add_edge('bing', 'slickdeals',"navigate_to_slickdeals", "navigated to slickdeals")

    all_paths = graph.find_all_paths_from_node('start')
    p graph.adj_matrix
    p all_paths

    all_paths.each do |path|
      p "path: #{path}"
      next if path.length < 2

      (0..path.length-1).each do |i|
        break if i == path.length-1
        break if graph.adj_matrix[path[i].to_s].eql? nil
        break if graph.adj_matrix[path[i].to_s][path[i+1].to_s].eql? nil

        graph.adj_matrix.fetch(path[i].to_s).fetch(path[i+1].to_s).fetch('function')
        sentinel = base_page.send(graph.adj_matrix.fetch(path[i].to_s).fetch(path[i+1].to_s).fetch('function'))
        graph.adj_matrix[path[i].to_s][path[i+1].to_s]['value'] = sentinel

        # if sentinel.eql? true
        #   graph.model.add_edge(path[i], path[i+1], color: "green", label: graph.adj_matrix[path[i]][path[i+1]]['label'])
        # elsif sentinel.eql? false
        #   graph.model.add_edge(path[i], path[i+1], color: "red", label: graph.adj_matrix[path[i]][path[i+1]]['label'])
        # end
      end
    end
    graph.output_model('output/web_navigation.png')
  end
end