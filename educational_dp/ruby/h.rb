# H

M = 10 ** 9 + 7
H, W = gets.split.map(&:to_i)
A = Array.new(H) { gets.chomp.chars }

dp = Array.new(H) { [0] * W }
dp[0][0] = 1

H.times do |i|
  W.times do |j|
    [[1, 0], [0, 1]].each do |di, dj|
      ni, nj = i + di, j + dj
      next unless ni.between?(0, H - 1) && nj.between?(0, W - 1) && A[ni][nj] == "."
      dp[ni][nj] += dp[i][j]
      dp[ni][nj] %= M
    end
  end
end

puts dp[-1][-1]
