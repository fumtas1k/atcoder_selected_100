# 57
# JOI2008YO/F
# 最短経路問題:ダイクストラ法

N, K = gets.split.map(&:to_i)
QUERY = Array.new(K) { gets.split.map(&:to_i) }
G = Array.new(N + 1) { [] }

def dijkstra(start, goal)
  dp = [Float::INFINITY] * (N + 1)
  dp[start] = 0
  deque = [start]
  until deque.empty?
    pos = deque.shift
    G[pos].each do |to, fare|
      next if dp[to] <= dp[pos] + fare
      dp[to] = dp[pos] + fare
      idx = deque.bsearch_index { dp[_1] >= dp[to] } || deque.size
      deque.insert(idx, to)
    end
  end
  dp[goal] == Float::INFINITY ? -1 : dp[goal]
end

QUERY.each do |query|
  case query[0]
  when 0
    puts dijkstra(*query[1..])
  when 1
    c, d, e = query[1..]
    G[c] << [d, e]
    G[d] << [c, e]
  end
end
