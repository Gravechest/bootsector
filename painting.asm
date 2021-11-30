
%console
%name epic

%lib   KERNEL32
%func  GetModuleHandleA
%func  ExitProcess
%func  Sleep

%lib   USER32
%func  RegisterClassA
%func  CreateWindowExA
%func  DefWindowProcA
%func  GetMessageA
%func  TranslateMessage
%func  DispatchMessageA
%func  PeekMessageA	
%func  GetDC
%func  FillRect
%func  GetKeyState

%var   style         4  0
%var   lpfnWndProc   4  ~proc
%var   cbClsExtra    4  0
%var   cbWndExtra    4  0
%var   hInstance     4  0
%var   hIcon         4  0
%var   hCursor       4  0
%var   hbrBackground 4  0
%var   lpszMenuName  4  0
%var   lpszClassName 4  0

%var   hwnd          4  0
%var   handle        4  0
%var   msg           32 0
%var   rect1         4  0
%var   rect2         4  0
%var   rect3         4  64
%var   rect4         4  64
%var   dirx          1  64
%var   diry          1  0 

%var   name1 "window"
%var   name2 "debug.txt"

xor    ebx,ebx
push   ebx
call   GetModuleHandleA 
mov    $hInstance,eax
mov    eax,$name1
mov    $lpszMenuName,eax
mov    $lpszClassName,eax
push   $style
call   RegisterClassA
push   ebx
push   $hInstance
push   ebx
push   ebx
push   h300
push   h500
push   h100
push   h100
push   h10080000
push   $name1
push   $name1
push   ebx
call   CreateWindowExA
mov    $hwnd,eax
push   eax
call   GetDC
mov    esi,eax

%label inf
push   300
call   Sleep
push   h53
call   GetKeyState
test   al,h80
jne    skey
push   h57
call   GetKeyState
test   al,h80
jne    wkey
push   h44
call   GetKeyState
test   al,h80
jne    dkey
push   h41
call   GetKeyState
test   al,h80
jne    akey
mov    bl,*$dirx
mov    dl,*$diry
jmp    nomovement

%label dkey
mov    ebx,h40
mov    edx,0
jmp    movement

%label akey
mov    ebx,hffffffc0
mov    edx,0
jmp    movement

%label wkey
mov    ebx,0
mov    edx,hffffffc0
jmp    movement

%label skey
mov    ebx,0
mov    edx,h40

%label movement
mov    $dirx,bl
mov    $diry,dl

%label nomovement
push   edx
push   0
push   $rect1
push   esi
call   FillRect
pop    edx
mov    eax,*$rect1
mov    ecx,*$rect2
add    eax,ebx
add    ecx,edx
mov    $rect1,eax
mov    $rect2,ecx
add    eax,64
add    ecx,64
mov    $rect3,eax
mov    $rect4,ecx
push   3
push   $rect1
push   esi
call   FillRect
push   0
push   0
push   0
mov    eax,*$hwnd
push   eax
push   $msg
call   PeekMessageA
cmp    eax,0
je     inf
push   0
push   0
mov    eax,*$hwnd
push   eax
push   $msg
call   GetMessageA
push   $msg
call   TranslateMessage
push   $msg
call   DispatchMessageA
jmp    inf

%label exit
call   ExitProcess

%label proc
push   ebp
mov    ebp,esp
push   *ebp+20
push   *ebp+16
push   *ebp+12
push   *ebp+8
call   DefWindowProcA
mov    esp,ebp
pop    ebp
ret
