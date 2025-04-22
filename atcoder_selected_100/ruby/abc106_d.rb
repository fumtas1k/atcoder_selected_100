# 79
# ABC106/D
# 累積和:二次元

N, M, Q = gets.split.map(&:to_i)
LR = Array.new(M) { gets.split.map(&:to_i) }
PQ = Array.new(Q) { gets.split.map(&:to_i) }

# dp[l][r] は区間[l, r]を走る列車の本数
dp = Array.new(N + 1) { [0] * (N + 1) }
LR.each { dp[_1][_2] += 1 }

# dp[l][r]を区間[l, r]に完全に含まれる列車の本数にするため累積和を用いる
# dp[l][l] + dp[l][l + 1] ... + dp[l][r] + dp[l + 1][l + 1] + ... + dp[r - 1][r] + dp[r][r]
N.times do |i|
  N.times do |j|
    dp[i + 1][j + 1] += dp[i][j + 1]
    dp[i + 1][j + 1] += dp[i + 1][j]
    dp[i + 1][j + 1] -= dp[i][j]
  end
end

puts PQ.map { dp[_2][_2] - dp[_2][_1 - 1] - dp[_1 - 1][_2] + dp[_1 - 1][_1 - 1] }
