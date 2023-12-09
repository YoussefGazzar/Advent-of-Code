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
  'J' => 1,
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

TYPES = {
  'Five' => [],
  'Four' => [],
  'Full' => [],
  'Three' => [],
  'Two' => [],
  'One' => [],
  'High' => [],
}

def hand_type(hand)
  case hand.chars.tally.values.sort.reverse
  when [5] then return 'Five'
  when [4, 1] then return 'Four'
  when [3, 2] then return 'Full'
  when [3, 1, 1] then return 'Three'
  when [2, 2, 1] then return 'Two'
  when [2, 1, 1, 1] then return 'One'
  else return 'High'
  end 
end
  
def adjust_for_jokers!
  TYPES.values.each do |hands|
    next if hands.empty?
    to_be_deleted = []
    hands.each_with_index do |hand, i|
      count = hand.chars.count { _1 == 'J' }
      if count.between?(1, 4)
        char = hand.gsub('J', '').chars.tally.sort_by { |k, v| v }.last[0]
        new_hand = hand.gsub('J', char)
        new_type = hand_type(new_hand)
        to_be_deleted << i
        TYPES[new_type] << hand
      end
    end
    to_be_deleted.reverse.each { hands.delete_at(_1) }
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
hands.each do |hand, _|
  type = hand_type(hand)
  TYPES[type] << hand
end
# pp TYPES
adjust_for_jokers!
rankings = rank_hands(hands)
result = rankings.map { |hand, rank| hands[hand] * rank }.sum

pp result
__END__
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483