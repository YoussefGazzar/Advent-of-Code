require_relative '../fetch_input'

input = InputFetcher.fetch(2024, 1)
# part 1  
p input
.map(&:split)
.map { |x| x.map(&:to_i) }
.transpose
.map(&:sort)
.transpose
.map { |x| (x[-1] - x[0]).abs }
.sum

# part 2
h1, h2 = input
.map(&:split)
.map { |x| x.map(&:to_i) }
.transpose
.map(&:tally)
p h1.reduce(0) { |sum, (k, v)| sum + v * k * h2[k].to_i }
