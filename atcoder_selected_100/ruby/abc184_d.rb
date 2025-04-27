# -
# ABC184/D
# 動的計画法:期待値DP

A, B, C = gets.split.map(&:to_i)
dp = Array.new(101) { Array.new(101) { [0] * 101 } }

dfs = ->(a, b, c) do
  return 0 if a == 100 || b == 100 || c == 100
  return dp[a][b][c] if dp[a][b][c] > 0
  total = (a + b + c).to_f
  dp[a][b][c] = (dfs.(a + 1, b, c) + 1) * a / total
  dp[a][b][c] += (dfs.(a, b + 1, c) + 1) * b / total
  dp[a][b][c] += (dfs.(a, b, c + 1) + 1) * c / total
end

puts dfs.(A, B, C)
