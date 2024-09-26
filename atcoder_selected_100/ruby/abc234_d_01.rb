# -
# ABC234/D
# 優先度付きキュー

require "ac-library-rb/priority_queue"

N, K = gets.split.map(&:to_i)
P = gets.split.map(&:to_i)

queue = AcLibraryRb::PriorityQueue.new(P[0, K]) { _1 < _2 }

ans = [queue.top]
K.upto(N - 1) do |i|
  if queue.top < P[i]
    queue.pop
    queue << P[i]
  end
  ans << queue.top
end

puts ans
