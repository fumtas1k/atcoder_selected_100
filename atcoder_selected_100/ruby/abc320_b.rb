# -
# ABC320/B
# 数学的問題
# 回文
# manacher

# 回文の長さを求める
# O(N) で求められる
def manacher(str)
  # 偶数長の場合も考慮し奇数長になるよう文字列に含まれない"$"を挿入
  s = str.chomp.chars.join("$").then { "$#{_1}$" }
  # 中心を含む回文の半径（実際には回文の長さ + 1だが定義上の名前）
  radius = [0] * s.size
  i = 0
  loop do
    # 中心がiの半径を求める
    radius[i] += 1 while i - radius[i] >= 0 &&
      i + radius[i] < s.size &&
      s[i - radius[i]] == s[i + radius[i]]

    k = 1
    # 対称性を利用して i + k の半径を求める
    while i - k >= 0 && i + k < s.size && k + radius[i - k] < radius[i]
      radius[i + k] = radius[i - k]
      k += 1
    end

    break if i + k >= s.size

    # i + radius[i - k] が radius[i] 以上の場合 中心iの半径に入っていないので
    # radius[i + k] は radius[i] - k 以上となることまでしかわからない。
    # ここでは、暫定的な値を入れる
    radius[i + k] = radius[i] - k
    i += k
  end
  radius[1...-1].map(&:pred)
end

puts manacher(gets).max
