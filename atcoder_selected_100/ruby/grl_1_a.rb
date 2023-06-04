# 56
# GRL-1/A
# 最短経路問題:ダイクストラ法

V, E, R = gets.split.map(&:to_i)
G = Array.new(V) { [] }
E.times do
  s, t, d = gets.split.map(&:to_i)
  G[s] << [t, d]
end

def dijukstra(start)
  dist = Array.new(V, Float::INFINITY)
  dist[start] = 0
  nex = [start]
  until nex.empty?
    from = nex.shift
    G[from].each do |to, d|
      next if dist[to] <= dist[from] + d
      dist[to] = dist[from] + d
      idx = nex.bsearch_index { |pos| dist[pos] >= dist[to] } || nex.size
      nex.insert(idx, to)
    end
  end
  dist
end

puts dijukstra(R).map { |d| d == Float::INFINITY ? "INF" : d }
