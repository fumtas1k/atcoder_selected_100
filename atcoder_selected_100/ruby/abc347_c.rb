# -
# ABC347/C
# 数学的問題
# 条件を変換する

N, A, B = gets.split.map(&:to_i)
D = gets.split.map(&:to_i)
days = D.map { (_1) % (A + B) }.uniq.sort

days.each_with_index do |d, i|
  dist = (days[(i + 1) % days.size] - d) % (A + B)
  # 全ての予定が休日である == 隣り合う予定の間に全ての平日を入れることができる予定が存在する
  # 予定が全て同じ曜日の場合も考慮
  if dist > B || dist.zero?
    puts "Yes"
    exit
  end
end

puts "No"
