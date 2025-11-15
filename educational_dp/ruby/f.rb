# F

S = gets.chomp.chars
T = gets.chomp.chars
dp = Array.new(S.size + 1) { [0] * (T.size + 1) }

# LCSの探索
S.each_with_index do |s, i|
  T.each_with_index do |t, j|
    dp[i + 1][j + 1] = [dp[i + 1][j], dp[i][j + 1]].max
    dp[i + 1][j + 1] = [dp[i + 1][j + 1], dp[i][j] + 1].max if s == t
  end
end

# 復元
s = S.size
t = T.size
ans = ""
while s > 0 && t > 0
  case dp[s][t]
  when dp[s - 1][t]
    s -= 1
  when dp[s][t - 1]
    t -= 1
  else dp[s - 1][t - 1]
    s -= 1
    t -= 1
    ans << S[s]
  end
end

puts ans.reverse
