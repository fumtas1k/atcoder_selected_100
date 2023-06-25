# K

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# dp[i]とはi個の石が残っている場合に先手が勝つときtrue
dp = [false] * (K + 1)
A[0].upto(K) do |i|
  A.each do |j|
    if i >= j && !dp[i - j]
      dp[i] = true
      break
    end
  end
end

puts dp[K] ? "First" : "Second"
