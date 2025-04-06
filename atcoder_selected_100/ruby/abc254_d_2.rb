# -
# ABC254/D
# 素因数分解
# 平方数

# i * j が平方数
# i の約数のうち最大の平方数で i を割った値が a、 j　の約数のうち最大の平方数で j を割った値が b
# a == b が成り立つ
# つまり, aの個数を求めれば良い
N = gets.to_i

factors = Array.new(N + 1, &:itself)
2.upto(N) do |i|
  i2 = i ** 2
  # Math.sqrtは丸誤差があるので、条件指定のbreakを使用する
  break if i2 > N
  x.step(N, i2) { factors[_1] /= i2 while factors[_1] % i2 == 0 }
end

# 0を除く
puts factors[1..].tally.sum { _2 ** 2 }
