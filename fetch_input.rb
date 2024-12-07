require 'dotenv/load'
require 'open-uri'
require 'byebug'

class InputFetcher
  def self.fetch(year, day, bulk = false)
    url = "https://adventofcode.com/#{year}/day/#{day}/input"
    URI.open(url, "Cookie" => "session=#{ENV['COOKIE_SESSION']}") do |f|
      return f.read if bulk
      f.readlines(chomp: true)
    end
  rescue OpenURI::HTTPError => e
    puts "Failed to fetch input for #{year} day #{day}: #{e.message}"
    []
  end
end