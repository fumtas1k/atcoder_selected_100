# -
# スタック
# ヒストグラム最大長方形

N = gets.to_i
A = gets.split.map(&:to_i) << 0

stack = []
max_area = 0

A.each_with_index do |a, i|
  while !stack.empty? && A[stack[-1]] > a
    height = A[stack.pop]
    width = stack.empty? ? i : i - stack[-1] - 1
    max_area = [max_area, height * width].max
  end
  stack << i
end

puts max_area
