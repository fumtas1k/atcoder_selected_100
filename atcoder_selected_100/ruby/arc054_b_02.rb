# 22
# ARC054/B
# 二分探索
# 微分

P = gets.to_f

# f(x) = x + P * 2^(-x/1.5)
# f′(x) = 1 - (P ln2 / 1.5) * 2^(-x/1.5)
# 単調増加

g = -> x do
  1 - P * Math.log(2) / 1.5 * 2.pow(-x / 1.5)
end

# x = 0の時点でg.(x) >= 0 以上の場合は、x = 0 が最適解
if g.(0) >= 0
  puts P
  exit
end

l = 0.0
r = P + 1.0
while r - l > 1e-8
  m = (l + r) / 2
  g.(m) <= 0 ? l = m : r = m
end

puts l + P * 2.pow(-l / 1.5)
