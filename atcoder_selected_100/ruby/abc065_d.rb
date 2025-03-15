# 67
# ABC065/D
#　最小全域木
# クラスカル法(貪欲法 + Union Find)
# XとYを別々に考える

require "ac-library-rb/dsu"

N = gets.to_i
xs = []
ys = []

N.times do |i|
  x, y = gets.split.map(&:to_i)
  xs << [x, i]
  ys << [y, i]
end

xs.sort_by!(&:first)
ys.sort_by!(&:first)

edges = []
(N - 1).times do |i|
  edges << [xs[i + 1][0] - xs[i][0], xs[i][1], xs[i + 1][1]]
  edges << [ys[i + 1][0] - ys[i][0], ys[i][1], ys[i + 1][1]]
end

edges.sort_by!(&:first)

dsu = AcLibraryRb::DSU.new(N)

ans = 0
edges.each do |c, u, v|
  next if dsu.same?(u, v)

  dsu.merge(u, v)
  ans += c
end

puts ans
