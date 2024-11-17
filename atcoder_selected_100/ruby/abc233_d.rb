# -
# 累積和

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

count = Hash.new(0)
sum = ans = 0
N.times do |i|
  count[sum] += 1
  sum += A[i]
  ans += count[sum - K]
end

puts ans
