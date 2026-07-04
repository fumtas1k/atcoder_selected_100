# -
# ABC295/D
# 数学的な問題
# Zobrist Hash(XOR)

S = gets.chomp.chars.map(&:to_i)

# xor の性質を利用して、同じ数字の出現回数が偶数回の区間を数える
hash = 10.times.map { rand(1 ... (1 << 61)) }

xor = [0]
group = Hash.new(0)
group[0] = 1
S.each_with_index do |s, i|
  xor << (xor[-1] ^ hash[s])
  group[xor[-1]] += 1
end

# hash値が同じ組み合わせの区間[l, r) では、同一数字の出現回数が偶数回 (xor[r] ^ xor[l] == 0)
puts group.sum { _2 * (_2 - 1) / 2 }