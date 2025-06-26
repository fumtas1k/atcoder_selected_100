# -
# ABC230/E
# 数学的問題
# 整数

N = gets.to_i

k0 = 1
k0 += 1 while (k0 + 1) ** 2 <= N

# i = N / k0 .. N
ans = (1 .. k0).sum { (N / _1 - N / (_1 + 1)) * _1 }

# i = 1 .. N / (k0 + 1)
ans += (1 .. N / (k0 + 1)).sum { N / _1 }

puts ans
