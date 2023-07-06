# 55
# ABC134/E
# 動的計画法:その他
# 最長増加部分列(LIS)

N = gets.to_i
A = Array.new(N) { gets.to_i }
dp = []

A.each do |a|
  idx = dp.bsearch_index { _1 < a } || dp.size
  dp[idx] = a
end

puts dp.size
