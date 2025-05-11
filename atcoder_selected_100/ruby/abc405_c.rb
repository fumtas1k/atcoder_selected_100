# -
# ABC405/C
# 累積和

N = gets.to_i
A = gets.split.map(&:to_i)

csum = 0
ans = 0
A.each do |a|
  ans += csum * a
  csum += a
end

puts ans
