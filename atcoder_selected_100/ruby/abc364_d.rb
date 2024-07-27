# -
# ABC364/E
# 二分探索

N, Q = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).sort
BK = Array.new(Q) { gets.split.map(&:to_i) }

def calc_size(d, b)
  # 配列のbsearch_indexを使うとTLEする
  # また、以下の二分探索の条件をprocとして受け取るメソッドに切り出して共通化して使用してもTLEする
  l = -1
  r = N
  while r - l > 1
    mid = (r + l) / 2
    A[mid] > b + d ? r = mid : l = mid
  end
  ub = r
  l = -1
  r = N
  while r - l > 1
    mid = (r + l) / 2
    A[mid] >= b - d ? r = mid : l = mid
  end
  lb = r
  ub - lb
end

ans = []
BK.each do |b, k|
  l = -1
  r = 10 ** 9
  while r - l > 1
    mid = (r + l) / 2
    calc_size(mid, b) >= k ? r = mid : l = mid
  end
  ans << r
end

puts ans
