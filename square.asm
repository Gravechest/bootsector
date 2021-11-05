%bootloader
%name epic.img

mov    ax,h0013        
int    h10
push   ha000
push   ha000
pop    ds
pop    es
mov    dl,20

%label line2
mov    cl,20

%label line
mov    *bx,ax
add    bl,1
loop   line
add    bx,300
sub    dl,1
cmp    dl,0
jne    line2
hlt
