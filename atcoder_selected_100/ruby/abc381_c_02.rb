# -
# ABC381/C

N = gets.to_i
S = gets.chomp.chars

# 番兵を置く
S.unshift("$") << "$"
ans = [1]
S.each_with_index do |s, i|
  next unless s == "/"
  j = 1
  j += 1 while S[i - j] == "1" && S[i + j] == "2"
  ans << j * 2 - 1
end

puts ans.max
