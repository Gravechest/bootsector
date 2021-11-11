%bootloader
%name epic.img

mov    ax,h0003
int    h10
mov    ax,hb800
mov    ds,ax
mov    es,ax
mov    ax,h0740
stosw
mov    cx,1999
mov    ax,h0723
rep    stosw
xor    di,di

%label L06
mov    cx,2000
lodsw  
cmp    al,h23
je     L00
loop   L07
pop    di
mov    al,h40
stosw
xor    di,di
xor    si,si
jmp    L06

%label L07
stosw
jmp    L06

%label L00
hlt
in     h60
cmp    h11
je     L01
cmp    h20
je     L02
cmp    h1e
je     L03
cmp    h1f
je     L04
jmp    L00

%label L01
mov    bl,160
jmp    L05

%label L02
mov    bl,2
jmp    L05

%label L03
mov    bx,hff5f
jmp    L05

%label L04
mov    bx,hffff

%label L05
add    si,bx
push   si
sub    si,bx
jmp    L07














