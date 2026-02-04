#include <iostream>
using namespace std;

class Shape {
public:
    virtual void displayArea() {
        cout << "Area not defined\n";
    }
};

class Circle : public Shape {
public:
    void displayArea() {
        cout << "Circle Area = " << 3.14 * 5 * 5 << endl;
    }
};

class Rectangle : public Shape {
public:
    void displayArea() {
        cout << "Rectangle Area = " << 10 * 5 << endl;
    }
};

class Triangle : public Shape {
public:
    void displayArea() {
        cout << "Triangle Area = " << 0.5 * 10 * 5 << endl;
    }
};

int main() {
    Shape *s;
    Circle c;
    Rectangle r;
    Triangle t;

    s = &c; s->displayArea();
    s = &r; s->displayArea();
    s = &t; s->displayArea();

    return 0;
}
