# -
# ABC367/F
# Zobrist Hash
# Schwartz–Zippel lemma

M = (1 << 61) - 1
N, Q = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
B = gets.split.map(&:to_i)

hash = (2 * 10 ** 5 + 1).times.map { rand(M) }

acsum = A.reduce([0]) { |acc, i| acc << (acc[-1] + hash[i]) % M }
bcsum = B.reduce([0]) { |acc, i| acc << (acc[-1] + hash[i]) % M }

ans = []
Q.times do
  la, ra, lb, rb = gets.split.map(&:to_i)
  a = (acsum[ra] - acsum[la - 1]) % M
  b = (bcsum[rb] - bcsum[lb - 1]) % M
  ans << (a == b ? "Yes" : "No")
end

puts ans
