# -
# ABC254/D
# 素因数分解
# 平方数
# 素数

require "prime"

N = gets.to_i

tally = Hash.new(0)
1.upto(N) do |i|
  Prime.prime_division(i).filter {|_, v| v % 2 == 1 }.map(&:first).reduce(:*)&.then { tally[_1] += 1 } || tally[1] += 1
end
puts tally.map {|_, v| v ** 2 }.sum
