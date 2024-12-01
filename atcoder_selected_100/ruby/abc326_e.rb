# -
# ABC326/E
# 動的計画法
# 期待値DP
# 累積和

MOD = 998244353
N = gets.to_i
A = gets.split.map(&:to_i)

prob = p = N.pow(MOD - 2, MOD)
ans = 0
N.times do |i|
  ans = (ans + prob * A[i]) % MOD
  # -1、つまり初期値の確率は 1
  # (0 から i - 1までの確率の和) * p + (i の確率) * p
  # つまり、 prob + prob * p
  prob = (prob + prob * p) % MOD
end

puts ans
