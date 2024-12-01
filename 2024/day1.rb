require 'dotenv/load'
require 'open-uri'
url = "https://adventofcode.com/2024/day/1/input"

URI.open(url, "Cookie" => "session=#{ENV['COOKIE_SESSION']}") {|f|
  # # part 1  
  # p f.readlines(chomp: true)
  # .map(&:split)
  # .map { |x| x.map(&:to_i) }
  # .transpose
  # .map(&:sort)
  # .transpose
  # .map { |x| (x[-1] - x[0]).abs }
  # .sum
 
  # part 2
  h1, h2 = f.readlines(chomp: true)
  .map(&:split)
  .map { |x| x.map(&:to_i) }
  .transpose
  .map(&:tally)
  p h1.reduce(0)  { |sum, (k, v)| sum + v * k * h2[k].to_i }
}
