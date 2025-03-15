# -
# 二分探索
# 式の変形
# 2次方程式

N = gets.to_i

# (x - y) ** 3 <= (x - y) * ((x - y) ** 3 + 3 * x * y) = N
# x - y = d
# (d + y) ** 3 - y ** 3 = N
# d ** 3 + 3 * d ** 2 * y + 3 * d * y ** 2 = N
# つまり単調増加

def bsearch_y(d)
  l = 1
  r = 10 ** 18
  while r - l > 1
    mid = (l + r) / 2
    3 * d * mid ** 2 + 3 * d ** 2 * mid + d ** 3 <= N ? l = mid : r = mid
  end
  (d + l) ** 3 - l ** 3 == N ? l : nil
end

1.upto(10 ** 6) do |d|
  next if N % d != 0
  y = bsearch_y(d)
  if y
    puts [d + y, y].join(" ")
    exit
  end
end

puts -1
