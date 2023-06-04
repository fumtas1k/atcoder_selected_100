# 46
# ALDS1-10/B
# 動的計画法:区間DP

N = gets.to_i
M = Array.new(N) { gets.split.map(&:to_i) }
dp = Array.new(N) { [Float::INFINITY] * N }
N.times {|i| dp[i][i] = 0 }

# 近接部分から計算していく
(1 ... N).each do |di|
  (0 ... N - di).each do |i|
    j = i + di
    (i ... j).each do |k|
      dp[i][j] = [dp[i][j], dp[i][k] + dp[k + 1][j] + M[i][0] * M[k][1] * M[j][1]].min
    end
  end
end

puts dp[0][-1]
