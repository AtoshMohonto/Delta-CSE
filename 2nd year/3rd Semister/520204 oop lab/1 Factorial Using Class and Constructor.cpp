#include <iostream>
using namespace std;

class Factorial {
    int n;
public:
    Factorial(int x) {
        n = x;
    }
    int calculate() {
        int fact = 1;
        for(int i = 1; i <= n; i++)
            fact *= i;
        return fact;
    }
};

int main() {
    int num;
    cout << "Enter a number: ";
    cin >> num;

    Factorial f(num);
    cout << "Factorial = " << f.calculate();
    return 0;
}
