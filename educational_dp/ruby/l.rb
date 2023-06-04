# L

N = gets.to_i
A = gets.split.map(&:to_i)

dp = Array.new(N) { [0] * N }
# 最後から考える（バックトラック法）
N.times { dp[_1][_1] = A[_1] * (N.odd? ? 1 : -1) }

1.upto(N - 1) do |dl|
  0.upto(N - dl - 1).each do |l|
    r = l + dl
    if (N - dl).odd?
      dp[l][r] = [dp[l][r - 1] + A[r], dp[l + 1][r] + A[l]].max
    else
      dp[l][r] = [dp[l][r - 1] - A[r], dp[l + 1][r] - A[l]].min
    end
  end
end

puts dp[0][-1]
