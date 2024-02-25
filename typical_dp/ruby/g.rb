# G
# 1問TLEする

S = gets.chomp.chars
N = S.size
K = gets.to_i

# dp[i][j] := i文字目以降について("a".ord + j).chrから始まる部分文字列の個数
dp = Array.new(N) { [0] * 26 }
row_sum = dp[N - 1][S[N - 1].ord - "a".ord] = 1

# nex[i][j] := i文字目以降で、最初に("a".ord + j).chrの文字が現れるインデックス
nex = Array.new(N) { [N] * 26 }
nex[N - 1][S[N - 1].ord - "a".ord] = N - 1

(N - 2).downto(0) do |i|
  dp[i] = dp[i + 1].dup
  j = S[i].ord - "a".ord
  # + 1 は、c文字のみの場合
  dp[i][j] = row_sum + 1
  row_sum += dp[i][j] - dp[i + 1][j]

  nex[i] = nex[i + 1].dup
  nex[i][j] = i
end

if dp[0].sum < K
  puts "Eel"
  exit
end

k = K
ans = ""
i = 0
while i < N
  j = 0
  while j < 26 && k > dp[i][j]
    k -= dp[i][j]
    j += 1
  end
  c = ("a".ord + j).chr
  ans << c
  # c文字のみ取って終了の場合を引く
  k -= 1
  break if k <= 0
  i = nex[i][j] + 1
end

puts ans
