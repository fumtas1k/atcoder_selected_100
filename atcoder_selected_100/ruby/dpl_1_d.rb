# 53
# DPL-1/D
# 動的計画法:その他
# 最長増加部分列(LIS)

N = gets.to_i
A = Array.new(N) { gets.to_i }
lis = []
A.each do |a|
  idx = lis.bsearch_index { |i| i >= a } || lis.size
  lis[idx] = a
end

puts lis.size
