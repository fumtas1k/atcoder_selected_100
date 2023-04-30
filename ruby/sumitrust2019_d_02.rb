N = gets.to_i
S = gets.chomp.chars.map(&:to_i)

dp = Array.new(N + 1) { [N] * 10 }

(N - 1).downto(0) do |i|
  dp[i] = dp[i + 1].clone
  10.times do |j|
    dp[i][j] = i if S[i] == j
  end
end

ans = 0
[*0 .. 9].repeated_permutation(3) do |nums|
  i = -1
  ans += 1 if nums.all? { |n| (i = dp[i + 1][n]) < N }
end

puts ans
