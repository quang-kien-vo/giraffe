all_paths = [["a"], ["a", "b"], ["a", "c", "f", "b"], ["a", "d", "f", "b"], ["a", "b", "f", "c"], ["a", "c"], ["a", "d", "f", "c"], ["a", "b", "f", "d"], ["a", "c", "f", "d"], ["a", "d"], ["a", "b", "e"], ["a", "c", "f", "b", "e"], ["a", "d", "f", "b", "e"], ["a", "b", "f"], ["a", "c", "f"], ["a", "d", "f"], ["a", "b", "f", "g"], ["a", "c", "f", "g"], ["a", "d", "f", "g"]]
all_paths_sorted = all_paths.sort_by {|array| array.length }

p all_paths_sorted


a = ["1", "4", "5", "7", "10"]
b = ["1", "4", "5"]
c = ["1", "5", "4"]
d = ["1", "5", "10"]
e = ["1", "4", "5", "7", "10"]
f = ["4", "5", "7"]

def is_sub_array(sub_array, array)
  if sub_array.eql? array
    return false
  end
  count = 0
  conseq_indices = 0
  array.each do |i|
    unless sub_array[conseq_indices].eql? nil
      if sub_array[conseq_indices].eql? array[count]
        conseq_indices = conseq_indices + 1
      end
    end
    count = count+1
  end
  if conseq_indices.eql? sub_array.length
    true
  else
    false
  end
end


#           (a)
#          / | \
#        (b)(c)(d)
#       /  \ / _/
#     (e) (f)
#           \
#          (g)

all_paths_sorted.each do |i|

  longest_item = all_paths_sorted[all_paths_sorted.length-1]
  p longest_item
  unless i.eql? longest_item
    all_paths_sorted.delete_if { |i| is_sub_array(i, longest_item)}
  end
end

p all_paths_sorted


