# N

N = gets.to_i
A = gets.split.map(&:to_i)
csum = A.reduce([0]) { |acc, i| acc << acc[-1] + i }

dp = Array.new(N) { [Float::INFINITY] * N }
# 0にすることで累積和の足し算を使用できる
N.times { dp[_1][_1] = 0 }

1.upto(N - 1) do |dl|
  (N - dl).times do |l|
    r = l + dl
    l.upto(r - 1) do |m|
      dp[l][r] = [dp[l][r], dp[l][m] + dp[m + 1][r] + (csum[r + 1] - csum[l])].min
    end
  end
end

puts dp[0][-1]
