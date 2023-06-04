# 54
# ABC006/D
# 動的計画法:その他
# 最長増加部分列(LIS)

N = gets.to_i
C = Array.new(N) { gets.to_i }

lis = []
C.each_with_index do |c, i|
  idx = lis.bsearch_index { _1 >= c } || lis.size
  lis[idx] = c
end

puts N - lis.size
