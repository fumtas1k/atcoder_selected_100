# 29
# JOI2014YO/E
# ダイクストラ法
# 幅優先探索
# 優先度付キュー

class PriorityQueue
  private attr_accessor :heap, :ope

  def initialize(arr = [], &block)
    @heap = []
    @ope = block
    arr.each { self << _1 }
  end

  def size = heap.size

  def first = heap.first

  def empty? = heap.empty?

  def <<(x)
    i = size
    while i > 0
      parent_idx = (i - 1) / 2
      break if ope.call(heap[parent_idx], x)
      heap[i] = heap[parent_idx]
      i = parent_idx
    end
    heap[i] = x
  end

  def shift
    return if empty?
    min = first
    x = heap.pop
    unless empty?
      i = 0
      while (child_idx1 = 2 * i + 1) < size
        child_idx2 = child_idx1 + 1
        if child_idx2 < size && !ope.call(heap[child_idx1], heap[child_idx2])
          child_idx1 = child_idx2
        end
        break if ope.call(x, heap[child_idx1])
        heap[i] = heap[child_idx1]
        i = child_idx1
      end
      heap[i] = x
    end
    min
  end
end

N, K = gets.split.map(&:to_i)
CR = Array.new(N) { gets.split.map(&:to_i) }
G1 = Array.new(N) { [] }
K.times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  G1[a] << b
  G1[b] << a
end

G2 = Array.new(N) { [] }
def bfs(start)
  visited = [false] * N
  log = [[start, CR[start][1]]]
  until log.empty?
    pos, cnt = log.shift
    next if visited[pos] || cnt < 0
    visited[pos] = true
    G2[start] << pos unless start == pos

    G1[pos].each do |to|
      log << [to, cnt - 1]
    end
  end
end

N.times { bfs(_1) }

def dijkstra(start = 0)
  fares = [Float::INFINITY] * N
  fares[start] = 0
  log = PriorityQueue.new([[start, 0]]) { |x, y| x.last < y.last }
  until log.empty?
    pos, pos_fare = log.shift
    next if fares[pos] < pos_fare
    G2[pos].each do |to|
      fare = fares[pos] + CR[pos][0]
      next if fares[to] <= fare
      fares[to] = fare
      log << [to, fare]
    end
  end
  fares
end

puts dijkstra(0)[-1]
