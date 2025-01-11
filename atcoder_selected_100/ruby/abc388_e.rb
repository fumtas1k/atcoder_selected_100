# -
# 二分探索
# 決め打ち二分探索

N = gets.to_i
A = gets.split.map(&:to_i)

def double?(k) = k.times.all? { A[_1] * 2 <= A[N - k + _1] }

ok = 0
ng = N / 2 + 1
while ng - ok > 1
  m = (ok + ng) / 2
  double?(m) ? ok = m : ng = m
end

puts ok
