# -
# ABC459/E
# 逆元
# フェルマーの小定理
# rが小さい場合は逐次計算
# DFS(深さ優先探索)

MOD = 998244353

N = gets.to_i
P = gets.split.map(&:to_i).map(&:pred)
P.unshift(0)
C = gets.split.map(&:to_i)
D = gets.split.map(&:to_i)
children = Array.new(N) { [] }
(1 ... N).each do |i|
  children[P[i]] << i
end

# rが小さいため逐次計算で問題ない
ncr = ->(n, r) do
  res = 1
  r.times do |i|
    res = (res * (n - i)) % MOD
    res = (res * (i + 1).pow(MOD - 2, MOD)) % MOD
  end
  res
end

remain = C.dup
ans = 1
dfs = ->(pos = 0) do
  children[pos].each do |child|
    remain[pos] += dfs.(child)
  end
  if remain[pos] < D[pos]
    puts 0
    exit
  end
  ans = ans * ncr.(remain[pos], D[pos]) % MOD
  remain[pos] -= D[pos]
end

dfs.()
puts ans
