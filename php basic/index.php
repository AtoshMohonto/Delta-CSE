hi atosh 
<form action="">
    <input type="text" placeholder="Name" required > 
    <input type="NUMBER" value="124"> 
    <input type="text" value="Atosh"<?php 
     $user="atosh2";
    if($user=="atosh"){
        echo "readonly";
    }
    ?> > 
    <input type="HIDDEN"> 
    <input type="SUBMIT"> 
</form>
<?php
echo"";

?>
<?php
function add(){
    // int a,b;
    //code 
    return 0;
}
add();
function sum($a ,$b){
    $result =$a+$b;
    return $result; 
}
$m=5;
$n=6;
$a=sum($m,$n);
echo "result-".$a ." dayal";
?>


