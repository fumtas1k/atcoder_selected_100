# G
# トポロジカルソート

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
# 有効辺の向けられた数
arrows = [0] * N

M.times do
  x, y = gets.split.map(&:to_i).map(&:pred)
  G[x] << y
  arrows[y] += 1
end

# 有効辺の向けられた数が0なのは始点となるもの
next_candicates = N.times.filter { arrows[_1].zero? }

depth = [0] * N
until next_candicates.empty?
  pos = next_candicates.shift
  G[pos].each do |i|
    arrows[i] -= 1
    next_candicates << i if arrows[i].zero?
    depth[i] = [depth[i], depth[pos] + 1].max
  end
end

puts depth.max
