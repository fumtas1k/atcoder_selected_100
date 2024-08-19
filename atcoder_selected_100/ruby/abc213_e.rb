# -
# ABC213/E
# 幅優先探索
# 01-BFS

HASH, DOT = "#.".bytes
H, W = gets.split.map(&:to_i)
S = Array.new(H) { gets.chomp.bytes }

queue = [[0, 0]]
dist = Array.new(H) { Array.new(W, Float::INFINITY)}
dist[0][0] = 0
visited = Array.new(H) { Array.new(W, false) }

until queue.empty?
  r, c = queue.shift
  next if visited[r][c]
  visited[r][c] = true
  # 破壊無し(0)
  [[r + 1, c], [r - 1, c], [r, c + 1], [r, c - 1]].each do |nr, nc|
    next unless nr.between?(0, H - 1) && nc.between?(0, W - 1) && S[nr][nc] == DOT
    next if dist[nr][nc] <= dist[r][c]
    dist[nr][nc] = dist[r][c]
    queue.unshift([nr, nc])
  end
  # 破壊あり(1)
  (-2 .. 2).each do |dr|
    (-2 .. 2).each do |dc|
      next if dr.abs + dc.abs > 3
      nr, nc = r + dr, c + dc
      next unless nr.between?(0, H - 1) && nc.between?(0, W - 1)
      next if dist[nr][nc] <= dist[r][c] + 1
      dist[nr][nc] = dist[r][c] + 1
      queue << [nr, nc]
    end
  end
end

puts dist[-1][-1]
