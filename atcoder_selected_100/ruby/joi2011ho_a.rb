# 78
# JOI2011HO/A
# 累積和:2次元

# rubyではTLE
M, N = gets.split.map(&:to_i)
K = gets.to_i
MAP = Array.new(M) { gets.chomp.chars }

J = Array.new(M + 1) { [0] * (N + 1) }
O = Array.new(M + 1) { [0] * (N + 1) }
I = Array.new(M + 1) { [0] * (N + 1) }

M.times do |i|
  N.times do |j|
    case MAP[i][j]
    when "J"
      J[i + 1][j + 1] += 1
    when "O"
      O[i + 1][j + 1] += 1
    when "I"
      I[i + 1][j + 1] += 1
    end
  end
end

(M + 1).times do |i|
  N.times do |j|
    J[i][j + 1] += J[i][j]
    O[i][j + 1] += O[i][j]
    I[i][j + 1] += I[i][j]
  end
end

M.times do |i|
  (N + 1).times do |j|
    J[i + 1][j] += J[i][j]
    O[i + 1][j] += O[i][j]
    I[i + 1][j] += I[i][j]
  end
end

def calc_area(a, b, c, d, area)
  area[c][d] - area[a - 1][d] - area[c][b - 1] + area[a - 1][b - 1]
end

K.times do
  a, b, c, d = gets.split.map(&:to_i)
  puts [calc_area(a, b, c, d, J), calc_area(a, b, c, d, O), calc_area(a, b, c, d, I)].join(" ")
end
