# H

MOD = 10 ** 9 + 7
HASH, DOT = "#.".bytes
H, W = gets.split.map(&:to_i)
A = Array.new(H) { gets.chomp.bytes }
dp = Array.new(H) { [0] * W }
dp[0][0] = 1

H.times do |r|
  W.times do |c|
    next if dp[r][c].zero? || A[r][c] == HASH
    [[1, 0], [0, 1]].each do |dr, dc|
      nr, nc = r + dr, c + dc
      next unless nr <= H && nc < W && A[nr][nc] == DOT
      dp[nr][nc] = (dp[nr][nc] + dp[r][c]) % MOD
    end
  end
end

puts dp[-1][-1]
