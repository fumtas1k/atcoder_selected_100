# -
# CODE_THANKS_FESTIVAL 2017/H
# Union Find
# 並列二分探索

class DSU
  attr_accessor :parent_or_size

  def initialize(n)
    @parent_or_size = [-1] * n
  end

  def root(u)
    return u if parent_or_size[u] < 0
    parent_or_size[u] = root(parent_or_size[u])
  end
  alias leader root

  def unite(u, v)
    ru, rv = root(u), root(v)
    return ru if ru == rv
    ru, rv = rv, ru if -parent_or_size[ru] < -parent_or_size[rv]
    parent_or_size[ru] += parent_or_size[rv]
    parent_or_size[rv] = ru
  end
  alias merge unite

  def same?(u, v) = root(u) == root(v)
end

N, M = gets.split.map(&:to_i)
AB = Array.new(M) { gets.split.map(&:to_i).map(&:pred) }
Q = gets.to_i
XY = Array.new(Q) { gets.split.map(&:to_i).map(&:pred) }

ok = [M] * Q
ng = [-1] * Q
loop do
  finish = true
  mid_idx = Array.new(M) { [] }
  Q.times do |i|
    next if ok[i] - ng[i] == 1
    finish = false
    mid_idx[(ok[i] + ng[i]) / 2] << i
  end

  break if finish

  dsu = DSU.new(N)
  M.times do |i|
    dsu.merge(*AB[i])
    mid_idx[i].each do |j|
      dsu.same?(*XY[j]) ? ok[j] = i : ng[j] = i
    end
  end
end

puts ok.map { _1 == M ? -1 : _1.succ }.join("\n")
