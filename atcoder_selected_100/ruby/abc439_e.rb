# -
# ABC439/E
# 動的計画法:その他
# 最長増加部分列(LIS)
# 変換

# どちらかが成り立つ
# ・　Ai < Aj && Bi < Bj
# ・　Ai > Aj && Bi > Bj
# Aiを昇順でソートし、Aiをi, Biをciと考えると[c1, c2, ... cn]のLISを求めることと同義
# Aiが同じ場合はBiの降順でソートしておく

N = gets.to_i
AB = Array.new(N) { gets.split.map(&:to_i) }.sort_by { [_1, -_2] }
lis = []

AB.each do |_, b|
  idx = lis.bsearch_index { _1 >= b } || lis.size
  lis[idx] = b
end

puts lis.size
