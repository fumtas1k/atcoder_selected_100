// s
// 桁DP

const M = 10 ** 9 + 7;
const input = require("fs").readFileSync("/dev/stdin", "utf-8").split("\n");
const K = input[0];
const D = Number(input[1]);
const digit = K.length;
const dp = [...Array(digit + 1)].map(() =>
  [...Array(2)].map(() => Array(100).fill(0))
);
// dp[i:= 大きい方からの桁数][j:= Kより小さいか][k:= 各桁の数字の総和をDで割った余り]　= 場合の数
dp[0][0][0] = 1;

for (let i = 0; i < digit; i++) {
  const d = Number(K[i]);
  for (let j = 0; j < D; j++) {
    dp[i + 1][0][(j + d) % D] = (dp[i + 1][0][(j + d) % D] + dp[i][0][j]) % M;
    for (let k = 0; k < 10; k++) {
      if (d > k) dp[i + 1][1][(j + k) % D] += dp[i][0][j];
      dp[i + 1][1][(j + k) % D] = (dp[i + 1][1][(j + k) % D] + dp[i][1][j]) % M;
    }
  }
}

// 0が入ってしまうので、抜く
console.log((M + dp[digit][0][0] + dp[digit][1][0] - 1) % M);
