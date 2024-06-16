# -
# ABC358/E
# 動的計画法：その他
# 組み合わせ
# 逆元

M = 998244353
FACT = [1]
FACT_INV = [1]
1.upto(1000) do |i|
  FACT[i] = FACT[-1] * i % M
  FACT_INV[i] = FACT_INV[-1] * i.pow(M - 2, M) % M
end

def ncr(n, r)
  (FACT[n] * FACT_INV[n - r] % M) * FACT_INV[r] % M
end

K = gets.to_i
# 0個の英大文字は不要なので除去
C = gets.split.map(&:to_i).filter { !_1.zero? }

# dp[i:=文字種][j:=文字数] = 場合の数
dp = Array.new(C.size + 1) { Array.new(K + 1, 0) }
dp[0][0] = 1

C.size.times do |i|
  (K + 1).times do |j|
    ([C[i], K - j].min + 1).times do |k|
      # すでに置かれている文字列の配置は無視し、新たな文字種k個の配置を考える。
      # j+k個の文字列で、同じ文字k個の配置の数は j+kCk
      dp[i + 1][j + k] += dp[i][j] * ncr(j + k, k)
      dp[i + 1][j + k] %= M
    end
  end
end

# 0種0個は除去する
puts dp[-1].sum % M - 1
