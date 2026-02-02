#include<iostream>
using namespace std;
int main(){
int DATA[]={1,3,2,7,5,6},N=6,ITEM=7;
int K=0,LOC=-1;
while(K<N && LOC==-1){
if(DATA[K]==ITEM)LOC=K;
K=K+1;
}
if(LOC==-1)
cout<<ITEM<<"is not in the array DATA";
else
cout<<LOC<<"is the location of"<<ITEM;
return 0;
}
