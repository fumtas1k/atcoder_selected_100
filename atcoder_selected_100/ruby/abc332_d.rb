# -
# ABC332/D
# 全探索:順列全探索
# 幅優先探索

H, W = gets.split.map(&:to_i)
A = Array.new(H) { gets.split.map(&:to_i) }
B = Array.new(H) { gets.split.map(&:to_i) }

# 全列挙しても 5! * 5! = 120 * 120 = 14400通りなので、全探索で十分間に合う
# 操作回数を幅優先探索で求める
que = [A]
dist = Hash.new
dist[A] = 0
until que.empty?
  arr = que.shift
  (H - 1).times do |i|
    next_arr = arr.map { _1.dup }
    next_arr[i], next_arr[i + 1] = next_arr[i + 1], next_arr[i]
    next if dist[next_arr]
    dist[next_arr] = dist[arr] + 1
    que << next_arr
  end

  (W - 1).times do |i|
    next_arr = arr.map { _1.dup }
    next_arr.each do |row|
      row[i], row[i + 1] = row[i + 1], row[i]
    end
    next if dist[next_arr]
    dist[next_arr] = dist[arr] + 1
    que << next_arr
  end
end

dist.each do |arr, d|
  next unless arr == B
  puts d
  exit
end
puts -1
