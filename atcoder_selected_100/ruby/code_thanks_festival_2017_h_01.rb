# -
# CODE_THANKS_FESTIVAL 2017/H
# 部分永続UnionFind

class DSU
  attr_accessor :parent_or_size, :last

  def initialize(n)
    @parent_or_size = Array.new(n, -1)
    @last = Array.new(n, Float::INFINITY)
  end

  def root(u, i)
    return u if last[u] > i
    root(parent_or_size[u], i)
  end
  alias leader root

  def unite(u, v, i)
    ru, rv = root(u, i), root(v, i)
    return ru if ru == rv
    ru, rv = rv, ru if -parent_or_size[ru] < -parent_or_size[rv]
    parent_or_size[ru] += parent_or_size[rv]
    parent_or_size[rv] = ru
    last[rv] = i
  end
  alias merge unite

  def same?(u, v, i) = root(u, i) == root(v, i)
end

N, M = gets.split.map(&:to_i)
dsu = DSU.new(N)
M.times do |i|
  a, b = gets.split.map(&:to_i).map(&:pred)
  dsu.unite(a, b, i + 1)
end

Q = gets.to_i
ans = Q.times.map do
  x, y = gets.split.map(&:to_i).map(&:pred)
  (1 .. M).bsearch { dsu.same?(x, y, _1) } || -1
end

puts ans
