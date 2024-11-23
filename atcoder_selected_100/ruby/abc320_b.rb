# -
# ABC320/B
# 数学的問題
# 回文
# manacher

# 回文の長さを求める
# O(N) で求められる
def manacher(str)
  # 偶数長の場合も考慮し奇数長になるよう文字列に含まれない"$"を挿入
  chars = "$" + str.chars.join("$") + "$"
  size = chars.size
  # 中心iの回文の半径
  radius = [0] * size
  center = 0
  loop do
    # 中心centerの半径を求める
    radius[center] += 1 while center - radius[center] >= 0 &&
      center + radius[center] < size &&
      chars[center - radius[center]] == chars[center + radius[center]]

    i = 1
    # 対称性を利用して 中心が　center + i の半径を求める
    while center - i >= 0 && center + i < size && i + radius[center - i] < radius[center]
      radius[center + i] = radius[center - i]
      i += 1
    end

    break if center + i == size

    # i + radius[center - i] が radius[center] 以上の場合 中心centerの半径に入っていないので
    # radius[center + i] は radius[center] - i 以上となることまでしかわからない。
    # ここでは、暫定的な値を入れる
    radius[center + i] = radius[center] - i
    center += i
  end
  # strに$を付加しているので、その部分を抜く。
  # radiusは回文の半径としているが挿入された$も含むためradiusの値は回文の長さ + 1
  radius[1...-1].map(&:pred)
end

puts manacher(gets.chomp).max
