# -
# ABC350/E
# 動的計画法
# 期待値DP

N, A, X, Y = gets.split.map(&:to_i)

@memo = Hash.new(Float::INFINITY)
@memo[0] = 0

# dfs(n) = Y + 1 / 6 * dfs(n / 1) + 1 / 6 * dfs(n + 2) + ... + 1 / 6 * dfs(n / 6)
# -> dfs(n) = 6 / 5 * Y + 1 / 5 * dfs(n / 2) + ... + 1 / 5 * dfs(n / 6)
def dfs(n)
  return @memo[n] if @memo[n] != Float::INFINITY
  x = X + dfs(n / A)
  y = (6  * Y + (2 .. 6).sum { dfs(n / _1) }) / 5.to_r
  @memo[n] = [x, y].min
end

puts dfs(N).to_f
