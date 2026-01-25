# -
# ABC442/E
# 数学的問題
# 偏角ソート

Point = Struct.new(:x, :y) do
  # 外積
  def cross(other)
    x * other.y - y * other.x
  end

  # 180度回転対称な上半分にあるかどうか
  def up?
    y.positive? || (y.zero? && x.positive?)
  end

  # 反時計回りに小さい順
  def <=>(other)
    if up? != other.up?
      up? ? -1 : 1
    else
      c = cross(other)
      return 0 if c.zero?
      c.positive? ? -1 : 1
    end
  end
end

N, Q = gets.split.map(&:to_i)
points = Array.new(N) { gets.split.map(&:to_i).then { Point.new(*_1) } }

# 時計回りにするために反転
sorted = points.map.with_index.sort_by(&:first).reverse

current_rank = 0
prev_point = sorted[0].first
direction_rank = []
csum = [0]

sorted.each.with_index do |(point, idx), i|
  if (prev_point <=> point) != 0
    csum << i
    current_rank += 1
  end
  direction_rank[idx] = current_rank
  prev_point = point
end
csum << N

ans = []
Q.times do |i|
  a, b = gets.split.map(&:to_i).map(&:pred)
  rank_a = direction_rank[a]
  rank_b = direction_rank[b]

  ans[i] = if rank_a <= rank_b
    csum[rank_b + 1] - csum[rank_a]
  else
    (csum[-1] - csum[rank_a]) + csum[rank_b + 1]
  end
end

puts ans
