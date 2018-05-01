require 'rspec'
require 'json'
require_relative '../lib/giraffe'
require_relative '../page_objects/base_page'

describe '.add_edge' do
  let(:graph) { Graph.new }

  it 'should create the proper hash for adj_matrix' do
    graph.add_edge('a', 'b', true, 'clicked on paper')
    expect(graph.adj_matrix).eql?('a' => { 'b' => { 'function' => true, 'label' => 'clicked on paper' } })
  end
end

describe 'creates graph' do
  #           (start)
  #              |
  #           (google)
  #         /    |    \
  #    (frys)(amazon)(slickdeals)
  #              |
  #            (bing)

  let(:graph) { Graph.new }
  let(:base_page) { BasePage.instance }

  it 'should create the proper img for adj_matrix' do
    graph.add_edge('start', 'google', 'navigate_to_google', 'navigated to google')
    graph.add_edge('google', 'frys', 'navigate_to_frys', 'navigated to frys')
    graph.add_edge('google', 'amazon', 'navigate_to_amazon', 'navigated to amazon')
    graph.add_edge('google', 'slickdeals', 'navigate_to_slickdeals', 'navigated to slickdeals')
    graph.add_edge('amazon', 'bing', 'navigate_to_bing', 'navigated to bing')
    # graph.add_edge('google', 'bing', "navigate_to_bing", "navigated to bing")
    # graph.add_edge('frys', 'google', "navigate_to_google", "navigated to google")
    # graph.add_edge('frys', 'amazon',"navigate_to_amazon", "navigated to amazon")
    # graph.add_edge('bing', 'amazon',"navigate_to_amazon", "navigated to amazon")
    # graph.add_edge('bing', 'slickdeals',"navigate_to_slickdeals", "navigated to slickdeals")

    graph.traverse_graph(base_page, 'example')
  end
end
