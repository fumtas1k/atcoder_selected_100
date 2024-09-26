# -
# ABC234/D
# データ構造

N, K = gets.split.map(&:to_i)
P = gets.split.map(&:to_i)

exists = Array.new(N + 1, false)
K.times { exists[P[_1]] = true }

min = P[0, K].min
ans = [min]
K.upto(N - 1) do |i|
  if min < P[i]
    exists[P[i]] = true
    min += 1
    min += 1 until exists[min]
  end
  ans << min
end

puts ans
