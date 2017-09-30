#include <iostream>
#define Number typename

/*
 *	An exploration that leads to the Karatsuba algorithm
 *
 * */

template <Number N>
N half(N i)
{
	return i >> 1;
}

bool odd(int x)
{
	return x & 0x1;
}


//this algorithm obeys the invariant r + n*a = r0 + n0*a0
template <Number N>
N multiply_acc(N r, N a, N n) 
{
	if (odd(n)) {
		r = r + a;
		if (n == 1) return r;
	}
	a = a + a;
	n = half(n);
	return multiply_acc(r, a, n);
}

template <Number N>
N multiply2(N a, N n)
{
	if(n == 1) return a;
	return multiply_acc(a, n-1, a);
}

template <Number N>
N multiply3(N a, N n)
{
	while (!odd(n))
	{
		n = half(n);
		a = a + a;
	}
	return multiply_acc(a, half(n - 1), a + a);
}


template <Number N>
N multiply_acc4(N r, N a, N n) 
{
	while(true) {
		if (odd(n)) {
			r = r + a;
			if (n == 1) return r;
		}
		a = a + a;
		n = half(n);
	}
}

template <Number N>
N multiply4(N a, N n)
{
	while (!odd(n))
	{
		a = a + a;
		n = half(n);
	}
	//odd(n) => half(n) == half(n-1)
	return multiply_acc4(a, half(n), a + a);
}

template <Number N>
N multiply5(N a, N n)
{
	int odd_count = 0;
	int even_count = n;
	while ( (n >>= 1) > 1)
	{
		if ( odd(n) ) {
			odd_count++;
			a = a 
		}
		else {
			even_count++;
		}
	}
	a <<= even_count;
	return multiply5(odd_count + 1, a); // odd_count times
}

int main() {
	int res9 = multiply_acc(3 , 2, 3)
	, res18 = multiply_acc(3 , 5, 3)
	, res9_2 = multiply2(3, 3)
	, res18_2 = multiply2(6, 3)
	, res9_3 = multiply3(3, 3)
	, res18_3 = multiply3(6, 3)
	, res9_4 = multiply4(3, 3)
	, res18_4 = multiply4(6, 3)
	, res399_4 = multiply4(19, 21)
	, res31212_4 = multiply4(51, 612);
	using namespace std;

	cout << "multiply_acc(3 , 2, 3) =  " << res9 << endl;
	cout << "multiply_acc(3 , 2, 3) =  " << res18 << endl;


	cout << "multiply2(3, 3) =  " << res9_2 << endl;
	cout << "multiply2(6, 3) =  " << res18_2 << endl;
	
	cout << "multiply3(3, 3) =  " << res9_3 << endl;
	cout << "multiply3(6, 3) =  " << res18_3 << endl;

	cout << "multiply4(3, 3) =  " << res9_4 << endl;
	cout << "multiply4(6, 3) =  " << res18_4 << endl;

	cout << "multiply4(19, 21) =  " << res399_4 << endl;
	cout << "multiply4(51, 612) =  " << res31212_4 << endl;
}
