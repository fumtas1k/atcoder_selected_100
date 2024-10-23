# -
# ABC367/F
# Zobrist Hash
# Schwartz–Zippel lemma

M = 2.pow(61) - 1

N, Q = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
B = gets.split.map(&:to_i)

hash = (2 * 10 ** 5 + 1).times.map { rand(M) }

acsum = A.reduce([0]) { |acc, x| acc << (acc[-1] + hash[x]) % M }
bcsum = B.reduce([0]) { |acc, x| acc << (acc[-1] + hash[x]) % M }

ans = Q.times.map do
  la, ra, lb, rb = gets.split.map(&:to_i)
  a = (acsum[ra] - acsum[la - 1]) % M
  b = (bcsum[rb] - bcsum[lb - 1]) % M
  a == b ? "Yes" : "No"
end

puts ans
