# D

N, W = gets.split.map(&:to_i)
WV = Array.new(N) { gets.split.map(&:to_i) }

dp = [0] * (W + 1)

WV.each do |w, v|
  W.downto(w) do |j|
    dp[j] = [dp[j], dp[j - w] + v].max
  end
end

puts dp.max
