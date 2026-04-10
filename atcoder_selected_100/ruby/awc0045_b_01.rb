# -
# AWC0045/B
# その他
# KMP

N, M = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
B = gets.split.map(&:to_i)

# KMP の失敗関数(failure function)を構築
# fail[j] = B[0..j] の接頭辞と接尾辞が一致する最大長（自身を除く）
fail = [0] * M
j = 0
(1 ... M).each do |i|
  while j > 0 && B[j] != B[i]
    j = fail[j - 1]
  end
  next unless B[j] == B[i]
  j += 1
  fail[i] = j
end

# KMP 検索
j = 0
N.times do |i|
  while j > 0 && B[j] != A[i]
    j = fail[j - 1]
  end
  next unless B[j] == A[i]
  j += 1
  if j == M
    puts i - M + 2  # 1-indexed
    exit
  end
end

puts -1
