#TBA

---
Notes:
* Right now most of the usable code is in lib/graph.rb
* Working example is spec/graph_spec.rb which outputs to output folder
* graph/ folder contains experiments with different graph algorithms I was using to test but may not necessarily be used in the final framework.
* lib/node.rb currently is not being used

##TODO:
###Necessary
- [ ] Exception Handling (Currently Not Implemented)
- [ ] Finalize API
- [ ] Package Library As Gem

###Optimization
- [ ] Find subarrays within paths to optimize possible paths
- [ ] Find more suitable all paths algorithm which uses adjacent matrix and directed graph (currently using undirected graph)
- [ ] Add Observe Pattern to watch changes in adjacency matrix, and redraw on change

---
##Possible Research (Nice to haves):
- [ ] Get working json model which can be consumed by other visualization libraries
- [ ] Other visualization libraries
- [ ] Realtime updates of graph
- [ ] Associate tags with edges
- [ ] Associate microservices with edges
- [ ] Add tags to each edge

