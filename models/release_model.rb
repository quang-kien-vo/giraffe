require_relative '../lib/graph'

model = Graph.new

model.add_edge('Start', 'Squad Planning Meeting', nil)
model.add_edge('Squad Planning Meeting', 'QA Starts Ephemeral Environment', nil, 'Team Coordinates Which Tickets Go Into Release Train')
model.add_edge('QA Starts Ephemeral Environment', 'Tickets Ready For QA', nil, "Dev Pushes Relevant Codebases Deployed To Ephemeral Environment")
model.add_edge('Tickets Ready For QA', 'Tickets Accepted', nil, "QA Tests Tickets On Ephemeral Environment")
model.add_edge('Tickets Accepted', 'Tickets Merged To Staging', nil, "QA Functional Functional Test Suite Passes")
model.add_edge('Tickets Merged To Staging', 'Tickets Merged To Prod', nil, "QA Regression Suite Passes")
model.add_edge('Tickets Merged To Prod', 'Tickets Closed', nil)

model.output_model('../output/release.png')