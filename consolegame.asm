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
mov    ebx,$map
mov    al,*$wurm
add    bl,al
add    al,cl
mov    $wurm,al
mov    al,32
mov    *ebx,al
add    bl,cl
mov    al,35
cmp    *ebx,al
je     exit
mov    al,70
cmp    *ebx,al
jne    con
mov    edx,*$size
inc    edx
mov    $size,edx
push   ebx
call   rndfood
pop    ebx

%label con
mov    al,64
mov    *ebx,al
mov    $dir,cl
mov    ebx,$wurm
mov    cl,*$size
add    bl,cl

%label update
cmp    cl,0
je     print
dec    bl
mov    al,*ebx
inc    bl
mov    *ebx,al
dec    bl
dec    cl
jmp    update

%label exit
