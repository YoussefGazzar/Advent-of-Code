require 'dotenv/load'
require 'open-uri'

class InputFetcher
  def self.fetch(year, day)
    url = "https://adventofcode.com/#{year}/day/#{day}/input"
    input = URI.open(url, "Cookie" => "session=#{ENV['COOKIE_SESSION']}") { |f| f.readlines(chomp: true) }
  rescue OpenURI::HTTPError => e
    puts "Failed to fetch input for #{year} day #{day}: #{e.message}"
    []
  end
end