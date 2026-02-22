# -
# ABC325/D
# 貪欲法
# 優先度付きキュー

require "ac-library-rb/priority_queue"

N = gets.to_i
TD = Array.new(N) { gets.split.map(&:to_i).then { [_1[0], _1.sum] } }.sort

i = ans = 0
t = 0
# 商品が印字機の範囲外になる時間のリスト
pq = AcLibraryRb::PriorityQueue.min([])

loop do
  if pq.empty?
    break if i == N
    # 印字する商品がない場合は、商品が印字可能な時間に繰り上げ
    t = TD[i][0]
  end

  # 時刻tに新たに印字機に入る商品を追加
  while i < N && TD[i][0] == t
    pq << TD[i][1]
    i += 1
  end

  # 期限切れの商品を除去
  pq.pop while !pq.empty? && pq.first < t

  # 期限が最も早い商品に印字
  unless pq.empty?
    pq.pop
    ans += 1
  end

  t += 1
end

puts ans
