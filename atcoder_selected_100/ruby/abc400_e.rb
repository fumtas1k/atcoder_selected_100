# -
# ABC400/E
# 素因数
# 平方数

# p, q は 素数
# p ^ (2 * k) * q ^ (2 * l) <= 10 ** 12
# p ^ k * q ^ l <= 10 ** 6
MAX = 10 ** 6

# 素因数の個数を求める
prime_factor_cnts = Array.new(MAX + 1, 0)
2.upto(MAX) do |i|
  next if prime_factor_cnts[i] > 0
  i.step(MAX, i) do |j|
    prime_factor_cnts[j] += 1
  end
end

candidates = []
2.upto(MAX) do |i|
  next unless prime_factor_cnts[i] == 2
  candidates << i.pow(2)
end

candidates.sort!.reverse!
gets.to_i.times.map do
  query = gets.to_i
  candidates.bsearch { _1 <= query }
end.then(&method(:puts))
