# C

N = gets.to_i
ABC = Array.new(N) { gets.split.map(&:to_i) }

dp = Array.new(N + 1) { [0] * 3 }

ABC.each_with_index do |happiness, i|
  happiness.each_with_index do |h, j|
    3.times do |k|
      next if j == k
      dp[i + 1][j] = [dp[i + 1][j], dp[i][k] + h].max
    end
  end
end

puts dp[N].max
