# S

M = 10 ** 9 + 7
K = gets.chomp.chars.map(&:to_i)
D = gets.to_i
DIGIT = K.size

# dp[is_less][Dで割った余り] is_less = 1なら既にK未満
# dp[上からの桁数][is_less][Dで割った余り]ではTLEする
dp = Array.new(2) { [0] * D }
dp[0][0] = 1

# iは上から何桁目かを表す
DIGIT.times do |i|
  dp2 = Array.new(2) { [0] * D }
  D.times do |d|
    10.times do |j|
      dp2[1][(d + j) % D] += dp[1][d]
      dp2[1][(d + j) % D] += dp[0][d] if j < K[i]
    end
    dp2[0][(d + K[i]) % D] += dp[0][d]
  end
  dp = dp2.map {|row| row.map { _1 % M } }
end

# 答えに0が含まれるので除去
puts (dp.sum { _1[0] } - 1 + M) % M
