# -
# ABC340/E
# 動的計画法:その他
# フェニックス木
# imos法

class FenwickTree
  attr_accessor :data, :size

  # imos法を使用する場合は、配列数を1つ多くして初期化する必要がある（配列ではなく数値での初期化)
  # imos法では、値の入力は、imosメソッドで行う
  def initialize(arg)
    case arg
    when Array
      @data = [0].concat(arg)
      @size = arg.size
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
    while idx <= size
      data[idx] += value
      idx += (idx & -idx)
    end
  end

  # imos法
  # [l, r) にvalueを加算する
  # l > r の場合は、 [0, r) と [l, size -　1) にvalueを加算する
  def imos(l, r, value)
    add(l, value)
    add(r, -value)
    if l > r
      add(size - 1, -value)
      add(0, value)
    end
  end

  # 合計
  # [l, r): l .. r - 1 の合計を返す
  # l: 0 .. l - 1 の合計を返す
  def sum(l, r = nil)
    if r
      _sum(r) - _sum(l)
    else
      _sum(l)
    end
  end

  def _sum(idx)
    res = 0
    while idx > 0
      res += data[idx]
      idx &= idx - 1
    end
    res
  end
end

N, M = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
B = gets.split.map(&:to_i)

ft = FenwickTree.new(N + 1)
A.each_with_index do |a, i|
  ft.imos(i, i + 1, a)
end

B.each do |i|
  a = ft.sum(i + 1)
  next if a.zero?
  ft.imos(i, i + 1, -a)
  div, mod = a.divmod(N)
  ft.imos(0, N, div) unless div.zero?
  ft.imos((i + 1) % N, (i + mod) % N + 1, 1) unless mod.zero?
end

puts N.times.map { ft.sum(_1 + 1) }.join(" ")
