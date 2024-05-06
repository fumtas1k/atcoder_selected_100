// A

const input = require("fs").readFileSync("/dev/stdin", "utf-8").split("\n");
const N = Number(input[0]);
const H = input[1].split(" ").map(Number);
const K = 2;
const dp = new Array(N).fill(Number.MAX_VALUE);
dp[0] = 0;

for (let i = 0; i < N; i++) {
  for (let j = 1; j <= K; j ++) {
    if (i + j >= N) continue;
    dp[i + j] = Math.min(dp[i + j], dp[i] + Math.abs(H[i + j] - H[i]));
  }
}

console.log(dp[N - 1]);
