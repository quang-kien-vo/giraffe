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

  it 'should create the proper img for adj_list' do
    graph.add_edge('start', 'google', 'navigate_to_google', 'navigated to google')
    graph.add_edge('google', 'frys', 'navigate_to_frys', 'navigated to frys')
    graph.add_edge('google', 'amazon', 'navigate_to_amazon', 'navigated to amazon')
    graph.add_edge('google', 'slickdeals', 'navigate_to_slickdeals', 'navigated to slickdeals')
    graph.add_edge('amazon', 'bing', 'navigate_to_bing', 'navigated to bing')

    #graph.add_edge('google', 'bing', "navigate_to_bing", "navigated to bing")
    #graph.add_edge('frys', 'google', "navigate_to_google", "navigated to google")
    #graph.add_edge('bing', 'amazon',"navigate_to_amazon", "navigated to amazon")

    graph.traverse_graph('start', base_page, 'website')
  end
end

describe '[CAMS] flow' do
  context 'Credit Application Flow' do
    let(:graph) { Graph.new }
    let(:base_page) { BasePage.instance }

    it 'creates username and logs in' do
      graph.add_edge('start', 'Created User', 'say_hello', 'create user')
      graph.add_edge('Created User', 'Logged In', 'say_hello', 'log in')
      graph.add_edge('Logged In', 'Select New Make', 'say_hello', 'select new make')
      graph.add_edge('Logged In', 'Select Used Make', 'say_hello', 'select used make')
      graph.add_edge('Select New Make', 'Select New Model', 'say_hello', 'select new model')
      graph.add_edge('Select Used Make', 'Select Used Model', 'say_hello', 'select used model')
      graph.traverse_graph('start',base_page, 'example')
    end
  end
end
