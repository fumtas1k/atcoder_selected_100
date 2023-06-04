# B

N, K = gets.split.map(&:to_i)
H = gets.split.map(&:to_i)
dp = [Float::INFINITY] * N
dp[0] = 0

(N - 1).times do |i|
  (i + 1).upto([N - 1, i + K].min) do |j|
    dp[j] = [dp[j], dp[i] + (H[i] - H[j]).abs].min
  end
end

puts dp[-1]
