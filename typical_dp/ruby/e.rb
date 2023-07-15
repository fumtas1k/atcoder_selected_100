# E

M = 10 ** 9 + 7
D = gets.to_i
N = gets.chomp.chars.map(&:to_i)

# dp[i][Dで割った余り] iが1の場合すでにN未満
dp = Array.new(2) { [0] * D }
dp[0][0] = 1

N.each do |n|
  dp2 = Array.new(2) { [0] * D }
  D.times do |d|
    10.times do |i|
      dp2[1][(d + i) % D] += dp[1][d]
      dp2[1][(d + i) % D] += dp[0][d] if i < n
    end
    next if dp[0][d].zero?
    dp2[0][(d + n) % D] += dp[0][d]
  end
  dp = dp2.map {|row| row.map { _1 % M } }
end

# dp[0][0]の初期値を入れたのでそれを引く
puts (dp.sum(&:first) + M - 1) % M
