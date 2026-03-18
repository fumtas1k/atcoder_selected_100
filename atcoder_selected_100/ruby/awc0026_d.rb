# -
# AWC0026/D
# 貪欲法
# 優先度付きキュー

require "ac-library-rb/priority_queue"

N, M = gets.split.map(&:to_i)
HS = Array.new(N) { gets.split.map(&:to_i) }.sort_by(&:first)
P = gets.split.map(&:to_i).sort

pq = AcLibraryRb::PriorityQueue.max([])
ans = 0
P.each do |p|
  pq << HS.shift[1] while !HS.empty? && HS[0][0] <= p

  if pq.empty?
    puts -1
    exit
  end

  ans += pq.pop
end

puts ans

