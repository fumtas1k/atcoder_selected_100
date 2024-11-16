# 39
# JOI2011YO/D
# 動的計画法:ナップサックDP

N = gets.to_i
A = gets.split.map(&:to_i)

dp = Array.new(N - 1) { [0] * 21 }
dp[0][A[0]] = 1

(1 .. N - 2).each do |i|
  21.times do |j|
    dp[i][j + A[i]] += dp[i - 1][j] if (j + A[i]).between?(0, 20)
    dp[i][j - A[i]] += dp[i - 1][j] if (j - A[i]).between?(0, 20)
  end
end

puts dp[-1][A[-1]]
