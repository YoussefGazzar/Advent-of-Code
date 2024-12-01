require 'byebug'
if ARGV.empty?
	data =  DATA.readlines(chomp: true)
else
	data = File.readlines(ARGV.first, chomp: true)
end

def bs((t, d))
  d += 1
  l = 1
  r = t-1
  
  while l <= r
    m = ((l+r)/2).floor
    rest = t - m
    target = m * rest
    if target == d
      answer = rest - m + 1
			return answer
    elsif target < d
      l = m + 1
    else
      answer = rest - m + 1
      r = m - 1
    end
  end
	answer
end

# Part 1
# t, d = data.map { _1.scan(/\d+/).map(&:to_i) }
# result = t.zip(d)
# result = result.map { bs(_1) }.inject(:*)
# pp result

# Part 2
result = data.map { _1.scan(/\d+/).join.to_i }
pp bs(result)

__END__
Time:      7  15   30
Distance:  9  40  200