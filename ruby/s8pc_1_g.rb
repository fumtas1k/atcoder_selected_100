# 50
# S8PC-1/G
# 動的計画法:bit DP
# 巡回セールスマン問題

N, M = gets.split.map(&:to_i)

# [距離, 時間]
G = Array.new(N) { Array.new(N) { [Float::INFINITY, 0] } }

M.times do
  s, t, d, time = gets.split.map(&:to_i)
  G[s - 1][t - 1] = [d, time]
  G[t - 1][s - 1] = [d, time]
end

# [距離, 総数]
dp = Array.new(1 << N) { Array.new(N) { [Float::INFINITY, 0] } }
dp[0][0] = [0, 1]

(1 << N).times do |i|
  N.times do |j|
    next if dp[i][j][0] == Float::INFINITY
    N.times do |k|
      next if i >> k & 1 == 1 # すでにkを通っている場合
      dist = dp[i][j][0] + G[j][k][0] # dist == time
      next if G[j][k][1] < dist # 通れる時間を過ぎている場合
      if dp[i + (1 << k)][k][0] > dist
        dp[i + (1 << k)][k] = [dist, dp[i][j][1]]
      elsif dp[i + (1 << k)][k][0] == dist
        dp[i + (1 << k)][k][1] += dp[i][j][1]
      end
    end
  end
end

puts dp[-1][0][1].zero? ? "IMPOSSIBLE" : dp[-1][0].join(" ")
