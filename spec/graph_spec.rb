require 'rspec'
require_relative '../lib/graph'

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
  # let(:navigate_to_google) {true}
  # let(:navigate_to_amazon) {true}
  # let(:navigate_to_slickdeals) {false}
  # let(:navigate_to_frys) {true}
  # let(:navigate_to_bing) {true}

  def navigate_to_google
    puts 'www.google.com'
    true
  end

  def navigate_to_amazon
    puts 'www.amazon.com'
    true
  end

  def navigate_to_slickdeals
    puts 'www.slickdeals.net'
    false
  end

  def navigate_to_frys
    puts 'www.frys.com'
    true
  end

  def navigate_to_bing
    puts 'www.bing.com'
    true
  end


  it 'should create the proper hash for adj_matrix' do
    graph.add_edge('start', 'a', navigate_to_google, "navigated to google")
    graph.add_edge('a', 'b', navigate_to_frys, "navigated to frys")
    graph.add_edge('a', 'c',navigate_to_amazon, "navigated to amazon")
    graph.add_edge('a', 'd',navigate_to_slickdeals, "navigated to slickdeals")
    graph.add_edge('c', 'e', navigate_to_bing, "navigated to bing")

    all_paths = graph.find_all_paths_from_node('start')
    p graph.adj_matrix
    p all_paths
    graph.output_model('output/web_navigation.png')
    all_paths.each do |path|
      p "path: #{path}"
      next if path.length < 2

      (0..path.length-1).each do |i|
        next if i == path.length-1
        p graph.adj_matrix.fetch(path[i].to_s).fetch(path[i+1].to_s).fetch('function')
      end
    end

  end
end