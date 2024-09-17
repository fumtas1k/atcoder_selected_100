# -
# ABC353/E
# Rolling Hash

B = 1009
M = 2.pow(61) - 1

N = gets.to_i
S = gets.chomp.split

counts = Hash.new(0)

ans = 0
S.each do |s|
  hash = 0
  s.chars.each do |c|
    hash = (hash * B + c.ord) % M
    ans += counts[hash]
    counts[hash] += 1
  end
end

puts ans
