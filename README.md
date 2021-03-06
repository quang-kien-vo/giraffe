# TBA


# Directory Structure

```
    ├── edge_definitions        # stores edge defintions (algorithm to traverse one edge to another)    
    ├── lib                     # main library for generating graphs
    ├── output                  # output files
    ├── page_objects            # example page objects
    ├── spec                    # tests
    ├── Gemfile
    ├── README.md
    ├── package.json
    ├── .rubocop.yml
    └── .gitignore
```

---
Notes:
* Working example is spec/graph_spec.rb which outputs to output folder
* graph/ folder contains experiments with different graph algorithms I was using to test but may not necessarily be used in the final framework.

## TODO:
### Necessary
- [x] Exception Handling (Currently Not Implemented)
- [x] Finalize API
- [x] Package Library As Gem
- [ ] Take care of instances where there are multiple paths between two nodes

### Optimization
- [x] Find subarrays within paths to optimize possible paths
- [ ] Find more suitable all paths algorithm which uses adjacent matrix and directed graph (currently using undirected graph)
- [ ] Add Observe Pattern to watch changes in adjacency matrix, and redraw on change (tried not really what I expected)

---
## Possible Research (Nice to haves):
- [ ] Get working json model which can be consumed by other visualization libraries
- [ ] Other visualization libraries
- [ ] Realtime updates of graph
- [ ] Associate tags with edges
- [ ] Associate microservices with edges
- [ ] Add tags to each edges
- [ ] Combine multiple models into one

