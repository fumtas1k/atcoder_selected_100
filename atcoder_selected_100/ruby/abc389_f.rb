# -
# ABC389/F
# 動的計画法:その他
# フェニック木, Fenwick Tree, BIT
# 事前計算

require "ac-library-rb/fenwick_tree"

MAX = 5 * 10 ** 5
N = gets.to_i
LR = Array.new(N) { gets.split.map(&:to_i) }
ft = AcLibraryRb::FenwickTree.new(MAX + 1)
MAX.times { ft.add(_1 + 1, 1) }

LR.each do |l, r|
  left = (1 .. MAX).bsearch { ft.sum(_1 + 1) >= l }
  right = (1 .. MAX).bsearch { ft.sum(_1 + 1) > r }
  ft.add(left, 1)
  ft.add(right, -1) if right
end

ans = gets.to_i.times.map do
  ft.sum(gets.to_i + 1)
end

puts ans
