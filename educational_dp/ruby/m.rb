# M
# 累積和

M = 10 ** 9 + 7
N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# dp[i] := 分け合う飴の数がiのときの場合の数
dp = [0] * (K + 1)
dp[0] = 1

A.each do |a|
  ep = []
  csum = [0]
  (K + 1).times do |i|
    csum[i + 1] = (csum[i] + dp[i]) % M
    ep[i] = (csum[i + 1] - csum[[i - a, 0].max]) % M
  end
  dp = ep
end

puts dp[K]
