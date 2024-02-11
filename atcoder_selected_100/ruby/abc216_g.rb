# -
# ABC216/G
# フェニック木
# 貪欲法

class FenwickTree
  attr_accessor :data, :size
  def initialize(arg)
    case arg
    when Array
      @size = arg.size
      @data = [0].concat(arg)
      1.upto(@size) do |i|
        up = i + (i & -i)
        next if up > @size
        @data[up] += @data[i]
      end
    when Integer
      @size = arg
      @data = [0] * (@size + 1)
    end
  end

  def add(pos, value)
    idx = pos + 1
    while idx <= @size
      data[idx] += value
      idx += idx & -idx
    end
  end

  def sum(l, r = nil)
    r ? _sum(r) - _sum(l) : _sum(l)
  end

  def _sum(idx)
    res = 0
    while idx > 0
      res += data[idx]
      idx -= idx & -idx
    end
    res
  end
end

N, M = gets.split.map(&:to_i)
LRX = Array.new(M) { gets.split.map(&:to_i) }.sort_by { _1[1] }

ft = FenwickTree.new(N)
c = 0
candidates = []

LRX.each do |l, r, x|
  n = x - ft.sum(l - 1, r)
  while c < r
    candidates << c
    c += 1
  end

  n.times do |i|
    j = candidates.pop
    ft.add(j, 1)
  end
end

puts N.times.map { ft.sum(_1, _1 + 1) }.join(" ")
