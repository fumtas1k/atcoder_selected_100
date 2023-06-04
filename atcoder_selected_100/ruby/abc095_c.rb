# 5
# ABC095/C
# 全探索:工夫して通り数を減らす全列挙

A, B, C, X, Y = gets.split.map(&:to_i)

ans = []

(2 * [X, Y].max + 1).times do |c|
  a = [X -  c / 2, 0].max
  b = [Y -  c / 2, 0].max
  ans << a  * A + b * B + c * C
end

puts ans.min
