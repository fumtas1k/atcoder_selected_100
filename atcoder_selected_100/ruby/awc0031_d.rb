# -
# AWC0031/D
# 二分探索
# 二部グラフ最大マッチング

N, M = gets.split.map(&:to_i)
L = gets.split.map(&:to_i).sort.reverse
R = gets.split.map(&:to_i).sort.reverse

prefix_l = L.reduce([0]) {|acc, x| acc << acc[-1] + x }
prefix_r = R.reduce([0]) {|acc, x| acc << acc[-1] + x }

(1 .. M).each do |i|
  # i 冊以上点検できる日数
  count = L.bsearch_index { _1 < i } || N

  # i 冊以上点検できる日数 * i 冊 + i 冊未満で点検できる冊数の合計
  # i 冊未満の日はルール違反（同じ日に同じ本を複数回点検する）を犯すことなく、持っている分を完全に使い切ることができる
  supply = count * i + (prefix_l[N] - prefix_l[count])
  demand = prefix_r[i]
  if demand > supply
    puts "No"
    exit
  end
end

puts "Yes"

