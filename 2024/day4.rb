require_relative '../fetch_input'

INPUT = InputFetcher.fetch(2024, 4)
ROWS = INPUT.size - 1
COLS = INPUT[0].length - 1
ans = 0

def find_xmas(row, col)
  current = 0
  if col + 3 <= COLS
    current += 1 if INPUT[row][col + 1] == 'M' && INPUT[row][col + 2] == 'A' && INPUT[row][col + 3] == 'S'
  end

  if col - 3 >= 0
    current += 1 if INPUT[row][col - 1] == 'M' && INPUT[row][col - 2] == 'A' && INPUT[row][col - 3] == 'S'
  end

  if row + 3 <= ROWS
    current += 1 if INPUT[row + 1][col] == 'M' && INPUT[row + 2][col] == 'A' && INPUT[row + 3][col] == 'S'
  end

  if row - 3 >= 0
    current += 1 if INPUT[row - 1][col] == 'M' && INPUT[row - 2][col] == 'A' && INPUT[row - 3][col] == 'S'
  end

  if row + 3 <= ROWS && col + 3 <= COLS
    current += 1 if INPUT[row + 1][col + 1] == 'M' && INPUT[row + 2][col + 2] == 'A' && INPUT[row + 3][col + 3] == 'S'
  end

  if row - 3 >= 0 && col - 3 >= 0
    current += 1 if INPUT[row - 1][col - 1] == 'M' && INPUT[row - 2][col - 2] == 'A' && INPUT[row - 3][col - 3] == 'S'
  end

  if row + 3 <= ROWS && col - 3 >= 0
    current += 1 if INPUT[row + 1][col - 1] == 'M' && INPUT[row + 2][col - 2] == 'A' && INPUT[row + 3][col - 3] == 'S'
  end

  if row - 3 >= 0 && col + 3 <= COLS
    current += 1 if INPUT[row - 1][col + 1] == 'M' && INPUT[row - 2][col + 2] == 'A' && INPUT[row - 3][col + 3] == 'S'
  end
  
  current
end

# part 1 
INPUT.each_with_index do |line, i|
  line.chars.each_with_index do |char, j|
    if char == 'X'
      ans += find_xmas(i, j)
    end
  end
end

puts ans

def find_mas(row, col)
  current = 0
  if col - 1 >= 0 && col + 1 <= COLS && row - 1 >= 0 && row + 1 <= ROWS
    current += 1 if (INPUT[row - 1][col - 1] == 'M' && INPUT[row + 1][col - 1] == 'M' && INPUT[row - 1][col + 1] == 'S' && INPUT[row + 1][col + 1] == 'S') ||
                    (INPUT[row - 1][col - 1] == 'S' && INPUT[row + 1][col - 1] == 'S' && INPUT[row - 1][col + 1] == 'M' && INPUT[row + 1][col + 1] == 'M') ||
                    (INPUT[row - 1][col - 1] == 'M' && INPUT[row + 1][col - 1] == 'S' && INPUT[row - 1][col + 1] == 'M' && INPUT[row + 1][col + 1] == 'S') ||
                    (INPUT[row - 1][col - 1] == 'S' && INPUT[row + 1][col - 1] == 'M' && INPUT[row - 1][col + 1] == 'S' && INPUT[row + 1][col + 1] == 'M')
  end

  current
end

ans = 0
# part 2
INPUT.each_with_index do |line, i|
  line.chars.each_with_index do |char, j|
    if char == 'A'
      ans += find_mas(i, j)
    end
  end
end

puts ans
