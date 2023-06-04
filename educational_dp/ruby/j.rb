# J

N = gets.to_i
A = gets.chomp.split.map(&:to_i).tally
A.default = 0

three = A[3] + 1
two = three + A[2]
one = two + A[1]

DP = Array.new(three) { Array.new(two) { Array.new(one) } }
DP[0][0][0] = 0.0

# i: 3個の皿の数, j: 2個の皿の数, k: 1個の皿の数
def dfs(i, j, k)
  return DP[i][j][k] if DP[i][j][k]
  exp = N
  exp += dfs(i - 1, j + 1, k) * i if i > 0
  exp += dfs(i, j - 1, k + 1) * j if j > 0
  exp += dfs(i, j, k - 1) * k if k > 0
  DP[i][j][k] = exp / (i + j + k)
end

puts dfs(A[3], A[2], A[1])
