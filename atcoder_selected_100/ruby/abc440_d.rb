# -
# ABC440/D
# 二分探索
# 包除原理

def bsearch(ng, ok, &block)
  while (ok - ng).abs > 1
    mid = (ok + ng) / 2
    block[mid] ? ok = mid : ng = mid
  end
  ok
end

N, Q = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).sort

ans = []
Q.times do
  x, y = gets.split.map(&:to_i)

  si = (A.bsearch_index { _1 >= x } || N) - 1
  # Aに含まれる数を引くことで、含まれない数が求まる
  ti = bsearch(si, N) { (A[_1] - x + 1) - (_1 - si) >= y }
  # A.max < x の場合でも、ti - si - 1　== 0 となるので正しい答えが得られる
  ans << x + (y - 1) + (ti - si - 1)
end

puts ans
