#include<iostream>
using namespace std;
int main(){
int data[]={2,3,6,8,5,7},n=6;
int item =5 ,loc=-1;
for(int i=0;i<n;i++){
    if(data[i]==item){
            loc=i;
    }
}
    if(loc==-1){
        cout<< "Item not found";
    }
    else{
        cout<<loc<<" is the location";
    }

return 0;
}
