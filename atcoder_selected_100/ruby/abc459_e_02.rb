# -
# ABC459/E
# 逆元
# フェルマーの小定理
# rが小さい場合は逐次計算
# トポロジカルソート
# 幅優先探索

MOD = 998244353

N = gets.to_i
P = gets.split.map(&:to_i).map(&:pred)
P.unshift(0)
C = gets.split.map(&:to_i)
D = gets.split.map(&:to_i)
children = Array.new(N) { [] }
cnts = [0] * N
(1 ... N).each do |i|
  p = P[i]
  children[p] << i
  cnts[p] += 1
end

ncr = ->(n, r) do
  res = 1
  r.times do |i|
    res = (res * (n - i)) % MOD
    res = (res * (i + 1).pow(MOD - 2, MOD)) % MOD
  end
  res
end

candidates = N.times.filter { cnts[it].zero? }
ans = 1
remain = [0] * N
until candidates.empty?
  pos = candidates.shift
  remain[pos] += C[pos]
  if remain[pos] < D[pos]
    puts 0
    exit
  end

  ans = (ans * ncr.(remain[pos], D[pos])) % MOD
  remain[pos] -= D[pos]
  remain[P[pos]] += remain[pos]
  cnts[P[pos]] -= 1
  candidates << P[pos] if cnts[P[pos]].zero?
end

puts ans
