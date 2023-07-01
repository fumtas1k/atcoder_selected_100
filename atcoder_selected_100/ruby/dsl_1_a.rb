# 85
# DSL-1/A
# Union Find

class UnionFind
  attr_accessor :parents
  def initialize(size)
    @parents = Array.new(size, &:itself)
  end

  def unite(u, v)
    ru, rv = root(u), root(v)
    return if ru == rv
    parents[rv] = ru
  end

  def same?(u, v)
    root(u) == root(v)
  end

  private
  def root(u)
    return u if u == parents[u]
    parents[u] = root(parents[u])
  end
end

N, Q = gets.split.map(&:to_i)
uf = UnionFind.new(N)
Q.times do
  q, x, y = gets.split.map(&:to_i)
  case q
  when 0
    uf.unite(x, y)
  when 1
    puts uf.same?(x, y) ? 1 : 0
  end
end
