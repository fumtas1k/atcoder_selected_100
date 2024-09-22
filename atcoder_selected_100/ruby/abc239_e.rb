# -
# ABC239/E
# 深さ優先探索
# オイラーツアー
# 必要数分のみ保持

MAX_K = 20
N, Q = gets.split.map(&:to_i)
X = gets.split.map(&:to_i)
G = Array.new(N) { [] }
P = Array.new(N) { [X[_1]] }

(N - 1).times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  G[a] << b
  G[b] << a
end

def dfs(pos = 0, pre = -1)
  G[pos].each do |to|
    next if to == pre
    P[pos].concat(dfs(to, pos))
  end
  P[pos] = P[pos].max(MAX_K)
end

dfs

ans = []
Q.times do
  v, k = gets.split.map(&:to_i).map(&:pred)
  ans << P[v][k]
end

puts ans
