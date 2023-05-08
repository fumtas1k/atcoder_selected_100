# 86
# ABC075/C
# Union Find

class UnionFind
  attr_accessor :parents

  def initialize(size)
    @parents = Array.new(size, &:itself)
  end

  def root(u)
    return u if u == parents[u]
    parents[u] = root(parents[u])
  end

  def unit(u, v)
    ru, rv = root(u), root(v)
    return if ru == rv
    parents[rv] = ru
  end

  def same?(u, v)
    root(u) == root(v)
  end
end

N, M = gets.split.map(&:to_i)
AB = Array.new(M) { gets.split.map(&:to_i).map(&:pred) }

ans = M.times.count do |i|
  uf = UnionFind.new(N)
  M.times do |j|
    uf.unit(*AB[j]) unless i == j
  end
  [*1 ... N].any? { !uf.same?(_1, 0) }
end

puts ans
