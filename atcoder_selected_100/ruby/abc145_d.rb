# 73
# ABC145/D
# 逆元

M = 10 ** 9 + 7
X, Y = gets.split.map(&:to_i)

def ncr(n, r)
  n.downto(n - r + 1).inject(1) {|acc, i| acc * i % M } * (1..r).inject(1) {|acc, i| acc * i.pow(M - 2, M) % M } % M
end

# 連立方程式をとく
# i + 2 * j = X
# 2 * i + j = Y

(X + 1).times do |i|
  j2 = X - i
  break if j2 < 0
  next if j2 % 2 == 1
  j = j2 / 2
  if 2 * i + j == Y
    puts ncr(i + j, i)
    exit
  end
end
puts 0
