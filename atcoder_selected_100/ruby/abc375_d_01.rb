# -
# ABC375/D
# 累積和
# 3つ組は真ん中固定

S = gets.chomp.chars
lcnt = Array.new(26, 0)
rcnt = Array.new(26, 0)
S.each { rcnt[_1.ord - "A".ord] += 1 }

ans = 0
S.each do |c|
  ord = c.ord - "A".ord
  rcnt[ord] -= 1
  26.times do |j|
    ans += rcnt[j] * lcnt[j]
  end
  lcnt[ord] += 1
end

puts ans
