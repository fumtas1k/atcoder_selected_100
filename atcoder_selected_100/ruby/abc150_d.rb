# 97
# ABC150/D
# 数学的な考察

N, M = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
B = A.map { _1 / 2 }
GCD = B.reduce {|acc, i| acc.lcm(i) }

# a = 2 * b
# p + 0.5 = c / 2.to_f
# cは奇数である必要がある
# したがって、GCD / b は、すべて奇数
if B.all? { (GCD / _1)[0] == 1 }
  puts (M / GCD).divmod(2).sum
else
  puts 0
end
