# -
# ABC372/D
# スタック
# 単調減少

N = gets.to_i
H = gets.split.map(&:to_i)

ans = Array.new(N, 0)
stack = []
(N - 2).downto(0) do |i|
  # H[i+1]を含めた単調減少スタックを維持
  stack.pop while !stack.empty? && stack[-1] < H[i + 1]
  stack << H[i + 1]
  ans[i] = stack.size
end

puts ans.join(" ")
