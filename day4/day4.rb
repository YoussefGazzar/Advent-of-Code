require 'byebug'
if ARGV.empty?
	data =  DATA.readlines(chomp: true)
else
	data = File.readlines(ARGV.first, chomp: true)
end

# Part 1
# result = data
# 	.map { _1.split(': ')
# 		.last
# 		.split(' | ')
# 		.map { |set| set.split } 
# 	}
# 	.map { |winning, ours| winning & ours }
# 	.reject(&:empty?)
# 	.map { |list| 2 ** (list.size - 1) }
# 	.inject(:+)

# Part 2
result = data.each_with_object(Hash.new { |h, k| h[k] = 1 }) do |line, cards|
	card, sets = line.split(': ')
	card = card.split.last.to_i
	size = sets.split(' | ').map(&:split).inject(:&).size
	cards[card].times { size.times { cards[card + 1 + _1] += 1 } }
end

p result.values.sum

__END__
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11