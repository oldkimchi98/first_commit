console.log(pow(5,3));
console.log(pow(5));
// 좋지 않은 예시 - console.log(pow(y=2, x=3)); -> 무조건 첫번째 매개변수는 x(2), 두번째 매개변수는 y(3)로 됨. (자리 지정이 안됨) 
console.log(pow());

function pow(x=5, y=2){
    // x의 y승을 return
    console.log('함수 내의 x=${x}, y=${y}');
    result = x ** y;
    return result;
}