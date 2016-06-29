var p = document.getElementsByTagName('*');
for (i=0; i < p.length; i++) {
    var s = 12;
    if(p[i].style.fontSize && p[i].style.fontSize) {
        s = parseInt(p[i].style.fontSize.replace('px', ''));
    }
    s += 10;
    p[i].style.fontSize = s + 'px';
    p[i].style.lineHeight = '120%';
}
void 0;
