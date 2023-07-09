# 95
# ABC149/B
# 数学的な問題

A, B, K = gets.split.map(&:to_i)

a = [A, K].min
b = [B, K - a].min

puts [A - a, B - b].join(" ")
