# 42
# JOI2015YO/D
# 動的計画法:ナップサックDP

N, M = gets.split.map(&:to_i)
D = Array.new(N) { gets.to_i }
C = Array.new(M) { gets.to_i }

# dp[i日目][都市j] = 疲労度の最小値
dp = Array.new(M + 1) { Array.new(N + 1, Float::INFINITY) }
dp[0][0] = 0

1.upto(M) do |i|
  (N + 1).times do |j|
    # 移動しない場合
    dp[i][j] = [dp[i][j], dp[i - 1][j]].min
    # 移動する場合
    dp[i][j] = [dp[i][j], dp[i - 1][j - 1] + D[j - 1] * C[i - 1]].min if j >= 1
  end
end

puts dp.map(&:last).min
