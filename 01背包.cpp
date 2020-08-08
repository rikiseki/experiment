// 01背包.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include <iostream>
using namespace std;

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
