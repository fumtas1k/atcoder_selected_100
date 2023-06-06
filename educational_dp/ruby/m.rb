# M

M = 10 ** 9 + 7
N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# 貰うDP [i番目までの子][分け合う飴の個数] = 通り数
dp = Array.new(N + 1) { [0] * (K + 1) }
dp[0][0] = 1

N.times do |i|
  # dp[i]の累積和を求める
  csum = dp[i].reduce([0]) { |acc, j| acc << acc[-1] + j }

  (K + 1).times do |j|
    dp[i + 1][j] = (csum[j + 1] - csum[[j - A[i], 0].max]) % M
  end
end

puts dp[-1][-1]
