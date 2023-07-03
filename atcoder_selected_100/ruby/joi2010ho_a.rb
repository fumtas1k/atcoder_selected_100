# 77
# JOI2010HO/A
# 累積和

MOD = 10 ** 5
N, M = gets.split.map(&:to_i)
S = Array.new(N - 1) { gets.to_i }
A = Array.new(M) { gets.to_i }
scsum = S.reduce([0]) { |acc, s| acc << acc[-1] + s }

ans = 0
k = 0
A.each do |a|
  left, right = [k, k + a].minmax
  ans += scsum[right] - scsum[left]
  k += a
end

puts ans % MOD
