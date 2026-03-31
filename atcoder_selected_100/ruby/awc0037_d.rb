# -
# AWC0037/D
# 動的計画法:その他
# 重複組み合わせ
# 逆元, フェルマーの小定理
# 二項係数

MOD = 10 ** 9 + 7

N, K = gets.split.map(&:to_i)
# K個の木と木の間隔の区画 K - 1個が最低必要
# それらを除いた N - 2K + 1個が自由に配置できる区画
# 木と木の間、K + 1 個のどこにでも N - 2K + 1 個を配置できる
# つまり、N - 2K + 1個の区画とそれを仕切る仕切りK個の合計 N - K + 1 個から、仕切りK個を選ぶことを考えれば良い

MAX = N - K + 1

if MAX - K < 0
  puts 0
  exit
end

fact = [1] * (MAX + 1)
inv_fact = [1] * (MAX + 1)
(2 .. MAX).each do |i|
  fact[i] = fact[i - 1] * i % MOD
  inv_fact[i] = inv_fact[i - 1] * i.pow(MOD - 2, MOD) % MOD
end

puts fact[N - K + 1] * inv_fact[K] % MOD * inv_fact[N - 2 * K + 1] % MOD
