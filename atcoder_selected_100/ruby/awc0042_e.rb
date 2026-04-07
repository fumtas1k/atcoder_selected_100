# -
# AWC0042/E
# 動的計画法:その他
# スライド最大

N, K, M = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

INF_NEG = -1 << 60

prefix = A.reduce([0]) { |acc, a| acc << acc[-1] + a }

dp_work = Array.new(N + 1, INF_NEG)
dp_rest = Array.new(N + 1, INF_NEG)
dp_work[0] = 0
dp_rest[0] = 0

# [j, dp_rest[j] - prefix[j]]
deq_w = [[0, 0]]
# [j, dp_work[j]]
deq_r = [[0, 0]]

(1 .. N).each do |i|
  deq_w.shift while !deq_w.empty? && deq_w[0][0] < i - (K - 1)
  if !deq_w.empty? && deq_w[0][1] > INF_NEG
    dp_work[i] = prefix[i] + deq_w[0][1]
  end

  deq_r.shift while !deq_r.empty? && deq_r[0][0] < i - (M - 1)
  if !deq_r.empty? && deq_r[0][1] > INF_NEG
    dp_rest[i] = deq_r[0][1]
  end

  if dp_rest[i] != INF_NEG
    v = dp_rest[i] - prefix[i]
    deq_w.pop while !deq_w.empty? && deq_w[-1][1] <= v
    deq_w << [i, v]
  end

  if dp_work[i] != INF_NEG
    v = dp_work[i]
    deq_r.pop while !deq_r.empty? && deq_r[-1][1] <= v
    deq_r << [i, v]
  end
end

ans = [dp_work[N], dp_rest[N]].max
puts ans == INF_NEG ? -1 : ans

