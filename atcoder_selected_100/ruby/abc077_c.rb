# 20
# ABC077/C
# 二分探索

N = gets.to_i
A = gets.split.map(&:to_i).sort.reverse
B = gets.split.map(&:to_i).sort
C = gets.split.map(&:to_i).sort

ans = 0
B.each do |b|
  a_idx = A.bsearch_index { _1 < b }
  c_idx = C.bsearch_index { _1 > b }
  next unless a_idx && c_idx
  ans += (N - a_idx) * (N - c_idx)
end

puts ans
