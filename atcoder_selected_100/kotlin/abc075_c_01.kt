/**
 * 86
 * ABC075/C
 * Union Find
 */

/**
 * Union-Find木
 *
 * @property size サイズ
 */
class UnionFind(private val size: Int) {
  // 親
  private val parents = IntArray(size + 1) { it }

  /**
   * 親を取得
   *
   * @param u 要素番号
   * @return 親番号
   */
  fun root(u: Int): Int {
    if (u == parents[u]) return u
    parents[u] = root(parents[u])
    return parents[u]
  }

  /**
   * 結合
   *
   * @param u 要素番号
   * @param v 結合する要素番号
   */
  fun unite(u: Int, v: Int) {
    val ru = root(u)
    val rv = root(v)
    if (ru == rv) return
    parents[rv] = ru
  }

  /**
   * 親が同じか
   *
   * @param u 要素番号
   * @param v 比較する要素番号
   * @return true or false
   */
  fun isSame(u: Int, v: Int) = root(u) == root(v)
}

fun solve() {
  val (N, M) = readLine()!!.split(" ").map(String::toInt)
  val AB = Array(M) { readLine()!!.split(" ").map(String::toInt) }

  val ans = (1 .. M).count { i ->
    val uf = UnionFind(N)
    (1 .. M).forEach { j ->
      // i番目の辺は取り除く
      if (i == j) return@forEach
      uf.unite(AB[j - 1][0], AB[j - 1][1])
    }
    // i番目の辺を取り除いている状態で、全ての頂点の親が同じ(= 連結している)場合、i番目の辺は橋ではない
    (1 .. N).map { uf.root(it) }.distinct().size != 1
  }

  println(ans)
}

fun main() {
  Thread(null, ::solve, "solve", 1.shl(26)).start()
}
