require_relative '../model_builder'

model = ModelBuilder.new
model.add_node('Start')
model.add_node('Squad Planning Meeting')
model.add_node('QA Starts Ephemeral Environment')
model.add_node('Tickets Ready For QA')
model.add_node('Tickets Accepted')
model.add_node('Tickets Merged To Staging')
model.add_node('Tickets Merged To Prod')
model.add_node('Tickets Closed')

model.add_edge('Start', 'Squad Planning Meeting', nil)
model.add_edge('Squad Planning Meeting', 'QA Starts Ephemeral Environment', nil, 'Team Coordinates Which Tickets Go Into Release Train')
model.add_edge('QA Starts Ephemeral Environment', 'Tickets Ready For QA', nil, "Dev Pushes Relevant Codebases Deployed To Ephemeral Environment")
model.add_edge('Tickets Ready For QA', 'Tickets Accepted', nil, "QA Tests Tickets On Ephemeral Environment")
model.add_edge('Tickets Accepted', 'Tickets Merged To Staging', nil, "QA Functional Functional Test Suite Passes")
model.add_edge('Tickets Merged To Staging', 'Tickets Merged To Prod', nil, "QA Regression Suite Passes")
model.add_edge('Tickets Merged To Prod', 'Tickets Closed', nil)

model.output_png('output/release.png')