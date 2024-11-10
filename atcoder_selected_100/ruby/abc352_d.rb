# -
# ABC352/D
# スライド最小, スライド最大
# DEQUEUE

class SlideWindow
  class << self
    def min(window, data)
      new(window, data, (window - 1).times.sort_by { data[_1] }, &:<)
    end

    def max(window, data)
      new(window, data, (window - 1).times.sort_by { -data[_1] }, &:>)
    end
  end

  attr_accessor :window, :data, :dequeue, :ope

  def initialize(window, data, dequeue, &ope)
    @window = window
    @data = data
    @dequeue = dequeue
    @ope = ope
  end

  def prod
    (window - 1).upto(data.size - 1).each_with_object([]) do |i, res|
      dequeue.shift while !dequeue.empty? && dequeue[0] < i - window + 1
      dequeue.pop while !dequeue.empty? && ope.(data[i], data[dequeue[-1]])
      dequeue << i
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

