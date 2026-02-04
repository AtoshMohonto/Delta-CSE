#include <iostream>
using namespace std;

class B;

class A {
    int x;
public:
    void set(int a) { x = a; }
    friend int largest(A, B, int);
};

class B {
    int y;
public:
    void set(int b) { y = b; }
    friend int largest(A, B, int);
};

int largest(A a, B b, int c) {
    if(a.x > b.y && a.x > c) return a.x;
    else if(b.y > c) return b.y;
    else return c;
}

int main() {
    A a;
    B b;
    int c;

    a.set(10);
    b.set(25);
    c = 15;

    cout << "Largest = " << largest(a, b, c);
    return 0;
}
