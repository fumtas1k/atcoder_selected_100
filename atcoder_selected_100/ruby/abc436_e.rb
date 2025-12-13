# -
# ABC436/E
# Union Find

require "ac-library-rb/dsu"

N = gets.to_i
P = gets.split.map(&:to_i).map(&:pred)
# 無向辺グラフで考える。
# 頂点iと頂点P[i]を結ぶ辺を張る。
# 連結成分の2頂点であれば、どの組みを選んでも良い
dsu = AcLibraryRb::DSU.new(N)
P.each_with_index do |p, i|
  next if dsu.same?(i, p)
  dsu.merge(i, p)
end

ans = dsu.groups.sum do |group|
  group.size * (group.size - 1) / 2
end

puts ans

