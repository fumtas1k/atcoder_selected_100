# H

M = 10 ** 9 + 7
H, W = gets.split.map(&:to_i)
A = Array.new(H) { gets.chomp.chars }

dp = Array.new(H) { [0] * W }
dp[0][0] = 1

H.times do |i|
  W.times do |j|
    next if A[i][j] == "#"
    dp[i][j] += dp[i - 1][j] if i >= 1
    dp[i][j] += dp[i][j - 1] if j >= 1
    dp[i][j] %= M
  end
end

puts dp[-1][-1]
