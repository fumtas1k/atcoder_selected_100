# -
# ABC214/D
# Union-Find
# 主客転倒

require "ac-library-rb/dsu"

N = gets.to_i
UVW = Array.new(N - 1) { gets.split.map(&:to_i) }
dsu = AcLibraryRb::DSU.new(N)

# 主客転倒
# 重みの小さい順に辺を追加していく
# 小さい順に辺を追加していくと、その辺により連結された時の最大値はその辺の重みとなる
ans = UVW.sort_by(&:last).sum do |u, v, w|
  u -= 1
  v -= 1
  (dsu.size(u) * dsu.size(v) * w).tap { dsu.merge(u, v) }
end

puts ans
