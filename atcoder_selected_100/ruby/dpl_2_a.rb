# 49
# DPL-2/A
# 動的計画法:bitDP
# 巡回セールスマン問題

V, E = gets.split.map(&:to_i)
G = Array.new(V) { [Float::INFINITY ] * V }
E.times do
  s, t, d = gets.split.map(&:to_i)
  G[s][t] = d
end

dp = Array.new(1 << V) { [Float::INFINITY] * V }
dp[0][0] = 0

(1 << V).times do |bit|
  V.times do |i|
    next if dp[bit][i] == Float::INFINITY
    V.times do |j|
      next if bit[j] == 1
      dp[bit + (1 << j)][j] = [dp[bit + (1 << j)][j], dp[bit][i] + G[i][j]].min
    end
  end
end

puts dp[-1][0] == Float::INFINITY ? -1 : dp[-1][0]
