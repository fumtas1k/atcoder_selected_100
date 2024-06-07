# -
# CHOKUDAI_S001/J
# 転倒数
# BIT/FENWICK TREE

class BIT
  attr_reader :size, :data
  def initialize(args)
    case args
    when Integer
      @size = args
      @data = Array.new(@size + 1, 0)
    when Array
      @size = args.size
      @data = [0].concat(args)
      1.upto(@size) do |i|
        up = i + (i & -i)
        next if up > @size
        @data[up] += @data[i]
      end
    end
  end

  def add(pos, value)
    idx = pos.succ
    while idx <= size
      data[idx] += value
      idx += idx & -idx
    end
  end

  def sum(l, r = nil)
    r ? _sum(r) - _sum(l) : _sum(l)
  end

  private
  def _sum(r)
    idx = r
    res = 0
    while idx > 0
      res += data[idx]
      idx -= idx & -idx
    end
    res
  end
end

N = gets.to_i
A = gets.split.map(&:to_i).map(&:pred)
bit = BIT.new(N)

ans = 0
A.each_with_index do |a, i|
  ans += bit.sum(a, N)
  bit.add(a, 1)
end

puts ans
