	%bootloader
%name epic.img

mov    ax,h0013        
int    h10
push   ha000
pop    ds

%label square
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
push   ax
mov    dl,*hff41

%label input
hlt
in     al,h60
cmp    al,dl
je     input
xor    dl,dl	
cmp    al,h91
je     wkey
jmp    input

%label wkey
mov    *hff41,al
mov    al,*hff40
add    al,1
mov    *hff40,al
mul    ax,320
mov    bx,ax
pop    ax
jmp    square












