# -
# AWC0045/D
# 素因数分解
# 最小素因数

MAX = 1_000_001

# 最小素因数の篩 (SPF)
spf = Array.new(MAX)
(2...MAX).each do |i|
  next if spf[i]
  i.step(MAX - 1, i) { spf[_1] ||= i }
end

N = gets.to_i
A = gets.split.map(&:to_i)

min_total = 0
max_total = 0

A.each do |a|
  next if a == 1
  factors = []
  tmp = a
  while tmp > 1
    p = spf[tmp]
    while tmp % p == 0
      factors << p
      tmp /= p
    end
  end

  factors.sort!

  product = 1
  min_ops = 0
  factors.each do |d|
    min_ops += product
    product *= d
  end
  min_total += min_ops

  product = 1
  max_ops = 0
  factors.reverse_each do |d|
    max_ops += product
    product *= d
  end
  max_total += max_ops
end

puts "#{min_total} #{max_total}"
