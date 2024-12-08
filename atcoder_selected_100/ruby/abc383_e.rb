# -
# ABC383/E
# 最小全域木
# クラスカル法(貪欲法 + Union Find)

require "ac-library-rb/dsu"

N, M, K = gets.split.map(&:to_i)
UVW = Array.new(M) { gets.split.map(&:to_i).then { [_1.pred, _2.pred, _3]} }.sort_by { _3 }
A = gets.split.map(&:to_i).map(&:pred).tally
B = gets.split.map(&:to_i).map(&:pred).tally
A.default = 0
B.default = 0

dsu = AcLibraryRb::DSU.new(N)
ans = UVW.sum do |(u, v, w)|
  next 0 if dsu.same?(u, v)
  ru, rv = dsu.leader(u), dsu.leader(v)
  dsu.merge(u, v)
  root = dsu.leader(u)
  A[root] = A[ru] + A[rv]
  B[root] = B[ru] + B[rv]
  cnt = [A[root], B[root]].min
  A[root] -= cnt
  B[root] -= cnt
  cnt * w
end

puts ans

