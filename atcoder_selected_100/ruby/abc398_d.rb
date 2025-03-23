# -
# ABC398/D
# 数学的問題
# 全体移動は座標移動, 相対位置

require "set"

# 煙全てを移動する => 相対的に考えると高橋君と座標を移動させる(移動が逆になる)
DIRECT = {"N" => [1, 0], "E" => [0, -1], "S" => [-1, 0], "W" => [0, 1]}
N, R, C = gets.split.map(&:to_i)
S = gets.chomp.chars

ans = []
# 煙の相対位置を記録
smokes = Set.new([[0, 0]])
# [0, 0]の相対座標
r = c = 0
# 高橋君の相対位置
takahashi = [R, C]
S.each do |s|
  r, c = r + DIRECT[s][0], c + DIRECT[s][1]
  takahashi[0] += DIRECT[s][0]
  takahashi[1] += DIRECT[s][1]
  smokes << [r, c]
  ans << (smokes.include?(takahashi) ? 1 : 0)
end

puts ans.join
