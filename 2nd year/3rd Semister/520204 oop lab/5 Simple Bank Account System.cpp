#include <iostream>
using namespace std;

class Bank {
    float balance;
public:
    Bank() {
        balance = 0;
    }

    void deposit(float amt) {
        balance += amt;
    }

    void withdraw(float amt) {
        if(amt <= balance)
            balance -= amt;
        else
            cout << "Insufficient balance\n";
    }

    void show() {
        cout << "Balance = " << balance << endl;
    }
};

int main() {
    Bank b;
    b.deposit(1000);
    b.withdraw(300);
    b.show();
    return 0;
}
