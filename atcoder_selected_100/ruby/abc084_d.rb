# 69
# ABC084/D
# 素因数分解

MAX = 1e5

is_prime = Array.new(MAX + 1, true)
is_prime[0] = is_prime[1] = false

2.upto(MAX) do |i|
  next unless is_prime[i]
  (2 * i).step(MAX, i) { is_prime[_1] = false }
end

csum = [0] * (MAX + 1)

3.upto(MAX) do |i|
  csum[i] = csum[i - 1]
  next unless is_prime[i] && is_prime[(i + 1) / 2]
  csum[i] += 1
end

Q = gets.to_i
puts Array.new(Q) { gets.split.map(&:to_i).then { csum[_2] - csum[_1 - 1] }}
