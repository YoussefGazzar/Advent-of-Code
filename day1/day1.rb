if ARGV.empty?
  data =  DATA.readlines(chomp: true)
else
  data = File.readlines(ARGV.first, chomp: true)
end

nums = {
  'one'=> '1',
  'two'=> '2',
  'three'=> '3',
  'four'=> '4',
  'five'=> '5',
  'six'=> '6',
  'seven'=> '7',
  'eight'=> '8',
  'nine'=> '9',
  '1' => '1',
  '2' => '2',
  '3' => '3',
  '4' => '4',
  '5' => '5',
  '6' => '6',
  '7' => '7',
  '8' => '8',
  '9' => '9'
}



# Part 1
# result = data.map { _1.scan(/\d/).values_at(0, -1).join.to_i }.sum

# Part 2
result = data.map { |line| line.scan(/(\d|one|two|three|four|five|six|seven|eight|nine)/).values_at(0, -1).flatten.map { nums[_1] }.join.to_i }.sum

puts result

__END__
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen