# ABC122/B
# 全探索：全列挙
# 尺取法

S = gets.chomp.chars
ACGT = "ACGT".chars

l = r = 0
ans = [0]
S.size.times do |l|
  r = [l, r].max
  next unless ACGT.include?(S[l])
  while r < S.size && ACGT.include?(S[r])
    r += 1
  end
  ans << r - l
end

puts ans.max
