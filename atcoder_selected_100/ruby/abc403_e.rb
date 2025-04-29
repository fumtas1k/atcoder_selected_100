# -
# ABC403/E
# その他
# trie木

require "set"

class Trie
  Node = Struct.new(:child, :is_x_end, :y_set) {
    def self.default = new(Hash.new, false, Set.new)
  }

  attr_reader :root, :y_set

  def initialize
    @root = Node.default
    # 辞書（type1）と Y 型（type2）双方の照合でマッチした Y 型のクエリ番号を格納
    @y_set = Set.new
  end

  # str：挿入文字列, idx：クエリ番号, is_y：type2 (Y 型) かどうか
  def add(str, idx, is_y)
    node = root
    str.each_char do |c|
      # 子ノードがなければ生成
      node.child[c] ||= Node.default
      # Y 型文字列の場合は、このノードの y_set に idx を登録。
      # そして、このノードが辞書終端 を持っていればマッチ済みとして全体 y_set にも追加。
      if is_y
        node.y_set << idx
        y_set << idx if node.is_x_end
      end

      node = node.child[c]
    end

    if is_y
      # Y 型の末端処理：同様に登録と、辞書終端との照合
      node.y_set << idx
      y_set << idx if node.is_x_end
    else
      # 辞書型(type1)文字列の末端処理：
      # このノードを辞書終端とマークし、
      # ここまでに登録された Y 型クエリ全てをマッチ済みとして全体 y_set に追加
      node.is_x_end = true
      node.y_set.each { y_set << _1 }
      # 一旦登録すれば、以降はマッチ済みとして扱うので、パフォーマンスのためクリアする
      node.y_set.clear
    end
  end
end

trie = Trie.new
y_count = 0

ans = gets.to_i.times.map do |i|
  t, s = gets.chomp.split
  is_y = t == "2"
  trie.add(s, i, is_y)
  y_count += 1 if is_y
  y_count - trie.y_set.size
end

puts ans
