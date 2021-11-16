%console
%name epic

%lib KERNEL32
%func GetStdHandle
%func WriteConsoleA
%func SetConsoleCursorPosition
%func SetConsoleCursorInfo
%func SetCurrentConsoleFontEx

%lib USER32
%func GetKeyState

%var map "###########\n#         #\n#         #\n#         #\n#         #\n#    @    #\n#         #\n#         #\n#         #\n#         #\n###########"
%var handle 8 0
%var player 4 0

%var cbsize 4 84
%var nFont 4 0
%var xfont 2 24
%var yfont 2 24
%var meuk 72 0

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
push   h57
call   GetKeyState
test   al,128
jne    wkey
jmp    inp

%label wkey
mov    eax,*$player
mov    bl,32
mov    *eax,bl
sub    eax,12
mov    bl,64
mov    *eax,bl
xor    eax,eax
jmp    print














