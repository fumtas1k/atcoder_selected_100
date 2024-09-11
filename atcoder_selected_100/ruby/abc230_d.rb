# -
# 貪欲法
# 区間スケジューリング問題

N, D = gets.split.map(&:to_i)
LR = Array.new(N) { gets.split.map(&:to_i) }.sort_by(&:last)

ans = 0
j = -1
LR.each_with_index do |(l, r), i|
  next if j >= l
  j = r + D - 1
  ans += 1
end

puts ans
