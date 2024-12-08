# -
# ABC383/D
# 全探索:全列挙
# 尺取法
# 約数
# 素数列挙
# エラトステネスの篩

# 整数Mは、素数p1, p2, ... pk を用いて p1^e1 * p2^e2 * ... * pk^ek と表すことができる。
# このとき、Mの約数の個数は (e1 + 1) * (e2 + 1) * ... * (ek + 1) である。

N = gets.to_i
LIMIT = Math.sqrt(N).to_i + 1

primes = []
is_prime = Array.new(LIMIT + 1, true)
2.upto(LIMIT) do |i|
  next unless is_prime[i]
  primes << i
  (i * 2).step(LIMIT, i) do |j|
    is_prime[j] = false
  end
end

ans = 0
r = primes.size - 1
primes.each_with_index do |prime, l|
  break if prime.pow(4) > N
  ans += 1 if prime.pow(8) <= N
  r -= 1 while r > 0 && prime.pow(2) * primes[r].pow(2) > N
  next if r < l
  ans += r - l
end

puts ans
