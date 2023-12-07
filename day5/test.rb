require 'byebug'

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

seeds = [79...93,
        #  55...68
        ]

mappings = [{98...100=>50, 50...98=>52},
            {15...52=>0, 52...54=>37, 0...15=>39},
            {53...61=>49, 11...53=>0, 0...7=>42, 7...11=>57},
            {18...25=>88, 25...95=>18},
            {77...100=>45, 45...64=>81, 64...77=>68},
            {69...70=>0, 0...69=>1},
            {56...93=>60, 93...97=>56}
          ]

seeds = seeds.map do |seed_range|
  temp_seed_range = [seed_range]
  pp temp_seed_range
  mappings.each do |mapping|
    new_seeds = []
    remainig_seeds = []
    pp mapping
    mapping.each do |map_range, destination|
      offset = destination - map_range.min
      current_seeds = remainig_seeds.empty? ? temp_seed_range : remainig_seeds
      pp "Current Seeds: #{current_seeds}"
      temp_rest = []
      current_seeds.each do |current_range|
        exist, rest = range_contains(current_range, map_range)
        pp "Map Range: #{map_range}"
        pp "Current Range: #{current_range}"
        pp "Exist: #{exist}"
        pp "Rest: #{rest}"
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
    pp temp_seed_range
  end
  # pp temp_seed_range
  temp_seed_range.map(&:min).min
end
# pp seeds
pp seeds.min