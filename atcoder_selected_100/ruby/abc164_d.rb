# -
# ABC164/D
# 数学的な問題
# 累積和
# 互いに素
# 剰余

# GCD(10, 2019) = 1(互いに素)
# T4 = (a0 + a1 * 10 + a2 * 100 + a3 * 1000 + a4 * 10000)
# ((T4 - T1) / 10) % 2019 = 0 -> つまり T4 % 2019 = T1 % 2019 となるものの組み合わせを数える
# ただし、Tk % 2019 = 0 の場合も数える必要がある

MOD = 2019
S = gets.chomp.chars.map(&:to_i).reverse

csum = [0]
base = 1
S.each do |c|
  csum << (csum[-1] + c * base) % MOD
  base = (base * 10) % MOD
end
csum.shift

ans = 0
csum.tally.each do |k, v|
  ans += v if k.zero?
  next if v <= 1
  ans += v * (v - 1) / 2
end

puts ans
