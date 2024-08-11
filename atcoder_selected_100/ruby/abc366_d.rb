# -
# ABC366/D
# 3次元累積和

N = gets.to_i
A = Array.new(N) { Array.new(N) { gets.split.map(&:to_i) } }
Q = gets.to_i
LR = Array.new(Q) { gets.split.map(&:to_i).map(&:pred) }

csum = Array.new(N + 1) { Array.new(N + 1) { Array.new(N + 1, 0) } }

N.times do |i|
  N.times do |j|
    N.times do |k|
      csum[i + 1][j + 1][k + 1] =
        csum[i + 1][j + 1][k] + csum[i + 1][j][k + 1] + csum[i][j + 1][k + 1] -
        csum[i][j][k + 1] - csum[i][j + 1][k] - csum[i + 1][j][k] +
        csum[i][j][k] + A[i][j][k]
    end
  end
end

ans = LR.map do |lx, rx, ly, ry, lz, rz|
  csum[rx + 1][ry + 1][rz + 1] -
    csum[lx][ry + 1][rz + 1] - csum[rx + 1][ly][rz + 1] - csum[rx + 1][ry + 1][lz] +
    csum[lx][ly][rz + 1] + csum[lx][ry + 1][lz] + csum[rx + 1][ly][lz] -
    csum[lx][ly][lz]
end

puts ans
