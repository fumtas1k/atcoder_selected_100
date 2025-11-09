# -
# ABC383/D
# 全探索:全列挙
# 尺取法
# 約数
# 素数列挙
# エラトステネスの篩

# 整数Mは、素数p1, p2, ... pk を用いて p1^e1 * p2^e2 * ... * pk^ek と表すことができる。
# このとき、Mの約数の個数は (e1 + 1) * (e2 + 1) * ... * (ek + 1) である。
# 正の約数が9個ということは、以下の2通りの場合がある。
# 1. ある素因数の指数が8で、他の素因数の指数が0である場合 (e1 = 8)
# 2. ある2つの素因数の指数が2で、他の素因数の指数が0である場合 (e1 = 2, e2 = 2)

N = gets.to_i
sqrt = Math.sqrt(N).to_i + 1
sqrt -= 1 while sqrt.pow(2) > N

primes = []
is_prime = [true] * (sqrt + 1)
is_prime[0] = is_prime[1] = false
2.upto(sqrt) do |i|
  next unless is_prime[i]
  primes << i
  (i * 2).step(sqrt, i) { is_prime[_1] = false }
end

ans = 0

l = 0
r = primes.size - 1
while l < r
  p1 = primes[l]
  ans += 1 if p1.pow(8) <= N
  r -= 1 while l < r && p1.pow(2) * primes[r].pow(2) > N
  ans += r - l
  l += 1
end

puts ans
