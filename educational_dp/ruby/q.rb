# Q
# セグメント木

class SegmentTree
  attr_accessor :tree, :leaf_size, :id_elm, :ope

  def initialize(arr, id_elm, &block)
    n = arr.size
    @leaf_size = 1 << (n - 1).bit_length
    @id_elm = id_elm
    @ope = block
    @tree = [id_elm] * (2 * leaf_size)
    n.times { tree[leaf_size + _1] = arr[_1] }
    (leaf_size - 1).downto(1) do |i|
      tree[i] = ope.call(tree[i * 2], tree[i * 2 + 1])
    end
  end

  # posは1から始まる
  def update(pos, val)
    u = leaf_size + pos
    tree[u] = val
    while u > 1
      u >>= 1
      tree[u] = ope.call(tree[2 * u], tree[2 * u + 1])
    end
  end

  # 求めたい半開区間[l, r)
  def query(l, r)
    ans = id_elm
    left = leaf_size + l
    right = leaf_size + r
    while right - left >= 1
      if left[0] == 1
        ans = ope.call(ans, tree[left])
        left += 1
      end
      if right[0] == 1
        ans = ope.call(ans, tree[right - 1])
        right -= 1
      end
      left >>= 1
      right >>= 1
    end
    ans
  end

  # 求めたい半開区間[l, r), 現在の半開区間[a, b), u = 現在地
  # こちらはTLEする
  def query2(l, r, a = 0, b = leaf_size, u = 1)
    return id_elm if r <= a || b <= l
    return tree[u] if l <= a && b <= r
    mid = (a + b) / 2
    left = query2(l, r, a, mid, 2 * u)
    right = query2(l, r, mid, b, 2 * u + 1)
    ope.call(left, right)
  end
end

N = gets.to_i
H = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

seg_tree = SegmentTree.new([0] * (N + 1), 0) {|a, b| [a, b].max }
H.zip(A).each do |h, a|
  seg_tree.update(h, seg_tree.query(1, h) + a)
end
puts seg_tree.query(1, N + 1)
