# 36
# DPL-1/B
# 動的計画法:ナップサックDP

N, W = gets.split.map(&:to_i)
VW = []
N.times do |i|
  VW << gets.split.map(&:to_i)
end
dp = [-Float::INFINITY] * (W + 1)
dp[0] = 0

N.times do |i|
  v, w = VW[i]
  (W + 1).times do |j|
    dp[j] = [dp[j], dp[j - w] + v].max if j - w >= 0
  end
end

puts dp.max
