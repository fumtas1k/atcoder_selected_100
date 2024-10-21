# -
# ABC361/E
# 最短経路問題
# 木の直径

require "ac-library-rb/priority_queue"

INF = 10 ** 18
N = gets.to_i
G = Array.new(N) { [] }
(N - 1).times do
  a, b, c = gets.split.map(&:to_i)
  G[a - 1] << [b - 1, c]
  G[b - 1] << [a - 1, c]
end

def dijkstra(start = 0)
  dists = [INF] * N
  dists[start] = 0
  queue = AcLibraryRb::PriorityQueue.new {|x, y| x.last < y.last }
  # queueの生成時に要素を入れると遅いので後で入れる
  queue << [start, 0]
  until queue.empty?
    pos, dist = queue.pop
    next if dists[pos] < dist
    G[pos].each do |to, d|
      next if dists[to] <= dist + d
      dists[to] = dist + d
      queue << [to, dists[to]]
    end
  end
  dists
end

start = dijkstra.map.with_index.max_by(&:first).last
puts G.flatten(1).sum(&:last) - dijkstra(start).max
