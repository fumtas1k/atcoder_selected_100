# -
# ABC366/E
# マンハッタン距離
# 尺取法

N, D = gets.split.map(&:to_i)
# マンハッタン距離を考えるのでX, Yを独立に扱う
X, Y = Array.new(N) { gets.split.map(&:to_i) }.transpose.map(&:sort)
# マンハッタン距離の総和は、X, Yの最大値にDを足したものを超えない
M = (X + Y).map(&:abs).max + D

def calc(arr)
  sums = Array.new(2 * M + 1, 0)
  # x or y が -M の時のマンハッタン距離の総和
  sums[-M] = arr.sum + N * M

  i = 0
  (-M + 1).upto(M) do |z|
    i += 1 while i < N && arr[i] < z
    # zより小さい座標の数 i, z以上の座標の数 N - i
    sums[z] = sums[z - 1] + i - (N - i)
  end
  sums
end

xsum = calc(X).sort
ysum = calc(Y).sort
j = 0
ans = (2 * M).downto(0).reduce(0) do |acc, i|
  j += 1 while j <= 2 * M && xsum[i] + ysum[j] <= D
  acc + j
end
puts ans
