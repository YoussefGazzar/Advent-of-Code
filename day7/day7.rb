require 'byebug'
if ARGV.empty?
	data =  DATA.readlines(chomp: true)
else
	data = File.readlines(ARGV.first, chomp: true)
end

CARD_SCORE = {
  'A' => 14,
  'K' => 13,
  'Q' => 12,
  'J' => 11,
  'T' => 10,
  '9' => 9,
  '8' => 8,
  '7' => 7,
  '6' => 6,
  '5' => 5,
  '4' => 4,
  '3' => 3,
  '2' => 2,
}

TYPE_SCORE = {
  'Five' => 5,
  'Four' => 4,
  'Full' => 3,
  'Three' => 2,
  'Two' => 1,
  'One' => 0,
  'High' => -1,
}

TYPES = {
  'Five' => [],
  'Four' => [],
  'Full' => [],
  'Three' => [],
  'Two' => [],
  'One' => [],
  'High' => [],
}

def categorize_hands!(hands)
  hands.keys.each do |cards|
    case cards.chars.tally.values.sort.reverse
    when [5] then TYPES['Five'] << cards
    when [4, 1] then TYPES['Four'] << cards
    when [3, 2] then TYPES['Full'] << cards
    when [3, 1, 1] then TYPES['Three'] << cards
    when [2, 2, 1] then TYPES['Two'] << cards
    when [2, 1, 1, 1] then TYPES['One'] << cards
    else TYPES['High'] << cards
    end 
  end
  
end

def rank_hands(hands)
  rank = hands.count
  rankings = []
  TYPES.values.each do |cards|
    next if cards.empty?
    sorted = cards.sort_by { |hand| hand.chars.map { |c| CARD_SCORE[c] } }
    while !sorted.empty?
      rankings << [sorted.pop, rank]
      rank -= 1
    end
  end
  rankings
end

hands = data.map(&:split).map {[_1, _2.to_i]}.to_h
categorize_hands!(hands)
rankings = rank_hands(hands)
result = rankings.map { |hand, rank| hands[hand] * rank }.sum

pp result
__END__
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483