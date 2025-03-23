# -
# ABC398/F
# 回文
# manacher

def manacher(str)
  chars = str.chars.join("$").then { "$#{_1}$" }
  size = chars.size
  radius = [0] * size
  i = 0
  loop do
    radius[i] += 1 while i - radius[i] >= 0 &&
      i + radius[i] < size &&
      chars[i - radius[i]] == chars[i + radius[i]]

    j = 1
    while i - j >= 0 && i + j < size && j + radius[i - j] < radius[i]
      radius[i + j] = radius[i - j]
      j += 1
    end

    break if i + j == size

    radius[i + j] = radius[i] - j
    i += j
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
