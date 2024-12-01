require 'byebug'
if ARGV.empty?
	data =  DATA.readlines(chomp: true)
else
	data = File.readlines(ARGV.first, chomp: true)
end

result = data.chunk_while {!_1.empty?}.to_a.map {_1.reject(&:empty?)}
seeds, *rest = result
seeds = seeds.flat_map {_1.scan(/\d+/)}.map(&:to_i).each_slice(2).to_a.map {|a, b| (a...a+b)}

mappings = rest.map do |line|
	_, *values = line 
	values = values.each_with_object({}) do |value, hash|
		distnation, source, range = value.split.map(&:to_i)
		key = (source...source+range)
		hash[key] = distnation
	end
	values
end

def range_contains(r1, r2)
  # not contained
  return [[], [r1]] if r1.min > r2.max || r1.max < r2.min

  # fully contained
  return [[r1], []] if r1.min >= r2.min && r1.max <= r2.max

  # partially contained from right
  return [[r2.min..r1.max], [r1.min...r2.min]] if r1.min < r2.min && r1.max >= r2.min && r1.max <= r2.max

  # partially contained from left
  return [[r1.min..r2.max], [r2.max+1..r1.max]] if r1.max > r2.max && r1.min <= r2.max && r1.min >= r2.min
 
  # overflow
  return [[r2.min..r2.max], [r1.min...r2.min, r2.max+1..r1.max]] if r1.min < r2.min && r1.max > r2.max
end

def move_range(r, num)
  r.min+num..r.max+num
end

seeds = seeds.map do |seed_range|
  temp_seed_range = [seed_range]
  mappings.each do |mapping|
    new_seeds = []
    remainig_seeds = []
    mapping.each do |map_range, destination|
      offset = destination - map_range.min
      current_seeds = remainig_seeds.empty? ? temp_seed_range : remainig_seeds
      temp_rest = []
      current_seeds.each do |current_range|
        exist, rest = range_contains(current_range, map_range)
        if !exist.empty?
          exist = exist.first
          new_seeds += [move_range(exist, offset)]
        end
        temp_rest += rest
        break if rest.empty?
      end
      remainig_seeds = temp_rest
    end
    temp_seed_range = new_seeds + remainig_seeds
  end
  temp_seed_range.map(&:min).min
end

pp seeds.min

__END__
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4