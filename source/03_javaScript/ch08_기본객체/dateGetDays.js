// now.getNumber0fDays(openday)     /   openday.getNumber0fDays(now)
Date.prototype.getNumber0fDays = function(thatday){ //  now가 this  /   openday가 thatday
    let interval = Math.abs(this.getTime()- thatday.getTime());   //  두 시점간 밀리세컨(절대값)
    // if  (this>thatday){
    //     interval = this.getTime() - thatday.getTime();
    // }else{
    //     interval = thatday.getTime() - this.getTime();
    // }
    let day = Math.trunc(interval/(1000*60*60*24)); // trunc() : 소수점 이하를 잘라내는 것
    day = Math.floor(interval/(1000*60*60*24)); // floor() : 소수점에서 반올림
    day = Math.round(interval/(1000*60*60*24));  //  소수점에서 올림
    day = Math.ceil(interval/(1000*60*60*24)); // ceil() : 소수점에서 올림
    return day;
};
// let now = new Date();   //  현재 시점
// let limitday = new Date(2026, 10, 19, 18, 0, 0);    //  2026.11.19
// console.log(now.getNumberofDays(limitday));
// console.log(limitday.getNumberofDays(now));
// console.log(now.getNumberofDays(now));