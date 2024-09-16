# -
# ABC217/D
# 二分探索
# insertとunshiftの使い分け

L, Q = gets.split.map(&:to_i)
CX = Array.new(Q) { gets.split.map(&:to_i) }
queue = [L]
ans = []
CX.each do |c, x|
  idx = queue.bsearch_index { _1 >= x }
  case c
  when 1
    # unshiftを使用しないとTLEになる
    idx.zero? ? queue.unshift(x) : queue.insert(idx, x)
  when 2
    ans << (idx.zero? ? queue[idx] : queue[idx] - queue[idx - 1])
  end
end

puts ans
