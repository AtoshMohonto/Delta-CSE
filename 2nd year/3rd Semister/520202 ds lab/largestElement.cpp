#include<iostream>
using namespace std;
int main(){
int data[]={2,3,4,5,67,7},n=6;
int max=data[0];
for(int i=1;i<n;i++){
    if (data[i]>max)
        max=data[i];
}
cout<<max<< " is the largest element \n";
return 0;
}
