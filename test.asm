%bootloader
%name epic.img

mov     ax,h0003
int     h10
push    hb800
pop     es
push    ha000
pop     ds
mov     cl,80
call    rnd
mov     *h0000,al
mov     cl,25
call    rnd
mov     *h0001,al
add     di,al
shl     di
mov     al,h40
stosb

%label inf
hlt
jmp     inf

%label rnd
in      al,h40
cmp     al,cl
jg      rnd
ret
