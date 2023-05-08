# 87
# ABC120/D
# Union Find

class UnionFind
  attr_accessor :parents, :cnts

  def initialize(size)
    @parents = Array.new(size, &:itself)
    @cnts = Array.new(size, 1)
  end

  def root(u)
    return u if u == parents[u]
    parents[u] = root(parents[u])
  end

  def unit(u, v)
    ru, rv = root(u), root(v)
    return 0 if ru == rv
    comb = cnts[ru] * cnts[rv]
    parents[rv] = ru
    cnts[ru] += cnts[rv]
    comb
  end

  def same?(u, v)
    root(u) == root(v)
  end
end

N, M = gets.split.map(&:to_i)
AB = Array.new(M) { gets.split.map(&:to_i).map(&:pred) }

uf = UnionFind.new(N)

ans = []
exclude_comb = 0
AB.each_with_index.reverse_each do |(a, b), i|
  ans[i] = N * (N - 1) / 2 - exclude_comb
  exclude_comb += uf.unit(a, b)
end

puts ans
