
import 'dart:math';

int levenshtein(String a, String b) {
  a = a.toUpperCase();
  b = b.toUpperCase();
  int sa = a.length;
  int sb = b.length;
int i, j, cost, min1, min2, min3;
  int levenshtein;
List<List<int>> d = new List.generate(sa + 1, (int i) => List.generate(sb+1, (index)=>(0)));
if (a.length == 0) {
    levenshtein = b.length;
    return (levenshtein);
  }
  if (b.length == 0) {
    levenshtein = a.length;
    return (levenshtein);
  }
for (i = 0; i <= sa; i++) d[i][0] = i;
for (j = 0; j <= sb; j++) d[0][j] = j;
for (i = 1; i <= a.length; i++)
    for (j = 1; j <= b.length; j++) {
      if (a[i - 1] == b[j - 1])
        cost = 0;
      else
        cost = 1;
min1 = (d[i - 1][j] + 1);
      min2 = (d[i][j - 1] + 1);
      min3 = (d[i - 1][j - 1] + cost);
      d[i][j] = min(min1, min(min2, min3));
    }
levenshtein = d[a.length][b.length];
  return (levenshtein);
}


double similarity(String a, String b) {
  double _similarity;
  a = a.toUpperCase();
  b = b.toUpperCase();
  _similarity = 1 - levenshtein(a, b) / (max(a.length, b.length));
  return (_similarity);
}