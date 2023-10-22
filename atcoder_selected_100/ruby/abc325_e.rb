# -
# ABC325/E
# ダイクストラ法
# 幅優先探索
# 二分探索法

N, A, B, C = gets.split.map(&:to_i)
D = Array.new(N) { gets.split.map(&:to_i) }

def dijukstra(start, &block)
  dist = [Float::INFINITY] * N
  dist[start] = 0
  log = [[start, 0]]
  until log.empty?
    pos, d = log.shift
    next if dist[pos] < d
    D[pos].each_with_index do |c, to|
      cost = dist[pos] + block.call(c)
      next if pos == to || dist[to] <= cost
      dist[to] = cost
      idx = log.bsearch_index { _1[1] > cost } || log.size
      log.insert(idx, [to, cost])
    end
  end
  dist
end

car = dijukstra(0) { _1 * A }
train = dijukstra(N - 1) { _1 * B + C }

ans = []
N.times do |i|
  ans << car[i] + train[i]
end

puts ans.min
