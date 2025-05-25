# -
# ABC407/F
# その他
# カルテジアン木
# いもす法
# 累積和

class CartesianTree

  Node = Struct.new(:index, :value, :left, :right)

  attr_reader :root, :comp, :size

  def initialize(arr, max_or_min = :max)
    @size = arr.size
    @comp = max_or_min == :max ? :> : :<
    stack = []

    arr.each_with_index do |v, i|
      node = Node.new(i, v, nil, nil)
      last = nil
      while !stack.empty? && node.value.send(@comp, stack[-1].value)
        last = stack.pop
      end
      node.left = last
      stack[-1].right = node unless stack.empty?
      stack << node
    end
    @root = stack[0]
  end
end

N = gets.to_i
A = gets.split.map(&:to_i)
ct = CartesianTree.new(A)
imos = Array.new(N + 2, 0)

f = ->(node) do
  return 0 if node.nil?
  l = f.(node.left)
  r = f.(node.right)
  imos[0] += node.value
  imos[l + 1] -= node.value
  imos[r + 1] -= node.value
  imos[l + r + 2] += node.value
  # 区間サイズを返す
  l + r + 1
end

f.(ct.root)

2.times do
  (N + 1).times { imos[_1 + 1] += imos[_1] }
end

puts imos[0, N]
