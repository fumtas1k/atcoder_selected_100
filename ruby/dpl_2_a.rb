# 49
# DPL-2/A
# 動的計画法:bitDP

V, E = gets.split.map(&:to_i)
G = Array.new(V) { [Float::INFINITY ] * V }
E.times do
  s, t, d = gets.split.map(&:to_i)
  G[s][t] = d
end

dp = Array.new(1 << V) { [Float::INFINITY] * V }
dp[0][0] = 0

(1 << V).times do |i|
  V.times do |j|
    next if dp[i][j] == Float::INFINITY
    V.times do |k|
      next if i >> k & 1 == 1
      dp[i + (1 << k)][k] = [dp[i + (1 << k)][k], dp[i][j] + G[j][k]].min
    end
  end
end

puts dp[-1][0] == Float::INFINITY ? -1 : dp[-1][0]
