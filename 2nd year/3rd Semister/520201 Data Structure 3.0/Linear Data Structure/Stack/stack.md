# stack mane (তাক /স্তূপ )
# Stack Rule : Last in first out (LIFO)

# push--> রাখতে / ঢুকাতে 

A রাখতে ->push (A)
B রাখতে ->push (B)
C রাখতে ->push (C)

 { একটার উপর আর একটা বসবে 
    C
    B
    A
 } 

 ## pop() --->  delete korte/ সরাতে

  সরাতে pop()--> 
  সরাতে pop()--->
{
 উপরেরটা মুছে যাবে
    
    
    A
 } 

### peek -->delete korbe na only return korbe 

peek(A)
{
     // database e takbe(delete hobe na) but value dekabe 
    
    A
}
push(A){
    A
    A
}

# Stack এর কোড কিভাবে করব ?


একটা Array /List nibo -->যেটাতে আমরা Stack হিসেবে চিন্তা করব 

# Stack Rule : Last in first out (LIFO)
push(item):Put items on  top of the Stack 
pop(item): Remove one item from top of the stack 
peek(item): Returns the Value of top item in the stack 