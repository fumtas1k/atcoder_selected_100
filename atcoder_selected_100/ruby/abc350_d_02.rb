# -
# ABC350/D
# DFS

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  G[a] << b
  G[b] << a
end

@visited = [false] * N
# 連結成分数を返す
def dfs(pos)
  return 0 if @visited[pos]
  @visited[pos] = true
  cnt = 1
  G[pos].each do |i|
    cnt += dfs(i)
  end
  cnt
end

# すでにある辺の数を引いておく
ans = - M
N.times do |i|
  cnt = dfs(i)
  # 連結成分の組み合わせ(辺)の数
  ans += cnt * (cnt - 1) / 2
end

puts ans
