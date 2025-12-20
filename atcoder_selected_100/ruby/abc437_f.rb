# -
# ABC437/F
# その他
# セグメント木
# マンハッタン距離の45度回転

require "ac-library-rb/segtree"

INF = 1 << 60
N, Q = gets.split.map(&:to_i)
XY = Array.new(N) { gets.split.map(&:to_i) }
x_plus_y = []
x_minus_y = []
XY.each do |x, y|
  x_plus_y << x + y
  x_minus_y << x - y
end
st_plus_max = AcLibraryRb::Segtree.new(x_plus_y, -INF) { [_1, _2].max }
st_plus_min = AcLibraryRb::Segtree.new(x_plus_y, INF) { [_1, _2].min }
st_minus_max = AcLibraryRb::Segtree.new(x_minus_y, -INF) { [_1, _2].max }
st_minus_min = AcLibraryRb::Segtree.new(x_minus_y, INF) { [_1, _2].min }
ans = []
Q.times do
  case gets.split.map(&:to_i)
  in [1, i, x, y]
    i -= 1
    st_plus_max.set(i, x + y)
    st_plus_min.set(i, x + y)
    st_minus_max.set(i, x - y)
    st_minus_min.set(i, x - y)
  in [2, l, r, x, y]
    l -= 1
    r -= 1
    max = (st_plus_max.prod(l, r + 1) - (x + y)).abs
    max = [max, (st_plus_min.prod(l, r + 1) - (x + y)).abs].max
    max = [max, (st_minus_max.prod(l, r + 1) - (x - y)).abs].max
    max = [max, (st_minus_min.prod(l, r + 1) - (x - y)).abs].max
    ans << max
  end
end

puts ans
