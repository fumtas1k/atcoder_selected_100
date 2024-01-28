# -
# ABC338/D
# 累積和
# いもす法

N, M = gets.split.map(&:to_i)
X = gets.split.map(&:to_i).map(&:pred)

# @total_dist[i] := i本目の橋を封鎖した時のツアーの長さ
@total_dist = [0] * (N + 1)

# from から to の間が通れる場合の長さ
def calc_dist(from, to)
  return to - from if from <= to
  N + to - from
end

# from から to　の間が封鎖されていた場合のツアーの長さを更新
# imos法で後で全計算
def add_dist(from, to, num)
  if from <= to
    @total_dist[from] += num
    @total_dist[to] -= num
  else
    @total_dist[from] += num
    @total_dist[N] -= num
    @total_dist[0] += num
    @total_dist[to] -= num
  end
end

(M - 1).times do |i|
  # X[i] から X[i + 1] - 1 の道が封鎖されていた場合の長さを更新
  add_dist(X[i], X[i + 1], calc_dist(X[i + 1], X[i]))
  # X[i + 1] から X[i] - 1 の道が封鎖されていた場合の長さを更新
  add_dist(X[i + 1], X[i], calc_dist(X[i], X[i + 1]))
end

N.times do |i|
  @total_dist[i + 1] += @total_dist[i]
end

puts @total_dist[0, N].min
