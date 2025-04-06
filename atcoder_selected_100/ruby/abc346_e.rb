# -
# ABC346/E
# 数学的問題
# 後ろから考える

H, W, M = gets.split.map(&:to_i)
rows = Hash.new
cols = Hash.new

TAX = Array.new(M) { gets.split.map(&:to_i) }

cnts = Hash.new(0)
cnts[0] = H * W
TAX.reverse.each do |t, a, x|
  cnt = 0
  a -= 1
  case t
  when 1
    next if rows[a]
    rows[a] = x
    cnt = W - cols.size
    cnts[x] += cnt
  when 2
    next if cols[a]
    cols[a] = x
    cnt = H - rows.size
    cnts[x] += cnt
  end
  cnts[0] -= cnt
end


ans = cnts.sort.filter_map { _1.join(" ") unless _1[1].zero? }
puts ans.size
puts ans
