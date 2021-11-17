%console
%name epic

%lib KERNEL32
%func ExitProcess
%func GetStdHandle
%func WriteConsoleA
%func SetConsoleCursorPosition
%func SetConsoleCursorInfo
%func SetCurrentConsoleFontEx
%func SetConsoleWindowInfo
%func Sleep

%lib USER32
%func GetKeyState

%var map "###########\n#         #\n#         #\n#         #\n#         #\n#    @    #\n#         #\n#         #\n#         #\n#         #\n###########"
%var handle 8 0
%var player 4 0

%var cbsize 4 84
%var nFont 4 0
%var xfont 2 36
%var yfont 2 36
%var meuk 0 0

%var rLeft 2 0
%var rTop 2 0
%var rRight 2 10
%var rBottom 2 10

mov    eax,$map
add    eax,65
mov    $player,eax
push   hf5
call   GetStdHandle
mov    $handle,eax
mov    eax,$cbsize
push   eax
push   0
mov    eax,*$handle
push   eax
call   SetCurrentConsoleFontEx
mov    eax,$rLeft
push   eax
push   1
mov    eax,*$handle
push   eax
call   SetConsoleWindowInfo
mov    eax,$cbsize
push   eax
mov    eax,*$handle
push   eax
call   SetConsoleCursorInfo

%label print
push   0
push   0
push   131
push   $map
mov    eax,*$handle
push   eax
call   WriteConsoleA
push   0
mov    eax,*$handle
push   eax
call   SetConsoleCursorPosition

%label inp
push   300
call   Sleep
push   h57
call   GetKeyState
test   al,128
jne    wkey
push   h41
call   GetKeyState
test   al,128
jne    akey
push   h44
call   GetKeyState
test   al,128
jne    dkey
push   h53
call   GetKeyState
test   al,128
jne    skey
mov    ecx,*$rLeft
jmp    movement
mov    cl,50
call   rnd
mov    ebx,$map
add    ebx,eax
mov    al,70
mov    *ebx,al

%label rnd
jmp    exit
rdrand eax

%label L01
cmp    eax,ecx
jg     L00
ret

%label L00
shr    eax
jmp    L01

%label skey
mov    cl,12
jmp    movement

%label akey
mov    cl,hff
jmp    movement

%label wkey
mov    cl,hf4
jmp    movement

%label dkey
mov    cl,1

%label movement
mov    eax,*$player
mov    bl,33
mov    *eax,bl
add    al,cl
mov    dl,35
cmp    dl,*eax
je     exit
mov    bl,64
mov    *eax,bl
mov    $player,eax
mov    $rLeft,ecx
jmp    print

%label exit
call   ExitProcess













