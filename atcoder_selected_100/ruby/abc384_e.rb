# -
# 優先度付きキュー

require "ac-library-rb/priority_queue"

H, W, X = gets.split.map(&:to_i)
P, Q = gets.split.map(&:to_i).map(&:pred)
S = Array.new(H) { gets.split.map(&:to_i) }

queue = AcLibraryRb::PriorityQueue.new { |x, y| x[0] < y[0] }
queue << [0, P, Q] # break条件の関係上, sizeを0とし、sの代わりにansに加算しておく
ans = S[P][Q]
visited = Array.new(H) { Array.new(W, false) }
visited[P][Q] = true


until queue.empty?
  size, r, c = queue.pop
  break if size >= ans / X.to_r
  ans += size
  [[r + 1, c], [r - 1, c], [r, c + 1], [r, c - 1]].each do |nr, nc|
    next unless nr.between?(0, H - 1) && nc.between?(0, W - 1)
    next if visited[nr][nc]
    visited[nr][nc] = true
    queue << [S[nr][nc], nr, nc]
  end
end

puts ans
