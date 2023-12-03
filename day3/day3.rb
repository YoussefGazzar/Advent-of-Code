require 'byebug'
if ARGV.empty?
	data =  DATA.readlines(chomp: true)
else
	data = File.readlines(ARGV.first, chomp: true)
end

# # Part 1
# class Grid
#   attr_accessor :grid, :len, :score, :cells
#   def initialize(data)
#     @grid = data.map {_1.split('')}
#     @len = grid.size - 1
#     @score = 0
#     @cells = []
#   end

#   def search
#     grid.each_with_index do |row, i|
#       row.each_with_index do |cell, j|
#         validate(i, j)
#       end
#     end
    
#     cells.each do |cell|
#       neighbors = get_neighbors(cell)
#       neighbors.each do |neighbor|
#         add_score(neighbor)
#       end
#     end
#   end

#   def validate(i, j)
#     cells << [i, j] if grid[i][j] =~ /[^.\d]/
#   end

#   def get_neighbors((i, j))
#     list = []
#     (-1..1).each do |x|
#       (-1..1).each do |y|
#         row = i + x
#         col = j + y
#         if row.between?(0, len) && col.between?(0, len) && grid[row][col] =~ /\d/
#           list << [row, col]
#         end
#       end
#     end
#     list
#   end

#   def add_score((row, col))
#     num = ''
#     col.downto(0) do |left|
#       break unless grid[row][left] =~ /\d/
#       num = grid[row][left] + num
#       grid[row][left] = '.'
#     end
    
#     col.upto(len) do |right|
#       next if col == right
#       break unless grid[row][right] =~ /\d/
#       num += grid[row][right]  
#       grid[row][right] = '.'
#     end
#     @score += num.to_i
#   end

#   def get_score
#     pp score
#   end

#   def display
#     pp grid
#   end
# end


# Part 2
class Grid
  attr_accessor :grid, :len, :score, :cells
  def initialize(data)
    @grid = data.map {_1.split('')}
    @len = grid.size - 1
    @score = []
    @cells = []
  end

  def search
    grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        validate(i, j)
      end
    end
    cells.each do |cell|
      cell_score = []
      neighbors = get_neighbors(cell)
      neighbors.each do |neighbor|
        current_score = add_score(neighbor)
        cell_score << current_score if current_score > 0
      end
      @score << cell_score.inject(:*) if cell_score.size == 2
    end
  end

  def validate(i, j)
    cells << [i, j] if grid[i][j] == '*'
  end

  def get_neighbors((i, j))
    list = []
    (-1..1).each do |x|
      (-1..1).each do |y|
        row = i + x
        col = j + y
        if row.between?(0, len) && col.between?(0, len) && grid[row][col] =~ /\d/
          list << [row, col]
        end
      end
    end
    list
  end

  def add_score((row, col))
    num = ''
    col.downto(0) do |left|
      break unless grid[row][left] =~ /\d/
      num = grid[row][left] + num
      grid[row][left] = '.'
    end
    
    col.upto(len) do |right|
      next if col == right
      break unless grid[row][right] =~ /\d/
      num += grid[row][right]  
      grid[row][right] = '.'
    end
    num.to_i
  end

  def get_score
    pp score.inject(:+)
  end

  def display
    pp grid
  end
end

grid = Grid.new(data)
grid.search
grid.get_score

__END__
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..