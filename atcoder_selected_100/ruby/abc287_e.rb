# -
# ABC287/E
# その他
# 辞書順

N = gets.to_i
# 辞書順でソートした後、隣接する文字列でLCPしたものの最大値が求めたい答えになる
S = Array.new(N) { [gets.chomp, _1] }.sort_by!(&:first)

ans = [0] * N
(N - 1).times do |i|
  s1, i1 = S[i]
  s2, i2 = S[i + 1]
  j = 0
  j += 1 while j < s1.size && j < s2.size && s1[j] == s2[j]
  ans[i1] = j if j > ans[i1]
  ans[i2] = j if j > ans[i2]
end

puts ans

