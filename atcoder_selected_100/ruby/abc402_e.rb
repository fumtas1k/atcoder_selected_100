# -
# ABC402/E
# 動的計画法:期待値DP
# ビットDP

N, X = gets.split.map(&:to_i)
SCP = Array.new(N) { gets.split.map(&:to_i) }

# dp[x][bit] = x円払って 正解が bit の状態の場合の最大期待値
dp = Array.new(X + 1) { Array.new(1 << N, 0) }

(X + 1).times do |x|
  (1 << N).times do |bit|
    N.times do |i|
      next if bit[i] == 1
      s, c, p = SCP[i]
      next if x - c < 0
      dp[x][bit] = [dp[x][bit], dp[x - c][bit] * (100 - p) / 100.to_f + (dp[x - c][bit | (1 << i)] + s) * p / 100.to_f].max
    end
  end
end

puts dp[X].max
