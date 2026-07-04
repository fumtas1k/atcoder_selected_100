# -
# ABC250/E
# 数学的問題
# Zobrist Hash

hash = Hash.new { |h, k| h[k] = rand(1 ... (1 << 61)) }

N = gets.to_i
A = gets.split.map(&:to_i)
B = gets.split.map(&:to_i)

a_xor = [0]
b_xor = [0]
a_seen = Hash.new(false)
b_seen = Hash.new(false)
N.times do |i|
  ax = a_xor[-1]
  bx = b_xor[-1]
  ax ^= hash[A[i]] unless a_seen[A[i]]
  bx ^= hash[B[i]] unless b_seen[B[i]]
  a_seen[A[i]] = b_seen[B[i]] = true
  a_xor << ax
  b_xor << bx
end

out = []
gets.to_i.times do
  x, y = gets.split.map(&:to_i)
  out << (a_xor[x] == b_xor[y] ? "Yes" : "No")
end
puts out
