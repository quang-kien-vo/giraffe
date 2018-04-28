# x = Array.new(6)
#
#
# x.each do |iterator|
#
# end
#
# for i in 0..x.count
#   x[i] = [i, i+1]
# end
#
# p x
#
# p x[0]

require 'matrix'

def print_hello
  p "hello"
end




num_of_nodes = 6

adj_matrix = Matrix.build(num_of_nodes, num_of_nodes) {|row, col| 0}

p adj_matrix[2,3]

adj_matrix.element[]
p adj_matrix

# p adj_matrix

# x = Matrix[[print_step_1,4], [6,8]]
#
# p x[0,0]