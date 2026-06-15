# -
# AWC0091/D
# Union Find
# 区間を連結成分で考える
# オフラインクエリ処理

INF = 1 << 60

class DSU
  attr_reader :total

  def initialize(n)
    @n = n
    @parent_or_size = [-1] * n
    @active = [false] * n
    @total = 0
  end

  def add(u)
    return if @active[u]
    @active[u] = true
    @total += 1
    merge(u - 1, u) if u > 0 && @active[u - 1]
    merge(u, u + 1) if u + 1 < @n && @active[u + 1]
  end

  private
  def root(u)
    return u if @parent_or_size[u] < 0
    @parent_or_size[u] = root(@parent_or_size[u])
  end

  def merge(u, v)
    ru, rv = root(u), root(v)
    return if ru == rv
    ru, rv = rv, ru if size(ru) < size(rv)
    @total -= calc(size(ru))
    @total -= calc(size(rv))
    @parent_or_size[ru] += @parent_or_size[rv]
    @parent_or_size[rv] = ru
    @total += calc(size(ru))
  end

  def size(u) = -@parent_or_size[root(u)]

  def calc(n) = n * (n + 1) / 2
end

N, Q, K = gets.split.map(&:to_i)
events = Array.new(N) do |i|
  a, d = gets.split.map(&:to_i)
  t = if a <= K
    0
  elsif d.zero?
    INF
  else
    (a - K + d - 1) / d
  end
  [t, i]
end.sort_by(&:first)
queries = Array.new(Q) { [gets.to_i, it] }.sort_by(&:first)

dsu = DSU.new(N)
ans = []
queries.each do |t, i|
  while !events.empty? && events[0][0] <= t
    _, j = events.shift
    dsu.add(j)
  end
  ans[i] = dsu.total
end

puts ans

