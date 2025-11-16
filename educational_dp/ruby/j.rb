# J

N = gets.to_i
A = gets.split.map(&:to_i)
tally = A.tally
tally.default = 0

# DP[i][j][k] = 残り1皿がi枚、2皿がj枚、3皿がk枚のときの操作回数の期待値
# DP[i][j][k] = (DP[i][j][k]*(N-i-j-k)/N + DP[i-1][j+1][k]*i/N + DP[i][j-1][k+1]*j/N + DP[i][j][k-1]*k/N) + 1
# 変形すると
# DP[i][j][k] = (DP[i-1][j+1][k] + DP[i][j-1][k+1] + DP[i][j][k-1] + N) / (i+j+k)
DP = Array.new(N + 1) { Array.new(N + 1) { Array.new(N + 1) } }
DP[0][0][0] = 0.0

def dfs(i, j, k)
  return DP[i][j][k] if DP[i][j][k]
  exp = N.to_f
  exp += dfs(i - 1, j, k) * i if i >= 1
  exp += dfs(i + 1, j - 1, k) * j if j >= 1
  exp += dfs(i, j + 1, k - 1) * k if k >= 1
  DP[i][j][k] = exp / (i + j + k)
end

puts dfs(tally[1], tally[2], tally[3])
