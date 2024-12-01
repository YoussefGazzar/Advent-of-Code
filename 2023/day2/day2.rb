require 'byebug'
if ARGV.empty?
	data =  DATA.readlines(chomp: true)
else
	data = File.readlines(ARGV.first, chomp: true)
end

# Part 1
# score = 0
# maximum = {
# 	'red' => 12,
# 	'green' => 13,
# 	'blue' => 14
# }
# 
# data.each do |line|
# 	game, cubes = line.split(': ')
# 	game =  game.split.last.to_i
# 	valid = true
# 	sets = cubes.split('; ').map {_1.scan(/\d+ \w+/)}
# 	sets.each do |set|
# 		set = set.each_with_object(Hash.new {|h, k| h[k] = 0}) do |pair, hash|
# 	 		count, color = pair.split(' ')
# 	 		hash[color] += count.to_i
# 	 	end
# 		maximum.each do |k, v|
# 			valid = false if set[k] > v
# 		end
# 		pp set
# 	end
# 	score += game if valid
# end
# pp score

# Part 2
result = data.map do |line|
	cubes = line.split(': ').last
	sets = cubes.split('; ').map {_1.scan(/\d+ \w+/)}
	minimum = sets.each_with_object(Hash.new {|h, k| h[k] = 0}) do |set, hash|
		set.each do |pair|
	 		count, color = pair.split(' ')
			hash[color] = count.to_i if count.to_i > hash[color]
	 	end
	end
	minimum.values.inject(:*)
end
pp result.inject(:+)

__END__
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green