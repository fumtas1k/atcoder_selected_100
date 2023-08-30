# 3
# ABC122/B
# 全探索:全列挙
# 尺取法

require "set"

ACGT = "ACGT".chars.to_set
S = gets.chomp.chars

l = r = 0
ans = []
while (l < S.size)
  while r < S.size && ACGT.include?(S[r])
    r += 1
  end
  ans << r - l
  r += 1
  l = r
end

puts ans.max
