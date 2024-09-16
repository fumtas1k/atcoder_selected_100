# -
# ABC217/D
# 二分探索
# セグメント木

require "ac-library-rb/segtree"

L, Q = gets.split.map(&:to_i)
CX = Array.new(Q) { gets.split.map(&:to_i) }
lengthes = CX.map(&:last).uniq.sort.map.with_index.to_h
max = AcLibraryRb::SegTree.new(Q + 1, 0) { [_1, _2].max }
min = AcLibraryRb::SegTree.new(Q + 1, L) { [_1, _2].min }

ans = []
CX.each do |c, x|
  case c
  when 1
    max.set(lengthes[x], x)
    min.set(lengthes[x], x)
  when 2
    l = max.prod(0, lengthes[x] + 1)
    r = min.prod(lengthes[x], Q + 1)
    ans << r - l
  end
end

puts ans
