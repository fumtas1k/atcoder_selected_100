# -
# ABC355/D
# 尺取法
# 余事象

N = gets.to_i
L, R = Array.new(N) { gets.split.map(&:to_i).map(&:pred) }.transpose.map(&:sort)

ans = N * (N - 1) / 2
j = 0
N.times do |i|
  j += 1 while R[j] < L[i]
  ans -= j
end

puts ans
