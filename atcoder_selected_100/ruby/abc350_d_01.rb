# -
# ABC350/D
# Union Find

require "ac-library-rb/dsu"

N, M = gets.split.map(&:to_i)
AB = Array.new(M) { gets.split.map(&:to_i).map(&:pred) }
G = Array.new(N, 0)
uf = AcLibraryRb::DSU.new(N)

AB.each do |a, b|
  G[a] += 1
  G[b] += 1
  next if uf.same?(a, b)
  uf.merge(a, b)
end

ans = N.times.sum { uf.size(_1) - 1 - G[_1] }
puts ans / 2
