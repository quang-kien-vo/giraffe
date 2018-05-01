all_paths = [['a'], %w[a b], %w[a c f b], %w[a d f b], %w[a b f c], %w[a c], %w[a d f c], %w[a b f d], %w[a c f d], %w[a d], %w[a b e], %w[a c f b e], %w[a d f b e], %w[a b f], %w[a c f], %w[a d f], %w[a b f g], %w[a c f g], %w[a d f g]]
all_paths_sorted = all_paths.sort_by(&:length)

p all_paths_sorted

a = %w[1 4 5 7 10]
b = %w[1 4 5]
c = %w[1 5 4]
d = %w[1 5 10]
e = %w[1 4 5 7 10]
f = %w[4 5 7]

def is_sub_array(sub_array, array)
  return false if sub_array.eql? array
  count = 0
  conseq_indices = 0
  array.each do |_i|
    unless sub_array[conseq_indices].eql? nil
      conseq_indices += 1 if sub_array[conseq_indices].eql? array[count]
    end
    count += 1
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
  longest_item = all_paths_sorted[all_paths_sorted.length - 1]
  p longest_item
  all_paths_sorted.delete_if { |i| is_sub_array(i, longest_item) } unless i.eql? longest_item
end

p all_paths_sorted
