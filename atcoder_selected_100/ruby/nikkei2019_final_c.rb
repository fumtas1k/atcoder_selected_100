# -
# NIKKEI2019_FINAL/C
# 二分探索
# マンハッタン距離の総和を最小値は、中央値を使う

H, W, K = gets.split.map(&:to_i)
R = Array.new(H, W)
C = Array.new(W, H)
K.times do |k|
  r, c = gets.split.map(&:to_i).map(&:pred)
  R[r] -= 1
  C[c] -= 1
end

r_csum = R.reduce([0]) {|acc, i| acc << acc[-1] + i }
c_csum = C.reduce([0]) {|acc, i| acc << acc[-1] + i }

r_median = (r_csum.bsearch_index { _1 >= (r_csum[-1] + 1) / 2 } || H) - 1
c_median = (c_csum.bsearch_index { _1 >= (c_csum[-1] + 1) / 2 } || W) - 1

puts R.map.with_index {|n, r| (r - r_median).abs * n }.sum +
      C.map.with_index {|n, c| (c - c_median).abs * n }.sum
