# 19
# JOI2009HO/B
# 二分探索

D = gets.to_i
N = gets.to_i
M = gets.to_i
dist = [0] + Array.new(N - 1) { gets.to_i }.sort + [D]
K = Array.new(M) { gets.to_i }

ans = K.sum do |k|
  idx = dist.bsearch_index { _1 > k }
  [dist[idx] - k, k - dist[idx - 1]].min
end

puts ans
