# -
# 貪欲法
# 区間スケジューリング問題

N, D = gets.chomp.split.map(&:to_i)
LR = Array.new(N) { gets.split.map(&:to_i) }.sort_by(&:last)

ans = j = 0
LR.each do |l, r|
  next if l <= j
  j = r + D - 1
  ans += 1
end

puts ans
