# 16
# ABC150/C
# 全探索:順列全探索

N = gets.to_i
P = gets.split.map(&:to_i)
Q = gets.split.map(&:to_i)

ALL = [*1 .. N].permutation(N).to_a
puts (ALL.index(P) - ALL.index(Q)).abs
