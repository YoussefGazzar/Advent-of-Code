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

# Part 1
# current = 'AAA'
# directions.each_with_index do |direction, i|
#   return pp i+1 if graph[current][direction] == 'ZZZ'
#   current = graph[current][direction]
# end

current_nodes = graph.keys.select {_1.end_with?('A')}
pp current_nodes


cycles = current_nodes.each_with_object([]) do |node, arr|
  directions.each_with_index do |direction, i|
    if node.end_with?('Z')
      pp "Node: #{node}, I: #{i}"
      arr << i
      break
    end
    node = graph[node][direction]
  end
end

pp cycles
pp cycles.reduce(1, :lcm)

# "Node: DDZ, I: 20093"
# "Node: XDZ, I: 12169"
# "Node: ZZZ, I: 22357"
# "Node: SRZ, I: 14999"
# "Node: JVZ, I: 13301"
# "Node: THZ, I: 17263"

__END__
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)