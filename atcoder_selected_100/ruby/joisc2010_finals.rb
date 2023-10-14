# 65
# JOI2010/FINALS
# 最小全域木
# 貪欲法
# Union Find
# クラスカル法

class UnionFind
  attr_accessor :parents
  def initialize(size)
    @parents = Array.new(size + 1, &:itself)
  end

  def root(u)
    return u if u == parents[u]
    parents[u] = root(parents[u])
  end

  def unite(u, v)
    ru, rv = root(u), root(v)
    return if ru == rv
    parents[ru] = rv
  end

  def same?(u, v)
    root(u) == root(v)
  end
end

N, M ,K = gets.split.map(&:to_i)
ABC = Array.new(M) { gets.split.map(&:to_i) }.sort_by(&:last)
uf = UnionFind.new(N)
ans = 0
cnt = N
ABC.each do |a, b, c|
  break if cnt == K
  next if uf.same?(a, b)
  cnt -= 1
  ans += c
  uf.unite(a, b)
end

puts ans
