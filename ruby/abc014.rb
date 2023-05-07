# 81
# ABC014/C
# 累積和
# いもす法

color_size = 10 ** 6 + 1
N = gets.to_i
colors = [0] * (color_size + 1)
N.times do
  a, b = gets.split.map(&:to_i)
  colors[a] += 1
  colors[b + 1] -= 1
end

color_size.times { colors[_1 + 1] += colors[_1] }
puts colors.max
