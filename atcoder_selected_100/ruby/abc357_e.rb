# -
# ABC357/E
# 強連結成分分解
# 深さ優先探索

class SCC
  attr_reader :size, :edges
  def initialize(size)
    @size = size
    @edges = Array.new(@size) { [] }
  end

  def add_edge(from, to)
    edges[from] << to
  end

  def add_edges(arr)
    arr.each { add_edge(_1, _2) }
  end

  def scc
    group_size, ids = scc_ids
    groups = Array.new(group_size) { [] }
    ids.each.with_index { groups[_1] << _2 }
    groups
  end

  private
  def scc_ids
    group_num = current_ord = 0
    visited = []
    low = []
    ord = []
    ids = []

    dfs = -> from do
      return if ord[from]
      ord[from] = low[from] = current_ord
      visited << from
      current_ord += 1
      edges[from].each do |to|
        if ord[to]
          low[from] = [low[from], ord[to]].min
        else
          dfs.call(to)
          low[from] = [low[from], low[to]].min
        end
      end
      return unless ord[from] == low[from]
      while (to = visited.pop)
        ord[to] = size
        ids[to] = group_num
        break if from == to
      end
      group_num += 1
    end

    size.times { dfs.call(_1) }

    [group_num, ids.map { group_num - 1 - _1 }]
  end
end

N = gets.to_i
A = gets.split.map(&:to_i).map(&:pred)

scc = SCC.new(N)
A.each_with_index { scc.add_edge(_2, _1) }

ans = Array.new(N, 0)
# sccはトポロジカルソートされているので、末端から処理する
scc.scc.reverse.each do |arr|
  # 強連結 or 自己ループの場合
  if arr.size > 1 || arr[0] == A[arr[0]]
    arr.each do |a|
      ans[a] = arr.size
    end
  else
    ans[arr[0]] = ans[A[arr[0]]] + 1
  end
end

puts ans.sum
