/**
 * 1
 * ITP1-7/B
 * 全探索:全列挙
 */

 fun main() {
  while (true) {
    val (n, x) = readLine()!!.split(" ").map(String::toInt)
    if (n == 0 && x == 0) break
    var ans = 0
    (1 .. n).forEach { i ->
      (i + 1 .. n).forEach { j ->
        if (x - i - j in (j + 1 .. n)) ans++
      }
    }
    println(ans)
  }
}
