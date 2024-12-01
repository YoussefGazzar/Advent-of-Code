require 'byebug'
if ARGV.empty?
	data =  DATA.readlines(chomp: true).map {_1.split.map(&:to_i)}
else
	data = File.readlines(ARGV.first, chomp: true).map {_1.split.map(&:to_i)}
end

# Part 1
def positive_recursion(arr)
  return arr.last if arr.all?(0)
  diff = []
  arr.each_cons(2) do |(a, b)|
    diff << b - a
  end
  arr.last + positive_recursion(diff)
end

positive_result = data.map { positive_recursion(_1) }
pp positive_result.inject(:+)


# Part 2
def negative_recursion(arr)
  return arr.first if arr.all?(0)
  diff = []
  arr.each_cons(2) do |(a, b)|
    diff << b - a
  end
  arr.first - negative_recursion(diff)
end

negative_result = data.map { negative_recursion(_1) }
pp negative_result.inject(:+)

__END__
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45