# -
# ABC405/E
# 数学的問題
# フェルマーの小定理
# 基準となるものを決める

M = 998244353

A, B, C, D = gets.split.map(&:to_i)

fract = [1]
fract_inv = [1]

(1 .. A + B + C + D).each do |i|
  fract[i] = fract[i - 1] * i % M
  fract_inv[i] = fract_inv[i - 1] * i.pow(M - 2, M) % M
end


# 一番左にあるぶどうの位置（d）を基準に考える
# dより左側にあるのは　A + B + c_left (c_leftはバナナの個数)
ans = (A + B .. A + B + C).reduce(0) do |acc, d|
  c_left = A + B + C - d
  c_right = C - c_left
  # リンゴはバナナより左側のためA + c_left の隙間にオレンジを入れる通り数
  left = fract[A + B + c_left] * fract_inv[A + c_left] % M * fract_inv[B] % M
  right = fract[D - 1 + c_right] * fract_inv[D - 1] % M * fract_inv[c_right] % M
  acc += left * right % M
  acc %= M
end

puts ans
