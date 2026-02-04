#include <iostream>
using namespace std;

class Student {
    string name;
    int roll;
    float marks[5];
public:
    void input() {
        cout << "Enter name and roll: ";
        cin >> name >> roll;
        cout << "Enter 5 subject marks: ";
        for(int i = 0; i < 5; i++)
            cin >> marks[i];
    }

    void result() {
        float total = 0;
        for(int i = 0; i < 5; i++)
            total += marks[i];

        float avg = total / 5;
        cout << "Total = " << total << endl;
        cout << "Average = " << avg << endl;

        if(avg >= 80) cout << "Grade: A";
        else if(avg >= 60) cout << "Grade: B";
        else cout << "Grade: C";
    }
};

int main() {
    Student s;
    s.input();
    s.result();
    return 0;
}
