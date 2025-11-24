# -
# ABC433/F
# 数学的な問題
# フェルマーの小定理
# 基準となるものを決める
# 累積和
# ヴァンデルモンドの畳み込み

MOD = 998244353
MAX = 10 ** 6
facts = [1]
inv_facts = [1]
(1 .. MAX).each do |i|
  facts << (facts[-1] * i) % MOD
  inv_facts << inv_facts[-1] * i.pow(MOD - 2, MOD) % MOD
end

S = gets.chomp.chars.map(&:to_i)
cnts = [[0] * 10]
S.each_with_index do |c, i|
  cnts[i + 1] = cnts[i].dup
  cnts[i + 1][c] += 1
end

ans = 0
S.each_with_index do |c, i|
  next if c == 9 # c+1が存在しない
  left = cnts[i][c] # iを含まない
  right = cnts[S.size][c + 1] - cnts[i + 1][c + 1]
  next if right.zero?

  # ヴァンデルモンドの畳み込みによる高速化:
  # 元の和: Σ(k=0 to min(left,right)) C(left,k) * C(right,k+1)
  #
  # この和の閉形式 (min制約込み):
  # Σ(k=0 to min(left,right)) C(left,left-k) * C(right,k+1) = C(left+right, left+1)
  ans += facts[left + right] * inv_facts[left + 1] % MOD * inv_facts[right - 1] % MOD
  ans %= MOD
end

puts ans
