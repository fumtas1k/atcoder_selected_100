# -
# 463/E
# 最短経路問題
# ダイクストラ法
# ワープ, 超頂点

require "ac-library-rb/priority_queue"
include AcLibraryRb

INF = 1 << 60
N, M, Y = gets.split.map(&:to_i)
# 超頂点 N, N + 1 を置き、ワープをi -> N -> N + 1 -> j という移動と考える。
# それぞれの移動時間を、 i -> N: Xi, N -> N + 1: Y, N + 1 -> j: Xj とする。
edges = Array.new(N + 2) { [] }
edges[N] << [N + 1, Y]
M.times do
  u, v, t = gets.split.map(&:to_i)
  u -= 1
  v -= 1
  edges[u] << [v, t]
  edges[v] << [u, t]
end
gets.split.map(&:to_i).each_with_index do |x, i|
  edges[i] << [N, x]
  edges[N + 1] << [i, x]
end

dists = [INF] * (N + 2)
dists[0] = 0
logs = PriorityQueue.new { |a, b| a[1] < b[1] }
logs << [0, 0]
until logs.empty?
  u, d = logs.pop
  next if dists[u] < d
  edges[u].each do |v, t|
    nd = d + t
    next if dists[v] <= nd
    dists[v] = nd
    logs << [v, nd]
  end
end

puts dists[1, N - 1].join(" ")
