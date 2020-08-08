#include <iostream>
#include<string>
using namespace std;
void MaxtrixChain(int *p,int n,int **m,int **s)
{
	for (int i = 0; i <= n; i++)
		m[i][i] = 0;
	for (int r = 2; r <= n; r++)//r为链中矩阵个数
	{
		for (int i = 1; i <= n - r + 1; i++)
		{
			int j = i + r - 1;
			m[i][j] = m[i + 1][j] + p[i - 1] * p[i] * p[j];//k=i时，m[i][k]=0
			s[i][j] = i;//此时断开在i
			for (int k = i + 1; k < j; k++)
			{
				int t = m[i][k] + m[k + 1][j] + p[i - 1] * p[k] * p[j];
				if (t < m[i][j])
				{
					m[i][j] = t;
					s[i][j] = k;
				}
			}
		}
	}
	
}
void Traceback(int i, int j, int** s)
{
	if (i == j)
	{
		cout << "A" << i;
		return;
	}
	cout << "(";
	Traceback(i, s[i][j], s);
	cout << "*";
	Traceback(s[i][j] + 1, j, s);
	cout << ")";
}
int main()
{
	int n;
	cin >> n;
	int p[10];
	for (int i = 0; i <= n; i++)
	{
		cin >> p[i];
	}
	int** m = new int* [10];
	int** s = new int* [10];
	for (int i = 0; i < 10; i++)
	{
		m[i] = new int[10];
		s[i] = new int[10];
	}
	MaxtrixChain(p, n, m,s);
	cout << "最优解: " << endl;
	Traceback(1, n,s);
	cout << endl;
	for (int i = 1; i <= n; i++)
	{
		for (int j = i; j <= n; j++)
			cout << m[i][j] << " ";
		cout << endl;
	}
	for (int i = 1; i <= n; i++)
	{
		s[i][i] = 0;
		for (int j = i; j <= n; j++)
			cout << s[i][j] << " ";
		cout << endl;
	}
	cout << endl;
	cout << "最优解: " << m[1][n];
	
}


//void MaxtrixChain(int* p, int n, int** m,int **sum)
//{
//	for (int i = 1; i <= n; i++)
//		m[i][i] =0;
//	for (int r = 2; r <= n; r++)//r为链中矩阵个数
//	{
//		for (int i = 1; i <= n - r + 1; i++)
//		{
//			int j = i + r - 1;
//			m[i][j] = m[i][i]+m[i + 1][j]+sum[i][j];
//			for (int k = i + 1; k < j; k++)
//			{
//				int t = m[i][k] + m[k + 1][j]+sum[i][j];
//				if (t < m[i][j])
//				{
//					m[i][j] = t;
//				}
//			}
//		}
//	}
//
//}
//int main()
//{
//	int n;
//	cin >> n;
//	int p[10];
//	for (int i = 1; i <= n; i++)
//	{
//		cin >> p[i];
//	}
//	int** m = new int* [10];
//	int** sum = new int* [10];
//	for (int i = 0; i < 10; i++)
//	{
//		m[i] = new int[10];
//		sum[i] = new int[10];
//	}
//	
//	for (int i = 1; i <= n; i ++ )
//		sum[i][i] = p[i];
//	for (int i = 1; i <= n; i++)
//	{
//		for (int j = i+1; j <= n; j++)
//		{
//			sum[i][j] = sum[i][j - 1] + p[j];
//		}
//	}
//	MaxtrixChain(p, n, m,sum);
//	for (int i = 1; i <= n; i++)
//	{
//		for (int j = i; j <= n; j++)
//			cout << m[i][j] << " ";
//		cout << endl;
//	}
//	
//	cout << "最优解: " << m[1][n];
//
//}

