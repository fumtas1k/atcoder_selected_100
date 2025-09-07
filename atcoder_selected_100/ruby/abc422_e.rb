# -
# ABC422/E
# その他
# 乱択

random = Random.new(0)

N = gets.to_i
XY = Array.new(N) { gets.split.map(&:to_i) }

# 過半数の点の個数 := (N + 1) / 2
# N点から、ランダムに異なる2点を選ぶとき、両方の点が直線上に存在する確率は
# ((N + 1) / 2 / N) * (((N + 1) / 2 - 1) / (N - 1)) = (N + 1) / (4 * N) > 1 / 4
# ランダムな2点を結ぶ直線上に過半数の点が存在する確率 > 1 / 4
# 誤答する確率 < 3 / 4
# 45回試行すれば、誤答する確率 < (3 / 4) ^ 45 ≒ 2.3e-6

45.times do
  i = random.rand(N)
  j = random.rand(N - 1)
  j += 1 if i <= j

  xi, yi = XY[i]
  xj, yj = XY[j]
  a = yj - yi
  b = xi - xj
  c = xj * yi - xi * yj

  cnt = 0
  XY.count do |x, y|
    cnt += 1 if a * x + b * y + c == 0
    if cnt * 2 >= N
      puts "Yes"
      puts [a, b, c].join(" ")
      exit
    end
  end
end

puts "No"
