# -
# ABC326/E
# 動的計画法
# 期待値DP
# 累積和

MOD = 998244353
N = gets.to_i
A = gets.split.map(&:to_i)
P = N.pow(MOD - 2, MOD)

# x = i + 1 から始めた場合の期待値を計算する
# 最後に得られるのは、 x = 0
sum = 0
(N - 1).downto(0) do |i|
  sum += (sum + A[i]) * P % MOD
  sum %= MOD
end

puts sum
