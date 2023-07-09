# 98
# SUMITRUST2019/E
# 数学的な考察

M = 10 ** 9 + 7
N = gets.to_i
A = gets.split.map(&:to_i)

cnt = [0] * (N + 1)
# cnt[i] = i個である色の数
cnt[0] = 3

ans = 1
A.each_with_index do |a, i|
  ans = (ans * cnt[a]) % M
  cnt[a] -= 1
  cnt[a + 1] += 1
end

puts ans
