# -
# ABC254/D
# 素因数分解
# 平方数

N = gets.to_i

nums = [*0 .. N]
2.upto(Math.sqrt(N).to_i) do |i|
  i2 = i ** 2
  i2.step(N, i2) do |j|
    while nums[j] % i2 == 0
      nums[j] /= i2
    end
  end
end

puts nums[1..].tally.map {|_, v| v ** 2 }.sum
