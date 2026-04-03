# -
# AWC0040/D
# 貪欲法
# 優先度付きキュー
# 遅延評価

require "ac-library-rb/priority_queue"
include AcLibraryRb

N, G, F = gets.split.map(&:to_i)
stations = Array.new(N) { gets.split.map(&:to_i) }.sort_by!(&:first)
stations << [G, 0]

fuel = F
count = 0
available = PriorityQueue.max([])
prev_pos = 0

stations.each do |pos, r|
  fuel -= (pos - prev_pos)

  # 負なら、通ってきた最大の給油所で給油したことにする
  while fuel < 0 && !available.empty?
    fuel += available.pop
    count += 1
  end

  if fuel < 0
    puts -1
    exit
  end

  available << r if r > 0
  prev_pos = pos
end

puts count
