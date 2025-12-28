# -
# ABC438/E
# 数学的な問題
# ダブリング

N, Q = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).map(&:pred)

LOG = 30
next_person = Array.new(LOG) { [] }
water_added = Array.new(LOG) { [] }

N.times do |i|
  next_person[0][i] = A[i]
  water_added[0][i] = i + 1
end

(LOG - 1).times do |d|
  N.times do |i|
    j = next_person[d][i]
    next_person[d + 1][i] = next_person[d][j]
    water_added[d + 1][i] = water_added[d][i] + water_added[d][j]
  end
end

ans = Q.times.map do
  t, b = gets.split.map(&:to_i)
  b -= 1

  current_person = b
  total_water = 0

  LOG.times do |d|
    next if t[d].zero?
    total_water += water_added[d][current_person]
    current_person = next_person[d][current_person]
  end

  total_water
end

puts ans
