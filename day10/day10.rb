require 'byebug'
if ARGV.empty?
	data =  DATA.readlines(chomp: true)
else
	data = File.readlines(ARGV.first, chomp: true)
end

# | is a vertical pipe connecting north and south.
# - is a horizontal pipe connecting east and west.
# L is a 90-degree bend connecting north and east.
# J is a 90-degree bend connecting north and west.
# 7 is a 90-degree bend connecting south and west.
# F is a 90-degree bend connecting south and east.

def get_start(grid)
  grid.each_with_index do |row, r|
    row.each_with_index do |cell, c|
      return [r, c] if cell == "S"
    end
  end
end

GRID = data.map { _1.split('') }
HEIGHT = GRID.length - 1
WIDTH = GRID.first.length - 1
current = get_start(GRID)
VISITED = []
steps = 0

def next_move(current)
  row, col = current
  up = [row-1, col] 
  down = [row+1, col]
  left = [row, col-1]
  right = [row, col+1]
  up_cell = GRID[row-1][col] if (row-1).between?(0, HEIGHT) && col.between?(0, WIDTH)
  down_cell = GRID[row+1][col] if (row+1).between?(0, HEIGHT) && col.between?(0, WIDTH)
  left_cell = GRID[row][col-1] if row.between?(0, HEIGHT) && (col-1).between?(0, WIDTH)
  right_cell = GRID[row][col+1] if row.between?(0, HEIGHT) && (col+1).between?(0, WIDTH)
  current_cell = GRID[row][col]

  if current_cell == "S"
    return up if up_cell && !VISITED.include?(up) && %w[| 7 F].include?(up_cell)
    return down if down_cell && !VISITED.include?(down) && %w[| L J].include?(down_cell)
    return left if left_cell && !VISITED.include?(left) && %w[- L F].include?(left_cell)
    return right if right_cell && !VISITED.include?(right) && %w[- 7 J].include?(right_cell)
  end

  if current_cell == "|"
    return up if up_cell && !VISITED.include?(up) && %w[| 7 F].include?(up_cell)
    return down if down_cell && !VISITED.include?(down) && %w[| L J].include?(down_cell)
  end

  if current_cell == "-"
    return left if left_cell && !VISITED.include?(left) && %w[- L F].include?(left_cell)
    return right if right_cell && !VISITED.include?(right) && %w[- 7 J].include?(right_cell)
  end

  if current_cell == "L"
    return up if up_cell && !VISITED.include?(up) && %w[| 7 F].include?(up_cell)
    return right if right_cell && !VISITED.include?(right) && %w[- 7 J].include?(right_cell)
  end

  if current_cell == "J"
    return up if up_cell && !VISITED.include?(up) && %w[| 7 F].include?(up_cell)
    return left if left_cell && !VISITED.include?(left) && %w[- L F].include?(left_cell)
  end

  if current_cell == "7"
    return down if down_cell && !VISITED.include?(down) && %w[| L J].include?(down_cell)
    return left if left_cell && !VISITED.include?(left) && %w[- L F].include?(left_cell)
  end

  if current_cell == "F"
    return down if down_cell && !VISITED.include?(down) && %w[| L J].include?(down_cell)
    return right if right_cell && !VISITED.include?(right) && %w[- 7 J].include?(right_cell)
  end
end

pp "Calculating steps..."
while !current.nil?
  steps += 1
  VISITED << current
  current = next_move(current)
end
pp steps / 2

__END__
..F7.
.FJ|.
SJ.L7
|F--J
LJ...
