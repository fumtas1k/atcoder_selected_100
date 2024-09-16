# -
# ABC217/E
# 優先度付キュー
# 二重構造

require "ac-library-rb/priority_queue"

Q = gets.to_i
queue1 = []
queue2 = AcLibraryRb::PriorityQueue.min([])

ans = []
Q.times do
  query = gets.split.map(&:to_i)
  case query
  in [1, x]
    queue1 << x
  in [2]
    ans << (queue2.empty? ? queue1.shift : queue2.pop)
  in [3]
    queue1.each { queue2 << _1 }
    queue1.clear
  end
end

puts ans

