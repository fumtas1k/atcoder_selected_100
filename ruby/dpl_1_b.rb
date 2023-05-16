# 35
# DPL-1/B
# 動的計画法:ナップザックDP

N, W = gets.split.map(&:to_i)
VW = Array.new(N) { gets.split.map(&:to_i) }

dp = Array.new(N + 1) { [-1] * (W + 1) }
dp[0][0] = 0

N.times do |i|
  v, w = VW[i]
  (W + 1).times do |j|
    dp[i + 1][j] = dp[i][j]
    next if j < w || dp[i][j - w] == -1
    dp[i + 1][j] = [dp[i + 1][j], dp[i][j - w] + v].max
  end
end

puts dp[-1].max
