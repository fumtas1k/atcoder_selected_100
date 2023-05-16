# 64
# GRL-2/A
# 最小全域木
# 貪欲法
# Union Find
# クラスカル法

class UnionFind
  attr_accessor :parents

  def initialize(size)
    @parents = Array.new(size, &:itself)
  end

  def root(u)
    return u if parents[u] == u
    parents[u] = root(parents[u])
  end

  def unite(u, v)
    ru, rv = root(u), root(v)
    return if ru == rv
    parents[rv] = ru
  end

  def same?(u, v)
    root(u) == root(v)
  end
end

V, E = gets.split.map(&:to_i)
STW = Array.new(E) { gets.split.map(&:to_i) }.sort_by { |s, t, w| w }
uf = UnionFind.new(V)
ans = 0

STW.each do |s, t, w|
  next if uf.same?(s, t)
  ans += w
  uf.unite(s, t)
end

puts ans
