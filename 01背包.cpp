// 01背包.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include <iostream>
using namespace std;
//int max(int a, int b)
//{
//	if (a >= b)
//		return a;
//	else
//		return b;
//}
//void package(int* v, int* w, int c, int n, int** m)
//{
//	for (int j = 0; j <= c; j++)
//	{
//		if (j < w[n])
//			m[n][j] = 0;
//		else
//			m[n][j] = v[n];
//	}
//	for (int i = n - 1; i >= 1; i--)
//	{
//		for (int j = 0; j <= c; j++)
//		{
//			if (w[i] > j)
//				m[i][j] = m[i + 1][j];
//			else
//				m[i][j] = max(m[i + 1][j], v[i] + m[i + 1][j - w[i]]);
//		}
//	}
//}
//void Traceback(int** m, int* w, int c, int n, int* x)
//{
//	for (int i = 1; i < n; i++)
//	{
//		if (m[i][c] == m[i + 1][c])
//			x[i] = 0;
//		else
//		{
//			x[i] = 1;
//			c -= w[i];
//		}
//	}
//	x[n] = (m[n][c]) ? 1 : 0;
//}
//int main()
//{
//	int n,c;
//	cin >> n>>c;
//	int* w = new int[11];
//	int* v = new int[11];
//	int* x = new int[11];
//	for (int i = 1; i <= n; i++)
//	{
//		cin >> w[i];
//	}
//	for (int i = 1; i <= n; i++)
//	{
//		cin >> v[i];
//	}
//	int** m = new int* [11];
//	for (int i = 0; i <= 10; i++)
//	{
//		m[i] = new int[11];
//		memset(m[i], 0, sizeof(int)*10);
//	}
//	package(v, w, c, n, m);
//	cout << endl;
//	for (int i = n; i>= 1; i--)
//	{
//		for (int j = 0; j <= c; j++)
//		{
//			cout << m[i][j] << " ";
//		}
//		cout << endl;
//	}
//	Traceback(m, w, c, n, x);
//	for (int i = 1; i <= n; i++)
//		cout << x[i] << " ";
//}
int n;
int x[11];
int w[11];
int v[11];
int y[11];
int c;
int cw;
int cv;
int bestv;
int Bound(int i)
{
	int rev=cv;
	while (i <= n)
	{
		rev += v[i];
		i++;
	}
	return rev;
}
void search(int i)
{
	if (i > n)
	{
		if(cv>bestv)
			bestv = cv;
		for (int k = 1; k <= n; k++)
			y[k] = x[k];
		return;
	}
	if (cw + w[i] <= c)
	{
		x[i] = 1;
		cw += w[i];
		cv += v[i];
		search(i + 1);
		cw -= w[i];
		cv -= v[i];
	}
	if (Bound(i + 1) > bestv)
	{
		x[i] = 0;
		search(i + 1);
	}
}
int main()
{
	cin >> n >> c;
	for (int i = 1; i <= n; i++)
	{
		cin >> w[i];
	}
	for (int i = 1; i <= n; i++)
	{
		cin >> v[i];
	}
	bestv = 0;
	cw = cv = 0;
	search(1);
	cout << endl;
	cout << bestv<<endl;
	cout << "最优选择";
	for (int t = 1; t <= n; t++)
		cout << y[t] << " ";
}
