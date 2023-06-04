# F

S = gets.chomp.chars
T = gets.chomp.chars

dp = Array.new(S.size + 1) { [0] * (T.size + 1) }

# LCSの探索
S.size.times do |i|
  T.size.times do |j|
    dp[i + 1][j + 1] = [dp[i + 1][j], dp[i][j + 1]].max
    dp[i + 1][j + 1] = [dp[i + 1][j + 1], dp[i][j] + 1].max if S[i] == T[j]
  end
end

# 復元
i = S.size
j = T.size
ans = ""
while i > 0 && j > 0
  if dp[i][j] == dp[i - 1][j]
    i -= 1
  elsif dp[i][j] == dp[i][j - 1]
    j -= 1
  elsif dp[i][j] == dp[i - 1][j - 1] + 1
    i -= 1
    j -= 1
    ans += S[i]
  else
    # ここには来ないはず
  end
end

puts ans.reverse
