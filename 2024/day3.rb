require_relative '../fetch_input'

input = InputFetcher.fetch(2024, 3, true)

# part 1 
# p input.map { |line| line.scan(/mul\((\d{1,3}),(\d{1,3})\)/).map { _1.map(&:to_i).inject(:*) }.sum }.sum
p input.scan(/mul\((\d{1,3}),(\d{1,3})\)/).map { _1.map(&:to_i).inject(:*) }.sum

# part 2
# p input.map { |line| line.gsub(/don't\(\).*?(?=do\(\)|$)/, "").scan(/mul\((\d{1,3}),(\d{1,3})\)/).map { _1.map(&:to_i).inject(:*) }.sum }.sum
p input.gsub(/\n+/, "").gsub(/don't\(\).*?(?=do\(\)|$)/, "").scan(/mul\((\d{1,3}),(\d{1,3})\)/).map { _1.map(&:to_i).inject(:*) }.sum


