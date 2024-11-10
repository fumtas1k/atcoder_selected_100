# -
# DPL-3/B
# スタック
# ヒストグラム最大長方形問題

def calc_largest_rectangle(heights)
  # 先頭と末尾に番兵を追加
  heights.unshift(0) << 0
  stack = []
  max_area = 0
  heights.each_with_index do |h, i|
    while !stack.empty? && heights[stack[-1]] > h
      height = heights[stack.pop]
      width = (i - 1) - stack[-1]
      max_area = [max_area, height * width].max
    end
    stack << i
  end
  max_area
end

H, W = gets.split.map(&:to_i)
C = Array.new(H) { gets.split.map(&:to_i) }

# ヒストグラムに変換
D = C.map do |row|
  row.reduce([0]) { |acc, c| acc << (c.zero? ? acc[-1] + 1 : 0) }[1, W]
end.transpose

ans = 0
D.each do |heights|
  ans = [ans, calc_largest_rectangle(heights)].max
end

puts ans
