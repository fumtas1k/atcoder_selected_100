# -
# ABC428/D
# 数学的な問題
# 整数
# 平方数
# 1桁ずつ計算

# Integer.sqrtは4503599761588224を正確に計算できない(https://qiita.com/HMMNRST/items/0b957c330b4125053ba6)
# したがって、正しく計算できるようメソッドをオーバーライドする
def Integer.sqrt(x)
  y = Math.sqrt(x).to_i + 1
  y -= 1 while y ** 2 > x
  y
end

ans = gets.to_i.times.map do
  c, d = gets.split.map(&:to_i)
  xmin = 1
  shift = 10
  res = 0
  # 1桁ずつ計算していく
  while xmin <= c + d
    l = [xmin, c + 1].max
    r = [xmin * 10 - 1, c + d].min
    if l <= r
      # k以下の正の平方数の個数は Integer.sqrt(k)個
      res += Integer.sqrt(c * shift + r) - Integer.sqrt(c * shift + l - 1)
    end
    xmin *= 10
    shift *= 10
  end
  res
end

puts ans
