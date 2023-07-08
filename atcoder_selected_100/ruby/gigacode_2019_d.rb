# 80
# GIGACODE-2019/D
# 累積和/二分探索

H, W, K, V = gets.split.map(&:to_i)
A = Array.new(H) { gets.split.map(&:to_i) }
@csum = Array.new(H + 1) { [0] * (W + 1) }

H.times do |i|
  W.times do |j|
    @csum[i + 1][j + 1] += @csum[i + 1][j] +  @csum[i][j + 1] - @csum[i][j] + A[i][j]
  end
end

def max_area(sh, sw)
  ans = [0]
  sh.upto(H - 1) do |eh|
    l = sw - 1
    r = W
    while r - l > 1
      m = (r + l) / 2
      area = (eh - sh + 1) * (m - sw + 1)
      if @csum[eh + 1][m + 1] - @csum[sh][m + 1] - @csum[eh + 1][sw] + @csum[sh][sw] + area * K <= V
        l = m
      else
        r = m
      end
    end
    ans << (eh - sh + 1) * (l - sw + 1)
  end
  ans.max
end


ans = []
H.times do |i|
  W.times do |j|
    ans << max_area(i, j)
  end
end

puts ans.max
