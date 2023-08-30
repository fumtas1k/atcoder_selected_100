/**
 * 3
 * ABC122/B
 * 全探索:全列挙
 * 尺取法
 */

 fun main() {
  val ACGT = "ACGT".toSet()
  val S = readLine()!!.toList()
  var l = 0
  var r = 0
  var ans = 0
  while (l < S.size) {
    while (r < S.size && (S[r] in ACGT)) { r++ }
    ans = maxOf(ans, r - l)
    l = ++r
  }
  println(ans)
}
