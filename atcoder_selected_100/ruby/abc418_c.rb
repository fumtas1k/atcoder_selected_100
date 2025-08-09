# -
# ABC418/C
# 累積和
# 面積

N, Q = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

maxv = 1_000_001
# acsum[i] = ティーバッグが i　個以下のときのティーバッグの総数
acsum = Array.new(maxv + 1, 0)
# cntcsum[i] = ティーバッグが i 個以下のときのフレーバーの総数
cntcsum = Array.new(maxv + 1, 0)

A.each do |a|
  acsum[a] += a
  cntcsum[a] += 1
end

maxv.times do |i|
  acsum[i + 1] += acsum[i]
  cntcsum[i + 1] += cntcsum[i]
end

ans = Q.times.map do
  b = gets.to_i
  next -1 if cntcsum[b - 1] == N
  # [A[i], b - 1].min の合計 + 1 が答え
  acsum[b - 1] + (N - cntcsum[b - 1]) * (b - 1) + 1
end

puts ans
