/**
 * -
 * ABC444/E
 * 全探索:全列挙
 * 尺取法
 * 順序付き集合
 */

import java.util.TreeSet

private const val INF = 1_000_000_000L

fun main() {
    val (N, D) = readln().split(" ").let { (n, d) -> n.toInt() to d.toLong() }
    val A = readln().split(" ").map(String::toLong)

    // TreeSet では同じ値を扱えないため、(値, インデックス) のペアで管理
    val sortedSet = TreeSet<Pair<Long, Int>>(compareBy({ it.first }, { it.second }))
    sortedSet.add(-INF to -2)
    sortedSet.add(2 * INF to -1)

    var ans = 0L
    var r = 0

    for (l in 0 until N) {
        while (r < N) {
            val key = A[r] to r
            // A[r] 以上の最小要素
            val hi = sortedSet.ceiling(key)!!
            if (hi.first - A[r] < D) break
            // A[r] 未満の最大要素
            val lo = sortedSet.lower(key)!!
            if (A[r] - lo.first < D) break
            sortedSet.add(key)
            r++
        }
        ans += r - l
        sortedSet.remove(A[l] to l)
    }

    println(ans)
}
