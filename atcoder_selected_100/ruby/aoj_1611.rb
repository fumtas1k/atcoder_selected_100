# 48
# AOJ-1611
# 動的計画法:区間DP
# ダルマ落とし
# バックトラック法

until (n = gets.to_i).zero?
  w = gets.split.map(&:to_i)
  dp = Array.new(n) { [0] * n }
  (n - 1).times do |i|
    dp[i][i + 1] = 2 if (w[i] - w[i + 1]).abs <= 1
  end

  2.upto(n - 1) do |dl|
    (n - dl).times do |l|
      r = l + dl
      if l + 1 <= r - 1 && dp[l + 1][r - 1] == r - l - 1 && (w[l] - w[r]).abs <= 1
        dp[l][r] = [dp[l][r], dp[l + 1][r - 1] + 2].max
      end
      (l ... r).each do |m|
        dp[l][r] = [dp[l][r], dp[l][m] + dp[m + 1][r]].max
      end
    end
  end
  puts dp[0][-1]
end
