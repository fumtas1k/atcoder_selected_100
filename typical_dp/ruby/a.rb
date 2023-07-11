# A

N = gets.to_i
P = gets.split.map(&:to_i)
MAX = N * P.max

dp = [0] * (MAX + 1)
dp[0] = 1

P.each do |p|
  MAX.downto(p) do |i|
    dp[i] += dp[i - p]
  end
end

puts dp.count { _1 != 0 }
