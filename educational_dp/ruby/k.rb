# K
# ゲーム必勝法

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).sort

# dp[i]とはi個の石が残っている場合に先手が勝つときtrue
dp = [false] * (K + 1)

(K + 1).times do |i|
  A.each do |j|
    break if i < j || dp[i]
    dp[i] |= !dp[i - j]
  end
end

puts dp[K] ? "First" : "Second"
