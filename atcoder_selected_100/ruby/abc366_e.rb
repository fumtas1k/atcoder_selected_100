# -
# ABC366/E
# マンハッタン距離
# 尺取法

N, D = gets.split.map(&:to_i)
# マンハッタン距離を考えるのでX, Yを独立に扱う
X, Y = Array.new(N) { gets.split.map(&:to_i) }.transpose.map(&:sort)
# マンハッタン距離の総和は、X, Yの最大値にDを足したものを超えない
M = (X + Y).map(&:abs).max + D

def counts(arr)
  cnts = [0] * (2 * M + 1)
  # x or y が -M の時のマンハッタン距離の総和
  cnts[-M] = arr.sum + M * N
  j = 0
  (-M + 1).upto(M) do |i|
    j += 1 while j < N && arr[j] < i
    # iより小さい座標の数 j, i以上の座標の数 N - j
    cnts[i] = cnts[i - 1] + j - (N - j)
  end
  cnts
end

xcnts = counts(X).sort
ycnts = counts(Y).sort

j = 0
ans = xcnts.reverse.sum do |xcnt|
  j += 1 while j <= 2 * M && xcnt + ycnts[j] <= D
  j
end

puts ans
