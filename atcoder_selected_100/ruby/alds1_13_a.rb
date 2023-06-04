# 17
# ALDS1_13/A
# 全探索:順列全探索
# バックトラック法

class Queen
  attr_accessor :board, :size, :absolute

  def initialize(size)
    @size = size
    @board = Array.new(size) { [false] * size }
    @absolute = Array.new(size) { [false] * size }
  end

  def add(row, col, is_absolute = false)
    absolute[row][col] = true if is_absolute
    board[row][col] = can_place?(row, col)
  end

  def can_place?(row, col)
    return true if board[row][col]
    size.times do |i|
      return false if @board[row][i] || @board[i][col]
      [[1, 1], [1, -1], [-1, 1], [-1, -1]].each do |dr, dc|
        nr, nc = row + i * dr, col + i * dc
        return false if nr.between?(0, size - 1) && nc.between?(0, size - 1) && board[nr][nc]
      end
    end
    true
  end

  def solve?(row = 0, count = 0)
    return false unless row.between?(0, size - 1)
    return true if count == size
    size.times do |col|
      if can_place?(row, col)
        board[row][col] = true
        return true if solve?((row + 1) % size, count + 1)
        return false if absolute[row][col]
        board[row][col] = false
      end
    end
    false
  end

  def to_s
    board.map { |row| row.map { |col| col ? "Q" : "." }.join }.join("\n")
  end
end


K = gets.to_i
RC = Array.new(K) { gets.split.map(&:to_i) }

8.times do |i|
  queen = Queen.new(8)
  RC.each {|r, c| queen.add(r, c, true) }
  next unless queen.solve?(i)
  puts queen.to_s
  exit
end
