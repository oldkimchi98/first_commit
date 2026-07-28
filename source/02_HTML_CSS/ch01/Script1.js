// JavaScript source code
/* 2.js */
name = prompt("이름은?", "수강생"); // 취소를 클릭하면 'null'
if (name != 'null' && name != '') {
    document.write(name + '반갑다.<br><br>');
}