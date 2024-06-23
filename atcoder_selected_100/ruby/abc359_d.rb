# -
# ABC359/D
# ビット全探索系

M = 998244353
N, K = gets.split.map(&:to_i)
S = gets.chomp.chars

# 回文判定には、K-1文字しか必要としない
# dp[i文字目][K-1文字以下の文字列] = i文字目までで「Kの連続する部分文字列が、回文であるものが存在しない」文字列の数
dp = Array.new(N + 1) { Hash.new(0) }
dp[0][""] = 1

def k_palindrome?(str) = str.size == K && str == str.reverse

S.each_with_index do |s, i|
  dp[i].each do |k, v|
    "AB".chars.each do |c|
      if [c, "?"].include?(s) && !k_palindrome?(k + c)
        nk =  k + c
        nk = nk.size == K ? nk[1..] : nk
        dp[i + 1][nk] += v
        dp[i + 1][nk] %= M
      end
    end
  end
end

puts dp[-1].values.sum % M

