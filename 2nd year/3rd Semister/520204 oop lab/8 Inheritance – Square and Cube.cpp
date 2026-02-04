#include <iostream>
using namespace std;

class Number {
protected:
    int n;
public:
    Number(int x) {
        n = x;
    }
};

class Square : public Number {
public:
    Square(int x) : Number(x) {}
    int getSquare() {
        return n * n;
    }
};

class Cube : public Number {
public:
    Cube(int x) : Number(x) {}
    int getCube() {
        return n * n * n;
    }
};

int main() {
    Square s(5);
    Cube c(5);

    cout << "Square = " << s.getSquare() << endl;
    cout << "Cube = " << c.getCube();
    return 0;
}
