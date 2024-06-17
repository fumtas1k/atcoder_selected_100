# 25
# 1160
# 深さ優先探索

def dfs(r, c)
  @visited[r][c] = true
  ([*-1 .. 1].product([*-1 .. 1]) - [0, 0]).each do |dr, dc|
    nr, nc = r + dr, c + dc
    next unless nr.between?(0, @height - 1) && nc.between?(0, @width - 1) && @atlas[nr][nc] == 1
    next if @visited[nr][nc]
    dfs(nr, nc)
  end
end

ans = []
until (@width, @height = gets.split.map(&:to_i); [@width, @height] == [0, 0])
  @atlas = Array.new(@height) { gets.split.map(&:to_i) }
  @visited = Array.new(@height) { Array.new(@width, false) }
  ans << 0
  @height.times do |r|
    @width.times do |c|
      next if @atlas[r][c].zero? || @visited[r][c]
      dfs(r, c)
      ans[-1] += 1
    end
  end
end

puts ans
