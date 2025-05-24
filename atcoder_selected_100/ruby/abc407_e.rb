# -
# ABC407/E
# その他
# 括弧列の成立条件
# 優先度付きキュー

require "ac-library-rb/priority_queue"

def calc_max_score(n, points)
  que = AcLibraryRb::PriorityQueue.new { |x, y| x > y }
  res = points[0]
  # 2 * k までの内 k 個は "(" であることを利用する
  # 貪欲法で確定していく
  (1 ... n).each do |i|
    2.times do |j|
      que << points[2 * i - j]
    end
    res += que.pop
  end
  res
end

ans = gets.to_i.times.map do
  n = gets.to_i
  points = Array.new(2 * n) { gets.to_i }
  calc_max_score(n, points)
end

puts ans
