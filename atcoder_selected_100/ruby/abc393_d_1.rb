# -
# ABC393/D
# 転倒数

N = gets.to_i
S = gets.chomp.chars.map(&:to_i)
total1 = S.sum

cnt1 = 0
ans = 0
S.each do |s|
  if s.zero?
    # 1の数が少ない側に寄せる
    ans += [cnt1, total1 - cnt1].min
  else
    cnt1 += 1
  end
end

puts ans
