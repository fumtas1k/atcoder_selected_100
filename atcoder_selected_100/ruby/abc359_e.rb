# -
# ABC359/E
# その他
# スタック

N = gets.to_i
H = gets.split.map(&:to_i)

# 水槽の水の量(高さ）を記録する。
# [index, height]
stack = [[0, 10 ** 9 + 1]]
ans = Array.new(N + 1, 0)

H.each.with_index(1) do |h, i|
  stack.pop while !stack.empty? && stack[-1][1] < h
  j = stack[-1][0]
  # jまではすでに水が満たされているので、ans[j] を足す
  ans[i] = (i - j) * h + ans[j]
  stack << [i, h]
end

# ans[i] = i番目の板の手前までを満たす時刻
# したがって、i番目の水槽に水が到達するのは ans[i] + 1
puts ans[1..].map(&:succ).join(' ')
