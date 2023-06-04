# K

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# 先手が勝つ場合をtrueとする
dp = [false] * (K + 1)
(A[0] .. K).each do |i|
  A.each do |j|
    dp[i] = true if i >= j && !dp[i - j]
  end
end
puts dp[K] ? "First" : "Second"
