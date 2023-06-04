# A

N = gets.to_i
H = gets.split.map(&:to_i)
dp = [Float::INFINITY] * N
dp[0] = 0

(N - 1).times do |i|
  (1 .. 2).each do |di|
    next if i + di >= N
    dp[i + di] = [dp[i + di], dp[i] + (H[i] - H[i + di]).abs].min
  end
end

puts dp[-1]
