# 76
# NIKKEI2019_FINAL/A
# 累積和

N = gets.to_i
A = gets.split.map(&:to_i)

csum = [0]
A.each { csum << csum[-1] + _1 }

1.upto(N) do |i|
  puts i.upto(N).map { csum[_1] - csum[_1 - i] }.max
end
