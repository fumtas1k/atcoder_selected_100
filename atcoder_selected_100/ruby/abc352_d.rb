# -
# ABC352/D
# スライド最小, スライド最大
# DEQUEUE

class SlideWindow
  class << self
    def min(window_size, data) = new(window_size, data, &:<)

    def max(window_size, data) = new(window_size, data, &:>)
  end

  attr_accessor :window_size, :data, :ope

  def initialize(window_size, data, &ope)
    @window_size = window_size
    @data = data
    @ope = ope
  end

  def prod
    dequeue = []
    data.size.times.each_with_object([]) do |i, res|
      dequeue.shift while !dequeue.empty? && dequeue[0] < i - window_size + 1
      dequeue.pop while !dequeue.empty? && ope.(data[i], data[dequeue[-1]])
      dequeue << i
      next if i < window_size - 1
      res << data[dequeue[0]]
    end
  end
end

N, K = gets.split.map(&:to_i)
P = gets.split.map(&:to_i).map(&:pred)
PINDEX = P.each_with_index.sort_by(&:first).map(&:last)

smaller = SlideWindow.min(K, PINDEX).prod
larger = SlideWindow.max(K, PINDEX).prod

puts larger.zip(smaller).map { _1 - _2 }.min
