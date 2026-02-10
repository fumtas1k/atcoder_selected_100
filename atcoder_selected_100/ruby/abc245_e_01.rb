# -
# ABC245/E
# 動的計画法:その他
# フェニック木, Fenwick Tree, BIT
# 二分探索法
# 座標圧縮

require "ac-library-rb/fenwick_tree"
include AcLibraryRb

N, M = gets.split.map(&:to_i)
# チョコレートを0, 箱を1で表現
AB = Array.new(2) { gets.split.map(&:to_i) }.transpose.map { [0, *_1] }
CD = Array.new(2) { gets.split.map(&:to_i) }.transpose.map { [1, *_1] }
ALL = (AB + CD).sort_by { [_2, _1] }.reverse

y_indexes = ALL.map { _3 }.uniq.sort.reverse.map.with_index.to_h
bit = FenwickTree.new(y_indexes.size)

ALL.each do |query|
  case query
  in [0, _, b]
    b_idx = y_indexes[b]
    sum = bit.sum(b_idx + 1)
    if sum.zero?
      puts "No"
      exit
    end
    d_idx = (-1 .. b_idx).bsearch { bit.sum(_1 + 1) >= sum }
    bit.add(d_idx, -1)
  in [1, _, d]
    bit.add(y_indexes[d], 1)
  end
end

puts "Yes"
