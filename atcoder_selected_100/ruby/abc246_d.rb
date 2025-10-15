# -
# ABC246/D
# 全探索:全列挙
# 尺取法

# a, b <= 10^6である
MAX = 1_000_000
def f(a, b) = a ** 3 + a ** 2 * b + a * b ** 2 + b ** 3

N = gets.to_i

x = 1 << 60
i = 0
j = MAX
while i <= j
  cf = f(i, j)
  next i += 1 if cf < N
  x = [x, cf].min
  j -= 1
end

puts x

