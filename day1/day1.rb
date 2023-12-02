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
  'eno'=> '1',
  'owt'=> '2',
  'eerht'=> '3',
  'ruof'=> '4',
  'evif'=> '5',
  'xis'=> '6',
  'neves'=> '7',
  'thgie'=> '8',
  'enin'=> '9',
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
# result = data.map { _1.scan(/\d/).values_at(0, -1).join.to_i }

# Part 2
forward_keys = Regexp.union(nums.keys)
backward_keys = Regexp.union(nums.keys.map(&:reverse))

result = data.map do |line| 
  first = line.scan(forward_keys).first
  last = line.reverse.scan(backward_keys).first
  (nums[first] + nums[last]).to_i
end

puts result.sum

__END__
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen