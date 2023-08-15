# J

N = gets.to_i
A = gets.split.map(&:to_i).tally
A.default = 0

# DP[i][j][k] := 3個の皿の数i, 2個の皿の数j, 1個の皿の数k, 0個の皿の数N-i-j-kの時の操作回数の期待値
# 求める値はDP[A[3]][A[2]][A[1]]
# DP[i][j][k] = (DP[i][j][k]*(N-i-j-k)/N + DP[i-1][j+1][k]*i/N + DP[i][j-1][k+1]*j/N + DP[i][j][k-1]*k/N) + 1
# 変形すると
# DP[i][j][k] = (DP[i-1][j+1][k] + DP[i][j-1][k+1] + DP[i][j][k-1] + N) / (i+j+k)
DP = Array.new(N + 1) { Array.new(N + 1) { Array.new(N + 1) } }
DP[0][0][0] = 0.0

def dfs(i, j, k)
  return DP[i][j][k] if DP[i][j][k]
  exp = N
  exp += dfs(i - 1, j + 1, k) * i if i > 0
  exp += dfs(i, j - 1, k + 1) * j if j > 0
  exp += dfs(i, j, k - 1) * k if k > 0
  DP[i][j][k] = exp / (i + j + k)
end

puts dfs(A[3], A[2], A[1])
