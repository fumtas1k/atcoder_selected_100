# 18
# ALDS1-4/B
# 二分探索

N = gets.to_i
S = gets.split.map(&:to_i).sort
Q = gets.to_i
T = gets.split.map(&:to_i).sort

ans = T.count do |t|
  i = S.bsearch_index {|s| s >= t }
  i && S[i] == t
end

puts ans
