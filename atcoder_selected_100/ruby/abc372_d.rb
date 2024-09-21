# -
# ABC372/D
# スタック

N = gets.to_i
H = gets.split.map(&:to_i)

ans = Array.new(N, 0)
stack = []
(N - 2).downto(0) do |i|
  stack.pop while !stack.empty? && stack[-1] < H[i + 1]
  stack << H[i + 1]
  ans[i] = stack.size
end

puts ans.join(" ")
