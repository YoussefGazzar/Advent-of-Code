require 'byebug'
if ARGV.empty?
	data =  DATA.readlines(chomp: true)
else
	data = File.readlines(ARGV.first, chomp: true)
end
data.delete_at(1)

directions, *graph = data
directions = directions.chars.cycle
graph = graph.each_with_object({}) do |direction, hash|
  match = /(?<key>\w{3}) = \((?<l>\w{3}), (?<r>\w{3})\)/.match(direction)
  hash[match[:key]] = {'L'=> match[:l], 'R'=> match[:r]}
end

current = 'AAA'
directions.each_with_index do |direction, i|
  return pp i+1 if graph[current][direction] == 'ZZZ'
  current = graph[current][direction]
end



__END__
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)