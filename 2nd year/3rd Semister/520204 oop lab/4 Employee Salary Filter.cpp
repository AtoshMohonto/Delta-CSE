#include <iostream>
using namespace std;

class Employee {
public:
    int id;
    string name, dept;
    float salary;

    void input() {
        cin >> id >> name >> dept >> salary;
    }

    void display() {
        cout << id << " " << name << " " << dept << " " << salary << endl;
    }
};

int main() {
    Employee e[3];
    float limit;

    cout << "Enter employee details (id name dept salary):\n";
    for(int i = 0; i < 3; i++)
        e[i].input();

    cout << "Enter salary limit: ";
    cin >> limit;

    cout << "Employees with salary above limit:\n";
    for(int i = 0; i < 3; i++)
        if(e[i].salary > limit)
            e[i].display();

    return 0;
}
