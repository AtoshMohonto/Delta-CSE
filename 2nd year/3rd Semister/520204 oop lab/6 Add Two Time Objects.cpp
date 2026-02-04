#include <iostream>
using namespace std;

class Time {
public:
    int h, m, s;

    Time(int x, int y, int z) {
        h = x; m = y; s = z;
    }

    void add(Time t) {
        s += t.s;
        m += t.m + s / 60;
        h += t.h + m / 60;
        s %= 60;
        m %= 60;
    }

    void display() {
        cout << h << ":" << m << ":" << s;
    }
};

int main() {
    Time t1(2, 45, 50), t2(1, 20, 30);
    t1.add(t2);
    t1.display();
    return 0;
}
