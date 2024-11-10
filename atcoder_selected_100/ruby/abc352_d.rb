# -
# ABC352/D
# スライド最小, スライド最大
# DEQUEUE

class SlideWindow
  class << self
    def min(window, data) = new(window, data, &:<)

    def max(window, data) = new(window, data, &:>)
  end

  attr_accessor :window, :data, :dequeue, :ope

  def initialize(window, data, &ope)
    @window = window
    @data = data
    @dequeue = []
    @ope = ope
  end

  def prod
    data.size.times.each_with_object([]) do |i, res|
      dequeue.shift while !dequeue.empty? && dequeue[0] < i - window + 1
      dequeue.pop while !dequeue.empty? && ope.(data[i], data[dequeue[-1]])
      dequeue << i
      next if i < window - 1
      res << data[dequeue[0]]
    end
  end
end

N, K = gets.split.map(&:to_i)
P = gets.split.map(&:to_i).map(&:pred)
PINDEX = P.each_with_object([]).with_index { |(p, arr), i| arr[p] = i }

smaller = SlideWindow.min(K, PINDEX).prod
larger = SlideWindow.max(K, PINDEX).prod

puts larger.zip(smaller).map { _1 - _2 }.min
