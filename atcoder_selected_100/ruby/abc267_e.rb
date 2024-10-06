# -
# ABC267/E
# 決め打ち二分探索
# 最小値の最大化

MAX = 2 * 10 ** 5 * 10 ** 9

N, M = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
G = Array.new(N) { [] }
COSTS = [0] * N
M.times do
  u, v = gets.split.map(&:to_i).map(&:pred)
  G[u] << v
  G[v] << u
  COSTS[u] += A[v]
  COSTS[v] += A[u]
end

def judge(cost)
  costs = COSTS.dup
  deleted = [false] * N
  queue = []
  costs.each_with_index do |c, i|
    next if c > cost
    deleted[i] = true
    queue << i
  end

  cnt = 0
  until queue.empty?
    pos = queue.shift
    cnt += 1
    G[pos].each do |to|
      costs[to] -= A[pos]
      next if deleted[to] || costs[to] > cost
      deleted[to] = true
      queue << to
    end
  end
  cnt == N
end

puts (-1 .. MAX).bsearch { judge(_1) }
