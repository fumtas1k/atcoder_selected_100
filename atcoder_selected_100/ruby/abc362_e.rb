# -
# ABC362/E
# 動的計画法
# 等差数列の個数を数える問題

M = 998244353
N = gets.to_i
A = gets.split.map(&:to_i)

# DP[i][l][d] = 初項 Ai 公差 d となる長さ l の等差数列の個数
DP = Array.new(N) { Array.new(N + 1) { Hash.new(0) } }

(N - 1).downto(0) do |i|
  DP[i][1][0] = 1
  2.upto(N - i) do |l|
    (N - 1).downto(i + 1) do |j|
      d = A[j] - A[i]
      case l
      when 2
        DP[i][l][d] += 1
      else
        DP[i][l][d] += DP[j][l - 1][d]
        DP[i][l][d] %= M
      end
    end
  end
end

ans = Array.new(N + 1, 0)

N.times do |i|
  1.upto(N) do |l|
    ans[l] += DP[i][l].values.sum % M
    ans[l] %= M
  end
end

puts ans[1, N].join(" ")
