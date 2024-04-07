# -
# ABC222/F
# ダイクストラ法
# 優先度付キュー
# 木の直径

require "ac-library-rb/priority_queue"

N = gets.to_i
G = Array.new(N) { [] }
(N - 1).times do
  a, b, c = gets.split.map(&:to_i)
  a -= 1
  b -= 1
  G[a] << [b, c]
  G[b] << [a, c]
end
D = gets.split.map(&:to_i)

def dijkstra(start)
  costs = [Float::INFINITY] * N
  costs[start] = 0
  log = AcLibraryRb::PriorityQueue.new([[0, start]]) {|x, y| x[0] < y[0] }
  until log.empty?
    cost, pos = log.pop
    next if costs[pos] < cost
    G[pos].each do |i, c|
      next if costs[i] <= cost + c
      costs[i] = cost + c
      log << [costs[i], i]
    end
  end
  costs
end

s = 0
t = u = -1

# 木の直径を求める
ds = dijkstra(s)
cost = -1
N.times do |i|
  next if i == s || cost >= D[i] + ds[i]
  cost = D[i] + ds[i]
  t = i
end

# 木の直径を求める
dt = dijkstra(t)
cost = -1
N.times do |i|
  next if i == t || cost >= D[i] + dt[i]
  cost = D[i] + dt[i]
  u = i
end

du = dijkstra(u)
costs = [-1] * N
N.times do |i|
  costs[i] = [costs[i], dt[i] + D[t]].max unless i == t
  costs[i] = [costs[i], du[i] + D[u]].max unless i == u
end

puts costs
