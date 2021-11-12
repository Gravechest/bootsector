%bootloader
%name epic.img

mov    ax,h0003
int    h10
mov    cx,h2607
mov    ah,1
int    h10
push   hb800
pop    ds
mov    di,950
mov    ax,h0740
mov    bx,h06f0
mov    *bx,ax
mov    *h1000,bx

%label inp
hlt
in     al,h60
cmp    al,dl
je     inp
xor    dx,dx
cmp    al,h11
je     wkey
cmp    al,h20
je     dkey
cmp    al,h1e
je     akey
cmp    al,h1f
je     skey
jmp    inp

%label wkey
mov    dx,hff60
jmp    L00

%label dkey
mov    dx,2
jmp    L00

%label skey
mov    dx,160
jmp    L00

%label akey
mov    dx,hfffe

%label L00
mov    bx,*h1000
add    bx,dx
mov    cl,*bx
cmp    cl,h23
je     inp
mov    cl,h40
mov    *bx,cl
mov    *h1000,bx
sub    bx,dx
mov    cl,h23
mov    *bx,cl
mov    dx,ax
jmp    inp













