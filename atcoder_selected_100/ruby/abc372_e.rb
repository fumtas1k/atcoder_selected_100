# -
# ABC372/E
# Union Find
# 必要数分のみ保持

class DSU
  attr_reader :parent_or_size, :members10

  def initialize(n)
    @parent_or_size = Array.new(n, -1)
    @members10 = Array.new(n) { [_1] }
  end

  def root(u)
    return u if parent_or_size[u] < 0
    parent_or_size[u] = root(parent_or_size[u])
  end
  alias leader root

  def unite(u, v)
    ru, rv = root(u), root(v)
    return ru if ru == rv
    ru, rv = rv, ru if size(ru) < size(rv)
    members10[ru] = members10[ru].concat(members10[rv]).max(10)
    members10[rv].clear
    parent_or_size[ru] += parent_or_size[rv]
    parent_or_size[rv] = ru
  end
  alias merge unite

  def same?(u, v) = root(u) == root(v)

  def size(u)
    -parent_or_size[root(u)]
  end

  def members(u, num)
    return -1 if size(u) < num
    members10[root(u)][num - 1]
  end
end

N, Q = gets.split.map(&:to_i)
dsu = DSU.new(N + 1)
ans = []
Q.times do
  query = gets.split.map(&:to_i)
  case query
  in [1, u, v]
    dsu.unite(u, v)
  in [2, v, k]
    ans << dsu.members(v, k)
  end
end

puts ans
