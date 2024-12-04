require_relative '../fetch_input'

input = InputFetcher.fetch(2024, 3, true)

# part 1 
p input.scan(/mul\((\d{1,3}),(\d{1,3})\)/).map { _1.map(&:to_i).inject(:*) }.sum

# part 2
p input.gsub(/\n+/, "").gsub(/don't\(\).*?(?=do\(\)|$)/, "").scan(/mul\((\d{1,3}),(\d{1,3})\)/).map { _1.map(&:to_i).inject(:*) }.sum


