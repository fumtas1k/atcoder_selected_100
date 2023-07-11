# B

A, B = gets.split.map(&:to_i)
a = gets.split.map(&:to_i)
b = gets.split.map(&:to_i)

dp = Array.new(A + 1) { [0] * (B + 1) }

(A + 1).times do |i|
  (B + 1).times do |j|
    if i > 0 && j == 0
      dp[i][j] = a[A - i] - dp[i - 1][j]
    elsif i == 0 && j > 0
      dp[i][j] = b[B - j] - dp[i][j - 1]
    elsif i > 0 && j > 0
      dp[i][j] = [a[A - i] - dp[i - 1][j], b[B - j] - dp[i][j - 1]].max
    end
  end
end

puts (dp[-1][-1] + a.sum + b.sum) / 2
