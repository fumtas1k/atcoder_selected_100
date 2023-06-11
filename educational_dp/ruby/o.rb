# O
# TLEします

M = 10 ** 9 + 7
N = gets.to_i
A = Array.new(N) { gets.split.map(&:to_i) }

dp = Array.new(N + 1) { [0] * (1 << N) }
dp[0][0] = 1

N.times do |i|
  (1 << N).times do |j|
    next if dp[i][j].zero?
    N.times do |k|
      next if j >> k & 1 == 1 || A[i][k].zero?
      dp[i + 1][j + (1 << k)] += dp[i][j]
      dp[i + 1][j + (1 << k)] %= M
    end
  end
end

puts dp[-1][-1]
