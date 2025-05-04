require "ac-library-rb/dsu"

# サイクルグラフの条件は以下
# 1. 全ての頂点の次数が2
# 2. 連結

N, M = gets.split.map(&:to_i)
deg = [0] * N
dsu = AcLibraryRb::DSU.new(N)
M.times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  deg[a] += 1
  deg[b] += 1
  dsu.merge(a, b)
end

puts deg.any? { _1 != 2 } || dsu.size(0) != N ? "No" : "Yes"
