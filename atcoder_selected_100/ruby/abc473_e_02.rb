# -
# ABC473/E
# 累積和 mod K（区間和が K の倍数 <=> 余りが等しい）
# 区間スケジューリング（最大個数）:動的計画法

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# 累積和 mod K が等しい 2 点 (l, r) の区間和が K の倍数。
# dp[i] = 先頭 i 要素までで取れる互いに重ならない区間の最大個数。
# dp は i とともに減ることがない（dp[i] >= dp[i-1]）ので、
# 同じ余りの位置のうち「直近のもの」だけ見れば十分。
dp = [0] * (N + 1)
last = { 0 => 0 }
sum = 0
A.each.with_index(1) do |a, i|
  sum = (sum + a) % K
  dp[i] = dp[i - 1]
  j = last[sum]
  dp[i] = dp[j] + 1 if j && dp[j] + 1 > dp[i]
  last[sum] = i
end

puts dp[N]
