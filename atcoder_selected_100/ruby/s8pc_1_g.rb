# 50
# S8PC-1/G
# 動的計画法:bit DP
# 巡回セールスマン問題

N, M = gets.split.map(&:to_i)

G = Array.new(N) { [] }
M.times do
  s, t, d, time = gets.split.map(&:to_i)
  G[s - 1] << [t - 1, d, time]
  G[t - 1] << [s - 1, d, time]
end

# dp[現在の建物][移動した建物のBIT] = [距離, 総数]
dp = Array.new(N) { Array.new(1 << N) { [Float::INFINITY, 0] } }
dp[0][0] = [0, 1]

(1 << N).times do |bit|
  N.times do |i|
    next if dp[i][bit].first == Float::INFINITY
    G[i].each do |j, d, time|
      next if bit[j] == 1 # すでにjを通っている場合
      dist = dp[i][bit][0] + d
      next if dist > time # 通れる時間を過ぎている場合
      next_bit = bit + (1 << j)
      case dp[j][next_bit][0] <=> dist
      when 1
        dp[j][next_bit] = [dist, dp[i][bit][1]]
      when 0
        dp[j][next_bit][1] += dp[i][bit][1]
      end
    end
  end
end

puts dp[0][-1][1].zero? ? "IMPOSSIBLE" : dp[0][-1].join(" ")
