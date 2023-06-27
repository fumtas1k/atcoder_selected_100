# O
# TLEします

M = 10 ** 9 + 7
N = gets.to_i
A = Array.new(N) { gets.split.map(&:to_i) }

# i番目までの男性がペアになっている、 j = 2進数で1となった番号の女性はペアとなっている
# dp[i][j] = 場合の数
dp = Array.new(N + 1) { [0] * (1 << N) }
dp[0][0] = 1

(1 << N).times do |j|
  i = j.to_s(2).count("1")
  next if dp[i][j].zero?
  N.times do |k|
    next if j[k] == 1 || A[i][k].zero?
    dp[i + 1][j + (1 << k)] += dp[i][j]
  end
end

puts dp[-1][-1] % M
