# -
# ABC460/E
# 数学的問題
# 桁数分割
# フェルマーの小定理
# 最大公約数
# 同値関係と周期性

# concat(x, y) = x * 10 ^ d + y
# concat(x, y) ≡ x + y (mod M)
# x * 10 ^ d + y ≡ x + y (mod M)
# (10 ^ d - 1) * x ≡ 0 (mod M)

MOD = 998244353
DMAX = 19

# 10の累乗テーブルを事前に作成
p10 = Array.new(DMAX + 1, 1)
(1 .. DMAX).each do |i|
  p10[i] = p10[i - 1] * 10
end

gets.to_i.times do
  n, m = gets.split.map(&:to_i)
  ans = 0

  (1 .. DMAX).each do |d|
    l = p10[d - 1]
    r = [p10[d], n + 1].min
    break if l >= r

    # (10 ^ d - 1) * x ≡ 0 (mod M)
    # (10 ^ d - 1) と M の最大公約数を g とすると
    # (10 ^ d - 1) / g と M / g は「互いに素（共通の約数を持たない）」になるので
    # (10 ^ d - 1) / g の側は M / g を割り切る要素を一切持たない。
    # したがって、もう片方の x が M / g の要素をすべて持つ必要があり、
    # x ≡ 0 (mod M/g)
    g = (p10[d] - 1).gcd(m)
    x_cnt = (n / (m / g)) % MOD
    y_cnt = (r - l) % MOD
    ans = (ans + y_cnt * x_cnt) % MOD
  end

  puts ans
end
