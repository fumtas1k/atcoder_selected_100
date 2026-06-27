# -
# ABC464/E
# いもす法
# 二次元suffix累積最大(最大値伝播)
# オフライン処理/クエリの逆発想

H, W, Q = gets.split.map(&:to_i)
xs = ["A"]
arr = Array.new(H) { [0] * W }
Q.times do |i|
  r, c, x = gets.chomp.split
  r = r.to_i - 1
  c = c.to_i - 1
  xs << x
  arr[r][c] = i + 1
end

(H - 1).downto(0) do |i|
  (W - 1).downto(0) do |j|
    arr[i - 1][j] = [arr[i - 1][j], arr[i][j]].max if i > 0
    arr[i][j - 1] = [arr[i][j - 1], arr[i][j]].max if j > 0
  end
end

puts arr.map { |row| row.map { xs[it] }.join }
