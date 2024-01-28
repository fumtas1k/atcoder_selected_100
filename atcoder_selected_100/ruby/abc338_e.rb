# -
# ABC338/E
# 数学的問題
# ビット
# スタック

N = gets.to_i
LEFT = {}
RIGHT = {}
N.times do |i|
  a, b = gets.split.map(&:to_i).minmax
  LEFT[a] = i
  RIGHT[b] = i
end

stack = []
1.upto(2 * N) do |i|
  if LEFT[i]
    stack << LEFT[i]
  end
  if RIGHT[i] && stack.pop != RIGHT[i]
    puts "Yes"
    exit
  end
end

puts "No"
