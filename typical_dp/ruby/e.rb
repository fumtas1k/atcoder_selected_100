# E

M = 10 ** 9 + 7
D = gets.to_i
N = gets.chomp.chars.map(&:to_i)

# dp[桁数][Nより小さいか][Dで割った余り] = 個数
dp = Array.new(N.size + 1) { Array.new(2) { [0] * D } }
dp[0][0][0] = 1
N.each_with_index do |n, i|
  D.times do |j|
    10.times do |k|
      # Nより小さい場合
      dp[i + 1][1][(j + k) % D] += dp[i][1][j]
      dp[i + 1][1][(j + k) % D] += dp[i][0][j] if k < n
      dp[i + 1][1][(j + k) % D] %= M
    end
    # Nより小さいことが確定していない場合
    dp[i + 1][0][(j + n) % D] += dp[i][0][j]
    dp[i + 1][0][(j + n) % D] %= M
  end
end

# 正整数なので0の場合を除く
puts (dp[-1].sum(&:first) + M - 1) % M
