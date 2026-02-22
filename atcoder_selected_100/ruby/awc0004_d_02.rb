# -
# AWC0004/D
# 貪欲法
# 区間スケジューリング問題
# 優先度付きキュー

require "ac-library-rb/priority_queue"

N, M = gets.split.map(&:to_i)

LR = Array.new(M) { gets.split.map(&:to_i).map(&:pred) }.sort
rs = AcLibraryRb::PriorityQueue.min([])
i = 0
assigned = 0

N.times do |x|
  while i < M && LR[i][0] <= x
    rs << LR[i][1]
    i += 1
  end

  break if !rs.empty? && rs.top < x
  next if rs.empty?

  rs.pop
  assigned += 1
end

puts assigned == M ? "Yes" : "No"
