/**
 * 50
 * S8PC-1/G
 * 動的計画法:bit DP
 * 巡回セールスマン問題
 */

fun main() {
  val (N, M) = readLine()!!.split(" ").map(String::toInt)
  val G = Array(N) { mutableListOf<Triple<Int, Long, Long>>() }
  repeat(M) {
    val (s, t, d, time) = readLine()!!.split(" ")
    G[s.toInt() - 1].add(Triple(t.toInt() - 1, d.toLong(), time.toLong()))
    G[t.toInt() - 1].add(Triple(s.toInt() - 1, d.toLong(), time.toLong()))
  }

  // dp[現在の建物][通った建物のbit] = Pair<距離, 総数>
  val dp = Array(N) { Array(1.shl(N)) { Pair(Long.MAX_VALUE, 0L) } }
  dp[0][0] = Pair(0L, 1L)

  repeat(1.shl(N)) { bit ->
    repeat(N) i@ { i ->
      if (dp[i][bit].first == Long.MAX_VALUE) return@i
      G[i].forEach { (j, d, time) ->
        if (bit.shr(j).and(1) == 1) return@forEach
        val dist = dp[i][bit].first + d
        if (dist > time) return@forEach
        val next_bit = bit + 1.shl(j)
        when (dp[j][next_bit].first.compareTo(dist)) {
          1 -> dp[j][next_bit] = Pair(dist, dp[i][bit].second)
          0 -> dp[j][next_bit] = Pair(dp[j][next_bit].first, dp[j][next_bit].second + dp[i][bit].second)
        }
      }
    }
  }
  val bit_max = 1.shl(N) - 1
  println(if (dp[0][bit_max].second == 0L) "IMPOSSIBLE" else dp[0][bit_max].toList().joinToString(" "))
}
