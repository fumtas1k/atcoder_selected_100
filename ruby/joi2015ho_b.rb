# 47
# JOI2015HO/B
# 動的計画法:区間DP

N = gets.to_i
A = Array.new(N) { gets.to_i }

# 残りのケーキの区間を表す区間DP
dp = Array.new(N) { [0] * N }

N.times do |di|
  N.times do |i|
    j = (i + di) % N
    if di & 1 != N & 1
      dp[i][j] = [dp[(i + 1) % N][j] + A[i], dp[i][(N + j - 1) % N] + A[j]].max
    else
      dp[i][j] = (A[i] > A[j] ? dp[(i + 1) % N][j] : dp[i][(N + j - 1) % N])
    end
  end
end

puts N.times.map { dp[_1][(N + _1 - 1) % N] }.max
