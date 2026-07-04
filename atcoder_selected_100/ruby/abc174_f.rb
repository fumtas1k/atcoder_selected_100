# -
# ABC174/F
# 動的計画法:その他
# フェニック木
# Fenwick Tree
# BIT
# クエリ先読み

require "ac-library-rb/fenwick_tree"
include AcLibraryRb

N, Q = gets.split.map(&:to_i)
C = gets.split.map(&:to_i).map(&:pred)
LR = Array.new(Q) { [it, *gets.split.map(&:to_i).map(&:pred)] }.sort_by!(&:last)
bit = FenwickTree.new([0] * N)
last = Array.new(N)

ans = []
C.each_with_index do |c, i|
  bit.add(i, 1)
  bit.add(last[c], -1) if last[c]
  last[c] = i
  while !LR.empty? && LR[0][2] == i
    j, l, r = LR.shift
    ans[j] = bit.sum(l, r + 1)
  end
end

puts ans