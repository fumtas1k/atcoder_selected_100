# -
# ABC312/D
# 動的計画法
# 括弧列の成立条件

M = 998244353
S = gets.chomp.chars
N = S.size

# 括弧列の成立条件は以下の２つを満たすことと同値
# * Sのi文字目までに含まれる"("が")"の個数以上
# * Sに含まれる"("と")"の個数が等しい

# dp[i番目]["("の個数 - ")"の個数 j] = 場合の数
dp = Array.new(N + 1) { [0] * (N + 1) }
dp[0][0] = 1

1.upto(N) do |i|
  0.upto(i) do |j|
    dp[i][j] += dp[i - 1][j - 1] if j >= 1 && S[i - 1] != ")"
    dp[i][j] += dp[i - 1][j + 1] if j + 1 < N && S[i - 1] != "("
    dp[i][j] %= M
  end
end

puts dp[-1][0]
