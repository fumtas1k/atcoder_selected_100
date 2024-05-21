# S

M = 10 ** 9 + 7
K = gets.chomp.chars.map(&:to_i)
D = gets.to_i

# dp[上からの桁数: i][Kより小さいか][i桁目までの総和をDで割った余り]
dp = Array.new(K.size + 1) { Array.new(2) { [0] * (D + 1) } }
dp[0][0][0] = 1

K.each_with_index do |k, i|
  D.times do |d|
    dp[i + 1][0][(d + k) % D] += dp[i][0][d]
    dp[i + 1][0][(d + k) % D] %= M

    10.times do |j|
      if j < k
        dp[i + 1][1][(d + j) % D] += dp[i][0][d]
      end
      dp[i + 1][1][(d + j) % D] += dp[i][1][d]
      dp[i + 1][1][(d + j) % D] %= M
    end
  end
end

# 答えに0が含まれるので除去
puts (dp[-1].sum(&:first) - 1 + M) % M
