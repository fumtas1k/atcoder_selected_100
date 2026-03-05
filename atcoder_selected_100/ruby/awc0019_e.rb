# -
# AWC0019/E
# 貪欲法
# 反悔貪欲
# 交換論法

require "ac-library-rb/priority_queue"

N = gets.to_i

# Wiを含んだ総重量 <= Wi + Di = Si を考える
boxes = Array.new(N) { gets.split.map(&:to_i).then { [_1 + _2, _1] } }.sort

heap = AcLibraryRb::PriorityQueue.max([])
total = 0

boxes.each do |s, w|
  heap << w
  total += w
  # total_w_before + w - max_w ≤ total_w_before + w - w = total_w_before
  # total_w_before ≤ s_prev ≤ s
  total -= heap.pop if total > s
end

puts heap.size
