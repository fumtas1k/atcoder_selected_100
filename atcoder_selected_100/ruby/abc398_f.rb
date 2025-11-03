# -
# ABC398/F
# 回文
# manacher

def manacher(str)
  bytes = str.chars.join("$").then { "$#{_1}$" }.bytes
  size = bytes.size
  radius = [0] * size
  center = 0
  r = 0
  while center < size
    r += 1 while center >= r && center + r < size && bytes[center - r] == bytes[center + r]
    radius[center] = r

    i = 1
    while center >= i && center + i < size && i + radius[center - i] < r
      radius[center + i] = radius[center - i]
      i += 1
    end

    r -= i
    center += i
  end
  radius[1...-1].map(&:pred)
end

S = gets.chomp
T = S.reverse

s_radius = manacher(T)

index = 0
s_radius.each.with_index(1) do |r, i|
  index = r if r == i
end

puts S + T[index ..]
