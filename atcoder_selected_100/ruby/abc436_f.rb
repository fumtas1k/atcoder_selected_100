# -
# ABC436/F
# 動的計画法:その他
# フェニック木, Fenwick Tree, BIT,
# 真ん中を固定する

require "ac-library-rb/fenwick_tree"

N = gets.to_i
B = gets.split.map(&:to_i).map(&:pred)

bit = AcLibraryRb::FenwickTree.new(N)

ans = B.sum do |b|
  # bを固定して考える
  # 左側のbより明るい星の数
  left = bit.sum(0, b)
  # 右側のbより明るい星の数(重複がないので、合計でbになる)
  right = b - left
  bit.add(b, 1)
  (left + 1) * (right + 1)
end

puts ans
