# 71
# S8PC-1/E
# 高度なべき乗計算

M = 10 ** 9 + 7
N, Q = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
C = [0] + gets.split.map(&:to_i).map(&:pred) + [0]
dist = (N - 1).times.reduce([0]) { |acc, i| acc << (acc[-1] + A[i].pow(A[i + 1], M)) % M }

ans = 0
(Q + 1).times do |i|
  min, max = [C[i], C[i + 1]].minmax
  ans = (ans + dist[max] - dist[min]) % M
end

puts ans
