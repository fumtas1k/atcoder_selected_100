# 40
# JOI2012YO/D
# 動的計画法:ナップサックDP



M = 10_000
N, K = gets.split.map(&:to_i)
AB = {}
K.times do
 a, b = gets.split.map(&:to_i)
 AB[a] = b - 1
end

# dp[i日目][i - 1日目のバスタ][i日目のパスタ] = 場合の数
dp = Array.new(N + 1) { Array.new(3) { [0] * 3 }}

if AB[1]
  if AB[2]
    dp[2][AB[1]][AB[2]] = 1
  else
    3.times do |i|
      dp[2][AB[1]][i] = 1
    end
  end
else
  if AB[2]
    3.times do |i|
      dp[2][i][AB[2]] = 1
    end
  else
    3.times do |i|
      3.times do |j|
        dp[2][i][j] = 1
      end
    end
  end
end

3.upto(N) do |i|
  if AB[i]
    3.times do |j|
      3.times do |k|
        next if AB[i] == j && j == k
        dp[i][j][AB[i]] += dp[i - 1][k][j]
      end
    end
  else
    3.times do |j|
      3.times do |k|
        3.times do |l|
          next if j == k && k == l
          dp[i][j][k] += dp[i - 1][l][j]
        end
      end
    end
  end
end

puts dp[-1].flatten.sum % M
