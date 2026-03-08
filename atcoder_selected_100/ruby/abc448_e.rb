# -
# ABC448/E
# 数学的な問題
#　ダブリング

# N mod (M*10007) を求めれば、floor(N/M) mod 10007 = floor(r/M) で得られる

K, M = gets.split.map(&:to_i)
MOD = M * 10007
BIT = 30  # L[i] ≦ 10 ** 9 < 2^30 なので、30 ビットあれば十分

C = Array.new(K)
L = Array.new(K)
K.times do |i|
  C[i], L[i] = gets.split.map(&:to_i)
end

# pow_keep[d] = 10^(2^d) mod MOD
pow_keep = Array.new(BIT)
pow_keep[0] = 10 % MOD
(1...BIT).each do |d|
  pow_keep[d] = pow_keep[d - 1] * pow_keep[d - 1] % MOD
end

# rpow2[d] = R(2^d) mod MOD  (レピュニット: 1が2^d個並んだ数)
# R(2^d) = R(2^(d-1)) * 10^(2^(d-1)) + R(2^(d-1))
rpow2 = Array.new(BIT)
rpow2[0] = 1
(1...BIT).each do |d|
  rpow2[d] = (rpow2[d - 1] * pow_keep[d - 1] + rpow2[d - 1]) % MOD
end

res = 0
dgt = 0  # 現在の桁位置（右端からの累積桁数）

(K - 1).downto(0) do |i|
  # C[i] * 10^dgt * R(L[i]) を MOD 上で計算
  ce = C[i] * 10.pow(dgt, MOD) % MOD

  r = 0
  (BIT - 1).downto(0) do |d|
    next if L[i][d].zero?
    r = (r * pow_keep[d] + rpow2[d]) % MOD
  end

  res = (res + ce * r) % MOD
  dgt += L[i]
end

puts res / M
