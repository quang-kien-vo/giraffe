require 'json'

all_hashes = []
all_jsons = Dir.glob('../../output/json/*.json')

all_jsons.each do |json|
  file = File.read(json)
  data_hash = JSON.parse(file)
  all_hashes.concat(data_hash)
end

p all_hashes
