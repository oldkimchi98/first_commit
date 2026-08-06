/*
※	매개변수가 없으면 -999를 리턴하고 매개변수가 1개 이상이면 
매개변수들의 누적합을 리턴하는 가변인자 함수 sumAll()을 작성한 스크립트 파일을 이용하시오.
*/
function sumAll(){
    let result = [];
    if(arguments.length==0){    // 매개변수가 없을때 return -999
    return -999; 
}   let result = 0;
    for (let idx in arguments){     // idx로 번호를 추가하여 0번째부터 순서대로 번호 출력
    result += arguments[idx];
}
    return result;
}
console.log(sumAll());
console.log(sumAll(1, 2, 3));