# -
# ABC361/E
# 最短経路問題
# ダイクストラ法

require "ac-library-rb/priority_queue"

INF = 10 ** 18

N, M, X = gets.split.map(&:to_i)
edges = Array.new(2 * N) { [] }
M.times do
  u, v = gets.split.map(&:to_i).map(&:pred)
  edges[u] << [v, 1]
  # 逆方向をv -> u を N + v -> N + u として追加
  edges[N + v] << [N + u, 1]
end
N.times do |u|
  # フリップするとコストが X かかる
  edges[u] << [u + N, X]
  edges[u + N] << [u, X]
end

costs = Array.new(2 * N, INF)
# [pos, cost]
log = AcLibraryRb::PriorityQueue.new { |x, y| x.last < y.last }

log << [0, 0]
costs[0] = 0
until log.empty?
  pos, cost = log.pop
  next if costs[pos] < cost
  if pos == N - 1 || pos == 2 * N - 1
    puts cost
    exit
  end

  edges[pos].each do |to, c|
    next if costs[to] <= cost + c
    costs[to] = cost + c
    log << [to, cost + c]
  end
end
