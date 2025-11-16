# L
# 区間DP
# バックトラック法

N = gets.to_i
A = gets.split.map(&:to_i)

# 最後から考える（バックトラック法）
# dp[左端][右端] = (左端から右端までが残っている時の最適な) X - Y
# 最後:偶数なら太郎君のターン
dp = Array.new(N) { Array.new(N) }
N.times { dp[_1][_1] = (N - 1).even? ? A[_1] : -A[_1] }

(1 ... N).each do |dl|
  (0 ... N - dl).each do |l|
    r = l + dl
    dp[l][r] = if dl % 2 == (N - 1) % 2
      [dp[l + 1][r] + A[l], dp[l][r - 1] + A[r]].max
    else
      [dp[l + 1][r] - A[l], dp[l][r - 1] - A[r]].min
    end
  end
end

puts dp[0][N - 1]
