%console
%name epic

%lib KERNEL32
%func GetStdHandle
%func WriteConsoleA
%func SetConsoleCursorPosition
%func Sleep

%lib USER32
%func GetKeyState

%var map "###########\n#         #\n#         #\n#         #\n#         #\n#    @    #\n#         #\n#         #\n#         #\n#         #\n###########"
%var handle 8 0
%var size 1 0
%var dir 1 1
%var wurm 10 65


push   hf5
call   GetStdHandle
mov    $handle,eax
call   rndfood

%label print
push   0
push   0
push   131
push   $map
mov    eax,*$handle
push   eax
call   WriteConsoleA
mov    eax,0
push   eax
mov    eax,*$handle
push   eax
call   SetConsoleCursorPosition
push   300
call   Sleep
push   h57
call   GetKeyState
test   al,128
jne    wkey
push   h53
call   GetKeyState
test   al,128
jne    skey
push   h44
call   GetKeyState
test   al,128
jne    dkey
push   h41
call   GetKeyState
test   al,128
jne    akey
xor    cl,cl
mov    cl,*$dir
jmp    movement

%label rndfood
rdrand eax
and    eax,255
cmp    eax,131
ja     rndfood
mov    ebx,$map
add    ebx,eax
mov    al,32
cmp    *ebx,al
jne    rndfood
mov    dl,70
mov    *ebx,dl
ret

%label wkey
mov    cl,hf4
jmp    movement

%label skey
mov    cl,12
jmp    movement

%label dkey
mov    cl,1
jmp    movement

%label akey
mov    cl,hff

%label movement
mov    eax,*$wurm
mov    $dir,cl
mov    ebx,$map
add    bl,al
mov    dl,32
mov    *ebx,dl
sub    bl,al
add    al,cl
mov    $wurm,al
mov    dl,*$size
mov    eax,$wurm
add    al,dl

%label itt1
cmp    dl,0
je     render
dec    eax
mov    cl,*eax
push   edx
mov    ebx,$map
mov    dl,64
add    ebx,ecx
mov    *ebx,dl
mov    ebx,$map
inc    eax
mov    *eax,cl
mov    dl,32
add    bl,cl
mov    *ebx,dl
pop    edx
dec    eax
dec    edx
jmp    itt1

%label render
mov    eax,$wurm
mov    dl,*$size
mov    cl,*eax
add    bl,cl
mov    cl,35
cmp    *ebx,cl
je     exit
mov    cl,70
cmp    *ebx,cl
je     food
mov    cl,64
mov    *ebx,cl
mov    eax,$wurm
jmp    print

%label exit
ret

%label food
mov    al,*$size
inc    eax
mov    $size,al
push   ebx
call   rndfood
pop    ebx
jmp    print













