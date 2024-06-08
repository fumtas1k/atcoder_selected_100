# -
# ABC357/C
# 深さ優先探索
# ３進法

N = gets.to_i

def dfs(n)
  return ["#"] if n == 0
  block = dfs(n - 1)
  size = block.size
  ret = Array.new(3 * size) { Array.new(3 * size, ".") }
  3.times do |i|
    3.times do |j|
      next if i == 1 && j == 1
      size.times do |k|
        size.times do |l|
          ret[i * size + k][j * size + l] = block[k][l]
        end
      end
    end
  end
  ret
end

puts dfs(N).map { _1.is_a?(Array) ? _1.join : _1 }.join("\n")
