# -
# ABC230/E
# 数学的問題
# 整数
# 反比例

N = gets.to_i

i = 1
ans = 0
while i <= N
  y = N / i
  ni = N / y + 1
  ans += y * (ni - i)
  i = ni
end

puts ans
