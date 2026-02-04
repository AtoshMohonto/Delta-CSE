#include <iostream>
#include <fstream>
#include <set>
using namespace std;

int main() {
    ifstream fin("input.txt");
    ofstream fout("output.txt");
    set<string> words;
    string word;

    while(fin >> word)
        words.insert(word);

    for(auto w : words)
        fout << w << " ";

    fin.close();
    fout.close();
    return 0;
}
