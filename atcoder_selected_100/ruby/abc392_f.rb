# -
# ABC389/F
# 動的計画法:その他
# フェニック木, Fenwick Tree, BIT
# 二分探索法
# 後ろから考える

class BIT
  attr_accessor :data, :size, :depth

  def initialize(arg)
    case arg
    when Array
      @size = arg.size
      @depth = @size.bit_length
      @data = [0].concat(arg)

      1.upto(@size) do |i|
        up = i + (i & -i)
        next if up > @size
        @data[up] += @data[i]
      end
    when Integer
      @size = arg
      @depth = 1 << n.bit_length
      @data = [0] * @size
    end
  end

  def add(pos, value)
    idx = pos + 1
    while idx <= size
      data[idx] += value
      idx += idx & -idx
    end
  end

  def sum(l, r = nil)
    r ? _sum(r) - _sum(l) : _sum(l)
  end

  def lower_bound(x)
    pos = csum = 0
    depth.downto(0) do |i|
      k = pos + (1 << i)
      next unless k <= size && csum + data[k] < x
      csum += data[k]
      pos = k
    end
    pos
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
P = gets.split.map(&:to_i)
ft = BIT.new([1] * N)

ans = []
(N - 1).downto(0) do |i|
  idx = ft.lower_bound(P[i])
  ans[idx] = i + 1
  ft.add(idx, -1)
end

puts ans.join(" ")
