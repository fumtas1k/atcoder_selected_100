# -
# ABC346/E
# 数学的問題
# 後ろから考える

require "set"

H, W, M = gets.split.map(&:to_i)
TAX = Array.new(M) { gets.split.map(&:to_i) }
ROW = Set.new
COLUMN = Set.new

ans = Hash.new(0)
# 最後に塗られたマスの色は確定
# 最後から逆順に見てすでに塗られているマスは固定
TAX.reverse.each do |t, a, x|
  a -= 1
  case t
  when 1
    next unless ROW.add?(a)
    ans[x] += W - COLUMN.size unless x.zero?
  when 2
    next unless COLUMN.add?(a)
    ans[x] += H - ROW.size unless x.zero?
  else
  end
end

ans[0] = H * W - ans.values.sum
ans.reject! {|_, v| v.zero? }
puts ans.size
puts ans.sort.map { _1.join(" ") }.join("\n")
