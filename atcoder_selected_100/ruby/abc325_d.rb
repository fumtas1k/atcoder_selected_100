# -
# ABC325/D
# 貪欲法
# 優先度付きキュー

require "ac-library-rb/priority_queue"

N = gets.to_i
TD = Array.new(N) { gets.split.map(&:to_i).then { [_1[0], _1.sum ] } }.sort

# i = 商品のindex, t = 時間, ans = 答え
i = t = ans = 0
# ds = 商品が印字機の範囲外になる時間のリスト
ds = AcLibraryRb::PriorityQueue.min([])
loop do
  if ds.empty?
    break if i == N
    # 印字する商品がない場合は、商品が印字可能な時間に繰り上げ
    t = TD[i][0]
  end

  # 印字機外になった商品(時間)を削除
  ds.pop until ds.empty? || ds.first >= t

  # 印字機に入る時間がtの商品の、印字範囲外になる時間をdsに詰める
  while i < N && TD[i][0] == t
    ds << TD[i][1]
    i += 1
  end

  next if ds.empty?
  # 印字する
  ds.pop
  ans += 1
  t += 1
end

puts ans
