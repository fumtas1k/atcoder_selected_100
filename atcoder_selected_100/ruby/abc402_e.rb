# -
# ABC402/E
# 動的計画法:期待値DP
# ビットDP

N, X = gets.split.map(&:to_i)
SCP = Array.new(N) { gets.split.map(&:to_i) }

# dp[x][bit] = x 円で 正答が　bit　の状態の時の期待値の最大値
dp = Array.new(X + 1) { Array.new(1 << N, 0) }

ans = 0
X.downto(0) do |x|
  (1 << N).times do |bit|
    N.times do |i|
      next if bit[i].zero?
      s, c, p = SCP[i]
      next if x + c > X
      dp[x][bit] = [dp[x][bit], dp[x + c][bit] * (100 - p) / 100.to_f + (dp[x + c][bit ^ (1 << i)] + s) * p / 100.to_f].max
      ans = [ans, dp[x][bit]].max
    end
  end
end

puts ans
