# 28
# ALDS1_11/C
# 幅優先探索

N = gets.to_i
G = []
N.times do
  u, _, *v = gets.split.map(&:to_i)
  G[u] = v
end

dist = [Float::INFINITY] * (N + 1)
dist[1] = 0
visits = [1]

until visits.empty?
  from = visits.shift
  G[from].each do |to|
    next if dist[to] <= dist[from] + 1
    dist[to] = dist[from] + 1
    visits << to
  end
end

dist[1 .. N].map { |d| d == Float::INFINITY ? -1 : d }.each_with_index { |d, i| puts [i + 1, d].join(" ")}
