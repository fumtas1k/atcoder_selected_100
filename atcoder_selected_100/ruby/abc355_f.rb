# -
# ABC355/F
# Union Find

require "ac-library-rb/dsu"

MAX = 10
N, Q = gets.split.map(&:to_i)

# 重み毎のdsu
dsu = Array.new(MAX) { AcLibraryRb::DSU.new(N) }

# 最小全域木の重みの和が最大を初期値とする
weight = MAX * (N - 1)
ans = []
(N - 1 + Q).times do |i|
  a, b, c = gets.split.map(&:to_i)
  a -= 1
  b -= 1
  c.upto(MAX - 1) do |j|
    # 重みjでの連結を考える
    next if dsu[j].same?(a, b)
    dsu[j].merge(a, b)
    # 新たに繋がった場合その分の重みを引く
    weight -= 1
  end
  next if i < N - 1
  ans << weight
end

puts ans
