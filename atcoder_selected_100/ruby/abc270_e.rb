# -
# ABC270/E
# 二分探索
# 決め打ち二分探索

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

def round(n) = A.sum { [_1, n].min }

k = (0 .. K + 1).bsearch { round(_1) >= K } - 1
remain = K - round(k)

N.times do |i|
  A[i] = [A[i] - k, 0].max
  next unless remain > 0 && A[i] > 0
  A[i] -= 1
  remain -= 1
end

puts A.join(" ")
