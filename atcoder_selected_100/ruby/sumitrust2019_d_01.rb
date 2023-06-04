# 6
# SUMITRUST2019/D
# 全探索:工夫して通り数を減らす全列挙

_ = gets.to_i
S = gets.chomp

ans = ("000" .. "999").count do |nums|
  i = -1
  nums.chars.all? { |num| i = S.index(num, i + 1) }
end

puts ans
