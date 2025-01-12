# -
# 二分探索
# 決め打ち二分探索

N = gets.to_i
A = gets.split.map(&:to_i)

def double?(k) = 2 * k <= N && k.times.all? { A[_1] * 2 <= A[N - k + _1] }

ok = 0
ng = N
while ng - ok > 1
  m = (ok + ng) / 2
  double?(m) ? ok = m : ng = m
end

puts ok
