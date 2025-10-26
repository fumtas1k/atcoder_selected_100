# -
# ABC429/D
# 幅優先探索
# 多始点BFS

N, M = gets.split.map(&:to_i)
edges = Array.new(N) { [] }

# dists[i]: [ノードiに到達した経路の始点, ノードiへの距離]
dists = Array.new(N) { [] }

# キュー (各要素は[start, pos, dist]の配列)
deque = []

M.times do
  u, v = gets.split.map(&:to_i).map(&:pred)
  edges[u] << v
  edges[v] << u
end

S = gets.chomp.chars

danger = []
S.each_with_index do |c, i|
  if c == 'S'
    dists[i] << [i, 0]
    deque << [i, i, 0]
  else
    danger << i
  end
end

until deque.empty?
  start, pos, dist = deque.shift

  edges[pos].each do |nxt|
    if dists[nxt].empty?
      dists[nxt] << [start, dist + 1]
      deque << [start, nxt, dist + 1]
    elsif dists[nxt].size == 1 && dists[nxt][0][0] != start
      dists[nxt] << [start, dist + 1]
      deque << [start, nxt, dist + 1]
    end
  end
end

puts danger.map { dists[_1].sum(&:last) }
