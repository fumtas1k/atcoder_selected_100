# 23
# JOI2008HO/C
# 二分探索法

require "set"

N, M = gets.split.map(&:to_i)
P = Array.new(N) { gets.to_i }.filter { _1 <= M }

point_set = Set.new([0, *P])
P.each do |i|
  P.each do |j|
    point_set << i + j if i + j <= M
  end
end

point_arr = point_set.to_a.sort.reverse

ans = []
point_arr.each do |i|
  j = point_arr.bsearch { _1 + i <= M }
  ans << i + j if j
end

puts ans.max
